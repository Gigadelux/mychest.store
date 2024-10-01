package com.gigadelux.mychest.repository;
import com.gigadelux.mychest.entity.User.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AppUserRepository extends JpaRepository<AppUser,Long> {

}
