package com.example.computerdesign.DAO.Vedio;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface VideoRepository extends JpaRepository<Video, Long> {
    List<Video> findByAuthorId(Long authorId);

    Page<Video> findByTitleContaining(String title, Pageable pageable);

    // 轮播图
    @Query("SELECT v.id FROM Video v")
    List<Long> findAllVideoIds();

}