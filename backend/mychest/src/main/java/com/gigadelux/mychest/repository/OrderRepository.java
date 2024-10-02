package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.entity.User.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order,Long> {

    @Query("SELECT o FROM Order o WHERE o.user = :user ORDER BY o.id DESC")
    Order findLastOrderByUser(@Param("user") AppUser user);

    List<Order> findOrderByUser(AppUser user);
}
