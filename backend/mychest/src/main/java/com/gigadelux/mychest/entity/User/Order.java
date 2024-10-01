package com.gigadelux.mychest.entity.User;

import com.gigadelux.mychest.entity.Product.Key;
import jakarta.persistence.*;
import lombok.Generated;
import lombok.Getter;
import lombok.Setter;
import org.apache.catalina.User;

@Entity
@Getter
@Setter
public class Order {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private App_User user;

    @OneToMany
    @JoinColumn(name = "key_id", referencedColumnName = "id")
    private Key key;
    
}
