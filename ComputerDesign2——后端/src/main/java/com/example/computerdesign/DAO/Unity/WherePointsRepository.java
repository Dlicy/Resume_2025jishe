package com.example.computerdesign.DAO.Unity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WherePointsRepository extends JpaRepository<WherePoints, Integer> {
    boolean existsById(Integer id);
}
