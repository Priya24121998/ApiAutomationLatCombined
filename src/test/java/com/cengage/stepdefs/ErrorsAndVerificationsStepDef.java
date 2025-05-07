package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.ErrorsAndVerificationsActions;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.restassured.path.json.JsonPath;
import org.testng.Assert;

import java.util.Map;


@SuppressWarnings("deprecation")
public class ErrorsAndVerificationsStepDef extends BaseClass {

	public ErrorsAndVerificationsStepDef() {
		super();
	}

	ErrorsAndVerificationsActions errActions = new ErrorsAndVerificationsActions();

	@Then("I verify (.*) address is added to cart")
	public void verifyAddressIsAddedToCart(String addressType) {
		errActions.verifyAddressIsAddedToCart(JsonPath.from(response), addressType);

	}
	
	@Then("User get (.*) address does not exist error")
	public void verifyInResponse(String addressType) {
		String addressId = PropFileHandler.readProperty(addressType + "_AddresID");
		String actualErrorMsg = extractValueFromJOSNPath("errors[0].message", response);
		String expectedErrorMsg = "Address with given id: '" + addressId + "' doesn't exist or belong to another user";
		compareResponseValue(actualErrorMsg, expectedErrorMsg);
	}

	@Then("I verify error with given message")
	public void verifyErrorMsg(Map<String, String> apiData) {
		ErrorsAndVerificationsActions.verifyErrorMessage(JsonPath.from(response), apiData.get("Message"));

	}

	@And("I get Error details")
	public void getErrorDetails() {
		errActions.verifyTypeOfError(JsonPath.from(response));
	}
	
	@Then("^assert verify stock level of the PDP response equals minstock$")
	public void assertVerifyStockLevelOfThePDPResponseEqualsMinstock() {
	    
		errActions.verifyStockPriceMinMatchesWithMinBundleCompStock(JsonPath.from(response));
	}
	
	
//----------------------------------------- Cart Error / Verifications ----------------------------------------------
	
		@Then("I verify user is not able to add same product twice")
		public void verifySameProductError() {
			String expectedMessage = "Product already added in cart";
			String actualMessage = errActions.errorMessage(JsonPath.from(response));
			compareResponseValue(actualMessage, expectedMessage);
		}

//	------------------------------------- Not Used  ---------------------------------

	@Then("I check for maximum charlimit Error at entry (.*)")
	public void name(int atEntry) {
		errActions.verifyErrormsg(JsonPath.from(response), atEntry);

	}
	
// -------------------------------------------- Cart Not Used--------------------------------------------------------------- 		
		@Then("User fetches warning message")
		public void userFetchWarningMessage() {
			String expectedMessage = "Products have been removed from the cart";
			String actualMessage = errActions.warningMessage(JsonPath.from(response));
			Assert.assertEquals(expectedMessage, actualMessage, "**[ASSERTION FAILED]  Message is not expected");
			logMessage("**[ASSERTION PASSED] Verified Warning Message is: " + actualMessage);

		}
		
		

		

	
}