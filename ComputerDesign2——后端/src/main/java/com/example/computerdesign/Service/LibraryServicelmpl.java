package com.example.computerdesign.Service;


import com.example.computerdesign.DAO.Library;
import com.example.computerdesign.DAO.LibraryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LibraryServicelmpl implements LibraryService {

    @Autowired
    private LibraryRepository libraryRepository; // 注入数据访问层

    @Override
    public String getBookFilePath(int bookId) {
        Library book = libraryRepository.findById(bookId);
        return (book != null) ? book.getFilePath() : null; // 返回文件路径或 null
    }
}
