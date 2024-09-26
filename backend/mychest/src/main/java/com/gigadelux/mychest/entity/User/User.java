package com.gigadelux.mychest.entity.User;

import jakarta.persistence.*;

public class User {
    @Id
    @GeneratedValue
    private Long id;

    @Column(unique = true)
    private String email;

    @OneToOne
    @JoinColumn(name = "credit_card_id", referencedColumnName = "id")
    private CreditCard credit_card;
}
