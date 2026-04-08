<script lang="ts" setup>
import { ref } from 'vue'

import {
  Check,
  Delete,
  Edit,
  Message,
  Search,
  Star,
} from '@element-plus/icons-vue'
import {getOrderAllListService,//获取所有订单
    addOrderService,//添加订单
    deleteOrderService,//删除订单
    showAllBageService,//分页查询
    updateOrderService,//修改订单
} from '@/views/Order/Order.js'
import { ElMessage } from 'element-plus'
const order = ref([])

const URl = ref('10.69.135.202')

//分页
const pageNum = ref(1)//当前页
const total = ref(20)//总条数
const pageSize = ref(3)//每页显示的条数
//查询条件
const productType = ref('')
const productName = ref('')

const productAllList = ref([])
//商品所有类别集合
const productListType = ref([])
//修改订单对话框
const diaUpdateVisible = ref(false)

//定义表单数据
const orderModel=ref({
        orderId:"",//订单ID
        orderNO:'',//订单编号
        userId:'',//用户编号
        productId:'',//商品编号
        paymentAmount:'',//支付金额
        status:'',//订单状态
        payStatus:'',//支付状态
        receiverName:'',//收货人姓名
        receiverPhone:'',//收货人手机
        receiverAddress:'',//收货人地址
        createTime:'',//创建时间
        deletedAt:'',//软删除
        product:{
            productId:"",//商品ID
            productNo:'',//商品编号
            userId:'',//用户编号
            productName:'',//商品名称
            productPhoto:'',//商品图片
            productType:'',//商品类型
            productPrice:'',//商品价格
            productState:true,//商品状态
            favorites:'',//收藏
            productInfo:'',//商品信息
            purchased:'',//购买
            createTime:'',//创建时间
            updateTime:'',//修改时间
        },
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

//情况数据的内容
const clearOrderModel=()=>{
    orderModel.value={
        orderId:"",//订单ID
        orderNO:'',//订单编号
        userId:'',//用户编号
        productId:'',//商品编号
        paymentAmount:'',//支付金额
        status:'',//订单状态
        payStatus:'',//支付状态
        receiverName:'',//收货人姓名
        receiverPhone:'',//收货人手机
        receiverAddress:'',//收货人地址
        createTime:'',//创建时间
        deletedAt:'',//软删除
        product:{
            productId:"",//商品ID
            productNo:'',//商品编号
            userId:'',//用户编号
            productName:'',//商品名称
            productPhoto:'',//商品图片
            productType:'',//商品类型
            productPrice:'',//商品价格
            productState:true,//商品状态
            favorites:'',//收藏
            productInfo:'',//商品信息
            purchased:'',//购买
            createTime:'',//创建时间
            updateTime:'',//修改时间
        },
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

//获取所有商品类别
const getOrderAllList=async()=>{
   let result=await getOrderAllListService();
    const allProductTypes = result.data.map(item => item.product.productType);
    productListType.value = Array.from(new Set(allProductTypes));
}

//当每页条数发生变化，调用此函数
const onSizeChange=(size)=>{
    pageSize.value = size
    showAllBage()
}

//当前页码发生变化，调用此函数
const onCurrentChange=(num)=>{
    pageNum.value = num
    showAllBage()
}

//分页查询
const showAllBage=async()=>{
        let param={
        pageNum : pageNum.value,
        pageSize : pageSize.value,
        productType : productType.value ? productType.value :null,//商品类别进行商品查询
        productName : productName.value ? productName.value :null//根据名称进行商品查询
    }
    let result=await showAllBageService(param)
    console.log(result);
    
    order.value=result.data.items
    total.value=result.data.total
//     for(let i=0;i<order.value.length;i++){
//     let p = order.value[i]
//     for(let j=0;j<order.value.length;j++){
//         if(p.productId==order.value[j].productId){
//             p.productName=order.value[j].productName
//         }
//     }
//    }
}


//修改商品时获取商品信息
const showUpdateDialog = (row) => {
  orderModel.value = {
    orderId:row.orderId,//订单ID
    orderNO:row.orderNO,//订单编号
    userId:row.userId,//用户编号
    productId:row.productId,//商品编号
    paymentAmount:row.paymentAmount,//支付金额
    status:row.status,//订单状态
    payStatus:row.payStatus,//支付状态
    receiverName:row.receiverName,//收货人姓名
    receiverPhone:row.receiverPhone,//收货人手机
    receiverAddress:row.receiverAddress,//收货人地址
    createTime:row.createTime,//创建时间
    deletedAt:row.deletedAt,//软删除
    product:{
        productId:row.product.productId,//商品ID
        productNo:row.product.productNo,//商品编号
        userId:row.product.userId,//用户编号
        productName:row.product.productName,//商品名称
        productPhoto:row.product.productPhoto,//商品图片
        productType:row.product.productType,//商品类型
        productPrice:row.product.productPrice,//商品价格
        productState:row.product.productState,//商品状态
        favorites:row.product.favorites,//收藏
        productInfo:row.product.productInfo,//商品信息
        purchased:row.product.purchased,//购买
        createTime:row.product.createTime,//创建时间
        updateTime:row.product.updateTime,//修改时间
    },
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

//关闭修改订单对话框
const closeUpdateDialog = () => {
    diaUpdateVisible.value = false
    clearOrderModel()
}

//显示所有商品（分页）
showAllBage()
//获取所有商品类别
getOrderAllList()

//修改订单确定
const updateCategory=async()=>{ 
    let result=await updateOrderService(orderModel.value)
    if((result as any).code==0){
        diaUpdateVisible.value = false
        clearOrderModel()
        showAllBage()
        ElMessage.success("修改成功")
    }else{
        ElMessage.error("修改失败")
    }
    
}

</script>

<template>
    <el-card class="custom-card"> 
        <template #header>
            <div class="header">
                <span>订单管理</span>
                <!-- 搜索菜单 -->
                <el-form inline>
                    <el-form-item label="商品类型">
                        <el-select placeholder="全部" v-model="productType" style="width: 120px;" @change="showAllBage">
                            <el-option label="全部" value=""></el-option>
                            <el-option v-for="c in productListType" :key="c" :label="c" :value="c"></el-option>
                        </el-select>
                    </el-form-item>
                </el-form>
                <!-- 搜索商品名称 -->
                 <el-form inline>
                    <el-form-item label="商品名称">
                        <el-input v-model="productName" placeholder="请输入商品名称" style="width: 200px;" @change="showAllBage"></el-input>
                    </el-form-item>
                </el-form>
            </div>

        </template>
        <el-table :data="order"  class="small-text-table">
            <el-table-column label="商品图片" prop="productPhoto">
                  <template #default="{row}">
                    <el-image :src="'http://'+URl+':8080/images/'+row.product.productPhoto" style="border-radius: 10px;" class="ImgList"></el-image>
                  </template>
            </el-table-column>
            <el-table-column label="订单编号" prop="orderNO"></el-table-column>
            <el-table-column label="商品编号" prop="product.productNo"></el-table-column>
            <el-table-column label="商品名称" prop="product.productName"></el-table-column>
            <el-table-column label="商品类别" prop="product.productType"></el-table-column>
            <el-table-column label="买家网名" prop="user.onlineUsername"></el-table-column>
            <el-table-column label="订单状态" prop="status">
                <template #default="{row}">
                  <el-tag v-if="row.status === '0'" type="danger">待付款</el-tag>
                  <el-tag v-if="row.status === '1'" type="primary">待发货</el-tag>
                  <el-tag v-if="row.status === '2'" type="success">待收货</el-tag>
                  <el-tag v-if="row.status === '3'" type="info">待评价</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="卖家网名" prop="product.user.onlineUsername">
                <template #default="scope">
                    {{ scope.row.product?.user?.onlineUsername || '无' }}
                </template>
            </el-table-column>
            <el-table-column label="支付状态" prop="payStatus">
                <template v-slot="{row}">
                  <el-tag v-if="row.payStatus === '0'" type="info">未支付</el-tag>
                  <el-tag v-if="row.payStatus === '1'" type="success">已支付</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="创建时间" prop="createTime"></el-table-column>

            <el-table-column label="收件人信息">
                <template #default="{ row }">
                    <el-tag>{{ row.receiverName }}</el-tag>
                    <el-tag>{{ row.receiverPhone }}</el-tag>
                    <el-tag>{{ row.receiverAddress }}</el-tag>
                </template>
            </el-table-column>

            <el-table-column label="支付金额" prop="paymentAmount">  
                <template #default="{ row }">
                    <span style="color: red;">{{ row.paymentAmount }} ￥</span>
                </template>
            </el-table-column>
            <el-table-column label="操作">
                <template #default="scope">
                    <el-button  :icon="Edit" circle plain type="primary" @click="showUpdateDialog(scope.row)"></el-button>
                    <el-button  :icon="Delete" circle plain type="danger" @click="deleteOrderService(scope.row.id)"></el-button>
                </template>
            </el-table-column>
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
    </el-card>

      <!-- 修改文章内容对话框 -->
<el-dialog v-model="diaUpdateVisible" title="修改商品" width="70%">
    <div class="form-container">
        <!-- 左侧图片区域 -->
        <div class="image-section">
            <div class="image-label">商品图片</div>
                    <img v-if="orderModel.product.productPhoto!=''" :src="'http://'+URl+':8080/images/' +orderModel.product.productPhoto" class="avatar" />
                    <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>

        </div>
        
        <!-- 右侧表单区域 -->
        <div class="form-section">
            <el-form ref="addForm" :model="orderModel"  label-width="80px">
                <el-form-item label="商品名称" prop="productName">
                    <el-input v-model="orderModel.product.productName" disabled></el-input>
                </el-form-item>
                <el-form-item label="商品类型" prop="productType">
                    <el-input v-model="orderModel.product.productType" disabled></el-input>
                </el-form-item>
                <el-form-item label="商品价格" prop="productPrice">
                    <el-input v-model="orderModel.product.productPrice" disabled></el-input>
                </el-form-item>
                <el-form-item label="支付状态" prop="payStatus">
                    <el-input v-model="orderModel.payStatus" disabled></el-input>
                </el-form-item>
                <el-form-item label="订单状态" prop="status">
                    <el-select v-model="orderModel.status" placeholder="请选择订单状态">
                        <el-option label="待付款" value="0"></el-option>
                        <el-option label="待发货" value="1"></el-option>
                        <el-option label="待收货" value="2"></el-option>
                        <el-option label="待评价" value="3"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
        </div>
    </div>
    
    <template #footer>
        <el-button @click=closeUpdateDialog>取消</el-button>
        <el-button type="primary" @click="updateCategory()">确定</el-button>
    </template>
</el-dialog>

</template>

<style scoped>

.form-container {
    display: flex;
    gap: 30px;
    align-items: flex-start;
}

.image-section {
    flex: 0 0 220px;
    padding: 10px;
}

.image-label {
    font-size: 14px;
    color: #606266;
    margin-bottom: 8px;
    font-weight: 500;

}
.form-section {
    flex: 1;
}

.small-text-table{
    font-size: 15px;
}

.header{
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 20px;
}
.custom-card{
    height: 600px;
}
.ImgList{
    width: 90px;
    height: 70px;
}

.avatar-uploader .avatar {
  width: 50px;
  height: 178px;
  display: block;
}

.avatar{
    width: 178px;
    height: 150px;
    
}
el-table-column{
    width: 1px;
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
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  text-align: center;
}
</style>