package com.example.springboard.service.impl;

import com.example.springboard.mapper.OrderMapper;
import com.example.springboard.pojo.Order;
import com.example.springboard.pojo.PageBean;
import com.example.springboard.pojo.Product;
import com.example.springboard.pojo.User;
import com.example.springboard.service.OrderService;
import com.example.springboard.service.ProductService;
import com.example.springboard.service.UserService;
import com.example.springboard.utils.ThreadLocalUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;
    @Override
    public List<Order> listAll() {
        return orderMapper.AllOrder();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)//声明式事务
    public String add(Order order) {
        //获取用户id
        Map<String,Object> map = ThreadLocalUtil.get();
        Integer userId = (Integer) map.get("userId");
        //设置用户id
        order.setUserId(userId);
        //生成订单号
        order.setOrderNO(UUID.randomUUID().toString());
        //对用的商品数量减少
        //获取商品信息
        Product product =productService.getProductById(order.getProductId());
        User user = userService.findById(userId);
        //判断商品是否上架或者是否被售出
        if (product.isProductState() && !product.isPurchased()){
        //判断用户余额是否充足
        if (user.getBalance()>=product.getProductPrice()){
            //修改用户余额
            user.setBalance(user.getBalance()-product.getProductPrice());
            //修改用户信息
            userService.update(user);
                //将商品的状态设置为售出
                product.setPurchased(true);
                //将商品下架
                product.setProductState(false);
                order.setPaymentAmount(product.getProductPrice());
                //修改商品信息
                productService.update(product);
                //添加订单
                if (orderMapper.add(order)>0){
                    return "购买成功";
                }else {
                    return "购买失败";
                }
            }else {
                return "余额不足";
            }
        }else {
            return "商品不存在或者商品已被售出";

        }
    }

    @Override
    public int delete(Integer id) {
        return 0;
    }

    @Override
    public List<Order> listByUserId() {
        Map<String,Object> map = ThreadLocalUtil.get();
        Integer userId = (Integer) map.get("userId");
        return orderMapper.listByUserId(userId);
    }

    @Override
    public List<Order> listByUserNameAndPayStatus(String userName, String payStatus) {
        return List.of();
    }

    @Override
    public PageBean<Order> PageList(Integer pageNum, Integer pageSize, String productType, String productName) {
        PageBean< Order> pageBeanOrderList = new PageBean<>();
        PageHelper.startPage(pageNum,pageSize);
        //调用mapper
        List<Order> pageBeanOrderListList = orderMapper.PageList(productType,productName);
        //page中提供了方法，可以获取pagehelper分页查询后的结果
        Page<Order> page = (Page<Order>)pageBeanOrderListList;
        //把数据填充到pageBean中
        pageBeanOrderList.setTotal(page.getTotal());
        pageBeanOrderList.setItems(page.getResult());
        return pageBeanOrderList;
    }

    @Override
    public int updateStatus(Order order) {
        return orderMapper.updateStatus( order);
    }
}
