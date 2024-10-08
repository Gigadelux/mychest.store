package com.gigadelux.mychest.entity.User;

import com.gigadelux.mychest.entity.Product.Product;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class CartItem {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "id")
    private Product product;

    private int quantity=1;

    @ManyToOne
    private Cart cart;

}
