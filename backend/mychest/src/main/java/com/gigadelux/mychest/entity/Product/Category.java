package com.gigadelux.mychest.entity.Product;

import com.gigadelux.mychest.entity.Banner;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
public class Category {
    @Getter
    @Id
    @GeneratedValue
    private Long id;

    @Getter
    @Column(unique = true)
    private String name;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "category")
    private List<Product> products;

    private Long popularity;

    @OneToOne(mappedBy = "category", cascade = CascadeType.ALL)
    //@JoinColumn(name = "banner_id", referencedColumnName = "id")
    private Banner banner;

}
