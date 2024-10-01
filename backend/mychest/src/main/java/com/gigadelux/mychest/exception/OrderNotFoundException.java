package com.gigadelux.mychest.exception;

public class OrderNotFoundException extends Exception{
    public OrderNotFoundException(){super("Order not found by id");}
}
