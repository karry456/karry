package com.example.springboard.utils;

import java.math.BigInteger;
import java.util.UUID;

public class UUIDUtils {
    // 工具方法：生成8位纯数字唯一编码
    public static String generate8DigitCode() {
        String uuidStr = UUID.randomUUID().toString().replace("-", "");
        BigInteger num = new BigInteger(uuidStr, 16);
        String numStr = num.toString();
        // 保证至少8位，不足补0；超过则取最后8位
        if (numStr.length() < 8) {
            return String.format("%08d", num);
        } else {
            return numStr.substring(numStr.length() - 8);
        }
    }

}
