package com.gigadelux.mychest.entity;

import com.gigadelux.mychest.entity.Product.Category;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;

public class Banner {
    @Id
    @GeneratedValue
    private Long id;

    @Column(unique = true)
    private String image;

    @OneToOne(mappedBy = "banner")
    private Category category;
}
