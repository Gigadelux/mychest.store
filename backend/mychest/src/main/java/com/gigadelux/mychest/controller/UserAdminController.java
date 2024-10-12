package com.gigadelux.mychest.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("/admincheck")
public class UserAdminController {

    @GetMapping("/name")
    public ResponseEntity getAdminName(Authentication authentication) {
        if (authentication == null) {
            System.out.println("Authentication object is null");
            throw new RuntimeException("User is not authenticated");
        } else {
            System.out.println("Authentication object: " + authentication);
        }
        Jwt jwt = (Jwt) authentication.getPrincipal();
        String adminName = jwt.getClaim("preferred_username");
        return ResponseEntity.ok("Admin's Name: " + adminName);
    }
}
