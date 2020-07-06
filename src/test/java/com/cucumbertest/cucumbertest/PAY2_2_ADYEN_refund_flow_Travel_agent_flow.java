package com.cucumbertest.cucumbertest;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class PAY2_2_ADYEN_refund_flow_Travel_agent_flow {
	@Given("Information of the Payment Reference ID for which CreditRefund request has to be sent")
	public void information_of_the_Payment_Reference_ID_for_which_CreditRefund_request_has_to_be_sent(
			io.cucumber.datatable.DataTable dataTable) {
		// Write code here that turns the phrase above into concrete actions
		// For automatic transformation, change DataTable to one of
		// E, List<E>, List<List<E>>, List<Map<K,V>>, Map<K,V> or
		// Map<K, List<V>>. E,K,V must be a String, Integer, Float,
		// Double, Byte, Short, Long, BigInteger or BigDecimal.
		//
		// For other transformations you can register a DataTableType.
		// throw new cucumber.api.PendingException();
	}

	@When("CCRefund API request is invoked with below attributes to aeroPAY")
	public void ccrefund_API_request_is_invoked_with_below_attributes_to_aeroPAY(String docString) {
		// Write code here that turns the phrase above into concrete actions
		// throw new cucumber.api.PendingException();
	}
}
