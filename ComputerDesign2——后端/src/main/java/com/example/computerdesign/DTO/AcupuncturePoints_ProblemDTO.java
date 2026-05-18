package com.example.computerdesign.DTO;

import com.example.computerdesign.DAO.AcupuncturePoints;

import java.util.List;

public class AcupuncturePoints_ProblemDTO {
    private List<AcupuncturePoints> options; // 选项列表
    private AcupuncturePoints answer; // 答案的 ID

    // 构造方法
    public AcupuncturePoints_ProblemDTO(List<AcupuncturePoints> options, AcupuncturePoints answer) {
        this.options = options;
        this.answer = answer;
    }

    // Getter 和 Setter 方法
    public List<AcupuncturePoints> getOptions() {
        return options;
    }

    public void setOptions(List<AcupuncturePoints> options) {
        this.options = options;
    }

    public AcupuncturePoints getAnswer() {
        return answer;
    }

    public void setAnswer(AcupuncturePoints answer) {
        this.answer = answer;
    }
}
