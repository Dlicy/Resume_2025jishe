package com.example.computerdesign.Service.Encyclopedia;

import com.example.computerdesign.DAO.Encyclopedia.Herbs;
import com.example.computerdesign.DTO.HerbDTO;
import com.example.computerdesign.DTO.HerbsDTO;
import com.example.computerdesign.DTO.MaxHerbDTO;
import com.example.computerdesign.DTO.UpdateHerbDTO;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface HerbsService {
    List<String> findAllDrugCategories();
    List<String> findSpecificDrugCategory(String categories);

    List<Map<String, Object>> findSpecificMainName(String category);
    List<Map<String, Object>> getAllHerbs_satisfy_DrugCategory(String name);

    List<HerbsDTO> searchHerbs(String category, String input);

    List<HerbsDTO> searchHerbsByInput(String input);

    List<HerbsDTO> searchHerbsByCategories(String categories);

    List<HerbsDTO> searchHerbsBySubCategory(String category);

    // 保存药物图片
    String saveImage(MultipartFile file) throws IOException;

    Herbs createHerb(HerbDTO herbDTO);

    // 更新数据库
    boolean updateHerb(UpdateHerbDTO herbUpdateDTO);

    boolean deleteHerb(int id);

    // 删除对应图片
    void deleteImageFile(String imageUrl);

}
