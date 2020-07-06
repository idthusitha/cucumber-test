package com.cucumbertest.cucumbertest;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class PAY2_34_ADYEN_cancel_flow_Travel_Agent_Flow {
	@Given("Information of the Payment Reference ID for which cancel request has to be sent")
	public void information_of_the_Payment_Reference_ID_for_which_cancel_request_has_to_be_sent(
			io.cucumber.datatable.DataTable dataTable) {
		// Write code here that turns the phrase above into concrete actions
		// For automatic transformation, change DataTable to one of
		// E, List<E>, List<List<E>>, List<Map<K,V>>, Map<K,V> or
		// Map<K, List<V>>. E,K,V must be a String, Integer, Float,
		// Double, Byte, Short, Long, BigInteger or BigDecimal.
		//
		// For other transformations you can register a DataTableType.
		//throw new cucumber.api.PendingException();
	}

	@When("CCCancel API request is invoked with below attributes to aeroPAY")
	public void cccancel_API_request_is_invoked_with_below_attributes_to_aeroPAY(String docString) {
		// Write code here that turns the phrase above into concrete actions
		//throw new cucumber.api.PendingException();
	}

	@Then("HTTPS status code should be {string}")
	public void https_status_code_should_be(String string) {
		// Write code here that turns the phrase above into concrete actions
		//throw new cucumber.api.PendingException();
	}

	@Then("API Response should have Below values")
	public void api_Response_should_have_Below_values(String docString) {
		// Write code here that turns the phrase above into concrete actions
		//throw new cucumber.api.PendingException();
	}
//
//	@When("HTTPS status code should be {string}")
//	public void https_status_code_should_be(String string) {
//		// Write code here that turns the phrase above into concrete actions
//		//throw new cucumber.api.PendingException();
//	}

	@Then("No API Response")
	public void no_API_Response() {
		// Write code here that turns the phrase above into concrete actions
		//throw new cucumber.api.PendingException();
	}

	@Then("Error description in the response message header name {string} should be {string}")
	public void error_description_in_the_response_message_header_name_should_be(String string, String string2) {
		// Write code here that turns the phrase above into concrete actions
		//throw new cucumber.api.PendingException();
	}

	@Then("Read errorMessageDesc from payment gateway and print in responseHeaders[{string}]")
	public void read_errorMessageDesc_from_payment_gateway_and_print_in_responseHeaders(String string) {
		// Write code here that turns the phrase above into concrete actions
		//throw new cucumber.api.PendingException();
	}

}
