package com.cognizant.ormlearn;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.cognizant.ormlearn.model.Country;
import com.cognizant.ormlearn.model.Department;
import com.cognizant.ormlearn.model.Employee;
import com.cognizant.ormlearn.model.Skill;
import com.cognizant.ormlearn.service.CountryService;
import com.cognizant.ormlearn.service.DepartmentService;
import com.cognizant.ormlearn.service.EmployeeService;
import com.cognizant.ormlearn.service.SkillService;
import com.cognizant.ormlearn.service.exception.CountryNotFoundException;

@SpringBootApplication
public class OrmLearnApplication {

    private static final Logger LOGGER = LoggerFactory.getLogger(OrmLearnApplication.class);

    private static CountryService countryService;
    private static EmployeeService employeeService;
    private static DepartmentService departmentService;
    private static SkillService skillService;

    public static void main(String[] args) throws CountryNotFoundException {

        ApplicationContext context = SpringApplication.run(OrmLearnApplication.class, args);
        LOGGER.info("Inside main");

        countryService = context.getBean(CountryService.class);
        employeeService = context.getBean(EmployeeService.class);
        departmentService = context.getBean(DepartmentService.class);
        skillService = context.getBean(SkillService.class);

        testGetAllCountries();
        testFindCountryByCode();
        testAddCountry();
        testUpdateCountry();
        testSearchCountryByPartialName();
        testDeleteCountry();

        testCountriesStartingWith();
        testCountriesEndingWith();
        testCountriesContaining();
        testCountryByCodeRepository();

        testGetAllDepartments();
        testGetAllSkills();
        testGetAllEmployees();
        testGetPermanentEmployees();
    }

    private static void testGetAllCountries() {
        LOGGER.info("Start");
        List<Country> countries = countryService.getAllCountries();
        LOGGER.debug("countries={}", countries);
        LOGGER.info("End");
    }

    private static void testFindCountryByCode() throws CountryNotFoundException {
        LOGGER.info("Start");
        Country country = countryService.findCountryByCode("IN");
        LOGGER.debug("Country: {}", country);
        LOGGER.info("End");
    }

    private static void testAddCountry() throws CountryNotFoundException {
        LOGGER.info("Start");
        Country country = new Country("JP", "Japan");
        countryService.addCountry(country);

        Country addedCountry = countryService.findCountryByCode("JP");
        LOGGER.debug("Added Country: {}", addedCountry);
        LOGGER.info("End");
    }

    private static void testUpdateCountry() throws CountryNotFoundException {
        LOGGER.info("Start");
        countryService.updateCountry("JP", "Japan Updated");

        Country updatedCountry = countryService.findCountryByCode("JP");
        LOGGER.debug("Updated Country: {}", updatedCountry);
        LOGGER.info("End");
    }

    private static void testSearchCountryByPartialName() {
        LOGGER.info("Start");
        List<Country> countries = countryService.searchCountriesByPartialName("Uni");
        LOGGER.debug("Matching Countries: {}", countries);
        LOGGER.info("End");
    }

    private static void testDeleteCountry() {
        LOGGER.info("Start");
        countryService.deleteCountry("JP");
        LOGGER.debug("Country deleted with code: JP");
        LOGGER.info("End");
    }

    private static void testCountriesStartingWith() {
        LOGGER.info("Start");
        List<Country> countries = countryService.getCountriesStartingWith("U");
        LOGGER.debug("Countries={}", countries);
        LOGGER.info("End");
    }

    private static void testCountriesEndingWith() {
        LOGGER.info("Start");
        List<Country> countries = countryService.getCountriesEndingWith("a");
        LOGGER.debug("Countries={}", countries);
        LOGGER.info("End");
    }

    private static void testCountriesContaining() {
        LOGGER.info("Start");
        List<Country> countries = countryService.getCountriesContaining("Ind");
        LOGGER.debug("Countries={}", countries);
        LOGGER.info("End");
    }

    private static void testCountryByCodeRepository() {
        LOGGER.info("Start");
        List<Country> countries = countryService.getCountryByCode("IN");
        LOGGER.debug("Countries={}", countries);
        LOGGER.info("End");
    }

    private static void testGetAllDepartments() {
        LOGGER.info("Start");
        List<Department> departments = departmentService.getAllDepartments();
        LOGGER.debug("Departments={}", departments);
        LOGGER.info("End");
    }

    private static void testGetAllSkills() {
        LOGGER.info("Start");
        List<Skill> skills = skillService.getAllSkills();
        LOGGER.debug("Skills={}", skills);
        LOGGER.info("End");
    }

    private static void testGetAllEmployees() {
        LOGGER.info("Start");
        List<Employee> employees = employeeService.getAllEmployees();
        LOGGER.debug("Employees={}", employees);
        LOGGER.info("End");
    }

    private static void testGetPermanentEmployees() {
        LOGGER.info("Start");
        List<Employee> employees = employeeService.getPermanentEmployees();
        LOGGER.debug("Permanent Employees={}", employees);
        employees.forEach(e -> LOGGER.debug("Skills={}", e.getSkillList()));
        LOGGER.info("End");
    }
}