package com.example.computerdesign.Utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class FileStorageService {

    @Value("${file.upload-dir}")
    private String uploadDir;

    public String storeFile(MultipartFile file, String subDirectory) {
        try {
            Path uploadPath = Paths.get(uploadDir, subDirectory);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
            Path filePath = uploadPath.resolve(filename);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            return subDirectory + "/" + filename;
        } catch (IOException ex) {
            throw new RuntimeException("Failed to store file", ex);
        }
    }

    public byte[] loadFileAsBytes(String filePath) {
        try {
            Path path = Paths.get(uploadDir).resolve(filePath);
            Resource resource = new UrlResource(path.toUri());
            if (resource.exists() || resource.isReadable()) {
                return Files.readAllBytes(path);
            } else {
                throw new RuntimeException("Could not read file: " + filePath);
            }
        } catch (IOException ex) {
            throw new RuntimeException("Could not read file: " + filePath, ex);
        }
    }

    public void deleteFile(String filePath) {
        try {
            Path path = Paths.get(uploadDir).resolve(filePath);
            Files.deleteIfExists(path);
        } catch (IOException ex) {
            throw new RuntimeException("Could not delete file: " + filePath, ex);
        }
    }
}