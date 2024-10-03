package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.Product.Key;
import com.gigadelux.mychest.entity.Product.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product,Long> {
    List<Product> findProductByNameContaining(String name);

    boolean existsByName(String name);

    //find products by category name
    @Query("SELECT p FROM Product p WHERE p.category.name = :name")
    List<Product> findProductsByCategory(@Param("name") String category);
}
