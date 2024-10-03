package com.gigadelux.mychest.exception;

import com.gigadelux.mychest.entity.User.CreditCard;

public class CreditCardNotFoundException extends Exception{
    public CreditCardNotFoundException(){super("Credit card not found");}
}
