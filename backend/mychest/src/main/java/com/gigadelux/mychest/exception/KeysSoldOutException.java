package com.gigadelux.mychest.exception;

import org.springframework.data.jpa.repository.JpaRepository;

public class KeysSoldOutException extends Exception {
    public KeysSoldOutException(){super("Key sold out :(");}
}
