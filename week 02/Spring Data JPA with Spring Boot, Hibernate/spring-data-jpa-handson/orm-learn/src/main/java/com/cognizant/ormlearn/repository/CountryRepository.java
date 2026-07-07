package com.cognizant.ormlearn.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cognizant.ormlearn.model.Country;

@Repository
public interface CountryRepository extends JpaRepository<Country, String> {

    List<Country> findByNameContainingOrderByNameAsc(String name);
    List<Country> findByNameStartingWith(String name);
    List<Country> findByNameEndingWith(String name);
    List<Country> findByNameContaining(String name);
    List<Country> findByCode(String code);
}