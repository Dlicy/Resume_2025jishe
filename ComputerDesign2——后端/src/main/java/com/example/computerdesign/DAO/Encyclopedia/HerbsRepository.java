package com.example.computerdesign.DAO.Encyclopedia;

import com.example.computerdesign.DAO.AcupuncturePoints;
import com.example.computerdesign.DTO.HerbDTO;
import com.example.computerdesign.DTO.HerbsDTO;
import com.example.computerdesign.DTO.MaxHerbDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Repository
public interface HerbsRepository extends JpaRepository<Herbs, Integer> {
    List<Herbs> findByDrugCategory(String name);

    @Query("SELECT DISTINCT h.drugCategories FROM Herbs h")
    List<String> findDistinctDrugCategories();

    @Query("SELECT DISTINCT h.drugCategory FROM Herbs h WHERE h.drugCategories = ?1")
    List<String> findDistinctDrugCategoryByCategories(String category);

    @Query("SELECT h FROM Herbs h WHERE h.drugCategory = ?1")
    List<Herbs> findMainNameByCategory(String category);

    Herbs findByid(int id);

    // 分页查询方法
    // 分页查询方法，返回 DTO
    @Query("SELECT new com.example.computerdesign.DTO.HerbsDTO(h.id, h.mainName, h.subName, h.drugCategories, h.drugCategory, h.imageUrl) FROM Herbs h")
    Page<HerbsDTO> findAllHerbs(Pageable pageable);

    // 返回所有详细信息的草药列表
    @Query("SELECT new com.example.computerdesign.DTO.MaxHerbDTO(h.id, h.mainName, h.subName, h.drugCategories, h.drugCategory, h.natureAndFlavor, h.processing, h.meridians, h.efficacy, h.indications, h.usageAndDosage, h.contraindications, h.source, h.characters, h.formulas, h.imageUrl) FROM Herbs h")
    Page<MaxHerbDTO> findAllMaxHerbs(Pageable pageable);

    @Query("SELECT new com.example.computerdesign.DTO.HerbsDTO(h.id, h.mainName, h.subName, h.drugCategories, h.drugCategory, h.imageUrl) " +
            "FROM Herbs h WHERE (:category IS NULL OR h.drugCategory = :category) " +
            "AND (LOWER(h.mainName) LIKE LOWER(CONCAT('%', :input, '%')))")
    List<HerbsDTO> searchHerbs(@Param("category") String category, @Param("input") String input);

    // 只根据搜索框的输入来进行查询
    @Query("SELECT new com.example.computerdesign.DTO.HerbsDTO(h.id, h.mainName, h.subName, h.drugCategories, h.drugCategory, h.imageUrl) " +
            "FROM Herbs h WHERE LOWER(h.mainName) LIKE LOWER(CONCAT('%', :input, '%'))")
    List<HerbsDTO> searchByInput(@Param("input") String input);

    @Query("SELECT new com.example.computerdesign.DTO.HerbsDTO(h.id, h.mainName, h.subName, h.drugCategories, h.drugCategory, h.imageUrl) " +
            "FROM Herbs h WHERE h.drugCategories = :category")
    List<HerbsDTO> findByCategory(@Param("category") String category);

    @Query("SELECT new com.example.computerdesign.DTO.HerbsDTO(h.id, h.mainName, h.subName, h.drugCategories, h.drugCategory, h.imageUrl) " +
            "FROM Herbs h WHERE h.drugCategory = :category")
    List<HerbsDTO> findBySubCategory(@Param("category") String category);

    // 管理员界面查询
    @Query("SELECT new com.example.computerdesign.DTO.MaxHerbDTO(h.id, h.mainName, h.subName, h.drugCategories, h.drugCategory, h.natureAndFlavor, h.processing, h.meridians, h.efficacy, h.indications, h.usageAndDosage, h.contraindications, h.source, h.characters, h.formulas, h.imageUrl) " +
            "FROM Herbs h WHERE LOWER(h.mainName) LIKE LOWER(CONCAT('%', :mainName, '%'))")
    List<MaxHerbDTO> findByMainName(@Param("mainName") String mainName);
}