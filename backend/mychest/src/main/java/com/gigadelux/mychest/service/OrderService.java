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
import java.util.Objects;

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
    CreditCardRepository creditCardRepository;

    @Autowired
    private EntityManager entityManager;

    @Transactional(readOnly = true)
    public List<Order> getAllOrdersByUser(String email) throws UserNotFoundException{
        if(!appUserRepository.existsByEmail(email)) throw new UserNotFoundException();
        AppUser appUser = appUserRepository.findAppUserByEmail(email);
        return appUser.getOrders();
    }

    //OPTIMISTIC_FORCE_INCREMENT: When you want stricter control over the versioning of entities
    // and explicitly propagate version increments, even to entities that haven't been directly modified.
    // In this mode, it's necessary to manually force the increment of the version field by calling flush()
    // on the EntityManager to ensure the state is persisted to the database.
    @Lock(LockModeType.OPTIMISTIC_FORCE_INCREMENT) //rollback For -> Exceptions
    @Transactional(readOnly = false) //////////////////////////////////////////////////////////                     v   -> the cartId will buy first only the cart from the frontend
    public Long insertOrder(String email, String postalCode, Long cartId) throws EmptyCartException, CartItemNotFoundException, InsufficientQuantityException, OrderNotFoundException, ProductNotFound, NoKeyFoundException, InsufficientCreditException, CreditCardNotFoundException, UserNotFoundException, UserNotOfCartException {
        if(!appUserRepository.existsByEmail(email)) throw new UserNotFoundException();
        AppUser appUser = appUserRepository.findAppUserByEmail(email);
        if(!creditCardRepository.existsByUser(appUser)) throw new CreditCardNotFoundException();
        CreditCard creditCard = creditCardRepository.findByUser(appUser);
        List<Cart> carts = cartRepository.findCartByUser(appUser);
        boolean found = false;
        if(carts.isEmpty()) throw new EmptyCartException();
        float price = 0f;
        for(Cart c: carts){
            if(c.getCartItem().isEmpty()) throw new EmptyCartException();
            if(Objects.equals(c.getId(), cartId)) {
                for (CartItem i : c.getCartItem()) {
                    if (!cartItemService.isQuantityAvaible(i.getId())) throw new InsufficientQuantityException();
                    price = price + (i.getProduct().getPrice() * i.getQuantity());
                }
                found = true;
            }
        }
        if(!found) throw new UserNotOfCartException();
        if(!creditCardService.hasCredit(appUser,price))throw new InsufficientCreditException();
        Order o = new Order();
        o.setCreditCard(creditCard);
        o.setUser(appUser);
        o.setPostalCode(postalCode);
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
        orderRepository.save(o);
        cartService.deleteFor(appUser); //Accessed by appUser
        return cartService.addNewCart(email);
    }
}
