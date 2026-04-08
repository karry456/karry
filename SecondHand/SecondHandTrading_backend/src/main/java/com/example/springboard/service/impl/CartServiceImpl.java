package com.example.springboard.service.impl;

import com.example.springboard.mapper.CartMapper;
import com.example.springboard.pojo.Cart;
import com.example.springboard.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartMapper cartMapper;
    @Override
    public List<Cart> listAll() {
        return cartMapper.showAll();
    }

    @Override
    public int add(Cart cart) {
        return 0;
    }

    @Override
    public int delete(Integer id) {
        return 0;
    }

    @Override
    public List<Cart> listByUserId(Integer userId) {
        return List.of();
    }
}
