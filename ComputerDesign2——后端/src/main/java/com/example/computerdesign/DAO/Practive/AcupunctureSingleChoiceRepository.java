package com.example.computerdesign.DAO.Practive;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface AcupunctureSingleChoiceRepository extends JpaRepository<AcupunctureSingleChoice, Integer> {
    List<AcupunctureSingleChoice> findByIsActiveTrue();

    @Query("SELECT q FROM AcupunctureSingleChoice q WHERE q.isActive = true ORDER BY RAND() LIMIT :count")
    List<AcupunctureSingleChoice> findRandomActiveQuestions(@Param("count") int count);

    // 分页查询方法
    Page<AcupunctureSingleChoice> findByQuestionContaining(String search, Pageable pageable);

    Page<AcupunctureSingleChoice> findByIsActive(Boolean isActive, Pageable pageable);

    Page<AcupunctureSingleChoice> findByQuestionContainingAndIsActive(String search, Boolean isActive, Pageable pageable);

    // 搜索方法
    List<AcupunctureSingleChoice> findByQuestionContainingOrExplanationContaining(String questionKeyword, String explanationKeyword);

    // 更新状态方法
    @Modifying
    @Transactional
    @Query("UPDATE AcupunctureSingleChoice q SET q.isActive = :isActive WHERE q.id = :id")
    void updateStatusById(Integer id, Boolean isActive);


    // 组卷
//    @Query("SELECT q FROM AcupunctureSingleChoice q WHERE q.isActive = true")
    @Query(value = "SELECT * FROM acupuncture_single_choice WHERE is_active = TRUE ORDER BY RAND() LIMIT :count", nativeQuery = true)
    List<AcupunctureSingleChoice> findActiveQuestions();


}
