package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.Product.Category;
import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.exception.CategoryDoesNotExistException;
import com.gigadelux.mychest.exception.ProductsByCategoryNotFoundException;
import com.gigadelux.mychest.repository.BannerRepository;
import com.gigadelux.mychest.repository.CategoryRepository;
import com.gigadelux.mychest.repository.ProductRepository;
import com.gigadelux.mychest.service.ProductService;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/products")
public class ProductController {
    @Autowired
    ProductService productService;

    @GetMapping("/featured")
    public ResponseEntity getFeatured() {
        List<Product> products = null;
        try {
            products = productService.getFeatured();
        } catch (CategoryDoesNotExistException e) {
            return new ResponseEntity("Category not found", HttpStatus.NOT_FOUND);
        } catch (ProductsByCategoryNotFoundException e) {
            return new ResponseEntity("No products are in this category", HttpStatus.NOT_FOUND);
        }
        return ResponseEntity.ok(products);
    }

    @PreAuthorize("hasAnyAuthority('admin')")
    @RequestMapping("/addProduct")
    public ResponseEntity addProduct(@RequestBody Product product, @RequestParam Long categoryId) throws CategoryDoesNotExistException{
        try{
            productService.insertProduct(product,categoryId);
        }catch (CategoryDoesNotExistException e) {
            return new ResponseEntity("Referencing category not found", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity("Product save successful",HttpStatus.OK);
    }



}
