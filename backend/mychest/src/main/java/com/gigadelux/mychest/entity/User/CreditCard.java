package com.gigadelux.mychest.entity.User;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class CreditCard { //--> CONTROL DATA FORMATTING IN CLIENT
    @Id
    @GeneratedValue
    private Long id;

    @Column(unique = true)
    private String card_number; //It can start with 0
    private String pass_code; //always
    private String expire_time; //Always in the format mm/YYYY

    @OneToOne
    private AppUser user;
}
