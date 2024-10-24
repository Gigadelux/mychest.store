package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Banner;
import com.gigadelux.mychest.entity.Product.Category;
import com.gigadelux.mychest.entity.Product.Product;
import com.gigadelux.mychest.exception.BannerNullException;
import com.gigadelux.mychest.exception.CategoryDoesNotExistException;
import com.gigadelux.mychest.exception.ProductNotFound;
import com.gigadelux.mychest.exception.ProductsByCategoryNotFoundException;
import com.gigadelux.mychest.repository.BannerRepository;
import com.gigadelux.mychest.repository.CategoryRepository;
import com.gigadelux.mychest.repository.ProductRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private BannerRepository bannerRepository;

    @Transactional
    public List<Product> getProductsByCategory(String category) throws ProductsByCategoryNotFoundException , CategoryDoesNotExistException{
        if(!categoryRepository.existsByName(category)) throw new CategoryDoesNotExistException();
        System.out.println(category);
        Category cat = categoryRepository.findByName(category);
        List<Product> res = cat.getProducts();
        if(res.isEmpty()) throw new ProductsByCategoryNotFoundException();
        System.out.println("Before increment: " + cat);
        if (cat.getPopularity() == null) {
            cat.setPopularity(1L);
        }
        else
            cat.setPopularity(cat.getPopularity() + 1L);
        System.out.println("After increment: " + cat);
        categoryRepository.save(cat);
        return res;
    }

    @Transactional
    public Product insertProduct(String name, String description, String image, float price, int type, String platforms, Long catId) throws CategoryDoesNotExistException{
        if(!categoryRepository.existsById(catId)) throw new CategoryDoesNotExistException();
        Product p = new Product();
        p.setName(name);
        p.setDescription(description);
        p.setImage(image);
        p.setPrice(price);
        p.setType(type);
        p.setPlatforms(platforms);
        p.setCategory(categoryRepository.getReferenceById(catId));
        p.setQuantity(0);
        productRepository.save(p);
        return p;
    }

    @Transactional
    public Product removeProduct(Long id) throws ProductNotFound{
        if(!productRepository.existsById(id)) throw new ProductNotFound();
        Product product = productRepository.getReferenceById(id);
        productRepository.deleteById(id);
        return product;
    }

    @Transactional
    public void editProduct(Long id, String name, String description, String image, int quantity, float price, int type ,String platforms, Long catId) throws ProductNotFound, CategoryDoesNotExistException{
        if(!productRepository.existsById(id)) throw new ProductNotFound();
        if(!categoryRepository.existsById(catId)) throw new CategoryDoesNotExistException();
        Product p = productRepository.getReferenceById(id);
        p.setName(name);
        p.setDescription(description);
        p.setImage(image);
        p.setQuantity(quantity);
        p.setPrice(price);
        p.setType(type);
        p.setPlatforms(platforms);
        p.setCategory(categoryRepository.getReferenceById(catId));
        productRepository.save(p);
    }

    @Transactional(readOnly = true)
    public List<Product> getFeatured() throws CategoryDoesNotExistException, ProductsByCategoryNotFoundException, BannerNullException {
        Banner b = bannerRepository.findFirstByOrderByIdAsc();
        if(b==null) throw new BannerNullException();
        Category bannerCat = b.getCategory();
        if(!categoryRepository.existsById(bannerCat.getId())) throw new CategoryDoesNotExistException();
        return getProductsByCategory(bannerCat.getName());
    }

    @Transactional(readOnly = true)
    public List<Product> searchProducts(String name) throws ProductNotFound{
        List<Product> res = productRepository.findProductByNameContaining(name);
        if(res.isEmpty()) throw new ProductNotFound();
        return res;
    }
}
