package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.entity.User.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    boolean existsByProduct(Product product);

    CartItem findByProduct(Product product);
}
