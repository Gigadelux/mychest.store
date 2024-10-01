package com.gigadelux.mychest.exception;

import jdk.dynalink.NamedOperation;

public class NoKeyFoundException extends Exception{
    public NoKeyFoundException(){super("No key found by id");}
}
