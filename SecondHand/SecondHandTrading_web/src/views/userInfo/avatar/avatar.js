import request from '@/utils/request.js'

// import {useTokenStore} from '@/store/token.js'
export const getUserInfoService = (param) => {
    // const tokenStore=useTokenStore();


    // return request.get('/category/showAll',{headers:{'Authorization':tokenStore.token}})

    return request.get('/user/userInfo')
}

//修改头像
export const updateUserAvatarService = (data) => {
    return request.post('/user/updateAvatar',data)
}