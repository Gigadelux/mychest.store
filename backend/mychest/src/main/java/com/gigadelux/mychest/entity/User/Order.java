package com.gigadelux.mychest.entity.User;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.gigadelux.mychest.entity.Product.Key;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "orders") // since Order is a reserved word
public class Order {
    @Id
    @GeneratedValue
    private Long id;

    private String postalCode;

    @ManyToOne
    private AppUser user;

    @JsonIgnore
    @OneToOne
    private CreditCard creditCard;

    @OneToMany
    private List<Key> keys;
}
