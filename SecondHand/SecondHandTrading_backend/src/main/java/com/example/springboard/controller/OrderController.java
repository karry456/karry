package com.example.springboard.controller;

import com.example.springboard.pojo.Order;
import com.example.springboard.pojo.PageBean;
import com.example.springboard.pojo.Product;
import com.example.springboard.pojo.Result;
import com.example.springboard.service.OrderService;
import com.example.springboard.utils.ThreadLocalUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private OrderService orderService;

    @RequestMapping("/showAll")
    public Result<List<Order>> showAll() {
        return Result.success(orderService.listAll());
    }

    //通过用户id查询账单
    @RequestMapping("showByUserId")
    public Result<List<Order>> showByUserId() {
        List<Order> userlist =orderService.listByUserId();
        return Result.success(userlist);
    }
    //添加
    @RequestMapping("/add")
    public Result add(@RequestBody Order order) {
        return Result.success(orderService.add(order));
    }

    //分页查询
    @RequestMapping("/PageList")
    public Result<PageBean<Order>> PageList(
            Integer pageNum,
            Integer pageSize,
            @RequestParam(required = false) String productType,
            @RequestParam (required = false) String productName
    ) {
        PageBean<Order> orderList = orderService.PageList(pageNum, pageSize,productType,productName);
        return Result.success(orderList);
    }

    //修改订单状态
    @RequestMapping("/updateStatus")
    public Result updateStatus(@RequestBody Order order) {
        return Result.success(orderService.updateStatus(order));

    }
}
