package com.gigadelux.mychest.entity.Product;


import com.gigadelux.mychest.entity.User.CartItem;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String name;

    private String description;
    private String image;
    private int quantity;
    private float price;
    private int type;
    private String platforms;

    @OneToOne
    private CartItem cartItem;

    @OneToMany(fetch = FetchType.EAGER,mappedBy = "product")
    private List<Key> keyList;

    @ManyToOne(optional = false)
    private Category category;
}
