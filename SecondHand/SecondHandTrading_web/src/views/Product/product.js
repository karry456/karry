import request from '@/utils/request.js'

// import {useTokenStore} from '@/store/token.js'
export const getProductListService = (param) => {
    // const tokenStore=useTokenStore();


    // return request.get('/category/showAll',{headers:{'Authorization':tokenStore.token}})

    return request.get('/product/showAll',{ params: param })
}

// 正确的方式：使用 FormData 传递包含文件的数据
export const addProductService = (data) => {

  return request.post('/product/add',data)
};

export const updateProductService = (data) => {
    return request.post('/product/update',data)
}

//删除图片
export const deleteProductService = (data) => {
  console.log(data);
  
    return request.post('/fileDel',{fileName:data} )
}

//获取商品的所有信息（不分页）
export const getAllProductService = () => {
    return request.get('/product/getAllProduct')
}