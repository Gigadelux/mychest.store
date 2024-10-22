package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.User.Cart;
import com.gigadelux.mychest.entity.User.CartItem;
import com.gigadelux.mychest.exception.CartItemNotFoundException;
import com.gigadelux.mychest.exception.InsufficientQuantityException;
import com.gigadelux.mychest.repository.CartItemRepository;
import com.gigadelux.mychest.repository.CartRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class CartItemService {

    @Autowired
    CartRepository cartRepository;

    @Autowired
    CartItemRepository cartItemRepository;

    @Transactional
    boolean isQuantityAvaible(Long id) throws CartItemNotFoundException{
        if(!cartItemRepository.existsById(id)) throw new CartItemNotFoundException();
        CartItem cartItem = cartItemRepository.getReferenceById(id);
        return cartItem.getProduct().getQuantity()>=cartItem.getQuantity();
    }

    @Transactional
    void addToCart(CartItem cartItem, Cart cart) throws CartItemNotFoundException, InsufficientQuantityException {
        List<CartItem> cartItems = cart.getCartItem();
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }
        boolean found = false;
        for(CartItem c:cartItems){
            if (Objects.equals(c.getProduct().getId(), cartItem.getProduct().getId())) {
                found = true;
                if(!isQuantityAvaible(cartItem.getId())) throw new InsufficientQuantityException();
                c.setQuantity(c.getQuantity()+1);
                cartItemRepository.save(c);
                break;
            }
        }
        if(!found) {
            cartItems.add(cartItem);
            cartItemRepository.save(cartItem);
        }
        cart.setCartItem(cartItems);
        cartRepository.save(cart);
    }
}
