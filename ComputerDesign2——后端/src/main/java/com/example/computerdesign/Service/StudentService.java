package com.example.computerdesign.Service;

import com.example.computerdesign.DAO.Student;

public interface StudentService {
    Student getStudentById(Integer id);

    Integer addNewStudent(Student studentDTO);

    void deleteStudentById(Integer id);

    Student updateStudentById(Integer id, String name, String email);

}
