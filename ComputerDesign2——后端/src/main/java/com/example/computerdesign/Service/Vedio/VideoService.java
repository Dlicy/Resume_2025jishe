package com.example.computerdesign.Service.Vedio;

import com.example.computerdesign.DAO.Vedio.Video;
import org.springframework.data.domain.Page;

import java.util.List;

public interface VideoService {


    Video createVideo(Video video);

    Video getVideoById(Long id);

    // 获取列表
    Page<Video> getVideos(int page, int size, String title);

    Video updateVideo(Long id, Video videoDetails);


    void deleteVideo(Long id);

    List<Video> getRandomVideos(int count);

}
