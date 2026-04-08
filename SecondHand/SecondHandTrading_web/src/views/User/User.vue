<script lang="ts" setup>
import {
  Check,
  Delete,
  Edit,
  Message,
  Search,
  Star,
} from '@element-plus/icons-vue'
const URl = ref('10.69.135.202')
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
const addForm = ref(null)
const user = ref([])
import { getUserListService,//获取所有用户的信息(分页)
    addUserService, //添加用户
    updateUserService,//修改用户
    deleteProductService, //删除商品
    getAllUserRoleService//获取所有用户信息(不分页)
} from '@/views/User/User.js'
import { c } from 'naive-ui'
import { useTokenStore } from '@/store/token'
//分页
const pageNum = ref(1)//当前页
const total = ref(20)//总条数
const pageSize = ref(4)//每页显示的条数

const userName = ref('')
const role = ref('')

const userAllList = ref([])
const userListType = ref([])
//当每页条数发生变化，调用此函数
const onSizeChange=(size)=>{
    pageSize.value = size
    articleUserList()
}

//当前页码发生变化，调用此函数
const onCurrentChange=(num)=>{
    pageNum.value = num
    articleUserList()
}

//回显商品分类
const userList=async()=>{
    let result=await getAllUserRoleService();

    userAllList.value=result.data.role

    const allUserTypes = result.data.map(item => item.role);
    // 2. 去重后赋值
    userListType.value = Array.from(new Set(allUserTypes));
}

//获取商品类别的信息
userList()

const tokenStore = useTokenStore()
// 获取商品列表分页
const articleUserList=async()=>{
    let param={
        pageNum : pageNum.value,
        pageSize : pageSize.value,
        userName : userName.value ? userName.value :null,//商品类别进行商品查询
        role : role.value ? role.value :null//根据名称进行商品查询
    }
    
   let result=await getUserListService(param);
   total.value=result.data.total
   user.value=result.data.items
  //  for(let i=0;i<user.value.length;i++){
  //   let p = user.value[i]
  //   for(let j=0;j<user.value.length;j++){
  //       if(p.productId==user.value[j].productId){
  //           p.productName=user.value[j].productName
  //       }
  //   }
  //  }
    
}

//弹出取消商品添加
const falseAddProductDisPlay=async()=>{
    if(imageUrl.value!=''){
      //删除图片
        deleteProductService(imageUrl.value)
    }
    dialogVisible.value=false
    clearUserModel()
    imageUrl.value=''
}
// 添加表单显示
const dialogVisible = ref(false)
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
//清空表单
const clearUserModel = () => {
  userModel.value = {
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
  }
}
const isFormValid = ref(false)
// 表单验证
const rules = ref({
    avatar: [
      { required: true, message: '请选择用户头像', trigger: 'change' }
      
    ],
    userName: [
      { required: true, message: '请输入登录名', trigger: 'change' },{ min: 5, max: 16, message: '用户昵称长度必须在5~16位之间', trigger: 'change' },
      
    ],
    passWord: [
      { required: true, message: '请输入用户密码', trigger: 'change' },{ min: 5, max: 16, message: '用户密码长度必须在5~16位之间', trigger: 'change' },
      
    ],
    onlineUsername: [
      { required: true, message: '请输用户昵称', trigger: 'change' },{ min: 5, max: 16, message: '用户昵称长度必须在5~16位之间', trigger: 'change' },
      
    ],
    email:[
        { required: true, message: '请输入电子邮件', trigger: 'change' },{pattern: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,message: '请输入正确的电子邮箱格式（如：xxx@xxx.com）',trigger: 'change'}
    ],
    telephoneNumber: [
      { required: true, message: '请输入用户电话', trigger: 'change' },{pattern: /^1[3-9]\d{9}$/,message: '请输入正确的11位手机号码',trigger: 'change'}
      
    ],
    status: [
      { required: true, message: '请选择用户状态', trigger: 'change' },
      
    ],
    role: [
      { required: true, message: '请选择用户状态', trigger: 'change' },
      
    ],
    balance: [
      { required: true, message: '请输入用户金额', trigger: 'change' },{ type: 'number', min: 0, message: '金额必须大于0', trigger: 'change' }
    ],
})
import { computed,watch  } from 'vue'
// 综合验证条件控制按钮状态
// const isFormValid = computed(() => {
//   const { avatar, onlineUsername,
//     telephoneNumber, status, role, balance
//    } = userModel.value
//   return avatar.trim() !== '' && onlineUsername.trim() !== '' && telephoneNumber !== '' && status !== '' && role !== '' && balance !== ''
// })

