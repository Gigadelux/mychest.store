package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.Banner;
import com.gigadelux.mychest.entity.Product.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BannerRepository extends JpaRepository<Banner,Long> {
    Category findFirstBy();
}
