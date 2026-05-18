package com.example.computerdesign.Service.Encyclopedia;

import com.example.computerdesign.DAO.Encyclopedia.Herbs;
import com.example.computerdesign.DAO.Encyclopedia.HerbsRepository;
import com.example.computerdesign.DTO.HerbDTO;
import com.example.computerdesign.DTO.HerbsDTO;
import com.example.computerdesign.DTO.MaxHerbDTO;
import com.example.computerdesign.DTO.UpdateHerbDTO;
import com.example.computerdesign.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Service
public class HerbsServicelmpl implements HerbsService {
    @Autowired
    private HerbsRepository herbsRepository;

    // 设置管理部分上传时的路径
    private final String UPLOAD_DIR = "./uploads/herbs/";


    List<Map<String, Object>> herbList = new ArrayList<>();

    @Override
    public List<Map<String, Object>> getAllHerbs_satisfy_DrugCategory(String name) {
        List<Herbs> results = herbsRepository.findByDrugCategory(name);
        if (!results.isEmpty()) {
            for (Herbs herb : results) {
                Map<String, Object> herbData = new HashMap<>();
                herbData.put("id", herb.getId());
                herbData.put("mainName", herb.getMainName());
                herbList.add(herbData);
            }
        }
        return herbList;
    }

    @Override
    public List<String> findAllDrugCategories() {
        return herbsRepository.findDistinctDrugCategories();
    }

    // 通过药大类去找药小类
    @Override
    public List<String> findSpecificDrugCategory(String categories) {
        return herbsRepository.findDistinctDrugCategoryByCategories(categories);
    }

    // 通过药小类去查询该类下的所有中药
    @Override
    public List<Map<String, Object>> findSpecificMainName(String category) {
        List<Herbs> results = herbsRepository.findMainNameByCategory(category);
        if (!results.isEmpty()) {
            for (Herbs herb : results) {
                Map<String, Object> herbData = new HashMap<>();
                herbData.put("id", herb.getId());
                herbData.put("mainName", herb.getMainName());
                herbList.add(herbData);
            }
        }
        return herbList;
    }

    @Override
    public List<HerbsDTO> searchHerbs(String category, String input) {
        return herbsRepository.searchHerbs(category, input);
    }

    @Override
    public List<HerbsDTO> searchHerbsByInput(String input) {
        if (input == null || input.trim().isEmpty()) {
            return List.of(); // 如果 input 为空，返回空列表
        }
        return herbsRepository.searchByInput(input);
    }

    @Override
    public List<HerbsDTO> searchHerbsBySubCategory(String category) {
        return herbsRepository.findBySubCategory(category); // 根据小类查询所有数据
    }

    @Override
    public List<HerbsDTO> searchHerbsByCategories(String categories) {
        return herbsRepository.findByCategory(categories); // 根据大类查询所有数据
    }

    // 保存图片到服务器
    @Override
    public String saveImage(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("请选择要上传的图片");
        }

        // 验证图片类型
        String contentType = file.getContentType();
        if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
            throw new IllegalArgumentException("只支持JPEG/PNG格式图片");
        }

        // 验证图片大小 (5MB)
        if (file.getSize() > 5 * 1024 * 1024) {
            throw new IllegalArgumentException("图片大小不能超过5MB");
        }

        // 创建上传目录
        Path uploadPath = Paths.get(UPLOAD_DIR);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // 生成唯一文件名
        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
