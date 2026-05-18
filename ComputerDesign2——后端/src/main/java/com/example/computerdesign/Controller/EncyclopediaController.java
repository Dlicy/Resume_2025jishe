package com.example.computerdesign.Controller;


import com.example.computerdesign.DAO.Encyclopedia.Herbs;
import com.example.computerdesign.DAO.Encyclopedia.HerbsRepository;
import com.example.computerdesign.DTO.HerbDTO;
import com.example.computerdesign.DTO.HerbsDTO;
import com.example.computerdesign.DTO.MaxHerbDTO;
import com.example.computerdesign.DTO.UpdateHerbDTO;
import com.example.computerdesign.Response;
import com.example.computerdesign.Service.Encyclopedia.HerbsService;
import jakarta.validation.constraints.Max;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;

@RestController
@RequestMapping("/Encyclopedia") // 设置分路由头
public class EncyclopediaController {
    @Autowired
    private HerbsService herbsService;
    @Autowired
    private HerbsRepository herbsRepository;

    @Value("${app.base-url}")
    private String baseUrl;

    @GetMapping("/getHerbs_drug_categories")
    public Response getHerbs_drug_categories() {
        List<String> herbList;
        herbList = herbsService.findAllDrugCategories();
        return Response.newSuccess(herbList);
    }

    @PostMapping("/getHerbs_drug_category")
    public Response getHerbs_drug_category(@RequestBody String categories) {
        System.out.println(categories);
        System.out.println("正在获取药物小类...");
        List<String> herbList;
        categories = categories.replace("\"", "").trim();
        herbList = herbsService.findSpecificDrugCategory(categories);
        return Response.newSuccess(herbList);
    }

    @PostMapping("/getHerbs_main_name")
    public Response getHerbs_main_name(@RequestBody String category) {
        List<Map<String, Object>> herbList;
        category = category.replace("\"", "").trim();
        herbList = herbsService.findSpecificMainName(category);
        return Response.newSuccess(herbList);
    }

    @PostMapping(value = "/getHerbs_detail")
    public Response getHerbs_detail(@RequestBody String id) {
        System.out.println(id);
        try {
            // 将字符串转换为整数
            id = id.replace("\"", "").trim();
            int ID = Integer.parseInt(id.trim()); // 去除首尾空格
            // 使用 Optional 来安全处理查找结果
            Optional<Herbs> optionalHerb = herbsRepository.findById(ID);

            if (optionalHerb.isPresent()) {
                Herbs herb = optionalHerb.get();
                return Response.newSuccess(herb);
            } else {
                return Response.newFail("Herb not found with ID: " + ID);
            }
        } catch (NumberFormatException e) {
            return Response.newFail("Invalid ID format: " + e.getMessage());
        } catch (Exception e) {
            return Response.newFail("An error occurred: " + e.getMessage());
        }
    }

    @GetMapping("/getHerbslists")
    public Response getHerbsLists(@RequestParam int page) {
        System.out.println("在被访问");
        System.out.println(page);

        int herbsPerPage = 9;
        PageRequest pageRequest = PageRequest.of(page - 1, herbsPerPage); // page从1开始，所以减去1
        Page<HerbsDTO> herbsPage = herbsRepository.findAllHerbs(pageRequest);

        long total = herbsRepository.count();
        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("lists", herbsPage.getContent());
        responseBody.put("total", total); // 总条数

        // 返回当前页的内容
        return Response.newSuccess(responseBody);
    }

    @GetMapping("/getMaxHerbslists")
    public Response getHerbalistsHerbsLists(@RequestParam int page) {
        System.out.println("在被访问");
        System.out.println(page);

        int herbsPerPage = 9;
        PageRequest pageRequest = PageRequest.of(page - 1, herbsPerPage); // page从1开始，所以减去1
        Page<MaxHerbDTO> herbsPage = herbsRepository.findAllMaxHerbs(pageRequest);

        long total = herbsRepository.count();
        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("lists", herbsPage.getContent());
        responseBody.put("total", total); // 总条数

        // 返回当前页的内容
        return Response.newSuccess(responseBody);
    }

    @GetMapping("/Managersearch")
    public Response ManagersearchsearchHerbs(@RequestParam(value = "input", required = false) String mainName) {
        System.out.println("得到管理搜索请求");
        System.out.println(mainName);
        List<MaxHerbDTO> results;
        System.out.println("准备获取到数据");
        results = herbsRepository.findByMainName(mainName);
        System.out.println("成功获取到数据");
        System.out.println(results);

        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("lists", results);
        System.out.println(results.size());
        responseBody.put("total", results.size()); // 总条数
        return Response.newSuccess(responseBody);
    }

    @GetMapping("/search")
    public Response searchHerbs(
            @RequestParam(value = "categories", required = false) String categories,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "input", required = false) String input) {
        System.out.println("得到搜索请求");
        System.out.println(category);
        System.out.println(input);
        List<HerbsDTO> results;

        // 根据传入的参数进行条件判断
        if (input == null || input.isEmpty()) {
            if (category == null || category.isEmpty()) {
                // 仅根据 categories 显示该大类的所有数据
                System.out.println("根据大类");
                System.out.println(categories);
                results = herbsService.searchHerbsByCategories(categories);
            } else {
                // 根据 category 显示该小类的所有数据
                results = herbsService.searchHerbsBySubCategory(category);
            }
        } else {
            if (category == null || category.isEmpty()) {
                // 在所有数据中根据 input 进行模糊搜索
                results = herbsService.searchHerbsByInput(input);
            } else {
                // 根据 category 和 input 进行模糊搜索
                results = herbsService.searchHerbs(category, input);
            }
        }
        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("lists", results);
        System.out.println(results.size());
        responseBody.put("total", results.size() + 1); // 总条数
        return Response.newSuccess(responseBody);
    }

    // 上传图片接口
    @PostMapping("/upload")
    public Response uploadImage(@RequestParam("image") MultipartFile file) {
        System.out.println("正在上传照片");
        try {
            String imageUrl = herbsService.saveImage(file);
            System.out.println(imageUrl);
            return Response.newSuccess(imageUrl);
        } catch (IOException e) {
            return Response.newFail("An error occurred: " + e.getMessage());
        }
    }

    // 创建药物记录接口
    @PostMapping("/herbs")
    public Response createHerb(@RequestBody HerbDTO herbDTO) {
        System.out.println("正在存入");
        System.out.println(herbDTO);
        try {
            Herbs herb = herbsService.createHerb(herbDTO);
            System.out.println("存入成功");
            return Response.newSuccess(herb);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return Response.newFail("An error occurred: " + e.getMessage());
        }
    }

    // 更改数据库记录
    @PutMapping("/updateHerb")
    public Response updateHerb(@RequestBody UpdateHerbDTO herbUpdateDTO) {
        try {
            // 调用服务层更新数据
            boolean success = herbsService.updateHerb(herbUpdateDTO);

            if (success) {
                System.out.println("更新成功");
                return Response.newSuccess("更新成功");
            } else {
                return Response.newFail("更新失败，药物不存在");
            }
        } catch (Exception e) {
            return Response.newFail("更新过程中发生错误: " + e.getMessage());
        }
    }

    // 删除
    @DeleteMapping("/deleteHerb/{id}")
    public Response deleteHerb(@PathVariable int id) {
        try {
            boolean success = herbsService.deleteHerb(id);
            if (success) {
                System.out.println("删除成功！");
                return Response.newSuccess("删除成功");
            } else {
                return Response.newFail("删除失败，药物不存在");
            }
        } catch (Exception e) {
            return Response.newFail("删除过程中发生错误: " + e.getMessage());
        }
    }

}