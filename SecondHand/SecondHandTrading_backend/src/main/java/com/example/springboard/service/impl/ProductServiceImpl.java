package com.example.springboard.service.impl;

import com.example.springboard.mapper.ProductMapper;
import com.example.springboard.pojo.PageBean;
import com.example.springboard.pojo.Product;
import com.example.springboard.service.ProductService;
import com.example.springboard.utils.ThreadLocalUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;
    @Override
    public List<Product> list() {
        return productMapper.list();
    }

    @Override
    public int add(Product product) {
        //获取登录用户的id
        Map<String,Object> map = ThreadLocalUtil.get();
        //设置商品编号
        product.setProductNo(UUID.randomUUID().toString().substring(0,20));
        Integer userId = (Integer) map.get("userId");
        //设置卖家信息
        product.setUserId(userId);
        return productMapper.add(product);
    }

    @Override
    public void delete(Integer id) {
        productMapper.delete(id);

    }

    @Override
    public void update(Product product) {

        productMapper.update(product);

    }

    @Override
    public Product getProductById(Integer id) {
        return productMapper.getProductById(id);
    }

    @Override
    public List<Product> getProductByType(String productType) {
        return productMapper.getProductByType(productType);
    }

    @Override
    public PageBean<Product> PageList(Integer pageNum, Integer pageSize, String productNo, String productName) {
        PageBean< Product> pageBeanProductList = new PageBean<>();
        //开启分页查询
        PageHelper.startPage(pageNum,pageSize);

        //调用mapper
        List<Product> productList = productMapper.PageList(productNo,productName);
        //page中提供了方法，可以获取pagehelper分页查询后的结果
        Page<Product> page = (Page<Product>) productList;
        //把数据填充到pageBean中
        pageBeanProductList.setTotal(page.getTotal());
        pageBeanProductList.setItems(page.getResult());

        return pageBeanProductList;
    }
}
