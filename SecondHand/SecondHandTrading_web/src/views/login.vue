<script setup>

    import {User,Lock} from '@element-plus/icons-vue'
    import  {userRegisterService,userLoginService} from '@/api/user.js'
    import {ref} from 'vue'
    import { ElMessage } from 'element-plus'
    const isRegister=ref(false)

    const registerData=ref({
        userName:"",
        passWord:"",
        rePassword:"",
        role:"2",
    })
    
    const checkRePassword=(rule,value,callback)=>{
        if(value==''){
            callback(new Error("请输入确认密码"))
        }else if(value !==registerData.value.passWord){
            callback(new Error("两次输入的密码不一致"))
        }else{
            callback
        }
    }

    // 定义表单校验规则
    const rules = {
        userName: [
            { required: true, message: '请输入用户名', trigger: 'change' },
            { min: 5, max: 16, message: '长度在 5 到 16 位非空字符', trigger: 'change' }
        ],
        passWord: [
            { required: true, message: '请输入密码', trigger: 'change' },
            { min: 6, max: 10, message: '长度在 5 到 16 个非空字符', trigger: 'change' }
        ]
        ,
        rePassword: [
            {validator : checkRePassword, trigger: 'change'}
    
        ]
    }

    //调用后台接口
    const  register=async()=>{
        let result=await userRegisterService(registerData.value)
            ElMessage.success(result.message!='' ? result.message : "注册成功")
            setTimeout(()=>{
                isRegister.value=false
            },2000)

    }
   
import { computed } from 'vue'

const isUsernameValid = computed(() => {
  const userName = registerData.value.userName
  return userName && userName.length >= 5 && userName.length <= 16
})

const isPasswordValid = computed(() => {
  const passWord = registerData.value.passWord
  return passWord && passWord.length >= 6 && passWord.length <= 20
})

const isPasswordMatch = computed(() => {
  return registerData.value.passWord === registerData.value.rePassword
})

// 综合验证条件控制按钮状态
const isFormValid = computed(() => {
  return isUsernameValid.value && 
         isPasswordValid.value && 
         isPasswordMatch.value
         
})


const islogin = computed(() => {
  return registerData.value.userName.length>0 && 
         registerData.value.passWord.length>0
})

import { useTokenStore } from '@/store/token.js'
import { useRouter } from 'vue-router'

const tokenStore = useTokenStore();

const router = useRouter()

const  login =async () => {
    await userLoginService(registerData.value).then(result=>{
        // if(result.code==0){
        //     ElMessage.success(result.message!='' ? result.message : "登录成功")
        //     router.push('/')//页面跳转
        // }else{
        //     ElMessage.error(result.message!='' ? result.message : "登录失败")
        // }
        ElMessage.success(result.message!='' ? result.message : "登录成功")
        localStorage.setItem("rememberMe",registerData.value.rememberMe)
        tokenStore.setToken(result.data)
        router.push('/')
    })
}

const clearRegisterData = () => { 
    registerData.value={
        userName:"",
        passWord:"",
        rePassword:"",
        role:"2",
    }
}

</script>

<template>
    <el-row class="login-page">
        <el-col :span="12" class="bg"></el-col>
        <el-col :span="9"   class="form">
            <el-form ref="form" size="large" autocomplete="off" v-if="isRegister" :model="registerData" :rules="rules">
                <el-form-item>
                    <h1>注册</h1>
                </el-form-item>
                <el-form-item prop="username">
                    <el-input  :prefix-icon="User" placeholder="请输入用户名" v-model="registerData.userName"></el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input  :prefix-icon="Lock" type="password" placeholder="请输入密码" v-model="registerData.passWord"></el-input>
                </el-form-item>
                <el-form-item prop="rePassword">
                    <el-input  :prefix-icon="Lock" type="password" placeholder="请输入确认密码" v-model="registerData.rePassword"></el-input>
                </el-form-item>
                <!-- 注册按钮 -->
                 <el-form-item>
                    <el-button class="button" type="primary" auto-insert-space @click="register()" :disabled="!isFormValid">
                        注册
                    </el-button>
                </el-form-item>
                <el-form-item class="felx">
                    <el-link type="info" :underline="false" @click="isRegister=false,clearRegisterData()">
                        已有账号？去登录
                    </el-link>
                </el-form-item>
            </el-form >
    <!-- 登录表单 -->
     <el-form ref="form" size="large" autocomplete="off" v-else :model="registerData"> 
        <el-form-item>
            <h1>登录</h1>
        </el-form-item>
        <el-form-item>
            <el-input  :prefix-icon="User" placeholder="请输入用户名" v-model="registerData.userName"></el-input>
        </el-form-item>
        <el-form-item>
            <el-input  :prefix-icon="Lock" type="password" placeholder="请输入密码" v-model="registerData.passWord"></el-input>
        </el-form-item>
        <el-form-item class="flex">
            <div class="eff">
                <el-checkbox v-model="registerData.rememberMe">记住我</el-checkbox>
                <el-link type="primary" :underline="false">忘记密码？</el-link>
            </div>   
         </el-form-item>
            <!-- 登录按钮 -->
             <el-form-item>
                <el-button class="button" type="primary" auto-insert-space @click="login" :disabled="!islogin">
                    登录</el-button>
             </el-form-item>
             <el-form-item class="flex">
                <el-link type="info" :underline="false" @click="isRegister=true,clearRegisterData()">
                    没有账号？去注册
                </el-link>
        </el-form-item>
    </el-form>

  </el-col>
</el-row>
</template>

<style scoped>
.login-page{
    height: 90vh;
}
.bg{
    background-image: url("../assets/login.jpg");
    background-size:cover   ;
    border-radius: 20px;
    margin-left: 100px;
 
}
.form {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 50px;
    background-color: #ffffff;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    width: 200px;
}

.button{
    width: 100%;
}
.flex{
    display: flex;
    justify-content: space-between;
}
.eff{
    display: flex; /* 启用Flex布局 */
  justify-content: space-between; /* 核心属性：子元素两端对齐，中间自动留白 */
  width: 500px; /* 父容器需指定宽度 */
}


.el-alert:first-child {
  margin: 0;
}
.form :deep(.el-form) {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* 确保表单项目也居中 */
.form :deep(.el-form-item) {
    width: 100%;
    display: flex;
    justify-content: center;
}

</style>