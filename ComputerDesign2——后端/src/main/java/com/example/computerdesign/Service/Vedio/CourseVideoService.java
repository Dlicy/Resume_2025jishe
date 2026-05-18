package com.example.computerdesign.Service.Vedio;

import com.example.computerdesign.DAO.Vedio.CourseVideoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CourseVideoService {
    private final CourseVideoRepository courseVideoRepository;

    public List<Long> getVideoIdsByCourseId(Long courseId) {
        return courseVideoRepository.findByCourseId(courseId).stream()
                .map(cv -> cv.getVideo().getId())
                .collect(Collectors.toList());
    }
}