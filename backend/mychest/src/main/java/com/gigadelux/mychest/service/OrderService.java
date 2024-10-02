package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.entity.User.*;
import com.gigadelux.mychest.exception.*;
import com.gigadelux.mychest.repository.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
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

    @Autowired
    CartRepository cartRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    CartItemService cartItemService;

    @Autowired
    KeyService keyService;

    @Autowired
    CartService cartService;

    @Autowired
    CreditCardService creditCardService;

    @Autowired
    private EntityManager entityManager;

    @Transactional(readOnly = true)
    public List<Order> getAllOrdersByUser(Long userId) throws UserNotFoundException{
        if(!appUserRepository.existsById(userId)) throw new UserNotFoundException();
        AppUser appUser = appUserRepository.getReferenceById(userId);
        return appUser.getOrders();
    }

    //OPTIMISTIC_FORCE_INCREMENT: quando si vuole avere un controllo più rigoroso sulla versione delle entità
    // e propagare gli incrementi di versione in modo esplicito, anche a entità non modificate direttamente.
    // In questa modalità è necessario forzare manualmente l'incremento del campo di versione chiamando flush()
    // sull'EntityManager per propagare lo stato nel database. TODO rename introduction
    @Lock(LockModeType.OPTIMISTIC_FORCE_INCREMENT) //rollback For -> Exceptions
    @Transactional(readOnly = false)
    public Order insertOrder(AppUser appUser, CreditCard creditCard) throws EmptyCartException, CartItemNotFoundException, InsufficientQuantityException, OrderNotFoundException, ProductNotFound, NoKeyFoundException, InsufficientCreditException { //TODO here all the key service methods necessary to complete the trasaction
        List<Cart> carts = cartRepository.findCartByUser(appUser);
        if(carts.isEmpty()) throw new EmptyCartException();
        float price = 0f;
        for(Cart c: carts){
            for(CartItem i: c.getCartItem()){
                if(!cartItemService.isQuantityAvaible(i.getId())) throw new InsufficientQuantityException();
                price = price + (i.getProduct().getPrice()*i.getQuantity());
            }
        }
        if(!creditCardService.hasCredit(price))throw new InsufficientCreditException();
        Order o = new Order();
        o.setCreditCard(creditCard);
        o.setUser(appUser);
        orderRepository.save(o);
        for(Cart c: carts){
            for(CartItem i: c.getCartItem()){
                Product p = productRepository.getReferenceById(i.getProduct().getId());
                entityManager.lock(p,LockModeType.OPTIMISTIC_FORCE_INCREMENT);
                keyService.insertKeysToOrder(o,i.getProduct().getId(),i.getQuantity());
                p.setQuantity(p.getQuantity()-i.getQuantity());
                entityManager.merge(p);
            }
        }
        cartService.deleteFor(appUser); //Accessed by appUser
        return o;
    }
}
