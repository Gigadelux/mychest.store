package com.gigadelux.mychest.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.gigadelux.mychest.entity.Product.Category;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Banner {
    @Id
    @GeneratedValue
    private Long id;

    @Column(unique = true)
    private String image;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id")
    private Category category;
}
