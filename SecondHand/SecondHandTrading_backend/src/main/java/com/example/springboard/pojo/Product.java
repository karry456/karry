package com.example.springboard.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.time.LocalDateTime;
@Data
public class Product {
    private Integer productId;//商品id
    private String productNo;//商品编号
    private Integer userId;//发行用户id
    private String productName;//商品名称
    private String productPhoto;//商品图片
    private String productType;//商品类型
    private Double productPrice;//商品价格
    private boolean productState;//商品状态
    private Integer favorites;//商品收藏数
    private String productInfo;//商品描述
    private boolean purchased;//是否被购买
    private LocalDateTime createTime;//创建时间
    private LocalDateTime updateTime;//修改时间

    @TableField(exist = false)
    private User user;

}
