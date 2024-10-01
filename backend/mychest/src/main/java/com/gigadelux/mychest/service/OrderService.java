package com.gigadelux.mychest.service;

import com.gigadelux.mychest.repository.KeyRepository;
import com.gigadelux.mychest.repository.OrderRepository;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderService {
    @Autowired
    OrderRepository orderRepository;

    @Autowired
    KeyRepository keyRepository;
}
