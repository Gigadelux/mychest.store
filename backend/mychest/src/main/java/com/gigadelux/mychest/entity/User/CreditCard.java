package com.gigadelux.mychest.entity.User;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;

import java.time.LocalDate;
import java.util.Date;

public class CreditCard { //--> CONTROL DATA FORMATTING IN CLIENT
    @Id
    @GeneratedValue
    private Long id;

    @Column(unique = true)
    private String card_number; //It can start with 0
    private String pass_code; //always
    private String expire_time; //Always in the format mm/YYYY

    @OneToOne
    private User user;
}
