import request from '@/utils/request.js'

import {useTokenStore} from '@/store/token.js'

export const getOrderAllListService = () => {
    return request.get('/order/showAll')
}

export const addOrderService = (data) => {
    return request.post('/order/add',data)
}

//删除订单
export const deleteOrderService = (data) => {
    return request.post('/order/delete',data)
}

//分页查询
export const showAllBageService = (param) => {
    return request.get('/order/PageList',{ params: param })
}

//修改订单状态
export const updateOrderService = (data) => {
    return request.post('/order/updateStatus',data)
}