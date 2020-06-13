package com.cucumbertest.cucumbertest.calculator;

import static org.junit.Assert.assertEquals;

import org.junit.Ignore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.cucumbertest.cucumbertest.CucumberRoot;
import com.cucumbertest.cucumbertest.utils.TestConfig;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

@Ignore
public class HelthSteupDefinitions extends CucumberRoot{
	
	

	private ResponseEntity<String> response; // output


//	@When("the client calls \\/health")
//	public void the_client_calls_health() {
//		response = restTemplate.getForEntity("/health", String.class);
//	}
//
//	@Then("the client receives response status code of {int}")
//	public void the_client_receives_response_status_code_of(Integer int1) {
//		assertEquals(response.getStatusCode(), int1);
//	}

}
