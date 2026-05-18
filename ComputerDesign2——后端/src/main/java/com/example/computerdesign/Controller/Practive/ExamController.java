package com.example.computerdesign.Controller.Practive;

import com.example.computerdesign.DAO.Practive.ExamAnswer;
import com.example.computerdesign.DAO.Practive.ExamSubmission;
import com.example.computerdesign.DTO.Practive.ExamAnswerDTO;
import com.example.computerdesign.DTO.Practive.ExamSubmissionDTO;
import com.example.computerdesign.Service.Practive.ExamService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/exams")
public class ExamController {
    private final ExamService examService;

    public ExamController(ExamService examService) {
        this.examService = examService;
    }

    @PostMapping
    public ResponseEntity<Integer> submitExam(@RequestBody ExamSubmissionDTO submissionDTO) {
        Integer submissionId = examService.submitExam(submissionDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(submissionId);
    }

    // 添加调试日志
    @GetMapping("/history")
    public ResponseEntity<Map<String, Object>> getUserExamHistory(
            @RequestParam Long userId,
            @RequestParam(required = false) String search) {

        try {
            List<ExamSubmission> results = examService.getUserExamHistory(userId, search);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("data", results); // 直接返回对象列表，Spring会自动序列化为JSON
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "查询失败: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
    @GetMapping("/history/{id}")
    public ResponseEntity<ExamSubmission> getExamDetail(
            @PathVariable Integer id) {
        return ResponseEntity.ok(examService.getExamDetail(id));
    }
}