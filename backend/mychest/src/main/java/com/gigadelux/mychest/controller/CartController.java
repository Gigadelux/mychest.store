package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.User.Cart;
import com.gigadelux.mychest.entity.User.CartItem;
import com.gigadelux.mychest.exception.UserNotFoundException;
import com.gigadelux.mychest.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/cart")
public class CartController {
    @Autowired
    CartService cartService;

    @PostMapping("/add")
    ResponseEntity addCart(@RequestParam String email){
        try {
            cartService.addNewCart(email);
        }catch (UserNotFoundException e){
            return new ResponseEntity();
        }
    }
    @PostMapping("/addItem")
    ResponseEntity addItem(){

    }

    @PostMapping("/removeItem")
    ResponseEntity removeItem(){

    }
}
