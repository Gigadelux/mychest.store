package com.gigadelux.mychest.entity.Product;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Key {
    @Id
    @GeneratedValue
    private Long id;

    @Column(unique = true)
    private String activationKey;

    @ManyToOne(optional = false)
    private Product product;
}
