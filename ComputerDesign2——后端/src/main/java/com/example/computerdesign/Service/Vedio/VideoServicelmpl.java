package com.example.computerdesign.Service.Vedio;

import com.example.computerdesign.DAO.User;
import com.example.computerdesign.DAO.UserRepository;
import com.example.computerdesign.DAO.Vedio.Video;
import com.example.computerdesign.DAO.Vedio.VideoRepository;
import com.example.computerdesign.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class VideoServicelmpl implements VideoService {
    private final VideoRepository videoRepository;
    private final UserRepository userRepository;

    @Override
    public Video createVideo(Video video) {
        video.setUploadTime(LocalDateTime.now());
        return videoRepository.save(video);
    }

    @Override
    public Video getVideoById(Long id) {
        return videoRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Video not found"));
    }

    @Override
    public Page<Video> getVideos(int page, int size, String title) {
        Pageable pageable = PageRequest.of(page, size);

        if (title != null && !title.trim().isEmpty()) {
            return videoRepository.findByTitleContaining(title, pageable);
        }

        return videoRepository.findAll(pageable);
    }

    @Override
    public Video updateVideo(Long id, Video videoDetails) {
        Video video = getVideoById(id);
        video.setTitle(videoDetails.getTitle());
        video.setDescription(videoDetails.getDescription());
        video.setCoverImage(videoDetails.getCoverImage());
        return videoRepository.save(video);
    }

    @Override
    public void deleteVideo(Long id) {
        videoRepository.deleteById(id);
    }

    @Override
    public List<Video> getRandomVideos(int count) {
        // 获取所有视频ID
        List<Long> allVideoIds = videoRepository.findAllVideoIds();

        if (allVideoIds.isEmpty()) {
            return Collections.emptyList();
        }

        // 随机选择
        Collections.shuffle(allVideoIds);
        List<Long> selectedIds = allVideoIds.stream()
                .limit(count)
                .collect(Collectors.toList());

        // 如果视频数量不足，用null填充
        while (selectedIds.size() < count) {
            selectedIds.add(null);
        }

        return selectedIds.stream()
                .map(id -> id != null ? videoRepository.findById(id).orElse(null) : null)
                .collect(Collectors.toList());
    }
}
