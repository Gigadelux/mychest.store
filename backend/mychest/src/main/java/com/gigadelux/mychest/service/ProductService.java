package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Product.Category;
import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.exception.CategoryDoesNotExistException;
import com.gigadelux.mychest.exception.ProductNotFound;
import com.gigadelux.mychest.exception.ProductsByCategoryNotFoundException;
import com.gigadelux.mychest.repository.CategoryRepository;
import com.gigadelux.mychest.repository.ProductRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Transactional
    public List<Product> getProductsByCategory(String category) throws ProductsByCategoryNotFoundException {
        List<Product> res = productRepository.findProductsByCategory(category);
        if(res.isEmpty()) throw new ProductsByCategoryNotFoundException();
        categoryRepository.incrementPopularity(category);
        return res;
    }

    public void insertProduct(@RequestBody Product p, Category cat) throws CategoryDoesNotExistException{
        if(categoryRepository.existsById(cat.getId())) throw new CategoryDoesNotExistException();
        p.setCategory(cat);
        productRepository.save(p);
    }

    public void removeProduct(Long id) throws ProductNotFound{
        if(!productRepository.existsById(id)) throw new ProductNotFound();
        productRepository.deleteById(id);
    }

    public void editProduct(Long id, String name, String description, String image, int quantity, float price, int type ,String platforms, Category cat) throws ProductNotFound, CategoryDoesNotExistException{
        if(!productRepository.existsById(id)) throw new ProductNotFound();
        if(!categoryRepository.existsById(cat.getId())) throw new CategoryDoesNotExistException();
        Product p = productRepository.getReferenceById(id);
        p.setName(name);
        p.setDescription(description);
        p.setImage(image);
        p.setQuantity(quantity);
        p.setPrice(price);
        p.setType(type);
        p.setPlatforms(platforms);
        p.setCategory(cat);
        productRepository.save(p);
    }

}
