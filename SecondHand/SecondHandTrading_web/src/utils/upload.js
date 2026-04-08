// 引入axios（确保已在项目中安装并配置axios）
import request from "@/utils/request.js";

/**
 * 上传文件到后端
 * @param {File} file - 要上传的文件对象
 * @returns {Promise} - 返回上传结果的Promise
 */
export const uploadFile = async (file) => {
  if (!file) {
    return Promise.reject(new Error('请选择文件'));
  }

  // 创建FormData对象（文件上传必须用multipart/form-data格式）
  const formData = new FormData();
  formData.append('file', file); // 与后端@RequestParam("file")对应

  try {
    // 发送上传请求
    const response = await request.post('/upload', formData, {
      headers: {
        'Content-Type': 'multipart/form-data' // 显式式指定Content-Type
      },
    });

    return response.data; // 返回后端响应结果
  } catch (error) {
    console.error('文件上传失败', error);
    // 统一处理错误（如网络异常、后端报错等）
    const errorMsg = error.response?.data || '上传失败，请重试';
    return Promise.reject(new Error(errorMsg));
  }
};


export  function show(){

        return  request.get('/showAll')   

}

  // 提交修改请求
export const submitUpdate = async (file, currentImage) => {
  console.log(file);
  console.log(currentImage);
  
  const formData = new FormData();

  formData.append("file", file);

  formData.append("id", currentImage.id);
  formData.append("fileName", currentImage.fileName);
  formData.append("filePath", currentImage.filePath);
  formData.append("fileType", currentImage.fileType);
  try {
    // 调用后端/update接口
    const response = await request.post("/edit", formData, {
      headers: {
        "Content-Type": "multipart/form-data" // 必须指定该类型，否则后端无法解析文件
      }
    });

    if (response.data === "修改成功") {
      alert("修改成功");
      isEditDialogShow.value = false;
    }
  } catch (error) {
    console.error("修改失败", error);
    console.log("失败");
    
  }
}
