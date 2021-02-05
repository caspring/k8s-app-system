
package com.example.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;


@Service
public class ApiService
{
    
    private RestTemplate restTemplate = new RestTemplate();

    // inject value from application.properties
    @Value("${API_SERVICE_NAME}")
    private String apiUrl;

    public String callGet(String path)
    {
        return restTemplate.getForObject("http://"+apiUrl+":8080", String.class);
    }

}