package com.gigadelux.mychest.exception;

public class EmailAlreadyExistsException extends Exception{
    public EmailAlreadyExistsException(){super("Email already in use");}
}
