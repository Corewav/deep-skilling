package com.cognizant.springlearn.controller;

import com.cognizant.springlearn.model.Employee;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import org.springframework.web.bind.annotation.PutMapping;

@RestController
public class EmployeeController {

    @GetMapping("/employee")
    public Employee getEmployee() {

        Employee employee = new Employee(
                101,
                "Mihir",
                50000
        );

        return employee;
    }


    @GetMapping("/employees")
    public List<Employee> getAllEmployees() {

        List<Employee> employees = new ArrayList<>();

        employees.add(new Employee(101, "Mihir", 50000));
        employees.add(new Employee(102, "Rahul", 60000));
        employees.add(new Employee(103, "Aman", 70000));

        return employees;
    }


    @PostMapping("/employee")
    public Employee addEmployee(@RequestBody Employee employee) {

        return employee;
    }


    @PutMapping("/employee")
    public Employee updateEmployee(@RequestBody Employee employee) {

        return employee;
    }
}