import request from '@/utils/request.js'

//修改用户密码
export const updateUserPaswService = (data) => {
    return request.post('/user/updatePwd',data)
}
//获取用户信息
export const getUserInfoService = (param) => {
    // const tokenStore=useTokenStore();

    return request.get('/user/userInfo')
}
