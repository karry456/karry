package com.example.springboard.anno;

import com.example.springboard.validation.StateValidation;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented//元注解
@Constraint(validatedBy = {StateValidation.class})
@Target({ ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)

public @interface State {
    //提供校验失败的提示信息
    String message() default "state的参数值只能是已发布或者草稿";
    //指定分组
    Class<?>[] groups() default {};
    //负载 获取到state注解的附加信息
    Class<? extends Payload>[] payload() default {};

}
