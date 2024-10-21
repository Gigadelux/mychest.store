package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.Product.Category;
import com.gigadelux.mychest.entity.Product.Key;
import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.service.CategoryService;
import com.gigadelux.mychest.service.KeyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/keys")
public class KeyController {
    @Autowired
    KeyService keyService;


    @PreAuthorize("hasRole('admin')")
    @PostMapping("/addKey")
    ResponseEntity addKey(@RequestParam String activationKey, Long productId){
        Key keyAdded = keyService.addKey(activationKey, productId);
        return ResponseEntity.ok("Key added: %s".formatted(keyAdded.toString()));
    }
    @PreAuthorize("hasRole('admin')")
    @PostMapping("/addKeys")
    ResponseEntity addKeys(@RequestBody List<String> activationKeys, Long productId){
        for(String activationKey : activationKeys) {
            keyService.addKey(activationKey, productId);
        }
        return ResponseEntity.ok("Keys added!");
    }
    //@PreAuthorize("hasAnyAuthority('admin')")
    //@PostMapping("/deleteKey")
}

