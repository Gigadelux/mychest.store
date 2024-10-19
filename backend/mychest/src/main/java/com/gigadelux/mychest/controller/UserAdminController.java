package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.service.AppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admincheck")
public class UserAdminController {
    @Autowired
    AppUserService appUserService;

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

    @GetMapping("/emailFromToken")
    public ResponseEntity getEmailFromToken(@RequestParam String token){
        try {
            String email = appUserService.getUserEmail(token);
            return ResponseEntity.ok(email);
        }catch(Exception e){
            return ResponseEntity.notFound().build();
        }
    }
}
