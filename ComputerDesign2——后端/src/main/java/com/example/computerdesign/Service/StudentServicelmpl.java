package com.example.computerdesign.Service;

import com.example.computerdesign.DAO.Student;
import com.example.computerdesign.DAO.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;

@Service
public class StudentServicelmpl implements StudentService{
    @Autowired
    private StudentRepository studentRepository;


    @Override
    public Student getStudentById(Integer id) {
        return null;
    }

    @Override
    public Integer addNewStudent(Student studentDTO) {
        List<Student> studentList = studentRepository.findByEmail(studentDTO.getEmail());
        if(!CollectionUtils.isEmpty(studentList)){
            throw new IllegalStateException("email:" + studentDTO.getEmail() + " already exist");
        }

        Student student =  studentRepository.save(studentDTO);

        return student.getId();
    }

    @Override
    public void deleteStudentById(Integer id) {

    }

    @Override
    public Student updateStudentById(Integer id, String name, String email) {
        return null;
    }
}
