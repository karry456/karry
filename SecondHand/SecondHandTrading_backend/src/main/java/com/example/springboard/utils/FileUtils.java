package com.example.springboard.utils;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;
import java.util.UUID;

@Component
public class FileUtils {

    public String uploadFile(MultipartFile file, String type, String uploadPath) throws IOException {
         String fileName = FileUtils.generateUniqueFileName(Objects.requireNonNull(file.getOriginalFilename()));
         File destFile = new File(uploadPath + type + "/" + fileName);
         System.out.println(uploadPath + type + "/" + fileName);
         file.transferTo(destFile);
         return type + "/" + fileName;
    }

    public String editFile(MultipartFile file, String type, String originalFilename, String uploadPath) throws IOException {
        File destFile = new File(uploadPath  + originalFilename);
        destFile.delete(); // 删除原有文件（如果存在）
        file.transferTo(destFile);
        System.out.println(originalFilename);
        return  originalFilename;
    }

    // 生成唯一文件名（UUID + 时间戳 + 原后缀）
    public static String generateUniqueFileName(String originalFilename) {
        String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().replace("-", "");
        String time = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        return uuid + "_" + time + suffix;
    }
}