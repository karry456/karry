package com.example.springboard.controller;
import com.example.springboard.pojo.Product;
import com.example.springboard.pojo.Result;
import com.example.springboard.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Collections;
import java.util.List;
@RestController
@CrossOrigin
@RequestMapping("/WeChar")
public class UserAllController {
    @Autowired
    private ProductService productService;
    @RequestMapping("/showAll")
    public Result<List<Product>> showAll() {
        List<Product> categories = productService.list();
        Collections.shuffle(categories);
        return Result.success(categories);
    }
}
