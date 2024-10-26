package com.gigadelux.mychest.entity.Product;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.gigadelux.mychest.entity.User.Order;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Table
@Entity
@Getter
@Setter
public class Key {
    @Id
    @GeneratedValue
    private Long id;

    @Column(unique = true)
    private String activationKey;

    @ManyToOne
    private Product product;

    private String productName;

    @JsonIgnore
    @ManyToOne
    private Order order;
}
