package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Product.Key;
import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.entity.User.Order;
import com.gigadelux.mychest.exception.UserNotFoundException;
import com.gigadelux.mychest.repository.AppUserRepository;
import com.gigadelux.mychest.repository.KeyRepository;
import com.gigadelux.mychest.repository.OrderRepository;
import jakarta.persistence.LockModeType;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderService {
    @Autowired
    OrderRepository orderRepository;

    @Autowired
    KeyRepository keyRepository;

    @Autowired
    AppUserRepository appUserRepository;

    public List<Order> getAllOrdersByUser(Long userId) throws UserNotFoundException{
        if(!appUserRepository.existsById(userId)) throw new UserNotFoundException();
        AppUser appUser = appUserRepository.getReferenceById(userId);
        return appUser.getOrders();
    }

    //OPTIMISTIC_FORCE_INCREMENT: quando si vuole avere un controllo più rigoroso sulla versione delle entità
    // e propagare gli incrementi di versione in modo esplicito, anche a entità non modificate direttamente.
    // In questa modalità è necessario forzare manualmente l'incremento del campo di versione chiamando flush()
    // sull'EntityManager per propagare lo stato nel database. TODO rename introduction
    @Lock(LockModeType.OPTIMISTIC_FORCE_INCREMENT) //rollbackFor = {eccezioni}
    @Transactional(readOnly = false)
    public Order insertOrder(){ //TODO here all the key service methods necessary to complete the trasaction
        //TODO nested for: for all carts in cartsof User and for all cartItems in cart
        //TODO keys (quantity check) dissociation from Product through EntityManager and  Lock
        //TODO reassignment of keys into Order
        return null;
    }
}
