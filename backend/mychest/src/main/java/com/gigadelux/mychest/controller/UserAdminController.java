package com.gigadelux.mychest.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admincheck")
public class UserAdminController {

    @GetMapping("/name")
    public String getAdminName(Authentication authentication) {
        if (authentication == null) {
            System.out.println("Authentication object is null");
            throw new RuntimeException("User is not authenticated");
        } else {
            System.out.println("Authentication object: " + authentication);
        }
        Jwt jwt = (Jwt) authentication.getPrincipal();
        String adminName = jwt.getClaim("preferred_username");
        return "Admin's Name: " + adminName;
    }
}
