import request from '@/utils/request.js'

// import {useTokenStore} from '@/store/token.js'
export const getUserListService = (param) => {
    // const tokenStore=useTokenStore();


    // return request.get('/category/showAll',{headers:{'Authorization':tokenStore.token}})

    return request.get('/user/getAllUser',{ params: param })
}

// 正确的方式：使用 FormData 传递包含文件的数据
export const addUserService = (data) => {

  return request.post('/user/addUser',data)
};

export const updateUserService = (data) => {
    
    return request.post('/user/update',data)
}

//删除图片
export const deleteProductService = (data) => {
  console.log(data);
  
    return request.post('/fileDel',{fileName:data} )
}

//用户的所有信息（不分页）
export const getAllUserRoleService = () => {
    return request.get('/user/getUserInfo')
}