package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.User.Cart;
import com.gigadelux.mychest.entity.User.CartItem;
import com.gigadelux.mychest.exception.*;
import com.gigadelux.mychest.service.AppUserService;
import com.gigadelux.mychest.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/cart")
public class CartController {
    @Autowired
    CartService cartService;

    @Autowired
    AppUserService appUserService;

    @PostMapping("/add")
    ResponseEntity addCart(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader){
        try {
            String email = appUserService.getUserEmail(authorizationHeader);
            Long id = cartService.addNewCart(email);
            return ResponseEntity.ok(Map.of("cartId",id));
        }catch (UserNotFoundException e){
            return new ResponseEntity("error user not found", HttpStatus.NOT_FOUND);
        }catch (JwtException e){
            return new ResponseEntity("error token not found", HttpStatus.UNAUTHORIZED);
        }
    }
    @PostMapping("/addItem")
    ResponseEntity addItem(@RequestParam Long cartId, @RequestParam String productName, @RequestParam int quantity, @RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader) {
        try {
            String email = appUserService.getUserEmail(authorizationHeader);
            return ResponseEntity.ok(cartService.addToCart(cartId, email, productName, quantity));
        } catch (ProductNotFound e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (CartNotFoundException ex) {
            return new ResponseEntity(ex.getMessage(), HttpStatus.NOT_FOUND);
        }catch (UserNotFoundException exce){
            return new ResponseEntity(exce.getMessage(), HttpStatus.NOT_FOUND);
        }catch (UserNotOfCartException exc){
                return new ResponseEntity(exc.getMessage(), HttpStatus.UNAUTHORIZED);
            }catch (JwtException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.UNAUTHORIZED);
        }
    }

    @PostMapping("/removeItem")
    ResponseEntity removeItem(@RequestParam Long cartId, @RequestParam String productName, @RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader) {
        try {
            String email = appUserService.getUserEmail(authorizationHeader);
            return ResponseEntity.ok(cartService.removeItemFrom(cartId, email, productName));
        } catch (ProductNotFound e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (CartNotFoundException ex) {
            return new ResponseEntity(ex.getMessage(), HttpStatus.NOT_FOUND);
        }catch (UserNotFoundException exce){
            return new ResponseEntity(exce.getMessage(), HttpStatus.NOT_FOUND);
        }catch (UserNotOfCartException exc){
            return new ResponseEntity(exc.getMessage(), HttpStatus.UNAUTHORIZED);
        } catch (CartItemNotInCartException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.NOT_FOUND);
        }catch (JwtException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.UNAUTHORIZED);
        }
    }

    @RequestMapping("/get")
    ResponseEntity getCart(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader,@RequestParam Long cartId) {
        try {
            String email = appUserService.getUserEmail(authorizationHeader);
            Cart c = cartService.get(email, cartId);
            return ResponseEntity.ok(c);
        } catch (CartNotFoundException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (UserNotOfCartException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (UserNotFoundException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (JwtException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.UNAUTHORIZED);
        }
    }
}
