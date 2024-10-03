package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.User.AppUser;
import com.gigadelux.mychest.entity.User.CreditCard;
import com.gigadelux.mychest.exception.CreditCardNotFoundException;
import com.gigadelux.mychest.exception.UserNotFoundException;
import com.gigadelux.mychest.repository.AppUserRepository;
import com.gigadelux.mychest.repository.CreditCardRepository;
import jakarta.transaction.Transactional;
import org.checkerframework.checker.units.qual.C;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CreditCardService {
    @Autowired
    CreditCardRepository creditCardRepository;

    @Autowired
    AppUserRepository appUserRepository;

    boolean hasCredit(AppUser appUser, float price) throws CreditCardNotFoundException { //Bank connection
        if(appUser.getCredit_card()==null) throw new CreditCardNotFoundException();
        return true; //ONLY FOR TEST PURPOSE!
    }

    @Transactional
    public void setCreditCard(Long userId, CreditCard creditCard) throws UserNotFoundException {
        if(!appUserRepository.existsById(userId)) throw new UserNotFoundException();
        AppUser user = appUserRepository.getReferenceById(userId);
        if(creditCardRepository.existsByUser(user)){
            CreditCard toDelete = creditCardRepository.findByUser(user);
            creditCardRepository.deleteById(toDelete.getId());
        }
        CreditCard c = new CreditCard();
        c.setCard_number(creditCard.getCard_number());
        c.setExpire_time(creditCard.getExpire_time());
        c.setPass_code(creditCard.getPass_code());
        c.setUser(user);
        creditCardRepository.save(c);
    }
}
