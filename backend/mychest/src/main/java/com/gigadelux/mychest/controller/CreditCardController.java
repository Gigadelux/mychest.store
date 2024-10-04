package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.User.CreditCard;
import com.gigadelux.mychest.exception.CreditCardNotFoundException;
import com.gigadelux.mychest.exception.UserNotFoundException;
import com.gigadelux.mychest.service.CreditCardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/creditCard")
public class CreditCardController {
    @Autowired
    CreditCardService creditCardService;

    @PreAuthorize("hasAnyAuthority('clientUser')")
    @GetMapping("/getFromUser")
    public ResponseEntity getFromUser(@RequestParam String email){
        try {
            CreditCard c = creditCardService.getCreditCardByUser(email);
            return ResponseEntity.ok(c);
        } catch (UserNotFoundException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (CreditCardNotFoundException e) {
            return new ResponseEntity(e.getMessage(),HttpStatus.NOT_FOUND);
        }
    }

    @PreAuthorize("hasAnyAuthority('clientUser')")
    @PostMapping("/setCreditCardOfUser")
    public ResponseEntity setCreditCardOfUser(@RequestParam String email, @RequestBody CreditCard creditCard){
        try {
            CreditCard c = creditCardService.setCreditCard(email, creditCard);
            return ResponseEntity.ok(c);
        } catch (UserNotFoundException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }
}
