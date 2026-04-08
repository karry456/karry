package com.example.springboard.service;

import com.example.springboard.pojo.Cart;
import com.example.springboard.pojo.PageBean;

import java.util.List;

public interface CartService {

    List<Cart> listAll();

    int add(Cart cart);

    int delete(Integer id);

    List<Cart> listByUserId(Integer userId);

}
