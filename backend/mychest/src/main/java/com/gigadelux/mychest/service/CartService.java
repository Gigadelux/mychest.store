package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.entity.User.Cart;
import com.gigadelux.mychest.entity.User.CartItem;
import com.gigadelux.mychest.exception.*;
import com.gigadelux.mychest.repository.AppUserRepository;
import com.gigadelux.mychest.repository.CartItemRepository;
import com.gigadelux.mychest.repository.CartRepository;
import com.gigadelux.mychest.repository.ProductRepository;
import jakarta.transaction.Transactional;
import org.checkerframework.checker.units.qual.C;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CartService {
    @Autowired
    CartRepository cartRepository;

    @Autowired
    CartItemRepository cartItemRepository;

    @Autowired
    AppUserRepository appUserRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
     CartItemService cartItemService;

    @Transactional
    public void deleteFor(AppUser appUser){
        List<Cart> carts = cartRepository.findCartByUser(appUser);
        for(Cart c: carts){
            cartItemRepository.deleteAll(c.getCartItem());
            cartRepository.delete(c);
        }
    }


    public Cart get(String userEmail, Long cartId) throws CartNotFoundException, UserNotOfCartException, UserNotFoundException {
        if(!cartRepository.existsById(cartId)) throw new CartNotFoundException();
        if(!cartRepository.getReferenceById(cartId).getUser().getEmail().equals(userEmail)) throw new UserNotOfCartException();
        if(!appUserRepository.existsByEmail(userEmail)) throw new UserNotFoundException();
        return cartRepository.getReferenceById(cartId);
    }

    @Transactional
    public Cart removeItemFrom(Long cartId,String email, String productName) throws CartNotFoundException, UserNotFoundException, UserNotOfCartException, ProductNotFound, CartItemNotInCartException {
        if(!cartRepository.existsById(cartId)) throw new CartNotFoundException();
        if(!productRepository.existsByName(productName)) throw new ProductNotFound();
        if(!cartRepository.getReferenceById(cartId).getUser().getEmail().equals(email)) throw new UserNotOfCartException();
        if(!appUserRepository.existsByEmail(email)) throw new UserNotFoundException();
        Cart c = cartRepository.getReferenceById(cartId);
        for(CartItem i:c.getCartItem()){
            if(i.getProduct().getName().equals(productName)){
                if(i.getQuantity()>0) {
                    i.setQuantity(i.getQuantity() - 1);
                    cartItemRepository.save(i);
                }else{
                    cartItemRepository.delete(i);
                }
                cartRepository.save(c);
                return c;
            }
        }
        throw new CartItemNotInCartException();
    }


    @Transactional
    public Cart addToCart(Long cartId,String email, String productName, int quantity) throws CartNotFoundException,UserNotFoundException, ProductNotFound, UserNotOfCartException {
        if(!cartRepository.existsById(cartId)) throw new CartNotFoundException();
        if(!productRepository.existsByName(productName)) throw new ProductNotFound();
        if(!appUserRepository.existsByEmail(email)) throw new UserNotFoundException();
        if(!cartRepository.getReferenceById(cartId).getUser().getEmail().equals(email)) throw new UserNotOfCartException();
        Cart c = cartRepository.getReferenceById(cartId);
        for(CartItem i:c.getCartItem()){
            if(i.getProduct().getName().equals(productName)){
                i.setQuantity(i.getQuantity()+1);
                cartItemRepository.save(i);
                return c;
            }
        }
        Product p = productRepository.findProductByNameContaining(productName).get(0);
        CartItem cartItem = new CartItem();
        cartItem.setCart(c);
        cartItem.setQuantity(quantity);
        cartItem.setProduct(p);
        cartItemRepository.save(cartItem);
        return c;
    }
    public Long addNewCart(String email) throws UserNotFoundException {
        if(!appUserRepository.existsByEmail(email)) throw new UserNotFoundException();
        AppUser user = appUserRepository.findAppUserByEmail(email);
        Cart c = new Cart();
        c.setUser(user);
        return cartRepository.save(c).getId();
    }

}
