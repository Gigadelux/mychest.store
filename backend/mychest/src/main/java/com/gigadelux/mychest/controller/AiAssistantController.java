package com.gigadelux.mychest.controller;

import com.gigadelux.mychest.exception.NoBannerException;
import com.gigadelux.mychest.service.AiAssistantService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("aiAssistant")
public class AiAssistantController {

    private final AiAssistantService aiAssistant;

    public AiAssistantController(AiAssistantService aiAssistant) {
        this.aiAssistant = aiAssistant;
    }

    @GetMapping("/reccomendProducts")
    public ResponseEntity reccomendProducts() {
        try {
            return ResponseEntity.ok(aiAssistant.reccomend());
        } catch (NoBannerException e) {
            return new ResponseEntity("", HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/newReccomendation")
    public ResponseEntity newProducts(@RequestParam String dislikedText) {
        try {
            return ResponseEntity.ok(aiAssistant.refreshReccomendation(dislikedText));
        } catch (NoBannerException e) {
            return new ResponseEntity("", HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}