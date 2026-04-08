import request from "../utils/request";

//提供注册接口的函数

export const userRegisterService= (registerDate)=>{
    const params =new URLSearchParams();
    for (let key in registerDate) {
        params.append(key,registerDate[key])
    }
    return request.post("/user/register",params);
}


export const userLoginService= (loginDate)=>{
    const params =new URLSearchParams();
    for (let key in loginDate) {
        params.append(key,loginDate[key])
    }
    return request.post("/user/login",params);
}

//获取用户详细信息
export const getUserInfoService = () => {
    return request.get('/user/userInfo')
}

//退出登录
export const logoutService = () => {
    return request.get('/user/logout')
}