package com.gigadelux.mychest.entity.Product;


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

    @OneToMany(fetch = FetchType.EAGER,mappedBy = "product")
    private List<Key> keyList;

    @ManyToOne(optional = false)
    private Category category;

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setType(int type) {
        this.type = type;
    }

    public void setPlatforms(String platforms) {
        this.platforms = platforms;
    }

    public void setKeyList(List<Key> keyList) {
        this.keyList = keyList;
    }

    public void setCategory(Category category) {
        this.category = category;
    }}
