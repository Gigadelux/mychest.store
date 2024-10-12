package com.gigadelux.mychest.entity.User;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.gigadelux.mychest.entity.Product.Key;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "orders") // since Order is a reserved word
public class Order {
    @Id
    @GeneratedValue
    private Long id;

    @CreationTimestamp
    @Column(updatable = false) // Make sure it won't be updated
    private LocalDateTime createdAt;

    private String postalCode;

    @ManyToOne
    private AppUser user;

    @JsonIgnore
    @OneToOne
    private CreditCard creditCard;

    @OneToMany
    private List<Key> keys;
}
