package com.cognizant.ormlearn.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cognizant.ormlearn.model.Country;
import com.cognizant.ormlearn.repository.CountryRepository;
import com.cognizant.ormlearn.service.exception.CountryNotFoundException;

@Service
public class CountryService {

    private final CountryRepository countryRepository;

    public CountryService(CountryRepository countryRepository) {
        this.countryRepository = countryRepository;
    }

    @Transactional
    public List<Country> getAllCountries() {
        return countryRepository.findAll();
    }

    @Transactional
    public Country findCountryByCode(String countryCode) throws CountryNotFoundException {
        Optional<Country> result = countryRepository.findById(countryCode);

        if (!result.isPresent()) {
            throw new CountryNotFoundException("Country not found with code: " + countryCode);
        }

        return result.get();
    }

    @Transactional
    public void addCountry(Country country) {
        countryRepository.save(country);
    }

    @Transactional
    public void updateCountry(String code, String name) throws CountryNotFoundException {
        Country country = findCountryByCode(code);
        country.setName(name);
        countryRepository.save(country);
    }

    @Transactional
    public void deleteCountry(String code) {
        countryRepository.deleteById(code);
    }

    @Transactional
    public List<Country> searchCountriesByPartialName(String name) {
        return countryRepository.findByNameContainingOrderByNameAsc(name);
    }

    @Transactional
    public List<Country> getCountriesStartingWith(String name) {
        return countryRepository.findByNameStartingWith(name);
    }

    @Transactional
    public List<Country> getCountriesEndingWith(String name) {
        return countryRepository.findByNameEndingWith(name);
    }

    @Transactional
    public List<Country> getCountriesContaining(String name) {
        return countryRepository.findByNameContaining(name);
    }

    @Transactional
    public List<Country> getCountryByCode(String code) {
        return countryRepository.findByCode(code);
    }
    
}