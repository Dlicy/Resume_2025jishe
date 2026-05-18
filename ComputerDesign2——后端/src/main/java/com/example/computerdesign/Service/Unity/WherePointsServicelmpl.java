package com.example.computerdesign.Service.Unity;

import com.example.computerdesign.DAO.Unity.WherePoints;
import com.example.computerdesign.DAO.Unity.WherePointsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WherePointsServicelmpl implements WherePointsService {
    @Autowired
    private WherePointsRepository wherePointRepository;

    @Override
    public List<WherePoints> getAllPoints() {
        return wherePointRepository.findAll();
    }

    @Override
    public WherePoints savePoint(WherePoints point) {
        // 可以在这里添加业务逻辑验证
        return wherePointRepository.save(point);
    }

    @Override
    public void deletePoint(Integer id) {
        wherePointRepository.deleteById(id);  // 实现删除方法
    }

    @Override
    public boolean existsById(Integer id) {
        return wherePointRepository.existsById(id);
    }
}
