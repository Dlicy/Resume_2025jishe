package com.example.computerdesign.DAO.Encyclopedia.Formulas;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface FormulasRepository extends JpaRepository<Formulas, Integer> , JpaSpecificationExecutor<Formulas> {

}
