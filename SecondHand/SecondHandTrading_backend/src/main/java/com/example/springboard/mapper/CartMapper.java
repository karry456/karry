package com.example.springboard.mapper;

import com.example.springboard.pojo.Cart;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CartMapper {

    //根据id查询
    @Select("select * from cart where userId=#{id}")
    List<Cart> getById(Integer id);


    // 查询所有
    List<Cart> showAll();

    //删除
    @Delete("delete from cart where cartId=#{id}")
    int deleteCart(Integer id);

    //添加
    @Insert("insert into cart (userId,productId,cartSize,cartNum,createTime) values (#{userId},#{productId},#{cartSize},#{cartNum},NEW())")
    int  addCart(Cart cart);
}
