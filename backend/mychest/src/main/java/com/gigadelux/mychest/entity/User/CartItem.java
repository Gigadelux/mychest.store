package com.gigadelux.mychest.entity.User;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.gigadelux.mychest.entity.Product.Product;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.checkerframework.common.aliasing.qual.Unique;

@Table(name = "cart_item")
@Entity
@Getter
@Setter
public class CartItem {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "id",unique = false)
    private Product product;

    private int quantity=1;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "cart_id", referencedColumnName = "id",unique = false)
    private Cart cart;

}
