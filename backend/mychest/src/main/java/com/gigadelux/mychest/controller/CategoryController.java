package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.Product.Category;
import com.gigadelux.mychest.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/category")
public class CategoryController {
    @Autowired
    CategoryService categoryService;


    @PreAuthorize("hasRole('admin')")
    @PostMapping("/addCategory")
    ResponseEntity addCategory(@RequestParam String category){
        Category catAdded = categoryService.addCategory(category);
        return ResponseEntity.ok("Category added: %s".formatted(catAdded.toString()));
    }

    @GetMapping("/getAll")
    ResponseEntity getAll(){
        List<Category> res = categoryService.getAll();
        return ResponseEntity.ok(res);
    }

    //@PreAuthorize("hasAnyAuthority('admin')")
    //@PostMapping("/removeCategory")

    @GetMapping("/mostPopular")
    ResponseEntity getMostPopular(@RequestParam int limit){
        return ResponseEntity.ok(categoryService.getMostPopular(limit));
    }
}
