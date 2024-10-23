package com.gigadelux.mychest.service;


import com.gigadelux.mychest.exception.BannerNullException;
import com.gigadelux.mychest.exception.NoBannerException;
import com.gigadelux.mychest.utilities.assistant.Prompts;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@Service
public class AiAssistantService {

    private final RestTemplate restTemplate;

    @Value("${spring.datasource.GeminyAPIKEY}")
    private String geminiApiKey;

    @Autowired
    BannerService bannerService;

    // Use @Value to inject the environment variable
    public AiAssistantService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public String reccomend() throws NoBannerException {

        //getting today offer
        String todayOffer = this.bannerService.get().getCategory().getName();

        //Initializing prompt
        String promptFormatted = Prompts.reccomendFeatured.format(todayOffer, todayOffer);
        System.out.println(promptFormatted);
        return generateText(promptFormatted);
    }

    public String refreshReccomendation(String disliked) throws NoBannerException {

        //getting today offer
        String todayOffer = this.bannerService.get().getCategory().getName();

        //Initializing prompt
        String promptFormatted = Prompts.reccomendFeatured.format(todayOffer, todayOffer)+Prompts.partialRefreshPrompt.formatted(disliked);

        return generateText(promptFormatted);
    }

    private String generateText(String prompt){
        String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key=" + geminiApiKey;

        // Create headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Create the body
        Map<String, Object> body = new HashMap<>();
        Map<String, Object> content = new HashMap<>();
        Map<String, String> part = new HashMap<>();
        part.put("text", prompt);

        content.put("parts", Collections.singletonList(part));
        body.put("contents", Collections.singletonList(content));

        //setting temperature
        Map<String, Object> generationConfig = new HashMap<>();
        generationConfig.put("temperature", 0.7D);
        body.put("generationConfig", generationConfig);

        // Build the request entity
        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        // Make the request and get the response
        ResponseEntity<String> responseEntity = restTemplate.exchange(
                url,
                HttpMethod.POST,
                requestEntity,
                String.class
        );

        // Return the response body
        return responseEntity.getBody();
    }
}
