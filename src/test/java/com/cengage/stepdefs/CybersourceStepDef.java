package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.CybersourceActions;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.Map;

@SuppressWarnings("deprecation")
public class CybersourceStepDef extends BaseClass {

	public CybersourceStepDef() {
		super();
	}

	public static final String BASE_SITE_ID = PropFileHandler.readProperty("baseSiteId");
	CybersourceActions cyberActions = new CybersourceActions();



	@And("User launches CyberSource")
	public void launchCybersourceURL() {
		String applicationPath = cyberActions.getApplicationPath(BASE_SITE_ID, userGUID, cartId);
		launchApplication(applicationPath);
	}

	@And("I launch dummy CyberSource")
	public void launchCybersourceURL(Map<String, String> apiData) {
		String applicationPath = cyberActions.getApplicationPath(apiData.get("basestore"), userID, cartId);
		launchApplication(applicationPath);
	}

	@And("I launch dummy CyberSource by passing userGuid")
	public void launchCybersourceURLUsingUserGuid(Map<String, String> apiData) {
		String applicationPath = cyberActions.getApplicationPath(apiData.get("basestore"), userGUID, cartId);
		launchApplication(applicationPath);
	}


	@And("launch CW CyberSource")
	public void launchCWCybersourceURL() {
		String uid = PropFileHandler.readProperty("CWUserId");
		String applicationPath = cyberActions.getApplicationPath("cengage-b2c-wfs-us", uid, cartId);
		launchApplication(applicationPath);
	}



	@And("User Enters (.*) card details")
	public void enterCCDetails(String ccType) {
		cyberActions.enterCCDetails(ccType);
	}

	@When("I enter (.*) credit card number,expiry date (.*), CVV (.*) and complete purchase")
	public void enterCCDetails(String ccType, String exdate, String cvv) {
		cyberActions.enterCCDetails(ccType, exdate, cvv);
	}


	@When("Accept (.*) securit popup")
	public void accept3dsPopup(String cardName) {
		cyberActions.accept3dsPopup(cardName);
	}



	@Then("User verifies (.*) message")
	public void verifyMessage(String msg) {
		cyberActions.verifyMessage(msg);
	}

	@Then("I verify error on payment page")
	public void verifyErrorMessage() {
		cyberActions.verifyErrorMessage();
	}

}
