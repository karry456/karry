package com.example.springboard.Test;

import com.example.springboard.utils.SHA256Util;
import org.junit.jupiter.api.Test;

public class SHA256UtilTest {
    @Test
    public void Test(){
        String password = "123456";
        // 加密操作
        String encryptedPassword = SHA256Util.encrypt(password);
        System.out.println("Encrypted Password: " + encryptedPassword);
        // 校验操作
        boolean isMatch = SHA256Util.verify(password, encryptedPassword);
        System.out.println("Is Match: " + isMatch);
    }
}