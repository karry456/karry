package com.example.springboard.service.impl;

import com.example.springboard.mapper.UserMapper;
import com.example.springboard.pojo.Order;
import com.example.springboard.pojo.PageBean;
import com.example.springboard.pojo.Result;
import com.example.springboard.pojo.User;
import com.example.springboard.service.UserService;

import com.example.springboard.utils.SHA256Util;
import com.example.springboard.utils.ThreadLocalUtil;
import com.example.springboard.utils.UUIDUtils;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }

    @Override
    public User findByName(String username) {
        return userMapper.findByName(username);

    }

    // 用户注册
    @Override
    public int register(String username, String password,String role) {
        User user = new User();
        user.setUserCode(UUIDUtils.generate8DigitCode());
        user.setOnlineUsername("二手市场未命名"+UUIDUtils.generate8DigitCode().substring(4));
        user.setUserName(username);
        user.setPassWord(password);

        user.setRole(role);
        return userMapper.register(user);
    }

    @Override
    public int update(User user) {
        return userMapper.update(user);
    }

    @Override
    public void updatePhoto(String avatar) {
        Map<String,Object> map = ThreadLocalUtil.get();
        Integer userId = (Integer) map.get("userId");
        userMapper.updatephoto(avatar,userId);
    }

    @Override
    public Result updatePwd(String newPassWord,String oldPassWord) {
        Map<String,Object> map = ThreadLocalUtil.get();
        Integer userId = (Integer) map.get("userId");
        User user = userMapper.findById(userId);
        if (!user.getPassWord().equals(SHA256Util.encrypt(oldPassWord))){
            return Result.error("密码错误");
        }
        if (userMapper.updatePwd(SHA256Util.encrypt(newPassWord),userId)>0){
            return Result.success("密码修改成功");
        }
        return Result.error("密码修改失败");
    }
    @Override
    public PageBean<User> getUserPageBeanList(Integer pageNum, Integer pageSize, String userName,Integer role) {
        Map<String,Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("userId");
        String  bearRole = userMapper.findById(id).getRole();
        PageBean<User> pageBeanUserList = new PageBean<>();
        PageHelper.startPage(pageNum,pageSize);
        //调用mapper
        List<User> pageBeanUserListList = userMapper.UserPageList(userName,role, bearRole);
        //page中提供了方法，可以获取pagehelper分页查询后的结果
        Page<User> page = (Page<User>)pageBeanUserListList;
        //把数据填充到pageBean中
        pageBeanUserList.setTotal(page.getTotal());
        pageBeanUserList.setItems(page.getResult());
        return pageBeanUserList;
    }

    @Override
    public List<User> getAllUserInfo() {
        Map<String,Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("userId");
        String beaRole = userMapper.findById(id).getRole();
        return userMapper.getAllUserInfo(beaRole);
    }

    @Override
    public Result addUser(User user) {
        Map<String,Object> map = ThreadLocalUtil.get();
        Integer id = (Integer) map.get("userId");
        User userA = userMapper.findById(id);
        //转换
        Integer bearRoleNum = Integer.parseInt(userA.getRole());//当前用户身份 0
        Integer userRoleNum = Integer.parseInt(user.getRole().trim());//新用户身份 1
        if (bearRoleNum>=userRoleNum){
            return Result.error("权限不足，不能创建更高权限的用户");
        }
        if (userMapper.findByName(user.getUserName())!=null){
            return Result.error("用户已存在");
        }
        user.setUserCode(UUIDUtils.generate8DigitCode());
        user.setOnlineUsername("二手市场未命名"+UUIDUtils.generate8DigitCode().substring(4));
        user.setPassWord(SHA256Util.encrypt("123456"));
        if(userMapper.addUser(user)>0){
            return Result.success("用户创建成功");
        }else {
            return Result.success("用户创建失败");
        }
    }
}
