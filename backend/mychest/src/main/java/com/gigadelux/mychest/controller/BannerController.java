package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.Banner;
import com.gigadelux.mychest.exception.CategoryDoesNotExistException;
import com.gigadelux.mychest.exception.NoBannerException;
import com.gigadelux.mychest.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/banner")
public class BannerController {
    @Autowired
    BannerService bannerService;

    @GetMapping("/get")
    ResponseEntity get(){
        try{
            Banner banner = bannerService.get();
            return ResponseEntity.ok(banner);
        }catch (NoBannerException e){
            return new ResponseEntity("Error banner not found", HttpStatus.NOT_FOUND);
        }
    }

    @PreAuthorize("hasRole('admin')")
    @PostMapping("/set")
        ResponseEntity set(@RequestParam String image, @RequestParam String category){
        try{
            bannerService.setBanner(image,category);
            return ResponseEntity.ok("Banner set: "+image+category);
        }catch (CategoryDoesNotExistException e){
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

}
