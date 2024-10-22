package com.gigadelux.mychest.exception;

public class InvalidQuantityException extends RuntimeException {
    public InvalidQuantityException() {
        super("Invalid quantity");
    }
}
