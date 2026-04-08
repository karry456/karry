<script setup>
    import {
        Management,
        Promotion,
        UserFilled,
        User,
        Crop,
        EditPen,
        SwitchButton,
        CaretBottom
    } from '@element-plus/icons-vue'
    import avatar from '../assets/avatar.webp'
    import { ref, onMounted, computed } from 'vue'; 
import { ElMessage, ElMessageBox } from 'element-plus'; // 新增 ElMessageBox
    const URl = ref('10.69.135.202')
    //调用函数
    import {getUserInfoService,logoutService} from '@/api/user.js';
    import {useUserInfoStore} from '@/store/userInfo.js';
    import {useTokenStore} from '@/store/token.js';
    const userInfoStore=useUserInfoStore();
    const tokenStore=useTokenStore();
    const getUserInfo=async()=>{ 
      let result=await getUserInfoService()

      userInfoStore.setUserInfo(result.data)
    }
    getUserInfo();

    const roleMap = {
  '0': '超级管理员',
  '1': '管理员',
  '2': '普通用户'
  // 可根据实际情况补充其他角色
};

// 计算用户身份（利用可选链+空值合并，避免 undefined）
const userRole = computed(() => {
  const role = userInfoStore.info?.role;
  return roleMap[role] ?? '未知身份';
});

import { useRouter } from 'vue-router';

const router=useRouter();
const handleCommand = (command) => {
  // 匹配 command 值（和 el-dropdown-item 的 command 属性完全一致）
  if (command === 'logout') {
        // 退出登录确认弹窗
        ElMessageBox.confirm(
          '确定要退出登录吗？', 
          '温馨提示', 
          {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning',
          }
        ).then(() => {
          // 点击「确定」执行这里（等效于你的 ex==1）
          tokenStore.removeToken();
          userInfoStore.removeUserInfo();
          router.push('/login');
          ElMessage.success('已退出登录');
        }).catch(() => {
          // 点击「取消」/关闭弹窗执行这里（等效于你的 else）
          ElMessage.info('取消退出登录');
        });
  } else if (command === 'password') {
    // 修改密码
    router.push('/views/userInfo/ChangePaw/ChangePaw');

  } else if (command === 'Crop') {
    // 修改头像
    router.push('/views/userInfo/avatar/avatar');

  } else if (command === 'profile') {
    // 基本资料
    router.push('/views/userInfo/Information/Information');
  }
};


</script>

<template>
    <el-container class="layout-container">
        <el-aside width="200px">
            <div class="el-aside_logo"></div>
            <el-menu active-text-color="#ffd04b" background-color="#212F3D" text-color="#fff" router>
                <el-menu-item index="/views/Product/product">
                    <el-icon>
                        <Management/>
                    </el-icon>
                    <span>商品管理</span>
                </el-menu-item>
                <el-menu-item index="/views/Order/Order">
                    <el-icon>
                        <Promotion/>
                    </el-icon>
                    <span>订单管理</span>
                </el-menu-item >
                <el-menu-item index="/views/User/User">
                    <el-icon>
                        <UserFilled/>
                    </el-icon>
                    <span>用户管理</span>
                </el-menu-item >
                <el-sub-menu>
                    <template #title>
                        <el-icon>
                            <UserFilled/>
                        </el-icon>
                        <span>个人中心</span>
                    </template>
                    <el-menu-item index="/views/userInfo/Information/Information">
                        <el-icon>
                            <User/>
                        </el-icon>
                        <span>基本信息</span>
                    </el-menu-item>
                    <el-menu-item index="/views/userInfo/avatar/avatar">
                        <el-icon>
                            <Crop/>
                        </el-icon>
                        <span>更换头像</span>
                    </el-menu-item>
                    <el-menu-item index="/views/userInfo/ChangePaw/ChangePaw">
                        <el-icon>
                            <EditPen/>
                        </el-icon>
                        <span>修改密码</span>
                    </el-menu-item>
                </el-sub-menu>
            </el-menu>
        </el-aside>
        <el-container>
            <el-header>
                <div>二手交易平台管理后台~第一组专属</div>
                <div>欢迎您：{{ userRole }}-{{userInfoStore.info.userName}}</div>
                <el-dropdown placement="bottom-end" @command="handleCommand">
                    <span class="el-dropdown_box">
                        <el-avatar :src="'http://'+URl+':8080/images/'+userInfoStore.info.avatar"/>
                        <el-icon>
                            <CaretBottom/>
                        </el-icon>
                    </span>
                    <template #dropdown>
                        <el-dropdown-menu>
                            <el-dropdown-item command="profile" :icon="User">基本资料</el-dropdown-item>
                            <el-dropdown-item command="Crop" :icon="Crop">更换头像</el-dropdown-item>
                            <el-dropdown-item command="password" :icon="EditPen">修改密码</el-dropdown-item>
                            <el-dropdown-item command="logout" :icon="SwitchButton">退出登录</el-dropdown-item>
                        </el-dropdown-menu>
                    </template>
                </el-dropdown>
            </el-header>
            <el-main>
                <div class="maindiv"> 
                    <router-view></router-view>
                </div>
            </el-main>
            <el-footer>二手交易平台管理后台</el-footer>
        </el-container>
    </el-container>
