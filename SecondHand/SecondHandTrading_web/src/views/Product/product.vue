<script lang="ts" setup>
import {
  Check,
  Delete,
  Edit,
  Message,
  Search,
  Star,
} from '@element-plus/icons-vue'

import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
const product = ref([])
import { getProductListService,//获取商品列表(分页)
    addProductService, //添加商品
    updateProductService,//修改商品
    deleteProductService, //删除商品
    getAllProductService
} from '@/views/Product/product.js'
import { c } from 'naive-ui'
import { useTokenStore } from '@/store/token'

const URl = ref('10.69.135.202')

//分页
const pageNum = ref(1)//当前页
const total = ref(20)//总条数
const pageSize = ref(4)//每页显示的条数

const productType = ref('')
const productName = ref('')

const productAllList = ref([])
const productListType = ref([])
//当每页条数发生变化，调用此函数
const onSizeChange=(size)=>{
    pageSize.value = size
    articleproductList()
}

//当前页码发生变化，调用此函数
const onCurrentChange=(num)=>{
    pageNum.value = num
    articleproductList()
}

//回显商品分类
const productList=async()=>{
    let result=await getAllProductService();
    console.log(result);
    
    productAllList.value=result.data.productType

    const allProductTypes = result.data.map(item => item.productType);
    // 2. 去重后赋值
    productListType.value = Array.from(new Set(allProductTypes));
}

//获取商品类别的信息
productList()

const tokenStore = useTokenStore()
// 获取商品列表
const articleproductList=async()=>{
    let param={
        pageNum : pageNum.value,
        pageSize : pageSize.value,
        productType : productType.value ? productType.value :null,//商品类别进行商品查询
        productName : productName.value ? productName.value :null//根据名称进行商品查询
    }
    
   let result=await getProductListService(param);
   console.log(11);
   
   console.log(result);
   
   total.value=result.data.total
   product.value=result.data.items
   for(let i=0;i<product.value.length;i++){
    let p = product.value[i]
    for(let j=0;j<product.value.length;j++){
        if(p.productId==product.value[j].productId){
            p.productName=product.value[j].productName
        }
    }
   }
}

