<script setup lang="ts">
  const URl = ref('10.69.135.202')
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { Plus, Upload } from '@element-plus/icons-vue'
const addForm = ref(null)
const user = ref([])
import { useTokenStore } from '@/store/token'

import {getUserInfoService,updateUserAvatarService} from '@/views/userInfo/avatar/avatar.js' 
const tokenStore = useTokenStore()
// 修改文章表单显示
const diaUpdateVisible = ref(false)
//定义表单数据
const userModel=ref({
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

const getUserInfo = () => {
return getUserInfoService().then(result=>{ 
    console.log(result);
    user.value = result.data
    userModel.value = result.data
    imageUrl.value = userModel.value.avatar
})
}
  
//上传成功之后的回调
const uploadSuccess = (res) => {
    imageUrlUp.value=userModel.value.avatar
    imageUrl.value = res.message;
    userModel.value.avatar = res.message;
}
//新的图片地址
const imageUrl = ref('');
//用于修改之前的图片地址
const imageUrlUp = ref('');

const maxSize = ref(1 * 1024 * 1024);
const beforeUpload = (file) => {
  // 判断文件大小是否超出限制（假设 maxSize 已定义）
  const isOverSize = file.size > maxSize.value;
  if (isOverSize) {
    ElMessage.error(`文件大小不能超过 ${maxSize.value / 1024 / 1024} MB！`);
    return false;
  }
  return true;
}
getUserInfo()

//确定修改信息
const updateUserInfo = async () => {
  let result=await updateUserAvatarService(userModel.value)
  if((result as any).code==0){
    ElMessage.success('修改成功！')
  }else{
    ElMessage.error('修改失败！')
  }
}
</script>

<template>
  <el-card>
    <template #header>
      <div>
        <span>更换头像</span>
      </div>
      <el-row>
        <el-col :span="12">
            <el-upload
                name="file"
                class="avatar-uploader"
                action="/api/upload"
                :auto-upload="true"
                :on-success="uploadSuccess"
                :headers="{Authorization:tokenStore.token}"
                :limit="1" 
                :data="{ folderName: 'user' }"
                :before-upload="beforeUpload"
                >
                <img v-if="imageUrl" :src="'http://'+URl+':8080/images/' +imageUrl" class="avatar" />
                    <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
                </el-upload>
                <br/>
                <el-button type="success" @click="updateUserInfo" :icon="Upload">确定上传</el-button>
        </el-col>
      </el-row>
    </template>
  </el-card>

</template>


<style scoped>
.avatar{
  width: 200px;
  height: 200px;
  border-radius: 50%;
  object-fit: cover;
  margin: 0 auto;
  display: block;
}
.avatar-uploader{
  width: 200px;
  height: 200px;;
}


</style>
