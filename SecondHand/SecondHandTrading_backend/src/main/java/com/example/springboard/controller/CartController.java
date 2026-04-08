package com.example.springboard.controller;

import com.example.springboard.pojo.Cart;
import com.example.springboard.pojo.Result;
import com.example.springboard.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;
@RestController
@CrossOrigin
@RequestMapping("/cart")
public class CartController {
    @Autowired
    private CartService cartService;
    @RequestMapping("/showAll")
    public Result<List<Cart>>  showAll() {
        return Result.success(cartService.listAll());
    }
}
