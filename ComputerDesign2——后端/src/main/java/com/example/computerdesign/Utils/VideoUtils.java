package com.example.computerdesign.Utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class VideoUtils {
    public static int getVideoDuration(String filePath) throws IOException, InterruptedException {
        ProcessBuilder pb = new ProcessBuilder(
                "ffmpeg",
                "-i", filePath,
                "-f", "null",
                "-"
        );
        pb.redirectErrorStream(true);

        Process process = pb.start();
        String output = new String(process.getErrorStream().readAllBytes());
        process.waitFor();

        // 解析输出获取时长
        Pattern pattern = Pattern.compile("Duration: (\\d+):(\\d+):(\\d+)\\.\\d+");
        Matcher matcher = pattern.matcher(output);

        if (matcher.find()) {
            int hours = Integer.parseInt(matcher.group(1));
            int minutes = Integer.parseInt(matcher.group(2));
            int seconds = Integer.parseInt(matcher.group(3));
            return hours * 3600 + minutes * 60 + seconds;
        }

        throw new RuntimeException("无法解析视频时长");
    }
}