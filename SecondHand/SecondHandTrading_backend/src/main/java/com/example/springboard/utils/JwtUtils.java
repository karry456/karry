package com.example.springboard.utils;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;

import java.util.Date;

import java.util.Map;

public class JwtUtils {

    private static final String KEY = "itheima";
    public static String getToken(Map<String,Object> clasims){
        System.out.println("dfdf"+clasims.get("userName"));
        return JWT.create()
                .withClaim("claims",clasims)
                .withExpiresAt(new Date(System.currentTimeMillis()+1000*2000))
                .sign(Algorithm.HMAC256(KEY));
    }

    //解析token
    public static Map<String,Object> parseToken(String token){
        return JWT.require(Algorithm.HMAC256(KEY))
                .build()
                .verify(token)
                .getClaim("claims")
                .asMap();
    }
}
