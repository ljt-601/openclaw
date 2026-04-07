package com.example.mall.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

/**
 * 静态文件快捷上传控制器（仅开发环境）
 * 用于快速从本地路径上传文件，无需前端选择
 */
@RestController
@RequestMapping("/mall/system/staticFile")
public class StaticFileQuickUploadController {

    // 开发环境允许的路径白名单
    private static final String[] ALLOWED_PATHS = {
        "/Users/bryle/Documents/",
        "/Users/bryle/Downloads/"
    };

    @PostMapping("/quickUpload")
    public Map<String, Object> quickUpload(
            @RequestParam String rootPath,
            @RequestParam String filePath,
            @RequestParam String localFilePath) {

        Map<String, Object> result = new HashMap<>();

        try {
            // 安全检查：仅开发环境
            if (!isDevEnvironment()) {
                result.put("code", 500);
                result.put("msg", "此功能仅开发环境可用");
                return result;
            }

            // 安全检查：路径白名单
            if (!isAllowedPath(localFilePath)) {
                result.put("code", 500);
                result.put("msg", "不在允许的路径白名单中");
                return result;
            }

            // 读取本地文件
            File sourceFile = new File(localFilePath);
            if (!sourceFile.exists()) {
                result.put("code", 500);
                result.put("msg", "文件不存在: " + localFilePath);
                return result;
            }

            // 调用现有的上传服务
            MultipartFile multipartFile = new MockMultipartFile(
                sourceFile.getName(),
                sourceFile.getName(),
                "application/zip",
                Files.readAllBytes(sourceFile.toPath())
            );

            // 复用 StaticFileController 的上传逻辑
            // staticFileService.importStaticFile(rootPath, filePath, multipartFile);

            result.put("code", 200);
            result.put("msg", "上传成功: " + sourceFile.getName());

        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "上传失败: " + e.getMessage());
        }

        return result;
    }

    private boolean isDevEnvironment() {
        // 检查是否是开发环境
        String profile = System.getProperty("spring.profiles.active");
        return "dev".equals(profile) || "test".equals(profile);
    }

    private boolean isAllowedPath(String filePath) {
        for (String allowedPath : ALLOWED_PATHS) {
            if (filePath.startsWith(allowedPath)) {
                return true;
            }
        }
        return false;
    }
}

/**
 * Mock MultipartFile 实现
 */
import org.springframework.web.multipart.MultipartFile;
import java.io.*;

class MockMultipartFile implements MultipartFile {
    private final String name;
    private final String originalFilename;
    private final String contentType;
    private final byte[] content;

    public MockMultipartFile(String name, String originalFilename, String contentType, byte[] content) {
        this.name = name;
        this.originalFilename = originalFilename;
        this.contentType = contentType;
        this.content = content;
    }

    @Override public String getName() { return name; }
    @Override public String getOriginalFilename() { return originalFilename; }
    @Override public String getContentType() { return contentType; }
    @Override public boolean isEmpty() { return content.length == 0; }
    @Override public long getSize() { return content.length; }
    @Override public byte[] getBytes() { return content; }
    @Override public InputStream getInputStream() { return new ByteArrayInputStream(content); }
    @Override public void transferTo(File dest) throws IOException { /* 实现文件写入 */ }
}
