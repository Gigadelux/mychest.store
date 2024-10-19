package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.exception.EmailAlreadyExistsException;
import com.gigadelux.mychest.exception.InvalidEmailException;
import com.gigadelux.mychest.exception.UserNotFoundException;
import com.gigadelux.mychest.exception.WeakPasswordException;
import com.gigadelux.mychest.service.AppUserService;
import com.gigadelux.mychest.service.CartService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/users")
public class AppUserController {
    @Autowired
    AppUserService appUserService;

    @Autowired
    CartService cartService;

    @PostMapping("/newUser")
    ResponseEntity newUser(@RequestBody AppUser user, @RequestParam String password){
        try {
            appUserService.addUser(user,password);
            Long cartId = cartService.addNewCart(user.getEmail());
            return ResponseEntity.ok(Map.of("cartId", cartId));
        } catch (EmailAlreadyExistsException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.UNAUTHORIZED);
        }catch (WeakPasswordException e){
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }catch (InvalidEmailException e){
            return new ResponseEntity(e.getMessage(),HttpStatus.BAD_REQUEST);
        } catch (UserNotFoundException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    @PreAuthorize("hasRole('clientUser')")
    @GetMapping("/getProfile")
    ResponseEntity getProfile(@RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader){
            try{
                String email = appUserService.getUserEmail(authorizationHeader);
                 return ResponseEntity.ok(appUserService.get(email));
            }catch (UserNotFoundException e){
                return new ResponseEntity("error: user not found", HttpStatus.NOT_FOUND);
            }catch(JwtException e){
                return new ResponseEntity(e.getMessage(), HttpStatus.UNAUTHORIZED);
            }
    }
    @GetMapping("/validateToken")
    public ResponseEntity<String> validateToken(@RequestHeader("Authorization") String token) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null || !authentication.isAuthenticated()) {
                return new ResponseEntity<>("Invalid or expired token", HttpStatus.UNAUTHORIZED);
            }
            Jwt jwt = (Jwt) authentication.getPrincipal();
            return ResponseEntity.ok("Token is valid. User: " + jwt.getSubject());
        } catch (Exception e) {
            return new ResponseEntity<>("Invalid token", HttpStatus.UNAUTHORIZED);
        }
    }

    //@PreAuthorize("hasAnyAuthority('clientUser')")
    //@PostMapping("/removeUser") //idk if I will ever implement that
}
