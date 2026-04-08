import axios from "axios";
import { ElMessage,ElMessageBox  } from 'element-plus'


// const baseURL="http://localhost:8080";
const baseURL="/api";

import {useTokenStore} from "@/store/token.js"

// import { useRouter } from "vue-router";
// const router=useRouter();
import router from "@/router";

const instance=axios.create({baseURL})
// 添加请求拦截器
// 添加请求拦截器
instance.interceptors.request.use(
    (config) => {
        // 在发送请求之前做些什么
        const tokenStore = useTokenStore(); // 在函数内部获取
        if(tokenStore.token){ 
            config.headers.Authorization = tokenStore.token;
        }
        return config
    },
    err => {
        // 对请求错误做些什么
        return Promise.reject(err)
    }
)

// 添加响应拦截器
instance.interceptors.response.use(
    result => { 
        if(result.data.code === 0){
            return result.data
        }  
        ElMessage.error(result.data.message !== '' ? result.data.message : "服务器异常!!")
        return Promise.reject(result.data)
    },
    err => {
        if(err.response && err.response.status === 401){ // 增加安全检查
            const tokenStore = useTokenStore();
            if(tokenStore.token ) {
                // 有token但失效了，说明是过期
                 ElMessageBox.alert('登录已过期，请重新登录', '提示', {
                    confirmButtonText: '确定',
                    type: 'warning'
                    }).then(() => {
                        tokenStore.removeToken()
                        router.push('/login')
                    })
            } else {
                // 没有token，说明从未登录
                ElMessage.error('请先登录')
                tokenStore.removeToken()
                router.push('/login')
            }
            
        } else {
            ElMessage.error('服务器异常')
        }
        
        return Promise.reject(err)
    }  
)
// 添加 token 过期检查函数
function isTokenExpired(token) {
    try {
        const payload = JSON.parse(atob(token.split('.')[1]));
        const currentTime = Date.now() / 1000;
        return payload.exp < currentTime;
    } catch (e) {
        return true;
    }
}
export default instance;