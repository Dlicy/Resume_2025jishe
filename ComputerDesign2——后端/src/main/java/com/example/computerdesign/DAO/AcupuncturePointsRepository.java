package com.example.computerdesign.DAO;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

@Repository
public interface AcupuncturePointsRepository extends JpaRepository<AcupuncturePoints, Integer> {
    List<AcupuncturePoints> findByAcupointName(String name);

    // 随机选取一个穴位
    @Query(value = "SELECT * FROM acupoints ORDER BY RAND() LIMIT 1", nativeQuery = true)
    AcupuncturePoints findRandomAcupuncturePoint();

    // 随机选取多个穴位（排除指定的答案）
    @Query(value = "SELECT * FROM acupoints WHERE id != :excludeId ORDER BY RAND() LIMIT :limit", nativeQuery = true)
    List<AcupuncturePoints> findRandomAcupuncturePoints(int excludeId, int limit);


}