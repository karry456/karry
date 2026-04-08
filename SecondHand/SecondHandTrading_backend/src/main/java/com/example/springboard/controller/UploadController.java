package com.example.springboard.controller;

import com.example.springboard.pojo.Result;
import com.example.springboard.utils.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

import java.nio.file.Paths;

import java.util.Map;

@Validated
@CrossOrigin
@RestController
public class UploadController {

    // 从配置文件中读取路径，支持动态配置
    @Value("${file.upload.path}")
    private String uploadPath;
    @PostMapping("/upload")
    public Result uploadFile(MultipartFile file,@RequestParam(value = "folderName", defaultValue = "product") String folderName) throws IOException {
                String originalFilename = file.getOriginalFilename();
                // 生成唯一文件名并保存
                String fileName = FileUtils.generateUniqueFileName(originalFilename);
                File destFile = Paths.get(uploadPath+"/"+folderName+"/", fileName).toFile();
                file.transferTo(destFile);
                String fileAccessUrl = folderName+"/" + fileName;
                return Result.success(fileAccessUrl);
            }
     // 文件删除
    @PostMapping("/fileDel")
    public Result deleteFile(@RequestBody Map<String, String> paramMap) {
        String fileName = paramMap.get("fileName");
                if (fileName != null && !"https://pic.616pic.com/ys_img/01/17/47/eVnQ1JdIY4.jpg".equals(fileName)){
                    File destFile = Paths.get(uploadPath+"/", fileName).toFile();
                    destFile.delete();
                    return Result.success("删除成功");
                }
                return Result.error("删除失败");
            }
}

