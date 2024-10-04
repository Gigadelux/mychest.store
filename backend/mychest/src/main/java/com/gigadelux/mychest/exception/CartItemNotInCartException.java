package com.gigadelux.mychest.exception;

public class CartItemNotInCartException extends Exception{
    public CartItemNotInCartException(){super("Cart item not in cart!");}
}
