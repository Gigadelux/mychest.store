package com.gigadelux.mychest.entity.User;

import com.gigadelux.mychest.entity.Product.Key;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
public class Order {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private AppUser user;

    @OneToMany
    private List<Key> keys;
}
