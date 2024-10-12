package com.gigadelux.mychest.entity;

import com.gigadelux.mychest.entity.Product.Category;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Banner {
    @Id
    @GeneratedValue
    private Long id;

    @Column(unique = true)
    private String image;

    @OneToOne
    @JoinColumn(name = "category_id")
    private Category category;
}