//弹出取消商品添加
const falseAddProductDisPlay=async()=>{
    if(imageUrl.value!=''){
        deleteProductService(imageUrl.value)
    }
    dialogVisible.value=false
    clearCategory()
    imageUrl.value=''
}
// 添加表单
const dialogVisible = ref(false)
// 修改文章表单
const diaUpdateVisible = ref(false)
//定义表单数据
const productModel=ref({
    productId:"",
    productNo:'',
    userId:'',
    productName:'',
    productPhoto:'',
    productType:'',
    productPrice:'',
    productState:true,
    favorites:'',
    productInfo:'',
    purchased:'',
    createTime:'',
    updateTime:'',
    user:{
        userId:'',
        userCode:'',
        avatar:'',
        userName:'',
        onlineUsername:'',
        email:'',
        telephoneNumber:'',
        status:'',
        role:'',
        balance:'',
        createTime:'',
        updateTime:''
    }
})
//清空表单
const clearCategory = () => {
  productModel.value = {
    productId:"",
    productNo:'',
    userId:'',
    productName:'',
    productPhoto:'',
    productType:'',
    productPrice:'',
    productState:true,
    favorites:'',
    productInfo:'',
    purchased:'',
    createTime:'',
    updateTime:'',
    user:{
        userId:'',
        userCode:'',
        avatar:'',
        userName:'',
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
}

// 表单验证
const rules = ref({
    productName: [
      { required: true, message: '请输入商品名称', trigger: 'change' },
      
    ],
    productPhoto: [
      { required: true, message: '请输入商品图片', trigger: 'change' },
      
    ],
    productType: [
      { required: true, message: '请输入商品类型', trigger: 'change' },
      
    ],
    productPrice: [
      { required: true, message: '请输入商品价格', trigger: 'change' },
      
    ],
    productNum: [
      { required: true, message: '请输入商品数量', trigger: 'change' },
      
    ],
    productInfo: [
      { required: true, message: '请输入商品信息', trigger: 'change' },
    ],
})
import { computed } from 'vue'
// 综合验证条件控制按钮状态
const isFormValid = computed(() => {
  const { productName, productPhoto,
    productType, productPrice, productInfo
   } = productModel.value
  return productName.trim() !== '' && productPhoto.trim() !== '' && productType.trim() !== '' && productPrice !== '' && productInfo.trim() !== ''
})

// 调用接口，获取商品列表
articleproductList();
//调用接口，添加表单
const addProduct = async () => {
        await addProductService(productModel.value).then(result=>{  
        if ((result as any).code==0) {
            ElMessage.success("添加成功");
            articleproductList(); 
        } else {
            ElMessage.error("添加失败"); // 这里补全了属性访问
        }
        clearCategory()
        dialogVisible.value = false;
        })}

//修改表单
// 显示修改对话框并填充当前行数据
const showUpdateDialog = (row) => {
  productModel.value = {
    productId:row.productId,
    productNo:row.productNo,
    userId:row.userId,
    productName:row.productName,
    productPhoto:row.productPhoto,
    productType:row.productType,
    productPrice:row.productPrice,
    productState:row.productState,
    favorites:row.favorites,
    productInfo:row.productInfo,
    purchased:row.purchased,
    createTime:row.createTime,
    updateTime:row.updateTime,
    user:{
        userId:row.user.userId,
        userCode:row.user.userCode,
        avatar:row.user.avatar,
        userName:row.user.userName,
        onlineUsername:row.user.onlineUsername,
        email:row.user.email,
        telephoneNumber:row.user.telephoneNumber,
        status:row.user.status,
        role:row.user.role,
        balance:row.user.balance,
        createTime:row.user.createTime,
        updateTime:row.user.updateTime
    }

  }
  diaUpdateVisible.value = true
}
//关闭修改对话框
const closeUpdateDialog = () => {
    if(imageUrl.value!=''){
        deleteProductService(imageUrl.value)
    }
    clearCategory()
    diaUpdateVisible.value = false
    imageUrl.value=''
}
//修改表单提交
const updateCategory = async () => {
        let result = await updateProductService(productModel.value);
        imageUrl.value=imageUrlUp.value
        if ((result as any).code == 0) {
            ElMessage.success("修改成功");
            closeUpdateDialog()
            articleproductList()
        }else {
            ElMessage.error("修改失败");
            
        }
        imageUrl.value=''
        clearCategory() 
}

//上传成功之后的回调
const uploadSuccess = (res) => {
    imageUrlUp.value=productModel.value.productPhoto
    imageUrl.value = res.message;
    productModel.value.productPhoto = res.message;
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
</script>
<template>
    <el-card class="custom-card"> 
        <template #header>
            <div class="header">
                <span>商品管理</span>
                        <!-- 搜索菜单 -->
                <el-form inline>
                    <el-form-item label="商品类型">
                        <el-select placeholder="全部" v-model="productType" style="width: 120px;" @change="articleproductList">
                            <el-option label="全部" value=""></el-option>
                            <el-option v-for="c in productListType" :key="c" :label="c" :value="c"></el-option>
                        </el-select>
                    </el-form-item>
                </el-form>
                <!-- 搜索商品名称 -->
                 <el-form inline>
                    <el-form-item label="商品名称">
                        <el-input v-model="productName" placeholder="请输入商品名称" style="width: 200px;" @change="articleproductList"></el-input>
                    </el-form-item>
                </el-form>
                <div>
                    <el-button type="primary" @click="dialogVisible=true">添加商品</el-button>
                </div>
            </div>
        </template>

        <!-- 商品列表 -->
        <el-table :data="product"  class="small-text-table">
            <!-- <el-table-column label="序号" width="100" type="index"></el-table-column> -->
                
                <el-table-column label="商品图片" prop="productPhoto">
                  <template #default="{row}">
                    <el-image :src="'http://'+URl+':8080/images/'+row.productPhoto" class="ImgList"></el-image>
                  </template>
                </el-table-column>
                <el-table-column label="商品编号" prop="productNo"></el-table-column>
                <el-table-column label="商品名称" prop="productName" show-overflow-tooltip></el-table-column>
                <el-table-column label="商品类型" prop="productType"></el-table-column>
                <el-table-column label="商品价格" prop="productPrice">
                  <template #default="{row}">
                      <span style="color: red;">￥{{ row.productPrice }}</span>
                  </template>
                </el-table-column>
                <el-table-column label="是否售出" prop="purchased">
                    <template #default="{row}">
                    <el-tag v-if="row.purchased==0" type="info">未售出</el-tag>
                    <el-tag v-else type="success">已售出</el-tag>
                  </template>
                </el-table-column>
                <el-table-column label="商品描述" prop="productInfo" show-overflow-tooltip></el-table-column>
                <el-table-column label="商品状态" prop="productState">
                  <template #default="{row}">
                    <el-tag v-if="row.productState==1">上架</el-tag>
                    <el-tag v-else type="danger">下架</el-tag>
                  </template>
                </el-table-column>
                <el-table-column label="收藏数" prop="favorites"></el-table-column>
                <el-table-column label="创建用户" prop="user.onlineUsername"></el-table-column>
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
<el-dialog v-model="dialogVisible" title="添加商品" width="70%">
    <!-- 左边和右边内容 -->
    <div class="form-container">
        <!-- 左边图片区域 -->
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
                    :before-upload="beforeUpload"
                    :data="{ folderName: 'product' }"
                    
                >
                    <img v-if="imageUrl" :src="'http://'+URl+':8080/images/' +imageUrl" class="avatar" />
                    <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
                </el-upload>
        </div>
        
        <!-- 右边表单区域 -->
        <div class="form-section">
            <el-form ref="addForm" :model="productModel" :rules="rules" label-width="80px">
                <el-form-item label="商品名称" prop="productName">
                    <el-input v-model="productModel.productName"></el-input>
                </el-form-item>
                <el-form-item label="商品类型" prop="productType">
                    <el-input v-model="productModel.productType"></el-input> <!-- 修复了绑定错误 -->
                </el-form-item>
                <el-form-item label="商品价格" prop="productPrice">
                    <el-input v-model="productModel.productPrice"></el-input>
                </el-form-item>
                <el-form-item label="商品状态" prop="productState">

                    <el-select v-model="productModel.productState" placeholder="请选择商品状态" style="width: 200px;">
                    <el-option label="上架" :value="true"></el-option>
                    <el-option 
                        label="下架" 
                        :value="false"
                    ></el-option>
                    </el-select>
                    </el-form-item>
                <el-form-item label="商品信息" prop="productInfo">
                    <el-input v-model="productModel.productInfo" type="textarea"></el-input>
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
                    :before-upload="beforeUpload"
                    :data="{ folderName: 'product' }"
                >
                    <img v-if="productModel.productPhoto!=''" :src="'http://'+URl+':8080/images/' +productModel.productPhoto" class="avatar" />
                    <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
                </el-upload>
        </div>
        
        <!-- 右侧表单区域 -->
        <div class="form-section">
            <el-form ref="addForm" :model="productModel" :rules="rules" label-width="80px">
                <el-form-item label="商品名称" prop="productName">
                    <el-input v-model="productModel.productName"></el-input>
                </el-form-item>
                <el-form-item label="商品类型" prop="productType">
                    <el-input v-model="productModel.productType"></el-input>
                </el-form-item>
                <el-form-item label="商品价格" prop="productPrice">
                    <el-input v-model="productModel.productPrice"></el-input>
                </el-form-item>

                <el-form-item label="商品状态" prop="productState">
                    <el-radio-group v-model="productModel.productState">
                        <el-radio :label="true">上架</el-radio>
                        <el-radio :label="false">下架</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="商品信息" prop="productInfo" >
                    <el-input v-model="productModel.productInfo" type="textarea" ></el-input>
                </el-form-item>
            </el-form>
        </div>
    </div>
    
    <template #footer>
        <el-button @click=closeUpdateDialog>取消</el-button>
        <el-button type="primary" :disabled="!isFormValid" @click="updateCategory()">确定</el-button>
    </template>
</el-dialog>
</el-card>
</template>

<style scoped>
.form-container {
  display: flex;
  align-items: flex-start;
  flex-wrap: wrap;
}

.image-section {
  flex: 0 0 200px; 
  padding: 10px;
  @media screen and (max-width: 768px) {
    flex: 0 0 100%;
    margin-bottom: 20px;
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
  height: 15px;
  flex-wrap: wrap; 
}

.custom-card {
  width: 100%;
  height: 100%;
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