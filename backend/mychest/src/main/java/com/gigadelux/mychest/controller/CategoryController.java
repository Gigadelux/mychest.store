package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.Product.Category;
import com.gigadelux.mychest.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/category")
public class CategoryController {
    @Autowired
    CategoryService categoryService;


    @PreAuthorize("hasAnyAuthority('admin')")
    @PostMapping("/addCategory")
    ResponseEntity addCategory(@RequestParam String category){
        Category catAdded = categoryService.addCategory(category);
        return ResponseEntity.ok("Category added: %s".formatted(catAdded.toString()));
    }
}
