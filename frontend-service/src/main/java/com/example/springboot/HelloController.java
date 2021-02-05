package com.example.springboot;

import com.example.services.DocDbService;
import com.example.services.ApiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

	
	private DocDbService ddbService = new DocDbService();
	private ApiService apiService = new ApiService();

	@RequestMapping("/")
	public String index() {
		return "Service is alive";
	}

	@RequestMapping("/ddb-svc")
	public String ddbValueLb() { 
		String document = ddbService.getDocument("a-key");
		return document;
	}

	@RequestMapping("/api-svc")
	public String ddbValueCip() { 
		String result = apiService.callGet("widgets");
		return result;
	}

}
