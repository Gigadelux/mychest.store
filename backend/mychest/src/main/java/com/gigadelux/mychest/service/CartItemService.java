package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.User.Cart;
import com.gigadelux.mychest.entity.User.CartItem;
import com.gigadelux.mychest.exception.CartItemNotFoundException;
import com.gigadelux.mychest.repository.CartItemRepository;
import com.gigadelux.mychest.repository.CartRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CartItemService {

    @Autowired
    CartRepository cartRepository;

    @Autowired
    CartItemRepository cartItemRepository;

    boolean isQuantityAvaible(Long id) throws CartItemNotFoundException{
        if(!cartItemRepository.existsById(id)) throw new CartItemNotFoundException();
        CartItem cartItem = cartItemRepository.getReferenceById(id);
        return cartItem.getProduct().getQuantity()>=cartItem.getQuantity();
    }

    @Transactional
    void addToCart(CartItem cartItem, Cart cart){
        List<CartItem> cartItems = cart.getCartItem();
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }
        cartItems.add(cartItem);
        cartItems.add(cartItem);
        cart.setCartItem(cartItems);
        cartItemRepository.save(cartItem);
        cartRepository.save(cart);
    }
}
