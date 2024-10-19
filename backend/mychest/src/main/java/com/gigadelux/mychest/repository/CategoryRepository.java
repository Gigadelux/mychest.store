package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.Product.Category;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category,Long> {

    @Query(value = "SELECT * FROM category ORDERED BY popularity DESC LIMIT ?1", nativeQuery = true)
    List<Category> mostPopular(int limit);

    Category findByName(String name);

    boolean existsByName(String name);

}
