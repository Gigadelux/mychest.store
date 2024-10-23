package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.User.CreditCard;
import com.gigadelux.mychest.exception.CreditCardNotFoundException;
import com.gigadelux.mychest.exception.UserNotFoundException;
import com.gigadelux.mychest.service.AppUserService;
import com.gigadelux.mychest.service.CreditCardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/creditCard")
public class CreditCardController {
    @Autowired
    CreditCardService creditCardService;

    @Autowired
    AppUserService appUserService;

    @PreAuthorize("hasRole('clientUser')")
    @GetMapping("/getFrom")
    public ResponseEntity getFromUser(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader){
        try {
            String email = appUserService.getUserEmail(authorizationHeader);
            CreditCard c = creditCardService.getCreditCardByUser(email);
            return ResponseEntity.ok(c);
        } catch (UserNotFoundException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (CreditCardNotFoundException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.NOT_FOUND);
        }catch (JwtException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.UNAUTHORIZED);
        }
    }

    @PreAuthorize("hasRole('clientUser')")
    @PostMapping("/setTo")
    public ResponseEntity setCreditCardOfUser(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader, @RequestBody CreditCard creditCard){
        try {
            String email = appUserService.getUserEmail(authorizationHeader);
            CreditCard c = creditCardService.setCreditCard(email, creditCard);
            return ResponseEntity.ok(c);
        } catch (UserNotFoundException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }
}
