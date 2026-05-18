package com.example.computerdesign.DAO;

import org.springframework.stereotype.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

@Repository
public interface LibraryRepository extends JpaRepository<Library, Integer> {
    Library findById(int id); // 根据 ID 查找书籍
}