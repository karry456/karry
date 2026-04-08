package com.example.springboard.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class Cart {
    private Integer cartId;//购物车id
    private Integer productId;//商品id
    private Integer userId;//用户id
    private LocalDateTime createTime;//创建时间
    @TableField(exist = false)
    private User user;
    @TableField(exist = false)//标明不是数据库字段
    private Product product;//商品信息

}
