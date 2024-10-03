package com.gigadelux.mychest.repository;

import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.entity.User.CreditCard;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CreditCardRepository extends JpaRepository<CreditCard,Long> {
    CreditCard findByUser(AppUser user);

    boolean existsByUser(AppUser user);
}
