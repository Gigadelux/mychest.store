package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.entity.User.Cart;
import com.gigadelux.mychest.entity.User.CartItem;
import com.gigadelux.mychest.exception.CartNotFoundException;
import com.gigadelux.mychest.exception.InsufficientQuantityException;
import com.gigadelux.mychest.exception.ProductNotFound;
import com.gigadelux.mychest.exception.UserNotFoundException;
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
            for(CartItem i: c.getCartItem()){
                cartItemRepository.delete(i);
            }
            cartRepository.delete(c);
        }
    }


    @Transactional
    public Cart addToCart(Long cartId,String email, String productName, int quantity) throws CartNotFoundException, ProductNotFound {
        if(!cartRepository.existsById(cartId)) throw new CartNotFoundException();
        if(!productRepository.existsByName(productName)) throw new ProductNotFound();
        Cart c = cartRepository.getReferenceById(cartId);
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
