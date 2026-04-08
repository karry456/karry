<script lang="ts" setup>
import { ref } from 'vue'
import {getCartAllListService,addCartService,deleteCartService} from '@/views/Cart/Cart.js'
import { ElMessage } from 'element-plus'
const Cart = ref([])


const getCartAllList=async()=>{
   let result=await getCartAllListService();
   Cart.value=result.data
    console.log(result.data)
}

getCartAllList()
</script>

<template>
    <el-card class="custom-card"> 
        <template #header>
            <div class="header">
                <span>购物车</span>
            </div>
        </template>
        <el-table :data="Cart"  class="small-text-table">
            <el-table-column label="序号" width="100" type="index"></el-table-column>
                <el-table-column label="商品id" prop="productId"></el-table-column>
        </el-table>
    </el-card>

</template>

<style scoped>


</style>