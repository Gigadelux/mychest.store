package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Product.Key;
import com.gigadelux.mychest.entity.User.Order;
import com.gigadelux.mychest.exception.NoKeyFoundException;
import com.gigadelux.mychest.exception.OrderNotFoundException;
import com.gigadelux.mychest.repository.KeyRepository;
import com.gigadelux.mychest.repository.OrderRepository;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class KeyService {
    @Autowired
    KeyRepository keyRepository;

    @Autowired
    OrderRepository orderRepository;

//TODO fix, unique method to OrderService
    void ReassignKey(Long keyId, Long orderId) throws NoKeyFoundException, OrderNotFoundException {
        if(!keyRepository.existsById(keyId)) throw new NoKeyFoundException();
        Key k = keyRepository.getReferenceById(keyId);
        if(!orderRepository.existsById(orderId)) throw new OrderNotFoundException();
        Order orderReassignment = orderRepository.getReferenceById(orderId);
        k.setProduct(null);
        k.setOrder(orderReassignment);

    }
}
