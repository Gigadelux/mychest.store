package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.Product.Category;
import com.gigadelux.mychest.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;

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

    @GetMapping("/getAll")
    ResponseEntity getAll(){
        List<Category> res = categoryService.getAll();
        return ResponseEntity.ok(res);
    }

    //@PreAuthorize("hasAnyAuthority('cliente')")
    //@PostMapping("/removeCategory")

    //@GetMapping("/mostPopular")
}
