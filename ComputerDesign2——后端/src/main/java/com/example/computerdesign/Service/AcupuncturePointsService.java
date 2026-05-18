package com.example.computerdesign.Service;

import com.example.computerdesign.DAO.AcupuncturePoints;
import com.example.computerdesign.DTO.AcupuncturePoints_ProblemDTO;

import java.util.List;

public interface AcupuncturePointsService {
    AcupuncturePoints getFirstAcupuncturePointByAcupuncturePointName(String name);
    AcupuncturePoints_ProblemDTO getProblem();
}
