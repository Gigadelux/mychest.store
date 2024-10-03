package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.service.AppUserService;
import com.gigadelux.mychest.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/orders")
public class OrderController {
    @Autowired
    OrderService orderService;

    @Autowired
    AppUserService appUserService;

    //@PostMapping("/pay")

    //@GetMapping("/getOrders")
}
