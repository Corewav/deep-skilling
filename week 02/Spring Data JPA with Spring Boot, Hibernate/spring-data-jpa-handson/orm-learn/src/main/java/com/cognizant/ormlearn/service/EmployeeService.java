package com.cognizant.ormlearn.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cognizant.ormlearn.model.Employee;
import com.cognizant.ormlearn.repository.EmployeeRepository;

@Service
public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    public EmployeeService(EmployeeRepository employeeRepository) {
        this.employeeRepository = employeeRepository;
    }

    @Transactional
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    @Transactional
    public List<Employee> getPermanentEmployees() {
        return employeeRepository.findByPermanentTrue();
    }

    @Transactional
    public List<Employee> getAllPermanentEmployeesHql() {
        return employeeRepository.getAllPermanentEmployees();
    }

    @Transactional
    public List<Employee> getAllPermanentEmployeesHqlFetch() {
        return employeeRepository.getAllPermanentEmployeesWithFetch();
    }

    @Transactional
    public double getAverageSalary() {
        return employeeRepository.getAverageSalary();
    }

    @Transactional
    public double getAverageSalaryByDepartment(int departmentId) {
        return employeeRepository.getAverageSalaryByDepartment(departmentId);
    }

    @Transactional
    public List<Employee> getAllEmployeesNative() {
        return employeeRepository.getAllEmployeesNative();
    }
}