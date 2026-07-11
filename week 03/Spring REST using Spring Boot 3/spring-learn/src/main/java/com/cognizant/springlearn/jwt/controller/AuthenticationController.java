package com.cognizant.springlearn.jwt.controller;


import com.cognizant.springlearn.jwt.model.User;
import com.cognizant.springlearn.jwt.service.JwtUtil;
import org.springframework.web.bind.annotation.*;

import java.util.Map;


@RestController
@RequestMapping("/authenticate")
public class AuthenticationController {


    private JwtUtil jwtUtil;


    public AuthenticationController(JwtUtil jwtUtil){
        this.jwtUtil = jwtUtil;
    }


    @PostMapping
    public Map<String,String> authenticate(
            @RequestBody User user
    ){

        String token = jwtUtil.generateToken(user.getUsername());

        return Map.of(
                "token", token
        );
    }
}