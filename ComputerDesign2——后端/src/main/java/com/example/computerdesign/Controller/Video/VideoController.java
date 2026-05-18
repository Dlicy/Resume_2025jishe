package com.example.computerdesign.Controller.Video;


import com.example.computerdesign.DAO.Vedio.Video;
import com.example.computerdesign.Service.Vedio.CourseService;
import com.example.computerdesign.Service.Vedio.VideoService;
import com.example.computerdesign.Utils.VedioStorageService;
import com.example.computerdesign.Utils.VideoUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import ws.schild.jave.MultimediaInfo;
import ws.schild.jave.MultimediaObject;

import java.io.File;
import java.io.IOException;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;


@RestController
@RequestMapping("/api/videos")
@RequiredArgsConstructor
public class VideoController {
    private final VideoService videoService;
    private final VedioStorageService vedioStorageService;

    private final CourseService courseService;

    @Value("${file.video-image-upload-dir}")
    private String videoUploadDir;

    @Value("${Manager_Vedio_video}")
    private String vedioVideo;

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Video> uploadVideo(
            @RequestParam("file") MultipartFile file,
            @RequestParam String title,
            @RequestParam Long authorId,
            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) Long courseId,
            @RequestParam(required = false) Integer order) {

        try {
            String filePath = vedioStorageService.storeFile(file);
            // 将路径与配置中的目录结合
            // 组合完整的存储路径用于计算时长

            // 2. 存储封面图片（如果有）
            String coverImagePath = null;
            if (coverImage != null && !coverImage.isEmpty()) {
                coverImagePath = vedioStorageService.storeFile(coverImage);
            }

            System.out.println(filePath);
            String fullPath = videoUploadDir + File.separator + filePath;
            // 计算视频时长
            Integer duration = getVideoDuration(fullPath);

            Video video = new Video();
            video.setTitle(title);
            video.setVideoPath(filePath);
            video.setCoverImage(coverImagePath);
            video.setDuration(duration);
            video.setDescription(description);
            video.setAuthorId(authorId);
            video.setUploadTime(LocalDateTime.now());

            if (file.getSize() > 500 * 1024 * 1024) { // 500MB限制
                System.out.println("文件大小超过限制");
            }
            System.out.println(1);
            Video savedVideo = videoService.createVideo(video);

            System.out.println(2);
            if (courseId != null) {
//
                courseService.addVideoToCourse(courseId, savedVideo.getId(), order != null ? order : 0);
            }

            return ResponseEntity.ok(savedVideo);
        } catch (IOException e) {
            throw new RuntimeException("Failed to store file", e);
        }
    }


    /**
     * 获取视频列表（分页+筛选）
     */
    @GetMapping
    public ResponseEntity<Page<Video>> getVideos(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String title) {

        Page<Video> videoPage = videoService.getVideos(page, size, title);

        // 为每个视频的路径添加前缀
        videoPage.getContent().forEach(video -> {
            video.setVideoPath(vedioVideo + video.getVideoPath());
            if (video.getCoverImage() != null) {
                video.setCoverImage(vedioVideo + video.getCoverImage());
            }
        });

        return ResponseEntity.ok(videoPage);
    }

    /**
     * 获取单个视频详情
     */
    @GetMapping("/{id}")
    public ResponseEntity<Video> getVideoById(@PathVariable Long id) {
        Video video = videoService.getVideoById(id);

        // 为视频路径和封面图片添加前缀
        if (video != null) {
            video.setVideoPath(vedioVideo + video.getVideoPath());
            if (video.getCoverImage() != null) {
                video.setCoverImage(vedioVideo + video.getCoverImage());
            }
        }

        return ResponseEntity.ok(video);
    }


    /**
     * 更新视频信息
     */
    @PutMapping("/{id}")
    public ResponseEntity<Video> updateVideo(
            @PathVariable Long id,
            @RequestBody Video videoDetails) {

        return ResponseEntity.ok(videoService.updateVideo(id, videoDetails));
    }

    /**
     * 删除视频
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVideo(@PathVariable Long id) {
        Video video = videoService.getVideoById(id);
        if (video != null) {
            // 删除视频文件
            deleteFile(video.getVideoPath());
            // 删除封面图片
            if (video.getCoverImage() != null) {
                deleteFile(video.getCoverImage());
            }
        }

        videoService.deleteVideo(id);
        return ResponseEntity.noContent().build();
    }


    /**
     * 获取轮播图视频（随机3个）
     */
    @GetMapping("/carousel")
    public ResponseEntity<List<Video>> getCarouselVideos() {
        List<Video> carouselVideos = videoService.getRandomVideos(3);

        // 添加路径前缀
        carouselVideos.forEach(video -> {
            if (video != null) {
                video.setVideoPath(vedioVideo + video.getVideoPath());
                if (video.getCoverImage() != null) {
                    video.setCoverImage(vedioVideo + video.getCoverImage());
                }
            }
        });

        return ResponseEntity.ok(carouselVideos);
    }

    private void deleteFile(String filePath) {
        try {
            Path path = Paths.get(videoUploadDir, filePath);
            Files.deleteIfExists(path); // 删除文件，如果存在的话
        } catch (Exception e) {
            // 处理异常，记录日志或其他处理
            System.err.println("Failed to delete file: " + e.getMessage());
        }
    }

    private Integer getVideoDuration(String fullPath) {
        try {
            // 使用相对路径创建 File 对象
            File videoFile = new File(fullPath);
            MultimediaObject multimediaObject = new MultimediaObject(videoFile);
            MultimediaInfo multimediaInfo = multimediaObject.getInfo();
            long durationInMillis = multimediaInfo.getDuration(); // 获取时长（毫秒）
            return (int) (durationInMillis / 1000); // 转换为秒并返回
        } catch (Exception e) {
            System.err.println("获取视频时长失败，" + e.getMessage());
            return 0; // 返回0表示失败
        }
    }


}

