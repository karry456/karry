package com.example.springboard.mapper;

import com.example.springboard.pojo.Product;
import org.apache.ibatis.annotations.*;

import java.util.List;
@Mapper
public interface ProductMapper {

    List<Product> list();

    @Insert("insert into product (productNo,productName,productPhoto,productType,productPrice,productState,productInfo,userId,createTime,updateTime) " +
            "values(#{productNo},#{productName},#{productPhoto},#{productType},#{productPrice},#{productState},#{productInfo},#{userId},NOW(),NOW())")
    int  add(Product product);

    @Delete("delete from product where productNo=#{productNo}")
    void delete(Integer id);

    void update(Product product);

    @Select("select * from product where productId= #{productId}")
    Product getProductById(Integer productId);

    //根据商品类型查找商品
    @Select("select * from product where productType= #{productType}")
    List<Product> getProductByType(String productType);

    List<Product> PageList(String productType, String productName);
}
