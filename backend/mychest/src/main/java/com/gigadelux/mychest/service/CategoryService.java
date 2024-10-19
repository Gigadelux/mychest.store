package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Product.Category;
import com.gigadelux.mychest.exception.CategoryDoesNotExistException;
import com.gigadelux.mychest.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Service
public class CategoryService {
    @Autowired
    CategoryRepository categoryRepository;

    public List<Category> getAll(){
        return categoryRepository.findAll();
    }

    public Category getById(@RequestParam Long id) throws CategoryDoesNotExistException{
        if(!categoryRepository.existsById(id)) throw new CategoryDoesNotExistException();
        return categoryRepository.getReferenceById(id);
    }

    public Category addCategory(String name){
        Category cat = new Category();
        cat.setName(name);
        cat.setPopularity(0L);
        categoryRepository.save(cat);
        return cat;
    }

    public Category delete(@RequestParam String name) throws CategoryDoesNotExistException{
        if(!categoryRepository.existsByName(name)) throw new CategoryDoesNotExistException();
        Category cat = categoryRepository.findByName(name);
        categoryRepository.delete(cat);
        return cat;
    }

    public List<Category> getMostPopular(int limit){
        return categoryRepository.mostPopular(limit);
    }
}
