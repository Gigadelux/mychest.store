package com.gigadelux.mychest.entity.User;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

public class Cart {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private User user;

    private String postal_code;
}
