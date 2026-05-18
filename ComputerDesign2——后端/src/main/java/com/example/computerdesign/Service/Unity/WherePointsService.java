package com.example.computerdesign.Service.Unity;

import com.example.computerdesign.DAO.Unity.WherePoints;

import java.util.List;

public interface WherePointsService {
    List<WherePoints> getAllPoints();
    WherePoints savePoint(WherePoints point);
    void deletePoint(Integer id);
    boolean existsById(Integer id);
}
