package com.example.computerdesign.Service.Practive;

import com.example.computerdesign.DAO.Practive.AcupunctureSingleChoice;
import com.example.computerdesign.DAO.Practive.AcupunctureSingleChoiceRepository;
import com.example.computerdesign.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class QuestionService {
    private final AcupunctureSingleChoiceRepository questionRepository;

    public QuestionService(AcupunctureSingleChoiceRepository questionRepository) {
        this.questionRepository = questionRepository;
    }

    public List<AcupunctureSingleChoice> getActiveQuestions() {
        return questionRepository.findByIsActiveTrue();
    }

    public List<AcupunctureSingleChoice> getRandomQuestions(int count) {
        return questionRepository.findRandomActiveQuestions(count);
    }

    public AcupunctureSingleChoice getQuestionById(Integer id) {
        return questionRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found with id: " + id));
    }

    public AcupunctureSingleChoice createQuestion(AcupunctureSingleChoice question) {
        return questionRepository.save(question);
    }

    public AcupunctureSingleChoice updateQuestion(Integer id, AcupunctureSingleChoice questionDetails) {
        AcupunctureSingleChoice question = getQuestionById(id);
        question.setQuestion(questionDetails.getQuestion());
        question.setOptionA(questionDetails.getOptionA());
        question.setOptionB(questionDetails.getOptionB());
        question.setOptionC(questionDetails.getOptionC());
        question.setOptionD(questionDetails.getOptionD());
        question.setCorrectAnswer(questionDetails.getCorrectAnswer());
        question.setExplanation(questionDetails.getExplanation());
        question.setIsActive(questionDetails.getIsActive());
        return questionRepository.save(question);
    }

    public void deleteQuestion(Integer id) {
        AcupunctureSingleChoice question = getQuestionById(id);
        questionRepository.delete(question);
    }

    /**
     * 分页查询题目
     */
    public Page<AcupunctureSingleChoice> getQuestionsByPage(int page, int size, String search, Boolean isActive) {
        Pageable pageable = PageRequest.of(page, size);
        if (search != null && isActive != null) {
            return questionRepository.findByQuestionContainingAndIsActive(search, isActive, pageable);
        } else if (search != null) {
            return questionRepository.findByQuestionContaining(search, pageable);
        } else if (isActive != null) {
            return questionRepository.findByIsActive(isActive, pageable);
        }
        return questionRepository.findAll(pageable);
    }

    /**
     * 更新题目状态
     */
    @Transactional
    public void updateQuestionStatus(Integer id, Boolean isActive) {
        questionRepository.updateStatusById(id, isActive);
    }

    /**
     * 搜索题目
     */
    public List<AcupunctureSingleChoice> searchQuestions(String keyword) {
        return questionRepository.findByQuestionContainingOrExplanationContaining(keyword, keyword);
    }


    public List<AcupunctureSingleChoice> generateRandomPaper(int count, String type) {
        // 目前简单实现随机抽题，后续可根据type实现不同逻辑
        List<AcupunctureSingleChoice> allQuestions = questionRepository.findActiveQuestions();
        Collections.shuffle(allQuestions);
        return allQuestions.stream().limit(count).collect(Collectors.toList());
    }
}