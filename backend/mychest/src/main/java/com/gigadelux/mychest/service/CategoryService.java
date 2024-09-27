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
}
