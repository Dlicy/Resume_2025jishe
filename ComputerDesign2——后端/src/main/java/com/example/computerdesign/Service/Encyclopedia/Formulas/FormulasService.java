package com.example.computerdesign.Service.Encyclopedia.Formulas;

import com.example.computerdesign.DAO.Encyclopedia.Formulas.Formulas;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface FormulasService {
    Formulas saveFormula(Formulas formulas);

    // 实现分页查询效果
    Page<Formulas> getAllFormulas(Pageable pageable);

    // 修改保存信息
    Formulas updateFormula(Formulas formula);

    // 删除对应信息
    void deleteFormula(Integer id);

    /**
     * 组合筛选方剂信息
     * @param mainCategory 方剂大类
     * @param subCategory 方剂小类
     * @param input 搜索关键词
     * @param pageable 分页信息
     * @return 筛选后的分页结果
     */
    Page<Formulas> searchFormulas(String mainCategory, String subCategory, String input, Pageable pageable);

    Formulas getFormulaById(Integer id);
}
