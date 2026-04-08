import {createRouter,createWebHistory} from 'vue-router'

import LoginVue  from '@/views/login.vue'
import LayoutVue from '@/views/LayoutVue.vue'
import { checkTagEmits } from 'element-plus'

const routes=[
    {
        path:'/login',
        component:LoginVue
    },
    {
        path:'/',
        component:LayoutVue,
        redirect:'/views/Product/product' ,//默认跳转
        children:[
            {
                path:'/views/Product/product',
                component:()=>import('@/views/Product/product.vue')
            },
            {
                path:'/views/Order/Order',
                component:()=>import('@/views/Order/Order.vue')
            },
            {
                path:'/views/User/User',
                component:()=>import('@/views/User/User.vue'),
            },
            {
                path:'/views/userInfo/Information/Information',
                component:()=>import('@/views/userInfo/Information/Information.vue'),
            },
            {
                path:'/views/userInfo/avatar/avatar',
                component:()=>import('@/views/userInfo/avatar/avatar.vue')
            },
            {
                path:'views/userInfo/ChangePaw/ChangePaw',
                component:()=>import('@/views/userInfo/ChangePaw/ChangePaw.vue')
            }
            ]
            },
        
    
]

//创建路由器
const router=createRouter({
    //路由模式

    history:createWebHistory(),
    routes:routes
})


export default router;