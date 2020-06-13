package com.cucumbertest.cucumbertest.calculator;

import static org.junit.Assert.assertEquals;

import org.junit.Ignore;
import org.springframework.http.ResponseEntity;

import com.cucumbertest.cucumbertest.CucumberRoot;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

@Ignore
public class CalculatorStepDefinitions extends CucumberRoot {

	int response = 0;
	String url = DEFAULT_URL + "calc/";

	@When("the client calls \\/calc\\/add with values {int} and {int}")
	public void the_client_calls_arithmetic_add_with_values_and(int int1, int int2) {
		response = restTemplate.getForObject(url + "add?a=" + int1 + "&b=" + int2, Integer.class);
	}

	@Then("the client receives answer as {int}")
	public void the_client_receives_answer_as(int result) {
		assertEquals(result, response);
	}

	@When("the client calls \\/calc\\/sub with values {int} and {int}")
	public void the_client_calls_calc_sub_with_values_and(Integer int1, Integer int2) {
		response = restTemplate.getForObject(url + "sub?a=" + int1 + "&b=" + int2, Integer.class);
	}

	@When("the client calls \\/calc\\/mul with values {int} and {int}")
	public void the_client_calls_calc_mul_with_values_and(Integer int1, Integer int2) {
		response = restTemplate.getForObject(url + "mul?a=" + int1 + "&b=" + int2, Integer.class);
	}

	@When("the client calls \\/calc\\/div with values {int} and {int}")
	public void the_client_calls_calc_div_with_values_and(Integer int1, Integer int2) {
		response = restTemplate.getForObject(url + "div?a=" + int1 + "&b=" + int2, Integer.class);
	}
	
	
	
	/**Second definition here******************************************/
	private ResponseEntity<String> responseEn; // output

	
	@When("the client calls \\/health")
	public void the_client_calls_health() {
		responseEn = restTemplate.getForEntity(DEFAULT_URL+"health", String.class);
	}

	@Then("the client receives response status code of {int}")
	public void the_client_receives_response_status_code_of(Integer int1) {
		assertEquals(""+responseEn.getStatusCodeValue(), int1.toString());
	}
}
