package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.exception.EmailAlreadyExistsException;
import com.gigadelux.mychest.exception.InvalidEmailException;
import com.gigadelux.mychest.exception.UserNotFoundException;
import com.gigadelux.mychest.exception.WeakPasswordException;
import com.gigadelux.mychest.service.AppUserService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/users")
public class AppUserController {
    @Autowired
    AppUserService appUserService;

    @PostMapping("/newUser")
    ResponseEntity newUser(@RequestBody AppUser user, String password){
        try {
            appUserService.addUser(user,password);
        } catch (EmailAlreadyExistsException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.UNAUTHORIZED);
        }catch (WeakPasswordException e){
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }catch (InvalidEmailException e){
            return new ResponseEntity(e.getMessage(),HttpStatus.BAD_REQUEST);
        }
        return ResponseEntity.ok("user Added:"+ user);
    }

    @PreAuthorize("hasAnyAuthority('clientUser')")
    @GetMapping("/getProfile")
    ResponseEntity getProfile(@RequestParam String email){
            try{
                 return ResponseEntity.ok(appUserService.get(email));
            }catch (UserNotFoundException e){
                return new ResponseEntity("error: user not found", HttpStatus.NOT_FOUND);
            }
    }

    //@PreAuthorize("hasAnyAuthority('clientUser')")
    //@PostMapping("/removeUser") //idk if I will ever implement that
}
