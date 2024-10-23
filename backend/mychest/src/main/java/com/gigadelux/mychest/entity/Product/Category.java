package com.gigadelux.mychest.entity.Product;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.gigadelux.mychest.entity.Banner;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Table
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

    @JsonIgnore
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "category")
    private List<Product> products;

    private Long popularity;

    @JsonIgnore
    @OneToOne(mappedBy = "category", cascade = CascadeType.ALL)
    //@JoinColumn(name = "banner_id", referencedColumnName = "id")
    private Banner banner;

    public String toString(){
        return "{name:"+name+", popularity:"+popularity+"}";
    }
}
