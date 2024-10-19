package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.exception.EmailAlreadyExistsException;
import com.gigadelux.mychest.exception.InvalidEmailException;
import com.gigadelux.mychest.exception.UserNotFoundException;
import com.gigadelux.mychest.exception.WeakPasswordException;
import com.gigadelux.mychest.repository.AppUserRepository;
import jakarta.transaction.Transactional;
import org.keycloak.jose.jwe.JWEException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtDecoders;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.stereotype.Service;

import java.util.regex.Pattern;

@Service
public class AppUserService {
    @Autowired
    AppUserRepository appUserRepository;

    @Autowired
    KeycloakService keycloakService;

    @Transactional
    public void addUser(AppUser appUser, String password)throws EmailAlreadyExistsException, WeakPasswordException, InvalidEmailException {
        if(appUserRepository.existsByEmail(appUser.getEmail())) throw new EmailAlreadyExistsException();
        validateEmail(appUser.getEmail());
        validatePassword(password);
        AppUser u = new AppUser();
        u.setEmail(appUser.getEmail());
        keycloakService.addAppUser(appUser,password);
        appUserRepository.save(u);
    }

    public AppUser get(String email) throws UserNotFoundException {
        if(!appUserRepository.existsByEmail(email)) throw new UserNotFoundException();
        return appUserRepository.findAppUserByEmail(email);
    }
    private void validateEmail(String email) throws InvalidEmailException {
        // Regular expression for validating email
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        Pattern emailPattern = Pattern.compile(emailRegex);
        if (!emailPattern.matcher(email).matches()) {
            throw new InvalidEmailException("Invalid email format.");
        }
    }

    private void validatePassword(String password) throws WeakPasswordException {
        // Regular expression for validating strong password
        // Password should be at least 8 characters long, contain one uppercase letter, one lowercase letter, one digit, and one special character
        String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        Pattern passwordPattern = Pattern.compile(passwordRegex);
        if (!passwordPattern.matcher(password).matches()) {
            throw new WeakPasswordException("Password is too weak. It must be at least 8 characters long, contain one uppercase letter, one lowercase letter, one digit, and one special character.");
        }
    }
    public String getUserEmail(String authorizationHeader) throws JwtException {
        //decoding
        String issuerUri = "http://localhost:8080/realms/mychest";
        JwtDecoder decoder = JwtDecoders.fromIssuerLocation(issuerUri);
        String token = authorizationHeader.replace("Bearer ", "");
        Jwt jwt = decoder.decode(token);
        //decoded
        String email = jwt.getClaim("email");
        return email;
    }
}
