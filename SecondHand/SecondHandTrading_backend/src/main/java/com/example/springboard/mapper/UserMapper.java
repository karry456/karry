package com.example.springboard.mapper;

import com.example.springboard.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface UserMapper {
    @Select("select * from user where userId=#{userId}")
    User findById(Integer id);

    @Select("select * from user where userName=#{userName}")
    User findByName(String userName);

    int register(User user);

    @Update("update user set avatar=#{avatar},onlineUsername=#{onlineUsername},email=#{email},telephoneNumber=#{telephoneNumber}," +
            "status=#{status},role=#{role},balance=#{balance},updateTime=NOW() where userId=#{userId}")
    int update(User user);

    @Update("update user set avatar=#{avatar},updateTime=NOW() where userId=#{userId}")
    void updatephoto(String avatar,Integer userId);

    @Update("update user set passWord=#{passWord},updateTime=NOW() where userId= #{userId}")
    int updatePwd(String passWord,Integer userId);

    //分页查询
    List<User> UserPageList(String userName,Integer role, String bearRole);

    //查询所有用户信息权限
    @Select("select * from user where role>#{beaRole}")
    List<User> getAllUserInfo(String beaRole);

    //管理员创建用户
    int addUser(User user);
}
