package com.example.springboard.controller;
import com.example.springboard.pojo.PageBean;
import com.example.springboard.pojo.Product;
import com.example.springboard.pojo.Result;
import com.example.springboard.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;


import java.io.IOException;

import java.util.Collections;
import java.util.List;


@Slf4j
@RestController
@CrossOrigin
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductService productService;

    @Value("${file.upload.path}")
    private String uploadPath;
    @RequestMapping("/showAll")
    public Result<PageBean<Product>> showAll(
            Integer pageNum,
            Integer pageSize,
            @RequestParam (required = false) String productType,
            @RequestParam (required = false) String productName
    ) {
        PageBean<Product> productList = productService.PageList(pageNum, pageSize,productType,productName);
        return Result.success(productList);
    }

    @PostMapping("/add")
    public Result add(@RequestBody Product product) throws IOException {
        if (productService.add(product)>0) {
            return Result.success("添加成功");
        }else {
            return Result.error("添加失败");
        }
    }
    @GetMapping("/delete")
    public Result delete(@RequestBody Integer id) {
        productService.delete(id);
        return Result.success("删除成功");
    }
    @PostMapping("/update")
    public Result update(@RequestBody Product product) {
        productService.update(product);
        return Result.success("修改成功");
    }

    //更加商品类型获取商品
    @GetMapping("/getProductByType")
    public Result<List<Product>> getProductByType(@RequestParam("productType") String productType) {
        List<Product> products = productService.getProductByType(productType);
        return Result.success(products);
    }

    //获取所有商品的信息
    @GetMapping("/getAllProduct")
    public Result<List<Product>> getAllProduct() {
        List<Product> products = productService.list();
        //打乱顺序
        Collections.shuffle(products);

        return Result.success(products);
    }

}
