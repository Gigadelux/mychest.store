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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/keys")
public class KeyController {
    @Autowired
    KeyService keyService;


    @PreAuthorize("hasAnyAuthority('admin')")
    @PostMapping("/addKey")
    ResponseEntity addCategory(@RequestParam String activationKey, Long productId){
        Key keyAdded = keyService.addKey(activationKey, productId);
        return ResponseEntity.ok("Key added: %s".formatted(keyAdded.toString()));
    }

    //@PreAuthorize("hasAnyAuthority('admin')")
    //@PostMapping("/deleteKey")
}

