package com.example.springboard.controller;

import com.example.springboard.pojo.PageBean;
import com.example.springboard.pojo.Result;
import com.example.springboard.pojo.User;
import com.example.springboard.service.UserService;

import com.example.springboard.utils.JwtUtils;
import com.example.springboard.utils.SHA256Util;
import com.example.springboard.utils.ThreadLocalUtil;
import jakarta.validation.constraints.Pattern;

import org.hibernate.validator.constraints.URL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Validated
@CrossOrigin
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    // 根据id查询用户
    @RequestMapping("/findById")
    public User findById(Integer id) {
        return userService.findById(id);
    }
    // 用户注册
    @PostMapping("/register")
    public Result register(@Pattern(regexp = "^\\S{5,16}$")String userName, @Pattern(regexp = "^\\S{5,16}$")String passWord,String role){
       User user =  userService.findByName(userName);
        System.out.println(userName);
        System.out.println(passWord);
        System.out.println(role);
       if(user != null){
           return Result.error("用户已存在");
       }
       else{
           int tf=userService.register(userName, SHA256Util.encrypt(passWord),role);
           if (tf==1)
               return Result.success("注册成功");
       }
       return Result.error("注册失败");
    }
    // 用户登录
    @RequestMapping("/login")
    public Result login(String userName, String passWord){
        // 生成token
        String token="";
        User user = userService.findByName(userName);
        if(user == null){
            return Result.error("用户不存在");
        }else if(!user.isStatus()){
            return Result.error("用户被封禁,请联系管理员");
        }else if(SHA256Util.verify(passWord, user.getPassWord())){
                Map<String, Object> claims = new HashMap<>();
                claims.put("userId", user.getUserId());
                claims.put("userName", userName);
                token = JwtUtils.getToken(claims);
                System.out.println("token:"+token);
                if ("0".equals(user.getRole())) {
                    return Result.success("超级管理员:" + userName + "登录成功", token);
                }else if ("1".equals(user.getRole())){
                    return Result.success("管理员:"+userName+"登录成功", token);
                }else{
                    return Result.success("用户:"+userName+"登录成功", token);
                }
        }
        return Result.error("密码错误");
    }

    //获取个人信息
    @RequestMapping("/userInfo")
    public Result<User> userInfo(){
        Map<String, Object> map = ThreadLocalUtil.get();
        return Result.success(userService.findByName((String) map.get("userName")));
    }

//    // 获取个人用户信息
//    @RequestMapping("/userInfo")
//    public Result<User> userInfo(@RequestHeader(name = "Authorization")String  token){
//        Map<String ,Object> map = ThreadLocalUtil.get();
//        String userName = (String) map.get("userName");
//        User user=userService.findByName(userName);
//        return Result.success(user);
//    }
    // 修改用户信息
    @RequestMapping("/update")
    public Result update(@RequestBody User user){
        System.out.println(user.getUserId());
        userService.update(user);
        return Result.success("修改成功");
    }
    // 修改用户头像
    @RequestMapping("/updateAvatar")
    public Result updatePhoto(@RequestBody User user){
        userService.updatePhoto(user.getAvatar());
        return Result.success("修改成功");
    }

    //退出登录
    @RequestMapping("/logout")
    public Result logout(){
        ThreadLocalUtil.remove();
        System.out.println("退出登录");
        return Result.success("退出成功");
    }

    //获取全部用户信息
    @RequestMapping("/getAllUser")
    public Result<PageBean<User>> getAllUser(
            Integer pageNum,// 页数
            Integer pageSize,// 页大小
            @RequestParam(required = false) String userName,//根据用户名查找
            @RequestParam(required = false) Integer role//根据角色类型查找
    ){
        PageBean<User> userPageBeanList = userService.getUserPageBeanList(pageNum, pageSize, userName,role);
        return Result.success(userPageBeanList);
    }


    //获取用户的所有信息
    @GetMapping("/getUserInfo")
    public Result<List<User>> getUserInfo(){
        List<User> user =userService.getAllUserInfo();
        return Result.success(user);
    }

    //管理员创建用户
    @RequestMapping("/addUser")
    public Result addUser(@RequestBody User user){
        System.out.println(user.getUserName());
        Result result = userService.addUser(user);
        if (result.getCode()==1){
            return Result.error(result.getMessage());
        }else {
            return Result.success(result.getMessage());
        }
    }

    //修改密码
    @RequestMapping("/updatePwd")
    public Result updatePwd(@RequestBody Map<String, String> request){
        String newPassWord = request.get("passWord");
        String oldPassWord=request.get("oldPassWord");

        Result result  =userService.updatePwd(newPassWord, oldPassWord);
        if (result.getCode()==1){
            return Result.error(result.getMessage());
        }else {
            return Result.success(result.getMessage());
        }
    }
}
