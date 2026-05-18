package com.example.computerdesign.Service;

import com.example.computerdesign.DAO.AcupuncturePoints;
import com.example.computerdesign.DAO.AcupuncturePointsRepository;
import com.example.computerdesign.DTO.AcupuncturePoints_ProblemDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class AcupuncturePointsServicelmpl implements AcupuncturePointsService {

    @Autowired
    private AcupuncturePointsRepository acupuncturePointsRepository;

    @Override
    public AcupuncturePoints getFirstAcupuncturePointByAcupuncturePointName(String name) {
        // 查询所有匹配的记录
        List<AcupuncturePoints> results = acupuncturePointsRepository.findByAcupointName(name);
        // 如果结果不为空，返回第一条记录；否则返回 null
        if (!results.isEmpty()) {
            return results.get(0);
        } else {
            return null;
        }
    }

    @Override
    public AcupuncturePoints_ProblemDTO getProblem() {
        // 1. 随机选取一个穴位作为答案
//        AcupuncturePoints answer = acupuncturePointsRepository.findRandomAcupuncturePoint();
        AcupuncturePoints answer = acupuncturePointsRepository.findById(343).orElseThrow(
                () -> new RuntimeException("未找到ID为 "  + " 的穴位")
        );

        // 2. 随机选取 3 个穴位作为误导选项（排除答案）
        List<AcupuncturePoints> options = acupuncturePointsRepository.findRandomAcupuncturePoints(answer.getId(), 3);

        // 3. 将答案和误导选项组合成一套题目
        List<AcupuncturePoints> problem = new ArrayList<>();
        problem.add(answer); // 添加答案
        problem.addAll(options); // 添加误导选项

        // 4. 打乱顺序（可选）
        Collections.shuffle(problem);

        // 5. 创建 ProblemDTO 对象
        AcupuncturePoints_ProblemDTO problemDTO = new AcupuncturePoints_ProblemDTO(problem, answer);

        return problemDTO;
    }
}
