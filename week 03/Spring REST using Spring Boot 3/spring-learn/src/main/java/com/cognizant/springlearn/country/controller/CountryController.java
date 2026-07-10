package com.cognizant.springlearn.country.controller;

import org.springframework.http.ResponseEntity;

import com.cognizant.springlearn.country.Country;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

@RestController
public class CountryController {


    @GetMapping("/countries")
    public List<Country> getCountries(){

        List<Country> countries = new ArrayList<>();

        countries.add(new Country("IN","India"));
        countries.add(new Country("US","United States"));
        countries.add(new Country("UK","United Kingdom"));

        return countries;
    }


    @GetMapping("/countries/{code}")
    public ResponseEntity<Country> getCountryByCode(@PathVariable String code) {

        List<Country> countries = new ArrayList<>();

        countries.add(new Country("IN","India"));
        countries.add(new Country("US","United States"));
        countries.add(new Country("UK","United Kingdom"));

        for(Country country : countries) {

            if(country.getCode().equalsIgnoreCase(code)) {
                return ResponseEntity.ok(country);
            }
        }

        return ResponseEntity.notFound().build();
    }

}