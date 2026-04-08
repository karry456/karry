package com.example.springboard.utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
public class SHA256Util {
    /**
     * 使用SHA-256算法对输入字符串进行加密
     *
     * @param input 加密前的字符串
     * @return 加密后的十六进制字符串
     */
    public static String encrypt(String input) {
        try {
            // 获取SHA-256算法实例
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            // 对输入字符串进行哈希计算
            byte[] hash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
            // 将字节数组转换为十六进制字符串
            return bytesToHex(hash);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
    /**
     * 校验输入字符串与散列值是否匹配
     *
     * @param input 输入字符串
     * @param hashString 散列值
     * @return 是否匹配
     */
    public static boolean verify(String input, String hashString) {
        String encryptedInput = encrypt(input);
        return encryptedInput != null && encryptedInput.equals(hashString);
    }
    /**
     * 将字节数组转换为十六进制字符串
     *
     * @param bytes 字节数组
     * @return 十六进制字符串
     */
    private static String bytesToHex(byte[] bytes) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : bytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }
}