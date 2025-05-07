package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.OrdersAction;
import com.cengage.pageactions.PayPalPageActions;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.path.json.JsonPath;

import java.util.Map;

/**
 * @author shiv.mangal
 *
 */
@SuppressWarnings("deprecation")
public class PayPalStepDef extends BaseClass {
	public PayPalStepDef() {
		super();
	}

	PayPalPageActions payPalPage = new PayPalPageActions();
	OrdersAction ordersActions = new OrdersAction();
	public static final String BASE_SITE_ID = PropFileHandler.readProperty("baseSiteId");

	@And("launch paypal")
	public static void launchPaypalURL() {
		response  = PayPalPageActions.getApplicationPathPaypal(BASE_SITE_ID, userGUID, cartId, 200);
		String applicationPath = response ;
		logMessage(applicationPath);
		PayPalPageActions.getPayPalToken(applicationPath);
		launchApplication(applicationPath);

	}

	@Then("I verify PayPal portal has launched successfully")
	public void verifyPayPalPortalHasLaunched() {
		payPalPage.verifyPayPalPortalHasLaunched();

	}

	@When("I enter paypal login details and make purchase")
	public void completePaypalTransaction() {
		hardWait(5);
		try {
			payPalPage.enterPayPalEmail(PropFileHandler.readProperty("ppUsername3"));
			payPalPage.clickNextButton();
			hardWait(3);
			payPalPage.enterPayPalPassword(PropFileHandler.readProperty("ppPassword3"));
			payPalPage.clickOnLoginButton();
			hardWait(3);
			payPalPage.completePaypalTransaction();
		} catch (Exception e) {
			payPalPage.completePaypalTransaction();
		}
	}
	
	@When("^I will enter paypal login details and make purchase for newer full auth implementation$")
	public void completeFullAuthNewPaypalTransaction() {
		hardWait(5);
		try {
			payPalPage.enterPayPalEmail(PropFileHandler.readProperty("ppUsername3"));
			payPalPage.clickNextButton();
			hardWait(3);
			payPalPage.enterPayPalPassword(PropFileHandler.readProperty("ppPassword3"));
			payPalPage.clickOnLoginButton();
			hardWait(3);
			payPalPage.completeNewPaypalTransaction();
		} catch (Exception e) {
			payPalPage.completeNewPaypalTransaction();
		}
	}

	@And("I launch paypal for B2C stores")
	public void launchPaypalURLForB2C(Map<String, String> apiData) {

		int status = getStatusCode(apiData.get("status"));
		String applicationPath = PayPalPageActions.getApplicationPathPaypal(apiData.get("basestore"), userID, cartId, status);
		if (status != 400) {
			logMessage(applicationPath);
			PayPalPageActions.getPayPalToken(applicationPath);
			launchApplication(applicationPath);
		}

	}
	
	@And("^I launch paypal new url for B2C stores")
	public void launchFullAuthNewPaypalURLForB2C(Map<String, String> apiData)  {
		int status = getStatusCode(apiData.get("status"));
		String applicationPath = PayPalPageActions.getApplicationPathPaypal(apiData.get("basestore"), userID, cartId, status);
		if (status != 400) {
			logMessage(applicationPath);
			PayPalPageActions.getPayPalTokenNew(applicationPath);
			launchApplication(applicationPath);
		}
	}
	
	@And("^I navigate to paypal new url for B2C stores using GUID")
	public void verifyNewPayPalPageHasBeenNavigated(Map<String, String> apiData)  {
		int status = getStatusCode(apiData.get("status"));
		String applicationPath = PayPalPageActions.getApplicationPathPaypal(apiData.get("basestore"), userGUID, cartId, status);
		if (status != 400) {
			logMessage(applicationPath);
			PayPalPageActions.getPayPalTokenNew(applicationPath);
			launchApplication(applicationPath);
		}
	}

	@Then("I hit api to place B2C order using Paypal")
	public void placeOrderUsingPaypal(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		OrdersAction.placeOrderUsingPayPal(apiData.get("basestore"), userID, cartId, status);
		logMessage("Order placed with ID: " + OrderID);
	}

	
	@Then("^I hit api to place B2C order using new Paypal workflow$")
	public void placeOrderUsingPaypalNewFullAuth(Map<String, String> apiData)  {
		if(apiData.get("basestore").equalsIgnoreCase("cengage-b2c-au"))
		{
	    String payerId= PropFileHandler.readProperty("payerIdB2CAU");
		OrdersAction.placeOrderUsingNewPayPal(apiData.get("basestore"), userID, cartId, getStatusCode(apiData.get("status")),payerId);
		
		}
		else if(apiData.get("basestore").equalsIgnoreCase("cengage-b2c-us"))
		{
		String payerId= PropFileHandler.readProperty("payerIdB2CUS");
		OrdersAction.placeOrderUsingNewPayPal(apiData.get("basestore"), userID, cartId, getStatusCode(apiData.get("status")),payerId);
		}
		else if(apiData.get("basestore").equalsIgnoreCase("cengage-b2c-ca"))
		{
		String payerId= PropFileHandler.readProperty("payerIdB2CCA");
		OrdersAction.placeOrderUsingNewPayPal(apiData.get("basestore"), userID, cartId, getStatusCode(apiData.get("status")),payerId);
		}
		else if(apiData.get("basestore").equalsIgnoreCase("cengage-b2c-emea"))
		{
		String payerId= PropFileHandler.readProperty("payerIdB2CEMEA");
		OrdersAction.placeOrderUsingNewPayPal(apiData.get("basestore"), userID, cartId, getStatusCode(apiData.get("status")),payerId);
		}
		logMessage("Order placed with ID: " + OrderID);
		
		
	}
	
	@Then("^I should able to place B2C order using new Paypal workflow using UserGuid$")
	public void placeOrderUsingPaypalNewFullAuthUsingGuid(Map<String, String> apiData)  {
		if(apiData.get("basestore").equalsIgnoreCase("cengage-b2c-au"))
		{
	    String payerId= PropFileHandler.readProperty("payerIdB2CAU");
		OrdersAction.placeOrderUsingNewPayPal(apiData.get("basestore"), userGUID, cartId, getStatusCode(apiData.get("status")),payerId);
		
		}
		else if(apiData.get("basestore").equalsIgnoreCase("cengage-b2c-us"))
		{
		String payerId= PropFileHandler.readProperty("payerIdB2CUS");
		OrdersAction.placeOrderUsingNewPayPal(apiData.get("basestore"), userGUID, cartId, getStatusCode(apiData.get("status")),payerId);
		}
		else if(apiData.get("basestore").equalsIgnoreCase("cengage-b2c-ca"))
		{
		String payerId= PropFileHandler.readProperty("payerIdB2CCA");
		OrdersAction.placeOrderUsingNewPayPal(apiData.get("basestore"), userGUID, cartId, getStatusCode(apiData.get("status")),payerId);
		}
		else if(apiData.get("basestore").equalsIgnoreCase("cengage-b2c-emea"))
		{
		String payerId= PropFileHandler.readProperty("payerIdB2CEMEA");
		OrdersAction.placeOrderUsingNewPayPal(apiData.get("basestore"), userGUID, cartId, getStatusCode(apiData.get("status")),payerId);
		}
		logMessage("Order placed with ID: " + OrderID);
		
		
	}
	
	
	@Then("I verify invalid payment info for cart error")
	public void verifyInvalidPaymentInfoErrorMsg() {
		String expectedMsg = PropFileHandler.readProperty("invalidPaymentException");
		payPalPage.verifyErrorMessage( JsonPath.from(response),expectedMsg);

	}

}
