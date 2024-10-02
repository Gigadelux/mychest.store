package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.entity.User.Cart;
import com.gigadelux.mychest.entity.User.CartItem;
import com.gigadelux.mychest.exception.InsufficientQuantityException;
import com.gigadelux.mychest.repository.AppUserRepository;
import com.gigadelux.mychest.repository.CartItemRepository;
import com.gigadelux.mychest.repository.CartRepository;
import jakarta.transaction.Transactional;
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

    @Transactional
    public void deleteFor(AppUser appUser){
        List<Cart> carts = cartRepository.findCartByUser(appUser);
        for(Cart c: carts){
            for(CartItem i: c.getCartItem()){
                cartItemRepository.delete(i);
            }
            cartRepository.delete(c);
        }
    }

    @Transactional
    public void addCart(AppUser appUser, Product product, int quantity, String postalCode) throws InsufficientQuantityException {
        Cart c = null;
        if(cartRepository.existsByAppUserAndProduct(appUser,product)){
            c=cartRepository.findCartByAppUserAndProduct(appUser,product);
            if(c.getCartItem().contains(cartItemRepository.findByProduct(product))){
                CartItem cartItem = cartItemRepository.findByProduct(product);
                if(cartItem.getProduct().getQuantity()<quantity+cartItem.getQuantity()) throw new InsufficientQuantityException();
                cartItem.setQuantity(cartItem.getQuantity()+quantity);
                cartItemRepository.save(cartItem);
            }
            else{
                CartItem cartItem= new CartItem();
                cartItem.setQuantity(quantity);
                cartItem.setProduct(product);
                cartItem.setCart(c);
                cartItemRepository.save(cartItem);
            }
        }else{
            c=new Cart();
            c.setUser(appUser);
            c.setPostal_code(postalCode);
            CartItem cartItem;
            cartItem = new CartItem();
            cartItem.setCart(c);
            cartItem.setProduct(product);
            cartItem.setQuantity(quantity);

        }
        cartRepository.save(c);
    }

}
