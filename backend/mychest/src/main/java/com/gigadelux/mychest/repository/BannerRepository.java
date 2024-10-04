package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.Banner;
import com.gigadelux.mychest.entity.Product.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BannerRepository extends JpaRepository<Banner,Long> {
    Category findFirstBy();
}
