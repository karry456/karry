import { defineStore } from "pinia";
import { ref } from "vue";
export const useUserInfoStore = defineStore('userInfo', () => {
    const info=ref({});
    const setUserInfo=(newInfo)=>{
        info.value=newInfo;
    }
    const removeUserInfo=()=>{
        info.value={};
    }

    return {info,setUserInfo,removeUserInfo}

},{persist: true})
