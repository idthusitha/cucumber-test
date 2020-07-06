package com.cucumbertest.cucumbertest;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class PAY2_4_Ability_to_pay_using_CCAvenue_payment_gateway {
	@Given("Agent's Card related information")
    public void agent_s_Card_related_information(io.cucumber.datatable.DataTable dataTable) {
        // Write code here that turns the phrase above into concrete actions
        // For automatic transformation, change DataTable to one of
        // E, List<E>, List<List<E>>, List<Map<K,V>>, Map<K,V> or
        // Map<K, List<V>>. E,K,V must be a String, Integer, Float,
        // Double, Byte, Short, Long, BigInteger or BigDecimal.
        //
        // For other transformations you can register a DataTableType.
        //throw new cucumber.api.PendingException();
    }

    @When("CCAuthorizePay API request is invoked with below attributes to aeroPAY")
    public void ccauthorizepay_API_request_is_invoked_with_below_attributes_to_aeroPAY(String docString) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("agentCreditBlock API request is invoked with below attributes to aeroAgent")
    public void agentcreditblock_API_request_is_invoked_with_below_attributes_to_aeroAgent(String docString) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("Payment authorize request is received by aeroPAY from a requesting application")
    public void payment_authorize_request_is_received_by_aeroPAY_from_a_requesting_application() {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @Then("agentCreditBlock Request should be sent from aeroPAY to aeroAGENT")
    public void agentcreditblock_Request_should_be_sent_from_aeroPAY_to_aeroAGENT() {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("AuthorizePay request is sent from aeroPAY to Payment Gateway")
    public void authorizepay_request_is_sent_from_aeroPAY_to_Payment_Gateway() {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @Then("AuthorizePay request is failed\\(due to some technical\\/server error)")
    public void authorizepay_request_is_failed_due_to_some_technical_server_error() {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("agentCreditBlockRelease Request should be sent from aeroPAY to aeroAGENT via kafka")
    public void agentcreditblockrelease_Request_should_be_sent_from_aeroPAY_to_aeroAGENT_via_kafka() {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @Then("AuthorizePaymentResponse with error details is sent to the consuming application \\(i.e) Payment authorize request failed at Payment Gateway and agentCreditBlockRelease is success at aeroAgent")
    public void authorizepaymentresponse_with_error_details_is_sent_to_the_consuming_application_i_e_Payment_authorize_request_failed_at_Payment_Gateway_and_agentCreditBlockRelease_is_success_at_aeroAgent() {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

}
