import request from '@/utils/request.js'

import {useTokenStore} from '@/store/token.js'

export const getCartAllListService = () => {
    return request.get('/cart/showAll')
}

export const addCartService = (data) => {
    return request.post('/cart/add',data)
}

//删除购物车
export const deleteCartService = (data) => {
    return request.post('/cart/delete',data)
}