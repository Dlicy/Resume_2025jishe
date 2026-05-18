package com.example.computerdesign.Controller;

import com.example.computerdesign.DTO.AcupuncturePoints_ProblemDTO;
import com.example.computerdesign.Response;
import com.example.computerdesign.Service.AcupuncturePointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.computerdesign.DAO.AcupuncturePoints;
import com.example.computerdesign.DAO.AcupuncturePointsRepository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/AcupuncturePoints") // 设置分路由头
public class AcupuncturePointsController {

    @Autowired
    private AcupuncturePointsRepository acupuncturePointsRepository;

    @Autowired
    private AcupuncturePointsService acupuncturePointsService;

    // 根据 acupointName 查询穴数据
    @PostMapping("/findByName")
    public Response getAcupuncturePointByPulse(@RequestBody String AcupointName) {
        System.out.println(AcupointName);

        AcupointName = AcupointName.replace("\"", "").trim();

        // 调用 Service 层方法
        AcupuncturePoints result = acupuncturePointsService.getFirstAcupuncturePointByAcupuncturePointName(AcupointName);

        // 返回结果
        if (result != null) {
            Map<String, Object> responseBody = new HashMap<>();
            responseBody.put("information", result);
            responseBody.put("result", "查找成功！");
            return Response.newSuccess(responseBody);
        } else {
            return Response.newFail("未找到匹配的记录");
        }
    }

    @GetMapping("/getProblem")
    public Response getProblem() {
        System.out.println("收到题目请求");
        try {
            // 调用 Service 方法获取题目
            AcupuncturePoints_ProblemDTO problem = acupuncturePointsService.getProblem();
            // 返回题目给前端
            return Response.newSuccess(problem);
        } catch (Exception e) {
            // 返回错误响应
            return Response.newFail("获取题目失败，请稍后重试");
        }
    }
}