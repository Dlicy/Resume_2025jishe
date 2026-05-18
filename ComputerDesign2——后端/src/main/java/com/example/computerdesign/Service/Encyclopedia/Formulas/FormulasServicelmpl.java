package com.example.computerdesign.Service.Encyclopedia.Formulas;

import com.example.computerdesign.DAO.Encyclopedia.Formulas.Formulas;
import com.example.computerdesign.DAO.Encyclopedia.Formulas.FormulasRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;



import org.springframework.data.jpa.domain.Specification;
import jakarta.persistence.criteria.Predicate;
import org.springframework.util.StringUtils;
import java.util.ArrayList;
import java.util.List;


@Service
public class FormulasServicelmpl implements FormulasService {
    private final FormulasRepository formulasRepository;

    @Autowired
    public FormulasServicelmpl(FormulasRepository formulasRepository) {
        this.formulasRepository = formulasRepository;
    }

    @Override
    public Formulas saveFormula(Formulas formula) {
        return formulasRepository.save(formula);
    }

    @Override
    public Page<Formulas> getAllFormulas(Pageable pageable) {
        // Spring Data JPA 提供的分页方法
        return formulasRepository.findAll(pageable);
    }

    // 修改保存信息
    @Override
    public Formulas updateFormula(Formulas formula) {
        // 检查ID是否存在
        if (formula.getId() == null) {
            throw new IllegalArgumentException("方剂ID不能为空");
        }

        // 检查记录是否存在
        formulasRepository.findById(formula.getId())
                .orElseThrow(() -> new RuntimeException("找不到ID为 " + formula.getId() + " 的方剂"));

        // 保存更新后的数据
        return formulasRepository.save(formula);
    }


    @Override
    public void deleteFormula(Integer id) {
        // 检查记录是否存在
        if (!formulasRepository.existsById(id)) {
            throw new RuntimeException("找不到ID为 " + id + " 的方剂");
        }

        // 删除记录
        formulasRepository.deleteById(id);
    }


    @Override
    public Page<Formulas> searchFormulas(String mainCategory, String subCategory, String input, Pageable pageable) {
        // 构建动态查询
        Specification<Formulas> spec = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            // 如果大类不为空
            if (StringUtils.hasText(mainCategory)) {
                predicates.add(cb.equal(root.get("mainCategory"), mainCategory));
            }

            // 如果小类不为空
            if (StringUtils.hasText(subCategory)) {
                predicates.add(cb.equal(root.get("subCategory"), subCategory));
            }

            // 如果搜索关键词不为空
            if (StringUtils.hasText(input)) {
                // 在多个字段中进行模糊搜索
                String likePattern = "%" + input + "%";
                predicates.add(cb.or(
                        cb.like(root.get("name"), likePattern),
                        cb.like(root.get("composition"), likePattern),
                        cb.like(root.get("functions"), likePattern),
                        cb.like(root.get("indications"), likePattern)
                ));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };

        return formulasRepository.findAll(spec, pageable);
    }

    @Override
    public Formulas getFormulaById(Integer id) {
        return formulasRepository.findById(id).orElse(null);
    }
}