//        String fileName = file.getOriginalFilename();
        Path filePath = uploadPath.resolve(fileName);

        // 保存文件
        Files.copy(file.getInputStream(), filePath);

        return "/herbs/" + fileName;
    }

    // 创建药物记录
    @Override
    public Herbs createHerb(HerbDTO herbDTO) {
        // 验证必填字段
        if (herbDTO.getMainName() == null || herbDTO.getMainName().trim().isEmpty()) {
            throw new IllegalArgumentException("药物名称不能为空");
        }

        Herbs herb = new Herbs();
        // 映射DTO到Entity
        herb.setDrugCategories(herbDTO.getDrugCategories());
        herb.setDrugCategory(herbDTO.getDrugCategory());
        herb.setMainName(herbDTO.getMainName());
        herb.setSubName(herbDTO.getSubName());
        herb.setNatureAndFlavor(herbDTO.getNatureAndFlavor());
        herb.setProcessing(herbDTO.getProcessing());
        herb.setMeridians(herbDTO.getMeridians());
        herb.setEfficacy(herbDTO.getEfficacy());
        herb.setIndications(herbDTO.getIndications());
        herb.setUsageAndDosage(herbDTO.getUsageAndDosage());
        herb.setContraindications(herbDTO.getContraindications());
        herb.setSource(herbDTO.getSource());
        herb.setCharacters(herbDTO.getCharacters());
        herb.setFormulas(herbDTO.getFormulas());
        herb.setImageUrl(herbDTO.getImageUrl());

        return herbsRepository.save(herb);
    }

    @Override
    public boolean updateHerb(UpdateHerbDTO herbUpdateDTO) {
        // 1. 检查药物是否存在
        Optional<Herbs> optionalHerb = herbsRepository.findById(herbUpdateDTO.getId());

        if (!optionalHerb.isPresent()) {
            return false;
        }

        // 2. 更新药物信息
        Herbs herb = optionalHerb.get();
        herb.setDrugCategories(herbUpdateDTO.getDrugCategories());
        herb.setDrugCategory(herbUpdateDTO.getDrugCategory());
        herb.setMainName(herbUpdateDTO.getMainName());
        herb.setSubName(herbUpdateDTO.getSubName());
        herb.setNatureAndFlavor(herbUpdateDTO.getNatureAndFlavor());
        herb.setProcessing(herbUpdateDTO.getProcessing());
        herb.setMeridians(herbUpdateDTO.getMeridians());
        herb.setEfficacy(herbUpdateDTO.getEfficacy());
        herb.setIndications(herbUpdateDTO.getIndications());
        herb.setUsageAndDosage(herbUpdateDTO.getUsageAndDosage());
        herb.setContraindications(herbUpdateDTO.getContraindications());
        herb.setSource(herbUpdateDTO.getSource());
        herb.setCharacters(herbUpdateDTO.getCharacters());
        herb.setFormulas(herbUpdateDTO.getFormulas());

        // 3. 保存更新
        herbsRepository.save(herb);
        return true;
    }

    public boolean deleteHerb(int id) {
        Optional<Herbs> herbOptional = herbsRepository.findById(id);
        if (!herbOptional.isPresent()) {
            return false;
        }

        Herbs herb = herbOptional.get();
        deleteImageFile(herb.getImageUrl());
        herbsRepository.delete(herb);
        return true;
    }

    @Override
    public void deleteImageFile(String imageUrl) {
        if (imageUrl == null || imageUrl.isEmpty()) {
            return;
        }

        try {
            // 从URL中提取文件名（去掉/Herbs/前缀）
            String fileName = imageUrl.startsWith("/herbs/")
                    ? imageUrl.substring("/herbs/".length())
                    : imageUrl;

            Path filePath = Paths.get(UPLOAD_DIR + fileName).normalize();

            // 安全检查：确保路径在UPLOAD_DIR目录内
            if (!filePath.startsWith(Paths.get(UPLOAD_DIR).normalize())) {
                throw new SecurityException("尝试删除非允许目录的文件: " + filePath);
            }

            boolean deleted = Files.deleteIfExists(filePath);
            if (!deleted) {
                System.out.println("文件不存在，无需删除: " + filePath);
            }
        } catch (IOException e) {
            System.err.println("删除图片文件失败: " + e.getMessage());
        } catch (SecurityException e) {
            System.err.println("安全异常: " + e.getMessage());
        }
    }
}
