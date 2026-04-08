package com.example.springboard.service;

import com.example.springboard.pojo.Order;
import com.example.springboard.pojo.PageBean;

import java.util.List;

public interface OrderService {

    //查询所有
    List<Order> listAll();

    //添加
    String add(Order order);

    //删除
    int delete(Integer id);

    //通过用户id查询
    List<Order> listByUserId();


    //通过用户名和支付状态获取订单
    List<Order> listByUserNameAndPayStatus(String userName, String payStatus);

    PageBean<Order> PageList(Integer pageNum, Integer pageSize, String productType, String productName);

    int updateStatus(Order order);
}
