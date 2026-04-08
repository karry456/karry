package com.example.springboard.service;

import com.example.springboard.pojo.PageBean;
import com.example.springboard.pojo.Product;

import java.util.List;

public interface ProductService {

    //查询所有商品
    public List<Product> list();

    //添加商品
    public int add(Product product);

    //删除商品
    public void delete(Integer id);
    //修改
    public void update(Product product);
    //通过id查询
    public Product getProductById(Integer productId);

    List<Product> getProductByType(String productType);

    //分页查询
    PageBean<Product> PageList(Integer pageNum, Integer pageSize, String productNo, String productName);




}
