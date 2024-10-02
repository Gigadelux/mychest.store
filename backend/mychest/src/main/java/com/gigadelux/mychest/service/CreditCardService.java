package com.gigadelux.mychest.service;

import com.gigadelux.mychest.repository.CreditCardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CreditCardService {
    @Autowired
    CreditCardRepository creditCardRepository;

    boolean hasCredit(float price){ //Bank connection
        return true; //ONLY FOR TEST PURPOSE!
    }
}
