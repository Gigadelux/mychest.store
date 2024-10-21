package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Product.Key;
import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.entity.User.Order;
import com.gigadelux.mychest.exception.InsufficientQuantityException;
import com.gigadelux.mychest.exception.NoKeyFoundException;
import com.gigadelux.mychest.exception.OrderNotFoundException;
import com.gigadelux.mychest.exception.ProductNotFound;
import com.gigadelux.mychest.repository.KeyRepository;
import com.gigadelux.mychest.repository.OrderRepository;
import com.gigadelux.mychest.repository.ProductRepository;
import jakarta.transaction.Transactional;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class KeyService {
    @Autowired
    KeyRepository keyRepository;

    @Autowired
    OrderRepository orderRepository;

    @Autowired
    ProductRepository productRepository;

    public Key addKey(String activationKey, Long productId){
        Key k = new Key();
        Product p = productRepository.getReferenceById(productId);
        k.setProduct(p);
        k.setActivationKey(activationKey);
        p.setQuantity(p.getQuantity()+1);
        productRepository.save(p);
        keyRepository.save(k);
        return k;
    }

    @Transactional
    protected void insertKeyToOrder(Long keyId, Order order) throws NoKeyFoundException, OrderNotFoundException { //it inherits Rollback
        if(!keyRepository.existsById(keyId)) throw new NoKeyFoundException();
        Key k = keyRepository.getReferenceById(keyId);
//     if(!orderRepository.existsById(orderId)) throw new OrderNotFoundException(); //not.........
        k.setProduct(null);
        k.setOrder(order);
        keyRepository.save(k);
    }
    private void insertKeyToProduct(Long keyId, Long pId) throws ProductNotFound { //it inherits Rollback
        //if(!keyRepository.existsById(keyId)) throw new NoKeyFoundException(); //useless, key are retrieved from KeyRepository
        Key k = keyRepository.getReferenceById(keyId);
        if(!productRepository.existsById(pId)) throw new ProductNotFound();
        Product prToAssign = productRepository.getReferenceById(pId);
        k.setProduct(prToAssign);
        keyRepository.save(k);
    }
    public void reassignKeysToProd(List<Key> keys, Product p ) throws ProductNotFound{//Reassignment through List for admin
        for(Key k : keys){
            insertKeyToProduct(k.getId(),p.getId());
        }
    }

    @Transactional
    public void insertKeysToOrder(Order order, Long productId, int quantity) throws OrderNotFoundException, ProductNotFound, NoKeyFoundException {
        if(!productRepository.existsById(productId)) throw new ProductNotFound();
        //Product reference = productRepository.getReferenceById(orderId);
        //if(reference.getQuantity()<quantity) throw new InsufficientQuantityException(); //REDUNDANT
        List<Key> keys = keyRepository.getRandomKeys(productId,quantity);
        for(Key k:keys){
            insertKeyToOrder(k.getId(),order);
        }
    }

    public List<Key> getKeysByOrder(Long orderId) throws OrderNotFoundException{
        if(!orderRepository.existsById(orderId)) throw new OrderNotFoundException();
        Order order = orderRepository.getReferenceById(orderId);
        return order.getKeys();
    }
}
