package com.example.computerdesign.Service.UserTools;

import com.example.computerdesign.DTO.UserTools.StudyTimeDTO;
import com.example.computerdesign.DAO.UserTools.StudyTime;
import com.example.computerdesign.DTO.UserTools.StudyTimeSummary;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;
public interface StudyTimeService {
    /**
     * 创建或更新学习记录
     * @param recordDto 学习记录数据传输对象
     * @return 保存后的学习记录实体
     */
    StudyTime createOrUpdateRecord(StudyTimeDTO recordDto);

    /**
     * 获取用户的所有学习记录
     * @param userId 用户ID
     * @return 学习记录列表
     */
    List<StudyTime> getUserRecords(Long userId);

    /**
     * 获取用户在指定日期范围内的学习记录
     * @param userId 用户ID
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 学习记录列表
     */
    List<StudyTime> getUserRecordsByDateRange(Long userId, LocalDate startDate, LocalDate endDate);

    /**
     * 计算用户的总学习时间
     * @param userId 用户ID
     * @return 总学习时间(分钟)
     */
    Integer getUserTotalStudyTime(Long userId);

    /**
     * 删除学习记录
     * @param recordId 记录ID
     */
    void deleteRecord(Long recordId);

    StudyTime save(StudyTime studyTime);

    StudyTime findByUserIdAndStudyDate(Long userId, LocalDate studyDate);


    // 更新学习记录
    void recordStudyTime(Long userId, String moduleType, int minutes);

    // 获取今日学习数据
    StudyTimeSummary getTodaySummary(Long userId);

    List<StudyTime> findByUserIdAndDateRange(Long userId, LocalDate startDate, LocalDate endDate);
}



