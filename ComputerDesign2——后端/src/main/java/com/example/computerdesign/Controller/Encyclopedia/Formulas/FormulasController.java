package com.example.computerdesign.Controller.Encyclopedia.Formulas;


import com.example.computerdesign.DAO.Encyclopedia.Formulas.Formulas;
import com.example.computerdesign.Response;
import com.example.computerdesign.Service.Encyclopedia.Formulas.FormulasService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import static org.springframework.beans.support.PagedListHolder.DEFAULT_PAGE_SIZE;

@RestController
@RequestMapping("/encyclopedia/formulas")
public class FormulasController {
    private final FormulasService formulasService;

    @Autowired
    public FormulasController(FormulasService formulasService) {
        this.formulasService = formulasService;
    }

    // 获取单个方剂详情
    @GetMapping("/{id}")
    public Response getFormulaById(@PathVariable Integer id) {
        Formulas formula = formulasService.getFormulaById(id);
        if (formula == null) {
            return Response.newFail("未找到ID为 " + id + " 的方剂");
        }
        return Response.newSuccess(formula);
    }

    // 存储数据
    @PostMapping("/addFormula")
    public Response createFormula(@RequestBody Formulas formula) {
        Formulas savedFormula = formulasService.saveFormula(formula);
        return Response.newSuccess(savedFormula);
    }

    // 获取所有信息
    @GetMapping("/getFormulasList")
    public Response getAllFormulas(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", required = false) Integer size) {

        // 如果前端没有指定size，则使用默认值
        int pageSize = (size != null && size > 0) ? size : DEFAULT_PAGE_SIZE;

        // 创建分页请求，页码从0开始
        Pageable pageable = PageRequest.of(page, pageSize);

        Page<Formulas> formulas = formulasService.getAllFormulas(pageable);
        return Response.newSuccess(formulas);
    }

    @PutMapping("/updateFormula/{id}")
    public Response updateFormula(
            @PathVariable Integer id,
            @RequestBody Formulas formula) {

        // 设置ID确保修改的是正确的记录
        formula.setId(id);

        // 调用服务层更新数据
        Formulas updatedFormula = formulasService.updateFormula(formula);

        return Response.newSuccess(updatedFormula);
    }


    // 删除数据
    @DeleteMapping("/deleteFormula/{id}")
    public Response deleteFormula(@PathVariable Integer id) {
        formulasService.deleteFormula(id);
        return Response.newSuccess("ID为 " + id + " 的方剂已成功删除");
    }

    // 用户端搜索
    @GetMapping("/searchFormulas")
    public Response searchFormulas(
            @RequestParam(name = "main_category", required = false) String mainCategory, // 明确指定name
            @RequestParam(name = "sub_category", required = false) String subCategory,
            @RequestParam(required = false) String input,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(required = false) Integer size) {

        // 设置默认分页大小
        int pageSize = (size != null && size > 0) ? size : DEFAULT_PAGE_SIZE;

        // 创建分页请求
        Pageable pageable = PageRequest.of(page, pageSize);

        // 调用服务层进行筛选
        Page<Formulas> result = formulasService.searchFormulas(mainCategory, subCategory, input, pageable);

        return Response.newSuccess(result);
    }


    // 管理端搜索
    /**
     * 简化版搜索（仅按关键词筛选）
     * @param input 搜索关键词
     * @param page 页码（从0开始）
     * @param size 每页大小（可选）
     * @return 分页结果
     */
    @GetMapping("/simpleSearch")
    public Response simpleSearch(
            @RequestParam(required = false) String input,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(required = false) Integer size) {

        // 设置默认分页大小
        int pageSize = (size != null && size > 0) ? size : DEFAULT_PAGE_SIZE;
        Pageable pageable = PageRequest.of(page, pageSize);

        // 调用服务层（复用searchFormulas方法，其他参数传null）
        Page<Formulas> result = formulasService.searchFormulas(null, null, input, pageable);
        return Response.newSuccess(result);
    }
}
