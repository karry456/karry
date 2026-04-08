<template> 
  <el-card>
    <template>
      <div class="header">
        <span>基本信息</span>
      </div>
    </template>
    <el-row>
        <el-col>
            <el-form ref="addForm" :model="updataPaswData" :rules="rules" label-width="100px" size="large">
              <el-form-item label="登录名称" prop="userName">
                <el-input v-model="user.userName" disabled></el-input>
              </el-form-item>
              <el-form-item label="旧密码" prop="oldPassWord">
                <el-input v-model="updataPaswData.oldPassWord" type="password"></el-input>
              </el-form-item>
              <el-form-item label="密码" prop="passWord">
                <el-input v-model="updataPaswData.passWord" type="password"></el-input>
              </el-form-item>
              <el-form-item label="确认密码" prop="rePassword">
                <el-input v-model="updataPaswData.rePassword" type="password"></el-input>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="updateUserInfo" :disabled="!isFormValid">确认修改</el-button>
              </el-form-item>
            </el-form>
        </el-col>
    </el-row>
  </el-card>

</template>
<script setup lang="ts"> 

import { ref } from 'vue'
import { computed,watch  } from 'vue'
import { useTokenStore } from '@/store/token'
import {ElMessage} from 'element-plus'
const addForm = ref(null)
import {getUserInfoService, updateUserPaswService } from '@/views/userInfo/ChangePaw/ChangePaw.js'
const checkRePassword=(rule, value, callback)=>{
  // 空值已由 required: true 校验，此处只需判断密码一致性
  if (value !== updataPaswData.value.passWord) {
    callback(new Error("两次输入的密码不一致"));
  } else {
    callback();
  }
};
//确定修改密码的数据
const updataPaswData=ref({
  oldPassWord:"",
  passWord:"",
  rePassword:"",
})
// 表单验证
const rules = ref({
    passWord: [
      { required: true, message: '请输入密码', trigger: 'change' },{ min: 5, max: 16, message: '用户密码长度必须在5~16位之间', trigger: 'change' },
    ],
    rePassword:[
        {required: true, validator : checkRePassword, trigger: 'change' }
    ],
    oldPassWord: [
      { required: true, message: '请输入旧密码', trigger: 'change' },{ min: 5, max: 16, message: '用户密码长度必须在5~16位之间', trigger: 'change' },
    ],
    userName: [{ required: false }]

})

const isFormValid = ref(false)
watch(updataPaswData, () => {
  addForm.value?.validate((valid) => {
    isFormValid.value = valid;
  });
}, { deep: true });


getUserInfoService().then(result=>{ 
    console.log(result);
    user.value = result.data
})

//确认修改
const updateUserInfo = async () => {
    let result=await updateUserPaswService(updataPaswData.value)
          if ((result as any).code==0) {
            ElMessage.success('修改成功！');
          }else{
            ElMessage.error('修改失败！');
          }
          console.log(result);
          
}
//定义用户数据
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