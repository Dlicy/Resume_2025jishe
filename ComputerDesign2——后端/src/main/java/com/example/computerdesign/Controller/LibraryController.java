package com.example.computerdesign.Controller;

import com.example.computerdesign.DAO.Library;
import com.example.computerdesign.DAO.LibraryRepository; // 假设你有一个名为 LibraryRepository 的接口
import com.example.computerdesign.Response;
import com.example.computerdesign.Service.LibraryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/Library") // 设置分路由头
//@CrossOrigin(origins = "http://localhost:5173")
public class LibraryController {

    @Autowired
    private LibraryRepository libraryRepository; // 注入 Repository

    @Autowired
    private LibraryService libraryService; // 使用 LibraryService 接口

    // 使用相对路径
    private final Path uploadDir = Paths.get(System.getProperty("user.dir"), "src", "main", "resources", "static", "LibraryData","PDFs");
    private final Path uploadDir2 = Paths.get("LibraryData","PDFs");
    @PostMapping("/upload")
    public Response uploadFile(
            @RequestParam("file") MultipartFile file,
            @RequestParam("title") String title,
            @RequestParam("author") String author,
            @RequestParam("description") String description) {

        // 确保上传目录存在
        File dir = uploadDir.toFile();
        if (!dir.exists()) {
            boolean created = dir.mkdirs(); // 创建目录
            if (!created) {
                return Response.newFail("目录创建失败！");
            }
        }

        // 文件存储路径
        String filePath = uploadDir.resolve(file.getOriginalFilename()).toString();
        String filePath2 = uploadDir2.resolve(file.getOriginalFilename()).toString();
        try {
            System.out.println("File path: " + filePath);
            file.transferTo(new File(filePath)); // 保存文件
            // 创建 Library 实例并填充数据
            Library book = new Library();
            book.setTitle(title);
            book.setAuthor(author);
            book.setDescription(description);
            book.setFilePath(filePath2);
            book.setCreatedAt(new Date()); // 设置创建时间
            // 保存书籍信息到数据库
            libraryRepository.save(book);

            Map<String, Object> responseBody = new HashMap<>();
            responseBody.put("path", filePath);
            responseBody.put("result", "存储成功！");
            return Response.newSuccess(responseBody);
        } catch (IOException e) {
            return Response.newFail(e.getMessage());
        }
    }

    // 获取书籍内容
    @GetMapping("/getbook")
    public Response getBook(@RequestParam int bookId) {
        String filepath = libraryService.getBookFilePath(bookId);
        String UrlPath = Paths.get("192.168.1.8:8080",filepath).toString();
        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("url", UrlPath);
        responseBody.put("result", "获取成功！");
        if (filepath != null) {
            return Response.newSuccess(responseBody);
        } else {
            return Response.newFail("获取失败！请检查id是否输入错误！");
        }
    }




}