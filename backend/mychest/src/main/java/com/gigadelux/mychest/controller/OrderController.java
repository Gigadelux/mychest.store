package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.User.Order;
import com.gigadelux.mychest.exception.*;
import com.gigadelux.mychest.service.AppUserService;
import com.gigadelux.mychest.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/orders")
public class OrderController {
    @Autowired
    OrderService orderService;

    @Autowired
    AppUserService appUserService;

    @PostMapping("/pay")
    ResponseEntity pay(String email, String postalCode, Long id){
        try {
            Order o = orderService.insertOrder(email,postalCode,id);
            return ResponseEntity.ok("Order successfully added of products");
        } catch (EmptyCartException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.UNAUTHORIZED);
        } catch (CartItemNotFoundException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.NOT_FOUND);
        } catch (InsufficientQuantityException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.UNAUTHORIZED);
        } catch (OrderNotFoundException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.NOT_FOUND);
        } catch (ProductNotFound e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.NOT_FOUND);
        } catch (NoKeyFoundException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.NOT_FOUND);
        } catch (InsufficientCreditException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.UNAUTHORIZED);
        } catch (CreditCardNotFoundException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.NOT_FOUND);
        } catch (UserNotFoundException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.NOT_FOUND);
        } catch (UserNotOfCartException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.UNAUTHORIZED);
        }
    }

    @PreAuthorize("hasAnyAuthority('clientUser')")
    @GetMapping("/getOrders")
    ResponseEntity getOrders(@RequestParam String email){
        try {
            List<Order> orders = orderService.getAllOrdersByUser(email);
            return ResponseEntity.ok(orders);
        } catch (UserNotFoundException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.NOT_FOUND);
        }
    }
}
