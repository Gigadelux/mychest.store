package com.gigadelux.mychest.exception;

public class ProductsByCategoryNotFoundException extends Exception{
    public ProductsByCategoryNotFoundException(){super("products not found in this category");}
}
