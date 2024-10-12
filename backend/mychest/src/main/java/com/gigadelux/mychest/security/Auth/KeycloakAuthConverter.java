package com.gigadelux.mychest.security.Auth;

import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class KeycloakAuthConverter implements Converter<Jwt, AbstractAuthenticationToken> {

    // Client name where roles will be extracted from within the JWT
    private static final String CLIENT_NAME = "mychest-restapi";  // Ensure this matches your Keycloak client name

    @Override
    @SuppressWarnings("unchecked")
    public AbstractAuthenticationToken convert(final Jwt jwt) {
        // Extract the resource_access claim
        Map<String, Object> resourceAccess = jwt.getClaim("resource_access");

        if (resourceAccess == null || !resourceAccess.containsKey(CLIENT_NAME)) {
            // If no roles exist for the specified client, return an empty set of authorities
            return new JwtAuthenticationToken(jwt, Collections.emptySet());
        }

        // Extract the client-specific resource access (roles)
        Map<String, Object> clientAccess = (Map<String, Object>) resourceAccess.get(CLIENT_NAME);
        Collection<String> clientRoles = (Collection<String>) clientAccess.get("roles");

        if (clientRoles == null || clientRoles.isEmpty()) {
            return new JwtAuthenticationToken(jwt, Collections.emptySet());
        }

        // Convert roles to GrantedAuthority with "ROLE_" prefix
        Set<GrantedAuthority> authorities = clientRoles.stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role))  // Prefix roles with "ROLE_"
                .collect(Collectors.toSet());

        return new JwtAuthenticationToken(jwt, authorities);
    }
}
