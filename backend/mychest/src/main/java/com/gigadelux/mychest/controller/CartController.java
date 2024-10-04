package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.User.Cart;
import com.gigadelux.mychest.entity.User.CartItem;
import com.gigadelux.mychest.exception.*;
import com.gigadelux.mychest.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/cart")
public class CartController {
    @Autowired
    CartService cartService;

    @PostMapping("/add")
    ResponseEntity addCart(@RequestParam String email){
        try {
            Long id = cartService.addNewCart(email);
            return ResponseEntity.ok(id);
        }catch (UserNotFoundException e){
            return new ResponseEntity("error user not found", HttpStatus.NOT_FOUND);
        }
    }
    @PostMapping("/addItem")
    ResponseEntity addItem(@RequestParam Long cartId, @RequestParam String email, @RequestParam String productName, @RequestParam int quantity) {
        try {
            cartService.addToCart(cartId, email, productName, quantity);
        } catch (ProductNotFound e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (CartNotFoundException ex) {
            return new ResponseEntity(ex.getMessage(), HttpStatus.NOT_FOUND);
        }catch (UserNotFoundException exce){
            return new ResponseEntity(exce.getMessage(), HttpStatus.NOT_FOUND);
        }catch (UserNotOfCartException exc){
                return new ResponseEntity(exc.getMessage(), HttpStatus.UNAUTHORIZED);
            }
        return new ResponseEntity("",HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/removeItem")
    ResponseEntity removeItem(@RequestParam Long cartId, @RequestParam String email, @RequestParam String productName, @RequestParam int quantity) {
        try {
            cartService.removeItemFrom(cartId, email, productName);
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
        }
        return new ResponseEntity("",HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
