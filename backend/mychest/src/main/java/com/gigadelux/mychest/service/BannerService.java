package com.gigadelux.mychest.service;

import com.gigadelux.mychest.entity.Banner;
import com.gigadelux.mychest.exception.NoBannerException;
import com.gigadelux.mychest.repository.BannerRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BannerService {
    @Autowired
    BannerRepository bannerRepository;

    public Banner get()throws NoBannerException {
        if(!bannerRepository.existsById(1L)) throw new NoBannerException();
        return bannerRepository.getReferenceById(1L);
    }
    @Transactional
    public Banner setBanner(Banner banner){
        if(bannerRepository.existsById(1L)){
            bannerRepository.deleteById(1L);
            bannerRepository.save(banner);
        }
        else {
            bannerRepository.save(banner);
        }
        return banner;
    }
}
