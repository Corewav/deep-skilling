package com.cognizant.ormlearn;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.cognizant.ormlearn.model.Country;
import com.cognizant.ormlearn.service.CountryService;
import com.cognizant.ormlearn.service.exception.CountryNotFoundException;

@SpringBootApplication
public class OrmLearnApplication {

    private static final Logger LOGGER = LoggerFactory.getLogger(OrmLearnApplication.class);

    private static CountryService countryService;

    public static void main(String[] args) throws CountryNotFoundException {

        ApplicationContext context = SpringApplication.run(OrmLearnApplication.class, args);
        LOGGER.info("Inside main");

        countryService = context.getBean(CountryService.class);

        testGetAllCountries();
        testFindCountryByCode();
        testAddCountry();
        testUpdateCountry();
        testSearchCountryByPartialName();
        testDeleteCountry();
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
}