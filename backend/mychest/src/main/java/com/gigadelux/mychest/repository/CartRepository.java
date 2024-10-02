package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.entity.User.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartRepository extends JpaRepository<Cart,Long> {
    List<Cart> findCartByUser(AppUser User);

    @Query("SELECT c FROM Cart c JOIN c.cartItem ci WHERE c.user = :user AND ci.product = :prodotto")
    Cart findCartByAppUserAndProduct(@Param("user") AppUser user, @Param("prodotto") Product prodotto);

    @Query("SELECT COUNT(c) > 0 FROM Cart c JOIN c.cartItem ci WHERE c.user = :user AND ci.product = :product")
    boolean existsByAppUserAndProduct(@Param("user") AppUser user, @Param("product") Product product);

}
