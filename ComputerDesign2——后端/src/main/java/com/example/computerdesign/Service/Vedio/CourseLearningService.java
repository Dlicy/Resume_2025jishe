package com.example.computerdesign.Service.Vedio;

import com.example.computerdesign.DAO.UserRepository;
import com.example.computerdesign.DAO.Vedio.CourseLearning;
import com.example.computerdesign.DAO.Vedio.CourseLearningRepository;
import com.example.computerdesign.DAO.Vedio.CourseRepository;
import com.example.computerdesign.DAO.Vedio.VideoLearningRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class CourseLearningService {
    private final CourseLearningRepository courseLearningRepository;
    private final CourseRepository courseRepository;
    private final UserRepository userRepository;
    private final LearningService learningService;

    public CourseLearning getOrCreateEnrollment(Long userId, Long courseId) {
        return courseLearningRepository.findByUserIdAndCourseId(userId, courseId)
                .orElseGet(() -> {
                    CourseLearning newRecord = new CourseLearning();
                    newRecord.setUser(userRepository.findById(userId).orElseThrow());
                    newRecord.setCourse(courseRepository.findById(courseId).orElseThrow());
                    newRecord.setStartTime(LocalDateTime.now());
                    newRecord.setProgress(0);
                    newRecord.setIsCompleted(false);
                    return courseLearningRepository.save(newRecord);
                });
    }

    public CourseLearning enrollCourse(Long userId, Long courseId) {
        CourseLearning enrollment = courseLearningRepository.findByUserIdAndCourseId(userId, courseId)
                .orElseGet(() -> {
                    CourseLearning newRecord = new CourseLearning();
                    newRecord.setUser(userRepository.findById(userId).orElseThrow());
                    newRecord.setCourse(courseRepository.findById(courseId).orElseThrow());
                    newRecord.setStartTime(LocalDateTime.now());
                    return newRecord;
                });

        // 更新最后学习时间
        enrollment.setLastLearnTime(LocalDateTime.now());
        return courseLearningRepository.save(enrollment);
    }

    @Transactional
    public void quitCourse(Long userId, Long courseId) {
        try {
            courseLearningRepository.deleteByUserIdAndCourseId(userId, courseId);
        } catch (Exception e) {
            // 记录异常信息
            System.err.println("退出课程时发生错误: " + e.getMessage());
            throw e; // 或者处理异常
        }
    }

    // 更新课程进度（根据视频学习记录计算）
    public void updateCourseProgress(Long userId, Long courseId) {
        int progress = learningService.calculateCourseProgress(userId, courseId);
        courseLearningRepository.findByUserIdAndCourseId(userId, courseId)
                .ifPresent(enrollment -> {
                    enrollment.setProgress(progress);
                    enrollment.setLastLearnTime(LocalDateTime.now());
                    if (progress >= 100) {
                        enrollment.setIsCompleted(true);
                        enrollment.setCompleteTime(LocalDateTime.now());
                    }
                    courseLearningRepository.save(enrollment);
                });
    }

    public boolean existsByUserIdAndCourseId(Long userId, Long courseId) {
        return courseLearningRepository.existsByUserIdAndCourseId(userId, courseId);
    }
}
