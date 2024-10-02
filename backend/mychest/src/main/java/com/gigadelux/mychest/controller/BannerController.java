package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.Banner;
import com.gigadelux.mychest.exception.NoBannerException;
import com.gigadelux.mychest.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
