package com.example.springboard.pojo;
import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import java.time.LocalDateTime;
@Data
public class Order {
    private Integer orderId;//订单id
    private String orderNO;//订单编号
    private Integer userId;//用户id
    private Integer productId;//商品id
    private Double paymentAmount;//支付金额
    private String status;//订单状态
    private String payStatus;//支付状态
    private String receiverName;//收货姓名
    private String receiverPhone;//收货手机
    private String receiverAddress;//收货地址
    private LocalDateTime createTime;//创建时间
    private boolean deletedAt;//逻辑删除

    @TableField(exist = false)//标明不是数据库字段
    private User user;//用户信息
    @TableField(exist = false)
    private Product product;//商品信息

}
