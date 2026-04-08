package com.example.springboard.inserceptors;


import com.example.springboard.utils.JwtUtils;
import com.example.springboard.utils.ThreadLocalUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.Map;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String token=request.getHeader("Authorization");
        try {
            Map<String,Object> claims= JwtUtils.parseToken( token);
            ThreadLocalUtil.set(claims);
            //放行
            return true;

        } catch (Exception e) {
            response.setStatus(401);
            //不放行
            return false ;
        }
        }

        @Override
        public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
            ThreadLocalUtil.remove();
        }
    }


