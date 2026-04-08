package com.example.springboard.pojo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
@Data
public class User {
    //用户id
    private Integer userId;
    //用户编号
    private String userCode;
    //头像
    private String avatar;
    @NotNull
    @NotEmpty
    @Pattern(regexp = "^\\S{5,16}$", message = "用户名格式不正确，请输入5-16位有效字符")
    //用户名
    private String userName;
    //密码
    @NotNull//
    @NotEmpty//

    @JsonIgnore//在前端忽略
    @Pattern(regexp = "^\\S{5,16}$", message = "密码格式不正确，请输入5-16位有效字符")
    private String passWord;
    //在线用户名（网名）
    @Pattern(regexp = "^\\S{5,16}$", message = "在线用户名格式不正确，请输入5-16位有效字符")
    private String onlineUsername;
    @Email
    private String email;
    //手机号
    @Pattern(regexp = "^1[3-9]\\d{8}$", message = "手机号格式不正确，请输入11位有效手机号") // 自定义错误提示
    private String telephoneNumber;

    //用户状态（是否被封禁）
    private boolean status;
    //身份
    private String  role;
    //账户余额
    private Double balance;
    //创建时间
    private LocalDateTime createTime;
    //更新时间
    private LocalDateTime updateTime;
}
