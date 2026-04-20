#!/bin/bash
# init-db.sh — Import secondhandplatform.sql into the Railway MySQL database
# on first deployment. Skips import if tables already exist.

set -euo pipefail

# ── 1. Resolve the SQL file path ────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
SQL_FILE="${REPO_ROOT}/secondhandplatform.sql"

if [ ! -f "${SQL_FILE}" ]; then
  echo "[init-db] WARNING: SQL file not found at ${SQL_FILE}. Skipping DB init."
  exit 0
fi

# ── 2. Require SPRING_DATASOURCE_URL ────────────────────────────────────────
if [ -z "${SPRING_DATASOURCE_URL:-}" ]; then
  echo "[init-db] ERROR: SPRING_DATASOURCE_URL is not set. Skipping DB init."
  exit 0
fi

# ── 3. Parse jdbc:mysql://host:port/dbname[?params] ─────────────────────────
# Strip the jdbc: prefix so we have a plain URL
PLAIN_URL="${SPRING_DATASOURCE_URL#jdbc:}"

# Extract host:port/dbname portion  (everything after mysql://)
HOSTPART="${PLAIN_URL#mysql://}"
# Drop query-string parameters
HOSTPART="${HOSTPART%%\?*}"

# host:port
HOSTPORT="${HOSTPART%%/*}"
DB_HOST="${HOSTPORT%%:*}"
DB_PORT="${HOSTPORT##*:}"

# database name
DB_NAME="${HOSTPART##*/}"

# Fall back to defaults if parsing produced empty strings
DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-3306}"

# ── 4. Credentials from env vars ────────────────────────────────────────────
DB_USER="${SPRING_DATASOURCE_USERNAME:-root}"
DB_PASS="${SPRING_DATASOURCE_PASSWORD:-}"

echo "[init-db] Target: ${DB_HOST}:${DB_PORT}/${DB_NAME} (user: ${DB_USER})"

# ── 5. Check that the mysql client is available ─────────────────────────────
if ! command -v mysql &>/dev/null; then
  echo "[init-db] WARNING: 'mysql' client not found in PATH. Attempting to install..."

  # Try common package managers (Debian/Ubuntu-based images)
  if command -v apt-get &>/dev/null; then
    apt-get update -qq && apt-get install -y -qq default-mysql-client 2>/dev/null \
      || apt-get install -y -qq mysql-client 2>/dev/null \
      || true
  elif command -v apk &>/dev/null; then
    apk add --no-cache mysql-client 2>/dev/null || true
  fi

  if ! command -v mysql &>/dev/null; then
    echo "[init-db] ERROR: 'mysql' client still not available. Skipping DB init."
    exit 0
  fi
fi

# ── 6. Build a reusable mysql invocation ────────────────────────────────────
# Use MYSQL_PWD to avoid password on the command line (avoids warnings)
export MYSQL_PWD="${DB_PASS}"
MYSQL_CMD="mysql --host=${DB_HOST} --port=${DB_PORT} --user=${DB_USER} --connect-timeout=30"

# ── 7. Wait for MySQL to be reachable (up to 60 s) ──────────────────────────
echo "[init-db] Waiting for MySQL to be reachable..."
MAX_TRIES=20
TRIES=0
until ${MYSQL_CMD} --execute="SELECT 1;" "${DB_NAME}" &>/dev/null; do
  TRIES=$((TRIES + 1))
  if [ "${TRIES}" -ge "${MAX_TRIES}" ]; then
    echo "[init-db] ERROR: MySQL did not become reachable after ${MAX_TRIES} attempts. Skipping DB init."
    exit 0
  fi
  echo "[init-db] MySQL not ready yet (attempt ${TRIES}/${MAX_TRIES}). Retrying in 3 s..."
  sleep 3
done
echo "[init-db] MySQL is reachable."

# ── 8. Check whether the tables already exist ───────────────────────────────
TABLE_COUNT=$(${MYSQL_CMD} --skip-column-names --silent \
  --execute="SELECT COUNT(*) FROM information_schema.tables
             WHERE table_schema = '${DB_NAME}'
               AND table_name IN ('user','product','cart','order');" 2>/dev/null || echo "0")

TABLE_COUNT=$(echo "${TABLE_COUNT}" | tr -d '[:space:]')

if [ "${TABLE_COUNT}" = "4" ]; then
  echo "[init-db] All required tables already exist. Skipping import."
  exit 0
fi

echo "[init-db] Found ${TABLE_COUNT}/4 required tables. Importing ${SQL_FILE}..."

# ── 9. Import the SQL file ───────────────────────────────────────────────────
if ${MYSQL_CMD} "${DB_NAME}" < "${SQL_FILE}"; then
  echo "[init-db] Database initialised successfully."
else
  echo "[init-db] ERROR: SQL import failed. The application may not function correctly."
  # Do not exit 1 — let the application start anyway so Railway doesn't loop
fi
