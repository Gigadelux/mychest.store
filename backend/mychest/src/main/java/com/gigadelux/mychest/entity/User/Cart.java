package com.gigadelux.mychest.entity.User;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Entity
@Getter
@Setter
public class Cart {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private AppUser user;

    @OneToMany
    private List<CartItem> cartItem;

    private String postal_code;
}
