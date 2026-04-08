package com.example.springboard.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ProductComment {
    private Integer commentId;//评论id
    @NotNull
    private Integer productId;//商品信息
    @NotNull
    private Integer userId;//用户信息
    @NotNull
    private String content;//评论内容

    private LocalDateTime createTime;

    @TableField(exist = false)
    private Product product;
    @TableField(exist = false)
    private User user;

}
