package com.gigadelux.mychest.entity.User;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Table
@Entity
@Getter
@Setter
public class AppUser {
    @Id
    @GeneratedValue
    private Long id;

    @Column(unique = true)
    private String email;

    @OneToOne
    @JoinColumn(name = "credit_card_id", referencedColumnName = "id")
    private CreditCard credit_card;

    @OneToMany
    private List<Order> orders;

    @OneToMany(fetch = FetchType.EAGER)
    private List<Cart> carts;
}
