package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.Product.Category;
import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.exception.CategoryDoesNotExistException;
import com.gigadelux.mychest.exception.ProductNotFound;
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
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.PUT;
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

    @GetMapping("/searchProductsByCategory")
    public ResponseEntity searchProductsByCategory(@RequestParam String category){
        List<Product> res = null;
        try {
            res = productService.getProductsByCategory(category);
        }catch(ProductsByCategoryNotFoundException e){
                return new ResponseEntity("Error category does not exist",HttpStatus.BAD_REQUEST);
        }
        return ResponseEntity.ok(res);
    }

    @GetMapping("/searchProducts")
    public ResponseEntity searchProducts(@RequestParam String name){
        List<Product> res = productService.searchProducts(name);
        return ResponseEntity.ok(res);
    }

    @PreAuthorize("hasAnyAuthority('admin')")
    @PostMapping("/addProduct")
    public ResponseEntity addProduct(
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam String image,
            @RequestParam int quantity,
            @RequestParam float price,
            @RequestParam int type,
            @RequestParam String platforms, @RequestParam Long categoryId) throws CategoryDoesNotExistException{
        try{
            productService.insertProduct(name,description,image,quantity,price,type,platforms,categoryId);
        }catch (CategoryDoesNotExistException e) {
            return new ResponseEntity("Referencing category not found", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity("Product save successful",HttpStatus.OK);
    }

    @PreAuthorize("hasAnyAuthority('admin')")
    @PostMapping("/removeProduct")
    public ResponseEntity removeProduct(@RequestParam Long id){
        Product res = null;
        try {
            res=productService.removeProduct(id);
        }catch (ProductNotFound e){
            return new ResponseEntity("the product with id "+id+" has not been found",HttpStatus.NOT_FOUND);
        }
        return ResponseEntity.ok(res);
    }

    @PreAuthorize("hasAnyAuthority('admin')")
    @PostMapping("/editProduct")
    public ResponseEntity editProduct(
            @RequestParam Long id,
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam String image,
            @RequestParam int quantity,
            @RequestParam float price,
            @RequestParam int type,
            @RequestParam String platforms,
            @RequestBody Category cat){
        try {
            productService.editProduct(id, name, description, image, quantity, price, type, platforms, cat);
        }catch (ProductNotFound e){return new ResponseEntity("error product not found", HttpStatus.BAD_REQUEST);}
        catch (CategoryDoesNotExistException e){return new ResponseEntity("error Category does not exist", HttpStatus.BAD_REQUEST);}
        return new ResponseEntity("Product edit successful",HttpStatus.OK);
    }
}
