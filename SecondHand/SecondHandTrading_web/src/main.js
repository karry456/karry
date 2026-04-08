

import { createApp } from 'vue'
import ElementPlus from 'element-plus'

import 'element-plus/dist/index.css'

import router from '@/router'

import App from './App.vue'

import {createPinia} from 'pinia'
import { createPersistedState } from 'pinia-persistedstate-plugin'

import naive from 'naive-ui';

import locale from 'element-plus/dist/locale/zh-cn.js'




const app = createApp(App)
const pinia = createPinia()
const persistedState = createPersistedState()
app.use(pinia)
pinia.use(persistedState)
app.use(router)
app.use(ElementPlus, {locale})
app.use(naive);
window.$loadingBar = app.config.globalProperties.$loadingBar;



app.mount('#app')

