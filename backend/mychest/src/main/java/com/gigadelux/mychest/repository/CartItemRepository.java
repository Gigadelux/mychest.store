package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.entity.User.Cart;
import com.gigadelux.mychest.entity.User.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import  java.util.List;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    boolean existsByProduct(Product product);
    List<CartItem> findByCart(Cart cart);
    CartItem findByProduct(Product product);
}
