package com.cucumbertest.cucumbertest;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class PAY2_36_Payments_using_single_voucher_in_iFRAME {
	@Given("Given Below payment template should be available in aeroPAY system")
    public void given_Below_payment_template_should_be_available_in_aeroPAY_system(io.cucumber.datatable.DataTable dataTable) {
        // Write code here that turns the phrase above into concrete actions
        // For automatic transformation, change DataTable to one of
        // E, List<E>, List<List<E>>, List<Map<K,V>>, Map<K,V> or
        // Map<K, List<V>>. E,K,V must be a String, Integer, Float,
        // Double, Byte, Short, Long, BigInteger or BigDecimal.
        //
        // For other transformations you can register a DataTableType.
        //throw new cucumber.api.PendingException();
    }

    @Given("Below payment options should be available in aeroPAY system")
    public void below_payment_options_should_be_available_in_aeroPAY_system(io.cucumber.datatable.DataTable dataTable) {
        // Write code here that turns the phrase above into concrete actions
        // For automatic transformation, change DataTable to one of
        // E, List<E>, List<List<E>>, List<Map<K,V>>, Map<K,V> or
        // Map<K, List<V>>. E,K,V must be a String, Integer, Float,
        // Double, Byte, Short, Long, BigInteger or BigDecimal.
        //
        // For other transformations you can register a DataTableType.
        //throw new cucumber.api.PendingException();
    }

    @Given("Below segments should be available in aeroSegment system")
    public void below_segments_should_be_available_in_aeroSegment_system(io.cucumber.datatable.DataTable dataTable) {
        // Write code here that turns the phrase above into concrete actions
        // For automatic transformation, change DataTable to one of
        // E, List<E>, List<List<E>>, List<Map<K,V>>, Map<K,V> or
        // Map<K, List<V>>. E,K,V must be a String, Integer, Float,
        // Double, Byte, Short, Long, BigInteger or BigDecimal.
        //
        // For other transformations you can register a DataTableType.
        //throw new cucumber.api.PendingException();
    }

    @When("iFrameAPIRequest is invoked with below attributes from XBE to aeroPAY")
    public void iframeapirequest_is_invoked_with_below_attributes_from_XBE_to_aeroPAY(String docString) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("RetrievePaymentOptionsRequest is invoked with below attributes from aeroPay to aeroPay itself")
    public void retrievepaymentoptionsrequest_is_invoked_with_below_attributes_from_aeroPay_to_aeroPay_itself(String docString) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("RetrievePaymentOptionsResponse is sent from aeroPay to aeroPay itself")
    public void retrievepaymentoptionsresponse_is_sent_from_aeroPay_to_aeroPay_itself() {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("Retrieved Payment Options will be available in the iFrame for the user to select the form of payment")
    public void retrieved_Payment_Options_will_be_available_in_the_iFrame_for_the_user_to_select_the_form_of_payment() {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("Click on {string} radio button")
    public void click_on_radio_button(String string) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("Enter {string} in the field {string}")
    public void enter_in_the_field(String string, String string2) {
        // Write code here that turns the phrase above into concrete actions
        throw new cucumber.api.PendingException();
    }

    @When("Click on {string} button")
    public void click_on_button(String string) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("Field {string} should be equal to {string}")
    public void field_should_be_equal_to(String string, String string2) {
        // Write code here that turns the phrase above into concrete actions
        ///throw new cucumber.api.PendingException();
    }

    @When("VoucherAuthorizePay API request is invoked with below attributes from aeroPAY to aeroPAY itself")
    public void voucherauthorizepay_API_request_is_invoked_with_below_attributes_from_aeroPAY_to_aeroPAY_itself(String docString) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("VoucherPaymentAuthorizeRS is sent from aeroPAY to aeroPAY itself")
    public void voucherpaymentauthorizers_is_sent_from_aeroPAY_to_aeroPAY_itself() {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @When("iFrameAPIResponse is sent from aeroPay to XBE")
    public void iframeapiresponse_is_sent_from_aeroPay_to_XBE() {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

    @Then("Error message {string} should be displayed in the iFrame at XBE")
    public void error_message_should_be_displayed_in_the_iFrame_at_XBE(String string) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

//    @Then("Field {string} should be equal to {string}")
//    public void field_should_be_equal_to(String string, String string2) {
//        // Write code here that turns the phrase above into concrete actions
//        //throw new cucumber.api.PendingException();
//    }
//
//    @Then("iFrameAPIResponse is sent from aeroPay to XBE")
//    public void iframeapiresponse_is_sent_from_aeroPay_to_XBE() {
//        // Write code here that turns the phrase above into concrete actions
//        //throw new cucumber.api.PendingException();
//    }

    @When("Click on {string} link")
    public void click_on_link(String string) {
        // Write code here that turns the phrase above into concrete actions
        //throw new cucumber.api.PendingException();
    }

//    @Then("Click on {string} radio button")
//    public void click_on_radio_button(String string) {
//        // Write code here that turns the phrase above into concrete actions
//        //throw new cucumber.api.PendingException();
//    }

//    @Then("Enter {string} in the field {string}")
//    public void enter_in_the_field(String string, String string2) {
//        // Write code here that turns the phrase above into concrete actions
//        //throw new cucumber.api.PendingException();
//    }


}