</template>

<style lang="scss" scoped>
// 全局自适应基础（解决不同屏幕的尺寸适配）
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
html {
  font-size: 14px; // 基准字号，媒体查询中动态调整
  @media screen and (max-width: 1200px) {
    font-size: 12px;
  }
  @media screen and (max-width: 992px) {
    font-size: 11px;
  }
  @media screen and (max-width: 768px) {
    font-size: 10px;
  }
}
body {
  min-width: 1200px; // 避免超小屏幕挤压布局，可根据需求调整
}
// Element Plus 表格自适应
:deep(.el-table) {
  width: 100% !important;
  overflow-x: auto; // 表格列过多时横向滚动
}
// Element Plus 对话框自适应
:deep(.el-dialog) {
  width: 80% !important;
  max-width: 1000px; // 限制最大宽度
  @media screen and (max-width: 768px) {
    width: 95% !important;
  }
}

.layout-container {
  height: 100vh; // 占满视口高度，替代固定97vh
  display: flex; // 弹性布局，适配侧边栏+主容器

  .el-aside {
    background-color: #212F3D;
    width: 180px !important; // 基础宽度，媒体查询调整
    flex-shrink: 0; // 侧边栏不收缩
    @media screen and (max-width: 1200px) {
      width: 150px !important; // 小屏幕缩小侧边栏
    }

    &_logo {
      height: 60px; // 修复原10px的错误高度
      background-color: #212F3D;
      width: 100%; // 占满侧边栏宽度
    }
  }

  .el-menu {
    border-right: none;
    width: 100%; // 菜单占满侧边栏
  }
}

.el-header {
  display: flex;
  justify-content: space-between;
  height: 60px; // 合理高度，替代40px
  line-height: 60px; // 文字垂直居中
  background-color: #212F3D;
  color: #ffffff;
  padding: 0 20px; // 左右内边距，避免文字贴边
  @media screen and (max-width: 768px) {
    height: 50px;
    line-height: 50px;
    font-size: 0.9rem; // 小屏幕缩小文字
  }
}

.el-footer {
  background-color: #212F3D;
  height: 50px; // 合理高度，替代25px
  line-height: 50px; // 文字垂直居中
  text-align: center;
  color: #ffffff;
  font-size: 0.9rem;
}

.maindiv {
  width: 100% !important; // 移除固定1320px，占满父容器
  height: 100%; // 移除固定600px，占满父容器
  padding: 10px; // 内边距，避免内容贴边
  overflow-y: auto; // 内容超出时滚动
}

// 下拉头像容器自适应
.el-dropdown_box {
  display: flex;
  align-items: center;
  gap: 5px; // 头像和箭头间距
}
</style>