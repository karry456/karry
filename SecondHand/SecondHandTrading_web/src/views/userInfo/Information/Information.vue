<template> 
  <el-card>
    <template>
      <div class="header">
        <span>基本信息</span>
      </div>
    </template>
    <el-row>
        <el-col>
            <el-form :model="user" :rules="rules" label-width="100px" size="large">
              <el-form-item label="登录名称" prop="userName">
                <el-input v-model="user.userName" disabled></el-input>
              </el-form-item>
              <el-form-item label="用户昵称" prop="onlineUsername">
                <el-input v-model="user.onlineUsername"></el-input>
              </el-form-item>
              <el-form-item label="用户邮箱" prop="email">
                <el-input v-model="user.email"></el-input>
              </el-form-item>
              <el-form-item label="用户电话" prop="telephoneNumber">
                <el-input v-model="user.telephoneNumber"></el-input>
              </el-form-item>
                <el-form-item label="用户余额" prop="balance" >
                <el-input v-model="user.balance" disabled></el-input>
              </el-form-item>
              <!-- 用户身份 -->
               <el-form-item label="用户身份" prop="role" >
                <el-select v-model="user.role" placeholder="请选择用户身份" disabled>
                  <el-option label="普通用户" :value="2"></el-option>
                  <el-option label="管理员" value="1"></el-option>
                  <el-option label="超级管理员" value="0"></el-option>
                </el-select>
              </el-form-item>

              <el-form-item>
                <el-button type="primary" @click="updateUserInfo">确认修改</el-button>
              </el-form-item>
            </el-form>
        </el-col>
    </el-row>
  </el-card>

</template>
<script setup lang="ts"> 

import { ref } from 'vue'
import { useTokenStore } from '@/store/token'
import {ElMessage} from 'element-plus'
import { getUserInfoService,updateUserInfoService } from '@/views/userInfo/Information/Information.js'
// 表单验证
const rules = ref({
    onlineUsername: [
      { required: true, message: '请输用户昵称', trigger: 'change' },{ min: 5, max: 16, message: '用户昵称长度必须在5~16位之间', trigger: 'change' },
    ],
    email:[
        { required: true, message: '请输入电子邮件', trigger: 'change' },{pattern: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,message: '请输入正确的电子邮箱格式（如：xxx@xxx.com）',trigger: 'change'}
    ],
    telephoneNumber: [
      { required: true, message: '请输入用户电话', trigger: 'change' },{pattern: /^1[3-9]\d{9}$/,message: '请输入正确的11位手机号码',trigger: 'change'}
    ],
})

getUserInfoService().then(result=>{ 
    console.log(result);
    user.value = result.data
})

//确认修改
const updateUserInfo = async () => {
    let result=await updateUserInfoService(user.value)
          if ((result as any).code==0) {
            ElMessage.success('修改成功！');
          }else{
            ElMessage.error('修改失败！');
          }
          console.log(result);
          
}

const user=ref({
    userId:"",
    userCode:'',
    avatar:'',
    userName:'',
    passWord:'',
    onlineUsername:'',
    email:'',
    telephoneNumber:'',
    status:'',
    role:'',
    balance:'',
    createTime:'',
    updateTime:''
})
</script>
<style scoped> 
</style>