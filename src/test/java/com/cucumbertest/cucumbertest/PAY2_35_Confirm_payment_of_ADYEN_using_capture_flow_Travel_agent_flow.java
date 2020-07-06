package com.cucumbertest.cucumbertest;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class PAY2_35_Confirm_payment_of_ADYEN_using_capture_flow_Travel_agent_flow {
	@Given("Below details should be present for payment confirmation:")
    public void below_details_should_be_present_for_payment_confirmation(io.cucumber.datatable.DataTable dataTable) {
        // Write code here that turns the phrase above into concrete actions
        // For automatic transformation, change DataTable to one of
        // E, List<E>, List<List<E>>, List<Map<K,V>>, Map<K,V> or
        // Map<K, List<V>>. E,K,V must be a String, Integer, Float,
        // Double, Byte, Short, Long, BigInteger or BigDecimal.
        //
        // For other transformations you can register a DataTableType.
        //throw new cucumber.api.PendingException();
    }

    @When("CConfirmPay API request is invoked with below attributes to aeroPAY")
    public void cconfirmpay_API_request_is_invoked_with_below_attributes_to_aeroPAY(String docString) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @Then("status code should be {string}")
    public void status_code_should_be(String string) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

}
