
package com.example.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;


@Service
public class DocDbService
{
    
    private RestTemplate restTemplate = new RestTemplate();

    // inject value from application.properties
    @Value("${service.doc-db.url}")
    private String API_URL;

    
    public String getDocument(String key)
    {
       return  restTemplate.getForObject("http://internal-af6b403661a89414ca465226c8bc597c-2037585698.us-west-2.elb.amazonaws.com:8080", String.class);
    }

   
}