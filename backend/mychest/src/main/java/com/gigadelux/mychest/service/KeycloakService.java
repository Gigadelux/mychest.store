package com.gigadelux.mychest.service;

import javax.ws.rs.core.Response;

import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.repository.AppUserRepository;
import org.keycloak.OAuth2Constants;
import org.keycloak.admin.client.CreatedResponseUtil;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.admin.client.resource.UsersResource;
import org.keycloak.representations.idm.ClientRepresentation;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Service
public class KeycloakService {

    @Autowired
    AppUserRepository appUserRepository;

    String usernameAdmin = "admin";
    String passwordAdmin = "BillCypher2012!";
    String role = "clientUser";
    String serverUrl = "http://localhost:8080";
    String realm = "mychest";
    String clientId = "mystore";
    String clientSecret = "";


    public Keycloak getKeyloack(){
        Keycloak result;
        result = KeycloakBuilder.builder()
                .serverUrl(serverUrl)
                .realm(realm)
                .grantType(OAuth2Constants.PASSWORD)
                .clientId(clientId)
                .clientSecret(clientSecret)
                .username(usernameAdmin)
                .password(passwordAdmin)
                .build();
        return result;
    }

    public List<AppUser> getAppUser(){
        Keycloak keyloack = getKeyloack();

        RealmResource realmResource = keyloack.realm(realm);
        UsersResource usersResource = realmResource.users();

        List<UserRepresentation> users = usersResource.list();

        List<AppUser> usersInfo = new ArrayList<>();
        for (UserRepresentation user : users) {

            UserResource userResource = usersResource.get(user.getId());
            UserRepresentation userWithInfo = userResource.toRepresentation();

            AppUser userToAdd = appUserRepository.findAppUserByEmail(userWithInfo.getEmail());
            if(userToAdd == null)
                usersInfo.add(null);
            else
                usersInfo.add(userToAdd);
        }
        return usersInfo;
    }
    public void addAppUser(AppUser userToAdd, String password){
        Keycloak keycloak = KeycloakBuilder.builder()
                .serverUrl(serverUrl)
                .realm(realm)
                .grantType(OAuth2Constants.PASSWORD)
                .clientId(clientId)
                .username(usernameAdmin)
                .password(passwordAdmin)
                .build();

        UserRepresentation user = new UserRepresentation();

        user.setEnabled(true);
        user.setEmail(userToAdd.getEmail());
        user.setEmailVerified(true);

        user.setAttributes(Collections.singletonMap("origin", Arrays.asList("demo")));

// Get realm
        RealmResource realmResource = keycloak.realm(realm);
        UsersResource usersResource = realmResource.users();

// Create user (requires manage-users role)
        Response response = usersResource.create(user);
        System.out.printf("Response: %s %s%n", response.getStatus(), response.getStatusInfo());
        System.out.println(response.getLocation());
        String userId = CreatedResponseUtil.getCreatedId(response);
        System.out.printf("User created with userId: %s%n", userId);

// Define password credential
        CredentialRepresentation passwordCred = new CredentialRepresentation();
        passwordCred.setTemporary(false);
        passwordCred.setType(CredentialRepresentation.PASSWORD);
        passwordCred.setValue(password);

        UserResource userResource = usersResource.get(userId);

// Set password credential
        userResource.resetPassword(passwordCred);

// Get client
        ClientRepresentation app1Client = realmResource.clients().findByClientId(clientId).get(0);

// Get client level role (requires view-clients role)
        RoleRepresentation userClientRole = realmResource.clients().get(app1Client.getId()).roles().get(role).toRepresentation();

// Assign client level role to user
        userResource.roles().clientLevel(app1Client.getId()).add(Arrays.asList(userClientRole));
    }
}

