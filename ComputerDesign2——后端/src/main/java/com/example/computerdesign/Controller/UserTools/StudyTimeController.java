package com.example.computerdesign.Controller.UserTools;

import com.example.computerdesign.DAO.UserTools.StudyTime;
import com.example.computerdesign.Response;
import com.example.computerdesign.Service.UserTools.StudyTimeService;
import com.example.computerdesign.Utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/study-time")
public class StudyTimeController {
    @Autowired
    private StudyTimeService studyTimeService;

    /**
     * 更新用户学习时间
     * @param token 用户令牌 (格式: Bearer <token>)
     * @return 更新结果
     */
    @PostMapping("/update")
    public Response updateStudyTime(
            @RequestHeader("Authorization") String token,
            @RequestBody Map<String, String> requestBody) { // 接收请求体

        try {
            // 1. 解析token
            String jwtToken = token.replace("Bearer ", "").trim();
            Map<String, Object> claims = JwtUtil.parseToken(jwtToken);
            Long userId = Long.valueOf(claims.get("id").toString());

            // 2. 获取模块参数
            String currentModule = requestBody.get("module");
            LocalDate currentDate = LocalDate.now();
            LocalTime currentTime = LocalTime.now();

            // 3. 查询或创建记录（修复版）
            StudyTime studyRecord = studyTimeService.findByUserIdAndStudyDate(userId, currentDate);
            if (studyRecord == null) {
                studyRecord = new StudyTime();
                studyRecord.setUserId(userId);
                studyRecord.setStudyDate(currentDate);
                // 必须初始化所有非空字段
                studyRecord.setStudyTime(0);
                studyRecord.setBookTime(0);
                studyRecord.setHerbTime(0);
                studyRecord.setFormulaTime(0);
                studyRecord.setOtherTime(0);
                studyRecord.setLastModified(currentTime);
                studyRecord = studyTimeService.save(studyRecord);
            }



            // 4. 检查时间差并更新
            Duration duration = Duration.between(studyRecord.getLastModified(), currentTime);
            if (duration.toMinutes() >= 1) {
                // 根据模块类型增加对应时间
                switch(currentModule) {
                    case "book":
                        studyRecord.setBookTime(studyRecord.getBookTime() + 1);
                        break;
                    case "herb":
                        studyRecord.setHerbTime(studyRecord.getHerbTime() + 1);
                        break;
                    case "formula":
                        studyRecord.setFormulaTime(studyRecord.getFormulaTime() + 1);
                        break;
                    default:
                        studyRecord.setOtherTime(studyRecord.getOtherTime() + 1);
                }
                studyRecord.setStudyTime(studyRecord.getStudyTime() + 1); // 总时长
                studyRecord.setLastModified(currentTime);
                studyTimeService.save(studyRecord);
            }

            return Response.newSuccess("学习时间已更新");
        } catch (Exception e) {
            return Response.newFail("更新学习时间失败: " + e.getMessage());
        }
    }

    /**
     * 创建响应数据
     * @param studyTime 学习时间
     * @return 包含学习时间的Map
     */
    private Map<String, Object> createResponseData(int studyTime) {
        Map<String, Object> data = new HashMap<>();
        data.put("studyTime", studyTime);
        return data;
    }

    /**
     * 获取用户当前学习时间
     * @param token 用户令牌
     * @return 当前学习时间
     */
    @GetMapping("/current")
    public Response getCurrentStudyTime(@RequestHeader("Authorization") String token) {
        try {
            // 解析token获取用户ID
            String jwtToken = token.replace("Bearer ", "").trim();
            Map<String, Object> claims = JwtUtil.parseToken(jwtToken);
            Long userId = Long.valueOf(claims.get("userId").toString());

            // 查询当天记录
            StudyTime studyRecord = studyTimeService.findByUserIdAndStudyDate(
                    userId,
                    LocalDate.now()
            );

            int currentStudyTime = (studyRecord != null) ? studyRecord.getStudyTime() : 0;
            return Response.newSuccess( createResponseData(currentStudyTime));

        } catch (Exception e) {
            return Response.newFail("获取学习时间失败: " + e.getMessage());
        }
    }

    /**
     * 获取用户过去一年的学习数据
     * @param token 用户令牌
     * @return 过去一年的学习数据
     */
    @GetMapping("/last-year")
    public Response getLastYearStudyData(@RequestHeader("Authorization") String token) {
        try {
            // 解析token获取用户ID
            String jwtToken = token.replace("Bearer ", "").trim();
            Map<String, Object> claims = JwtUtil.parseToken(jwtToken);
            Long userId = Long.valueOf(claims.get("id").toString());

            // 计算日期范围
            LocalDate today = LocalDate.now();
            LocalDate oneYearAgo = today.minusDays(364); // 364天前（共365天）

            // 查询数据库
            List<StudyTime> records = studyTimeService.findByUserIdAndDateRange(
                    userId,
                    oneYearAgo,
                    today
            );

            // 转换为前端需要的格式
            List<Map<String, Object>> result = records.stream()
                    .map(record -> {
                        Map<String, Object> item = new HashMap<>();
                        item.put("studyDate", record.getStudyDate().toString());
                        item.put("studyTime", record.getStudyTime());
                        return item;
                    })
                    .collect(Collectors.toList());

            return Response.newSuccess(result);
        } catch (Exception e) {
            return Response.newFail("获取学习数据失败: " + e.getMessage());
        }
    }

    /**
     * 获取用户今日各模块学习时间分布
     * @param token 用户令牌
     * @return 今日各模块学习时间
     */
    @GetMapping("/today-modules")
    public Response getTodayModuleDistribution(@RequestHeader("Authorization") String token) {
        try {
            // 解析token获取用户ID
            String jwtToken = token.replace("Bearer ", "").trim();
            Map<String, Object> claims = JwtUtil.parseToken(jwtToken);
            Long userId = Long.valueOf(claims.get("id").toString());

            // 查询今日记录
            StudyTime todayRecord = studyTimeService.findByUserIdAndStudyDate(
                    userId,
                    LocalDate.now()
            );

            // 构建返回数据
            Map<String, Object> result = new HashMap<>();
            result.put("bookTime", todayRecord != null ? todayRecord.getBookTime() : 0);
            result.put("herbTime", todayRecord != null ? todayRecord.getHerbTime() : 0);
            result.put("formulaTime", todayRecord != null ? todayRecord.getFormulaTime() : 0);
            result.put("otherTime", todayRecord != null ? todayRecord.getOtherTime() : 0);

            return Response.newSuccess(result);
        } catch (Exception e) {
            return Response.newFail("获取今日模块分布数据失败: " + e.getMessage());
        }
    }

}