// 调用接口，获取商品列表
articleUserList();
// 调用接口，添加表单
const addProduct = async () => {
        await addUserService(userModel.value).then(result=>{  
          console.log(result);
          
        if ((result as any).code==0) {
            ElMessage.success("添加成功");
            articleUserList(); 
        } else {
            ElMessage.error("添加失败"); // 这里补全了属性访问
        }
        clearUserModel()
        dialogVisible.value = false;
        })}

// 显示修改对话框并填充当前行数据
const showUpdateDialog = (row) => {
  userModel.value = {
    userId: row.userId,
    userCode:row.userCode,
    avatar:row.avatar,
    userName:row.userName,
    passWord:row.passWord,
    onlineUsername:row.onlineUsername,
    email:row.email,
    telephoneNumber:row.telephoneNumber,
    status:row.status,
    role:row.role,
    balance:row.balance,
    createTime:row.createTime,
    updateTime:row.updateTime
  }
  diaUpdateVisible.value = true
}
//关闭修改对话框
const closeUpdateDialog = () => {
    console.log(imageUrl);
    
    if(imageUrl.value!='' && imageUrl.value!="https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg"){
        deleteProductService(imageUrl.value)
    }
    clearUserModel()
    diaUpdateVisible.value = false
    imageUrl.value=''
}
//修改表单提交
const updateUserInfo = async () => {
        let result = await updateUserService(userModel.value);
        imageUrl.value=imageUrlUp.value
        if ((result as any).code == 0) {
            ElMessage.success("修改成功");
            closeUpdateDialog()
            articleUserList()
        }else {
            ElMessage.error("修改失败");
        }
        imageUrl.value=''
        clearUserModel() 
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


//监听表单数据
watch(userModel, () => {
  addForm.value?.validate((valid) => {
    isFormValid.value = valid;
  });
}, { deep: true });

// 根据值返回对应的标签文本
const   getUserTypeLabel=(value)=> {
      switch (value) {
        case "0":
          return '超级管理员';
        case "1":
          return '管理员';
        case "2":
          return '用户';
        default:
          return ''; // 兜底，避免无匹配值时显示异常
      }
}

</script>
<template>
    <el-card class="custom-card"> 
        <template #header>
            <div class="header">
                <span>用户管理</span>
                        <!-- 搜索菜单 -->
                <el-form inline>
                    <el-form-item label="用户身份">
                        <el-select placeholder="全部" v-model="role" style="width: 120px;" @change="articleUserList">
                            <el-option label="全部" value=""></el-option>
                            <el-option v-for="c in userListType" :key="c" :label="getUserTypeLabel(c)" :value="c"></el-option>
                        </el-select>
                    </el-form-item>
                </el-form>
                <!-- 搜索商品名称 -->
                 <el-form inline>
                    <el-form-item label="用户名称">
                        <el-input v-model="userName" placeholder="请输入用户登录名" style="width: 200px;" @change="articleUserList"></el-input>
                    </el-form-item>
                </el-form>
                <div>
                    <el-button type="primary" @click="dialogVisible=true">添加用户</el-button>
                </div>
            </div>
        </template>

        <!-- 商品列表 -->
        <el-table :data="user"  class="small-text-table">
            <!-- <el-table-column label="序号" width="100" type="index"></el-table-column> -->
                <el-table-column label="用户头像" prop="avatar">
                  <template #default="{row}">
                    <el-image v-if="row.avatar=='https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg'" :src="'https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg'" class="ImgList"></el-image>
                    <el-image v-else :src="'http://'+URl+':8080/images/'+row.avatar" class="ImgList"></el-image>
                  </template>
                </el-table-column>
                <el-table-column label="用户编号" prop="userCode"></el-table-column>
                <el-table-column label="用户名称" prop="userName"></el-table-column>
                <el-table-column label="用户网名" prop="onlineUsername"></el-table-column>
                <el-table-column label="用户邮箱" prop="email"></el-table-column>
                <el-table-column label="用户电话" prop="telephoneNumber"></el-table-column>
                <el-table-column label="用户状态" prop="status">
                  <template #default="{row}">
                    <el-tag v-if="row.status==1">正常</el-tag>
                    <el-tag v-else type="danger">封禁</el-tag>
                  </template>
                </el-table-column>
                <el-table-column label="用户身份" prop="role">
                    <template #default="{row}">
                    <el-tag v-if="row.role==0" type="danger">超级管理员</el-tag>
                    <el-tag v-if="row.role==1" type="success">管理员</el-tag>
                    <el-tag v-if="row.role==2" type="info">普通用户</el-tag>
                  </template>
                </el-table-column>
                <el-table-column label="用户余额" prop="balance">
                  <template #default="{row}">
                      <span style="color: red;">￥{{ row.balance }}</span>
                  </template>
                </el-table-column>
                <el-table-column label="创建日期" prop="createTime"></el-table-column>
                <el-table-column label="修改日期" prop="updateTime"></el-table-column>
                <el-table-column label="操作" width="100">
                    <template #default="{row}">
                        <el-button :icon="Edit" circle plain type="primary" @click="showUpdateDialog(row)"></el-button>
                        <el-button :icon="Delete" circle plain type="danger"></el-button>
                    </template>
                </el-table-column>
                <template #empty>
                    <el-empty description="没有数据"/>
                </template> 
        </el-table>
        <!-- 分页 -->
         <template #footer>
            <el-pagination 
                v-model:currentPage="pageNum"
                v-model:page-size="pageSize"
                :page-sizes="[3,5,10,15]"
                layout="jumper, total, sizes, prev, pager, next"
                background 
                :total="total" 
                @size-change="onSizeChange"
                @current-change="onCurrentChange"
                class="pagination"
                style="margin-top: 20px; justify-content: flex-end;"
            />
         </template>
         <!-- 添加表单 -->
<el-dialog v-model="dialogVisible" title="添加用户" width="70%">
    <!-- 左边和右边内容 -->
    <div class="form-container">
        <!-- 左边图片区域 -->
        <div class="image-section">
            
            <div class="image-label">用户头像</div>
                <el-upload
                    name="file"
                    class="avatar-uploader"
                    action="/api/upload"
                    :auto-upload="true"
                    :on-success="uploadSuccess"
                    :headers="{Authorization:tokenStore.token}"
                    :limit="1" 
                    :data="{ folderName: 'user' }"
                >
                    <img v-if="imageUrl" :src="'http://'+URl+':8080/images/' +imageUrl" class="avatar" />
                    <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
                </el-upload>
        </div>
        
        <!-- 右边表单区域 -->
        <div class="form-section">
            <el-form ref="addForm" :model="userModel" :rules="rules" label-width="80px">
                <el-form-item label="登录名" prop="userName">
                    <el-input v-model="userModel.userName"></el-input>
                </el-form-item>
                <el-form-item label="昵称" prop="onlineUsername">
                    <el-input v-model="userModel.onlineUsername"></el-input>
                </el-form-item>
                <el-form-item label="邮箱" prop="email">
                    <el-input v-model="userModel.email"></el-input>
                </el-form-item>
                <el-form-item label="手机号" prop="telephoneNumber">
                    <el-input v-model="userModel.telephoneNumber"></el-input>
                </el-form-item>
                <el-form-item label="角色" prop="role">
                    <el-radio-group v-model="userModel.role">
                        <el-radio :label="1">管理员</el-radio> <!-- 修复了布尔值绑定 -->
                        <el-radio :label="2">用户</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="状态" prop="status">
                    <el-radio-group v-model="userModel.status">
                        <el-radio :label="1">正常</el-radio> <!-- 修复了布尔值绑定 -->
                        <el-radio :label="0">封禁</el-radio>
                    </el-radio-group>
                </el-form-item>

                <el-form-item label="余额" prop="balance">
                    <el-input v-model.number="userModel.balance" type="number"></el-input>
                </el-form-item>
            </el-form> 
        </div>
    </div>
    
    <!-- 对话框底部按钮（使用footer插槽） -->
    <template #footer>
        <el-button @click="falseAddProductDisPlay">取消</el-button>
        <el-button type="primary" :disabled="!isFormValid" @click="addProduct()">确定</el-button>
    </template>
</el-dialog>

  <!-- 修改商品内容对话框 -->
<el-dialog v-model="diaUpdateVisible" title="修改商品" width="70%">
    <div class="form-container">
        <!-- 左侧图片区域 -->
        <div class="image-section">
            <div class="image-label">商品图片</div>
                <el-upload
                    name="file"
                    class="avatar-uploader"
                    action="/api/upload"
                    :auto-upload="true"
                    :on-success="uploadSuccess"
                    :headers="{Authorization:tokenStore.token}"
                    :limit="1" 
                    :data="{ folderName: 'user' }"
                >
                    <img v-if="userModel.avatar!='https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg'" :src="'http://'+URl+':8080/images/' +userModel.avatar" class="avatar" />
                    <img v-else-if="userModel.avatar=='https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg'" src="https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg"/>
                    <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
                </el-upload>
        </div>
        
        <!-- 右侧表单区域 -->
        <div class="form-section">
            <el-form ref="addForm" :model="userModel" :rules="rules" label-width="80px">
                <el-form-item label="登录名" prop="userName" >
                    <el-input v-model="userModel.userName" disabled></el-input>
                </el-form-item>
                <el-form-item label="网名" prop="onlineUsername">
                    <el-input v-model="userModel.onlineUsername"></el-input>
                </el-form-item>
                <el-form-item label="电子邮件" prop="email">
                    <el-input v-model="userModel.email"></el-input>
                </el-form-item>
                <el-form-item label="电话号码" prop="telephoneNumber">
                    <el-input v-model="userModel.telephoneNumber"></el-input>
                </el-form-item>
                <el-form-item label="状态" prop="status">
                    <el-radio-group v-model="userModel.status">
                        <el-radio :label="true">正常</el-radio>
                        <el-radio :label="false">封禁</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="余额" prop="balance">
                    <el-input v-model.number="userModel.balance"></el-input>
                </el-form-item>
            </el-form>
        </div>
    </div>
    
    <template #footer>
        <el-button @click=closeUpdateDialog>取消</el-button>
        <el-button type="primary" :disabled="!isFormValid" @click="updateUserInfo()">确定</el-button>
    </template>
</el-dialog>
</el-card>
</template>


<style scoped>
.form-container {
  display: flex;
  gap: 20px; 
  align-items: flex-start;
  flex-wrap: wrap;
}

.image-section {
  flex: 0 0 200px; 
  @media screen and (max-width: 768px) {
    flex: 0 0 100%;
  }
}

.image-label {
  font-size: 1rem;
  color: #606266;
  margin-bottom: 8px;
  font-weight: 500;
}

.form-section {
  flex: 1;
  min-width: 300px; 
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center; 
  height: 20px;
  flex-wrap: wrap; 
  gap: 10px;
}

.custom-card {
  width: 100%;
  height: 100%;
  padding: 10px;
}

.small-text-table {
  font-size: 0.85rem;
}


.ImgList {
  width: 8vw; 
  height: 6vw;
  max-width: 90px; 
  max-height: 70px; 
  min-width: 60px; 
  min-height: 50px; 
  box-shadow: 4px 4px 8px 0px rgba(33, 47, 61, 0.3);
}

.avatar-uploader .avatar {
  width: 15vw; 
  height: 15vw;
  max-width: 178px;
  max-height: 178px;
  min-width: 120px;
  min-height: 120px;
  display: block;
}

.pagination {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  padding: 10px 0;
  @media screen and (max-width: 768px) {
    justify-content: center; 
  }
}
</style>

<style>

.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
  width: 15vw;
  height: 15vw;
  max-width: 178px;
  max-height: 178px;
  min-width: 120px;
  min-height: 120px;
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 2rem;
  color: #8c939d;
  width: 100%;
  height: 100%;
  text-align: center;
  line-height: 15vw;
  max-height: 178px;
}
</style>