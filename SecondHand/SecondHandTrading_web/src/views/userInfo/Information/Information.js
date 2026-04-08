import request from '@/utils/request.js'

// import {useTokenStore} from '@/store/token.js'
export const getUserInfoService = (param) => {
    // const tokenStore=useTokenStore();

    return request.get('/user/userInfo')
}

export const updateUserInfoService = (data) => {
    return request.post('/user/update',data)
}