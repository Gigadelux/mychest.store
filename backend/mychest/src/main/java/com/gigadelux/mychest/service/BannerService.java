package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Banner;
import com.gigadelux.mychest.entity.Product.Category;
import com.gigadelux.mychest.exception.BannerNullException;
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
        Banner b = bannerRepository.findFirstByOrderByIdAsc();
        if(b == null) throw new NoBannerException();
        return b;
    }
    @Transactional
    public Banner setBanner(String image, String category) throws CategoryDoesNotExistException {
        if(!categoryRepository.existsByName(category)) throw new CategoryDoesNotExistException();
        Category cat = categoryRepository.findByName(category);
        Banner b = bannerRepository.findFirstByOrderByIdAsc();
        if(b != null) {
            b.setCategory(cat);
            b.setImage(image);
            bannerRepository.save(b);
            return b;
        }else {
            Banner banToSet = new Banner();
            banToSet.setImage(image);
            banToSet.setCategory(cat);
            bannerRepository.save(banToSet);
            return banToSet;
        }
    }

    @Transactional
    public String delete() throws BannerNullException {
        Banner b = bannerRepository.findFirstByOrderByIdAsc();
        if(b == null) throw new BannerNullException();
        b.setCategory(null);
        bannerRepository.deleteById(b.getId());
        return b.getImage();
    }
}
