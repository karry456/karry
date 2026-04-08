// server.js
const { Server } = require('socket.io');
const http = require('http');
const express = require('express');

// 创建Express应用和HTTP服务器
const app = express();
const server = http.createServer(app);

// 设置Socket.io
const io = new Server(server, {
  cors: {
    origin: "*", // 允许所有来源（生产环境应限制）
    methods: ["GET", "POST"]
  }
});

// 存储所有连接会话
const sessions = new Map();

io.on('connection', (socket) => {
  console.log('新连接:', socket.id);
  
  // 为每个新连接生成唯一会话ID
  const sessionId = `sess-${Date.now()}-${Math.floor(Math.random() * 1000)}`;
  sessions.set(sessionId, { socket, confirmed: false });
  
  // 将会话ID发送给电脑端
  socket.emit('sessionId', sessionId);
  
  // 处理来自手机的确认消息
  socket.on('confirm', (receivedId) => {
    const session = sessions.get(receivedId);
    if (session) {
      session.confirmed = true;
      session.socket.emit('confirmed');
      console.log(`会话 ${receivedId} 已确认`);
    }
  });
  
  // 连接断开时清理
  socket.on('disconnect', () => {
    console.log('连接断开:', socket.id);
    for (const [id, session] of sessions.entries()) {
      if (session.socket.id === socket.id) {
        sessions.delete(id);
        break;
      }
    }
  });
});

// 启动服务器
const PORT = 3001;
server.listen(PORT, () => {
  console.log(`服务运行在 http://localhost:${PORT}`);
});