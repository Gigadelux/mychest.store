package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.User.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order,Long> {

}
