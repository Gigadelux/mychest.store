package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Banner;
import com.gigadelux.mychest.exception.CategoryDoesNotExistException;
import com.gigadelux.mychest.exception.NoBannerException;
import com.gigadelux.mychest.repository.BannerRepository;
import com.gigadelux.mychest.repository.CategoryRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BannerService {
    @Autowired
    BannerRepository bannerRepository;

    @Autowired
    CategoryRepository categoryRepository;

    public Banner get()throws NoBannerException {
        if(!bannerRepository.existsById(1L)) throw new NoBannerException();
        return bannerRepository.getReferenceById(1L);
    }
    @Transactional
    public Banner setBanner(String image, String category) throws CategoryDoesNotExistException {
        if(!categoryRepository.existsByName(category)) throw new CategoryDoesNotExistException();
        if(bannerRepository.existsById(1L))
            bannerRepository.deleteById(1L);
        Banner b = new Banner();
        b.setImage(image);
        b.setCategory(categoryRepository.findByName(category));
        bannerRepository.save(b);
        return b;
    }
}
