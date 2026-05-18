package com.example.computerdesign.Service.UserTools;

import com.example.computerdesign.DAO.UserTools.StudyTime;
import com.example.computerdesign.DAO.UserTools.StudyTimeRepository;
import com.example.computerdesign.DTO.UserTools.StudyTimeDTO;
import com.example.computerdesign.DTO.UserTools.StudyTimeSummary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Service
public class StudyTimeServicelmpl  implements StudyTimeService{
    private final StudyTimeRepository studyTimeRepository;

    @Autowired
    public StudyTimeServicelmpl(StudyTimeRepository studyTimeRepository) {
        this.studyTimeRepository = studyTimeRepository;
    }

    @Override
    @Transactional
    public StudyTime createOrUpdateRecord(StudyTimeDTO recordDto) {
        // 获取 Optional 结果（不再需要手动包装）
        Optional<StudyTime> existingRecord = studyTimeRepository.findByUserIdAndStudyDate(
                recordDto.getUserId(),
                recordDto.getStudyDate()
        );

        StudyTime record;
        if (existingRecord.isPresent()) {
            // 更新现有记录
            record = existingRecord.get();
            record.setStudyTime(recordDto.getStudyTime());
            record.setBookTime(recordDto.getBookTime());       // 新增模块字段
            record.setHerbTime(recordDto.getHerbTime());       // 新增模块字段
            record.setFormulaTime(recordDto.getFormulaTime()); // 新增模块字段
            record.setLastModified(LocalTime.now());
        } else {
            // 创建新记录
            record = new StudyTime();
            record.setUserId(recordDto.getUserId());
            record.setStudyTime(recordDto.getStudyTime());
            record.setBookTime(recordDto.getBookTime());       // 新增模块字段
            record.setHerbTime(recordDto.getHerbTime());       // 新增模块字段
            record.setFormulaTime(recordDto.getFormulaTime()); // 新增模块字段
            record.setStudyDate(recordDto.getStudyDate());
            record.setLastModified(LocalTime.now());
        }

        return studyTimeRepository.save(record);
    }

    @Override
    public List<StudyTime> getUserRecords(Long userId) {
        return studyTimeRepository.findByUserId(userId);
    }

    @Override
    public List<StudyTime> getUserRecordsByDateRange(Long userId, LocalDate startDate, LocalDate endDate) {
        return studyTimeRepository.findByUserIdAndDateRange(userId, startDate, endDate);
    }

    @Override
    public Integer getUserTotalStudyTime(Long userId) {
        Integer total = studyTimeRepository.sumStudyTimeByUserId(userId);
        return total != null ? total : 0;
    }

    @Override
    public void deleteRecord(Long recordId) {
        studyTimeRepository.deleteById(recordId);
    }

    @Override
    @Transactional
    public StudyTime save(StudyTime studyTime) {
        return studyTimeRepository.save(studyTime);
    }


    @Override
    @Transactional
    public void recordStudyTime(Long userId, String moduleType, int minutes) {
        LocalDate today = LocalDate.now();
        // 获取Optional对象
        Optional<StudyTime> optionalRecord = studyTimeRepository.findByUserIdAndStudyDate(userId, today);

        StudyTime record;
        if (optionalRecord.isPresent()) {
            record = optionalRecord.get();
        } else {
            record = new StudyTime();
            record.setUserId(userId);
            record.setStudyDate(today);
            record = studyTimeRepository.save(record); // 保存新记录
        }

        // 更新学习时间
        record.updateStudyTime(moduleType, minutes);
        studyTimeRepository.save(record);
    }

    @Override
    public StudyTimeSummary getTodaySummary(Long userId) {
        LocalDate today = LocalDate.now();
        Optional<StudyTime> optionalRecord = studyTimeRepository.findByUserIdAndStudyDate(userId, today);

        if (optionalRecord.isPresent()) {
            StudyTime record = optionalRecord.get();
            return new StudyTimeSummary(
                    record.getStudyTime(),
                    record.getBookTime(),
                    record.getHerbTime(),
                    record.getFormulaTime()
            );
        } else {
            return new StudyTimeSummary(0, 0, 0, 0);
        }
    }


    @Override
    public StudyTime findByUserIdAndStudyDate(Long userId, LocalDate studyDate) {
        return studyTimeRepository.findByUserIdAndStudyDate(userId, studyDate)
                .orElse(null);
    }

    @Override
    public List<StudyTime> findByUserIdAndDateRange(Long userId, LocalDate startDate, LocalDate endDate) {
        return studyTimeRepository.findByUserIdAndStudyDateBetween(userId, startDate, endDate);
    }
}

