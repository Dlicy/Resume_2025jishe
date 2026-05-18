package com.example.computerdesign.Controller.Practive;

import com.example.computerdesign.DAO.Practive.AcupunctureSingleChoice;
import com.example.computerdesign.Service.Practive.QuestionService;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/questions")
public class QuestionController {
    private final QuestionService questionService;

    public QuestionController(QuestionService questionService) {
        this.questionService = questionService;
    }

    @GetMapping
    public ResponseEntity<List<AcupunctureSingleChoice>> getAllActiveQuestions() {
        return ResponseEntity.ok(questionService.getActiveQuestions());
    }

    @GetMapping("/random")
    public ResponseEntity<List<AcupunctureSingleChoice>> getRandomQuestions(
            @RequestParam(defaultValue = "10") int count) {
        return ResponseEntity.ok(questionService.getRandomQuestions(count));
    }

    @GetMapping("/{id}")
    public ResponseEntity<AcupunctureSingleChoice> getQuestionById(@PathVariable Integer id) {
        return ResponseEntity.ok(questionService.getQuestionById(id));
    }

    @PostMapping
    public ResponseEntity<AcupunctureSingleChoice> createQuestion(
            @RequestBody AcupunctureSingleChoice question) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(questionService.createQuestion(question));
    }

    @PutMapping("/{id}")
    public ResponseEntity<AcupunctureSingleChoice> updateQuestion(
            @PathVariable Integer id,
            @RequestBody AcupunctureSingleChoice questionDetails) {
        return ResponseEntity.ok(questionService.updateQuestion(id, questionDetails));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteQuestion(@PathVariable Integer id) {
        questionService.deleteQuestion(id);
        return ResponseEntity.noContent().build();
    }

    /**
     * 分页查询题目列表
     * @param page 页码(从0开始)
     * @param size 每页数量
     * @param search 搜索关键词
     * @param isActive 是否激活
     * @return 分页数据
     */
    @GetMapping("/list")
    public ResponseEntity<Page<AcupunctureSingleChoice>> getQuestionsByPage(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) Boolean isActive) {
        return ResponseEntity.ok(questionService.getQuestionsByPage(page, size, search, isActive));
    }

    /**
     * 更新题目状态
     * @param id 题目ID
     * @param isActive 是否激活
     * @return 空响应
     */
    @PatchMapping("/{id}/status")
    public ResponseEntity<Void> updateQuestionStatus(
            @PathVariable Integer id,
            @RequestParam Boolean isActive) {
        questionService.updateQuestionStatus(id, isActive);
        return ResponseEntity.noContent().build();
    }

    /**
     * 搜索题目
     * @param keyword 关键词
     * @return 题目列表
     */
    @GetMapping("/search")
    public ResponseEntity<List<AcupunctureSingleChoice>> searchQuestions(
            @RequestParam String keyword) {
        return ResponseEntity.ok(questionService.searchQuestions(keyword));
    }


    /**
     * 随机组卷
     * @param count 题目数量
     * @param type 组卷类型(quick/smart/custom)
     * @return 题目列表
     */
    @GetMapping("/random-paper")
    public ResponseEntity<List<AcupunctureSingleChoice>> generateRandomPaper(
            @RequestParam(defaultValue = "10") int count,
            @RequestParam(defaultValue = "quick") String type) {
        return ResponseEntity.ok(questionService.generateRandomPaper(count, type));
    }

}
