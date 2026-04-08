package com.example.springboard.mapper;

import com.example.springboard.pojo.Order;
import com.example.springboard.pojo.PageBean;
import com.example.springboard.pojo.Product;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface OrderMapper {
    //查询所有订单（管理员）
    List<Order> AllOrder();

    //添加订单
    @Insert("insert into `order` (orderNO,userId,productId,paymentAmount,status,payStatus,receiverName,receiverPhone,receiverAddress,createTime) " +
            "values (#{orderNO},#{userId},#{productId},#{paymentAmount},#{status},#{payStatus},#{receiverName},#{receiverPhone},#{receiverAddress},NOW())")
    int add(Order order);

    //删除订单
    @Update("update `order` deletedAt=0 where orderId= #{id}")
    int delete(Integer id);

    //通过用户id查询订单
    @Select("select * from `order` where userId= #{userId}")
    List<Order> listByUserId(Integer userId);


    //通过用户id和支付状态获取订单
    @Select("select * from `order` where userId= #{userId} and payStatus= #{payStatus}")
    List<Order> listByUserNameAndPayStatus(String userId, String payStatus);

    //分页查询
    List<Order> PageList(String productType, String productName);

    //修改订单状态
    @Update("update `order` set status=#{status} where orderId=#{orderId}")
    int updateStatus(Order order);
}
