package com.example.springboard.service;

import com.example.springboard.pojo.PageBean;
import com.example.springboard.pojo.Result;
import com.example.springboard.pojo.User;

import java.util.List;

public interface UserService {
    public User findById(Integer id);

    User findByName(String username);

    int register(String username, String password,String role);


    int update(User user);

    void  updatePhoto(String avatar);

    Result updatePwd(String newPassWord,String oldPassWord );

    PageBean<User> getUserPageBeanList(Integer pageNum, Integer pageSize, String userName,Integer role);

    List<User> getAllUserInfo();

    //管理员创建用户
    Result addUser(User user);
}
