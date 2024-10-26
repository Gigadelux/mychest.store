package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.Product.Key;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface KeyRepository extends JpaRepository<Key,Long> {
    @Query(value = "SELECT * FROM key WHERE product_id = :product_id ORDER BY RANDOM() LIMIT :limit", nativeQuery = true)
    List<Key> getRandomKeys(@Param("product_id") Long product_id, @Param("limit") int limit);
    Key findKeyByActivationKey(String key);
}
