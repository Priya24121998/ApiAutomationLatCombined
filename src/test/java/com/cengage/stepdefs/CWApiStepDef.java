package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.CWApiActions;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.path.json.JsonPath;
import org.json.simple.JSONObject;
import org.testng.Assert;

import java.util.Map;

@SuppressWarnings("deprecation")
public class CWApiStepDef extends BaseClass {

	public CWApiStepDef() {
		super();
	}

	CWApiActions cwapiActions = new CWApiActions();
	static String response;
	static String reTransferpayload;
	static String uid = PropFileHandler.readProperty("CWUserId");
	

	@Given("I hit API to create WFS token")
	public static void createWfsToken() {
		authorizationValue = CWApiActions.getCWToken();
		logMessage("CW Token created successfully");
	}

	@When("^I hit API to create WFS Cart$")
	public static void addCWCart(Map<String, String> apiData) {
		JSONObject payload = CWApiActions.generateCreateCartPayload(apiData);
		response = CWApiActions.createCWCart(payload.toString(), 201);
		logMessage("Cart created successfully, with:\nCartID: " + cartId);
		scenarioComment = "Cart ID: " + cartId;
	}

	@When("^I hit API to create WFS Cart with Empty Delivery Address$")
	public static void addCWCartWithoutDeliveryAddress(Map<String, String> apiData) {
		JSONObject payload = CWApiActions.generateCreateCartPayloadWithoutAddress(apiData);
		response = CWApiActions.createCWCart(payload.toString(), 400);
	}

	@When("^I hit API to create WFS Cart with same registration key$")
	public static void addCWCartForSameRegKey(Map<String, String> apiData) {
		JSONObject payload = CWApiActions.generateCreateCartPayloadWithSameRegKey(apiData);
		response = CWApiActions.createCWCartDuplicateRegKey(payload.toString(), 400);
	}

	@Then("I hit api to get cart response")
	public static void getCartDetails() {
		response = CWApiActions.getACart(uid, cartId, 200);
	}

	@Then("cart response for same key")
	public static void getCartDetailsForSameKey() {
		response = CWApiActions.getACart(uid, cartId, 400);
	}

	@Then("I get taxValue from response")
	public static void getTaxDetails() {
		response = CWApiActions.getACart(uid, cartId, 200);
		String taxValue = CWApiActions.getTaxValueDetilsFromResponse(response);
		PropFileHandler.writeProperty("taxValue", taxValue);
	}

	@Then("I compare old cart taxValue to new cart taxValue")
	public static void compareTaxDetails() {
		response = CWApiActions.getACart(uid, cartId, 200);
		String newCartTaxValue = CWApiActions.getTaxValueDetilsFromResponse(response);
		String oldCartTaxValue = PropFileHandler.readProperty("taxValue");

		Assert.assertNotEquals(newCartTaxValue, oldCartTaxValue,
				"**[ASSERT FAILED]: Actual response value matches with expected value");
		String logmsg = "**[ASSERT PASSED]: newCartTaxValue value: [" + newCartTaxValue
				+ "], does not matches with oldCartTaxValue [" + oldCartTaxValue + "] value";
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;
	}

	@Then("I verify Tax is Not calculated For Non Taxable state")
	public static void verifyTaxNotCalculation() {
		response = CWApiActions.getACart(uid, cartId, 200);
		String taxValue = CWApiActions.getTaxValueDetilsFromResponse(response);

		Assert.assertTrue(taxValue.equalsIgnoreCase("0.0"), "**[ASSERT FAILED]: Tax Amount  is not as expected");
		String logmsg = "**[ASSERT PASSED]: Tax Amount  is as expected : " + taxValue;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\nTax Amount: " + taxValue + "\n" + logmsg;

	}

	@Then("I verify Tax amount For Taxable state")
	public static void verifyTaxCalculation() {
		response = CWApiActions.getACart(uid, cartId, 200);
		String taxValue = CWApiActions.getTaxValueDetilsFromResponse(response);

		Assert.assertFalse(taxValue.equalsIgnoreCase("0.0"), "**[ASSERT FAILED]: Tax Amount  is not as expected");
		logMessage("**[ASSERT PASSED]: Tax Amount  is as expected : " + taxValue);
		scenarioComment = scenarioComment + "\nTax Amount: " + taxValue;
	}
	@And("I update Shipping Address to (.*)")
	public void addDeliveryAddressToCart(String state) {
		String payload = PropFileHandler.readPayloads("deliveryAddress_" + state);
		CWApiActions.updateDeliveryAddressToCart(uid, cartId, payload, 201);

	}

	@And("I Add Billing Address to (.*)")
	public static void addBillingAddressToCart(String state) {

		if (state.equalsIgnoreCase("invalid") || state.equalsIgnoreCase("EmptyLine1")
				|| state.equalsIgnoreCase("Empty")) {
			String payload = PropFileHandler.readPayloads("deliveryAddress_" + state);
			response = CWApiActions.addBillingAddressToCart(uid, cartId, payload, 400);
		} else {
			String payload = PropFileHandler.readPayloads("deliveryAddress_" + state);
			response = CWApiActions.addBillingAddressToCart(uid, cartId, payload, 201);
		}

	}

	@Then("I Add Billing Address with invalid BaseSite id")
	public static void addBillingAddressWithInvalidBaseSiteId() {

		String payload = PropFileHandler.readPayloads("deliveryAddress_Pennsylvania");
		response = CWApiActions.addBillingAddressWithInvalidBaseSiteId(uid, cartId, payload, 400, "/cengage-b2c-wfs");
		scenarioComment = scenarioComment + "\n" + response;
	}

	@Then("I Add Billing Address with invalid cart id")
	public static void addBillingAddressWithInvalidCartId() {

		String payload = PropFileHandler.readPayloads("deliveryAddress_Pennsylvania");
		response = CWApiActions.addBillingAddressWithInvalidBaseSiteId(uid, "12345678", payload, 400,
				"/cengage-b2c-wfs-us");
		scenarioComment = scenarioComment + "\n" + response;
	}

	@Then("Place CW order and verify status code")
	public static void placeOrder() {
		response = CWApiActions.placeOrder(uid, cartId, 201);
		logMessage("Order placed with ID: " + OrderID);
		scenarioComment = scenarioComment + "\nOrder ID: " + OrderID;
	}

	@Then("I verify Error message for maximum Character")
	public void getErrorinvalidAddress() {
		CWApiActions.verifyErrormsg(response);
	}

	@Then("Place CW order Without payment details")
	public static void placewithoutPaymentDetailsOrder() {
		response = CWApiActions.placeOrder(uid, cartId, 400);
		CWApiActions.verifyPaymentErrorMessage(response);
	}

	@Then("I hit api to validate cart response")
	public void validateCartResponse() {
		cwapiActions.validateCartResponseWithJsonScema(uid, cartId);
	}

	@Then("I verify cart details with Properties")
	public void verifyCartDetails(Map<String, String> properties) {
		JsonPath responseMap = JsonPath.from(response);
		cwapiActions.varifyCartDetailsInResponse(responseMap, properties);
		cwapiActions.verifyEntriesInCart(response, properties.get("entries"));
	}

	@When("^I hit API to create WFS Cart for multiple entries$")
	public static void addCWCartWithMulEntries(Map<String, String> apiData) {

		JSONObject payload = CWApiActions.generateCreateCartPayloadWithMulEntries(apiData);
		response = CWApiActions.createCWCart(payload.toString(), 201);
		logMessage("Cart created successfully, with:\nCartID: " + cartId);
		scenarioComment = "Cart ID: " + cartId;
	}

	@When("^I hit API to create WFS Cart using CSR key in payload$")
	public static void addCWCartUsingCSRkey(Map<String, String> apiData) {

		JSONObject payload = CWApiActions.generateCreateCartPayloadWithCSRkey(apiData);
		response = CWApiActions.createCWCart(payload.toString(), 201);
		logMessage("Cart created successfully, with:\nCartID: " + cartId);
	}

	@Then("I verify (.*) entries in cart response")
	public void verifyEntriesInCart(int numbers) {
		cwapiActions.verifyEntriesInCart(response, numbers);
	}

	@Then("I verify (.*) unique Registration Keys in cart response")
	public void verifyRegistrationKeysInCart(int numbers) {
		cwapiActions.verifyRegistrationKeysInCart(response, numbers);
	}

	@Then("I create consignment")
	public void createConsignment() {
		hardWait(10);
		CWApiActions.createConsignment();
	}

	@Then("I verify Error message for duplicate registration key")
	public void getErrorDuplicateRegKey() {
		cwapiActions.verifyErrorRegKey(response);
	}

	@Then("I check for (.*) order status in response")
	public static void verifyCWOredrStatus(String status) {
		response = CWApiActions.getOrder(uid, 200);
		JsonPath responseMap = JsonPath.from(response);
		String actualStatus = responseMap.get("status");
		Assert.assertEquals(actualStatus, status,
				"Value expected for OrderId: " + OrderID + ", Status: " + status + ",Found: " + actualStatus);
		String logmsg = "**[ASSERT PASSED]:Value expected for OrderId: " + OrderID + ", Status: " + status + ", Found: "
				+ actualStatus;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;
	}

	@When("I hit API to Get All BaseStores")
	public static void getAllTheBasestore() {
		response = CWApiActions.getAllTheBasestore();

	}

	@Then("I verify all BaseStores in response")
	public void verifyBasestoreDetails(Map<String, String> properties) {
		CWApiActions.verifyBasestoreDetailsInResponse(response, properties);
	}

	@And("I verify Billing Address is (.*)")
	public static void verifybillingAddress(String state) {
		JsonPath responseMap = JsonPath.from(response);

		if (state.equalsIgnoreCase("not_Present")) {
			Assert.assertNull(responseMap.get("billingAddress"), "**[ASSERT FAILED]:Value found for billingAddress");
			logMessage("**[ASSERT PASSED]:Value Not found for billingAddress");

		} else {
			Assert.assertNotNull(responseMap.get("billingAddress"),
					"**[ASSERT FAILED]:Value not found for billingAddress");
			String logmsg = "**[ASSERT PASSED]:Value found for billingAddress";
			logMessage(logmsg);
			scenarioComment = scenarioComment + "\n" + logmsg;
		}

	}

	@And("I Update delivary Address to (.*)")
	public static void updateDelivaryAddressToCart(String state) {

		if (state.equalsIgnoreCase("invalid") || state.equalsIgnoreCase("EmptyLine1")
				|| state.equalsIgnoreCase("InvalidIsd") || state.equalsIgnoreCase("Empty")) {
			String payload = PropFileHandler.readPayloads("deliveryAddress_" + state);
			response = CWApiActions.updateDelivaryAddressToCart(uid, cartId, payload, 400);
		} else {
			String payload = PropFileHandler.readPayloads("deliveryAddress_" + state);
			response = CWApiActions.updateDelivaryAddressToCart(uid, cartId, payload, 201);
		}

	}

	@And("I verify delivary Address is set to (.*)")
	public static void verifydelivaryAddress(String state) {
		JsonPath responseMap = JsonPath.from(response);
		Assert.assertTrue(responseMap.get("deliveryAddress").toString().contains(state));
		String logmsg = "**[ASSERT PASSED] deliveryAddress is as expected";
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@Then("I hit api to validate order response")
	public void getCWOredrDetails() {
		cwapiActions.validateOrderResponse(uid, 200);

	}

	@Then("I verify required fields in order response")
	public void verifyOrderResponse() {
		JsonPath responseMap = JsonPath.from(response);
		cwapiActions.verifyOrderResponse(responseMap);
	}

	@When("^I hit API to create WFS Extension Cart$")
	public static void addCWExtensionCart(Map<String, String> apiData) {

		JSONObject payload = CWApiActions.generateExtensionCartPayload(apiData);
		response = CWApiActions.createCWCart(payload.toString(), 201);
		logMessage("Extension Cart created successfully, with:\nCartID: " + cartId);
	}

	@When("^I cancel registration before Transfer$")
	public static void cancelRegistration() {

		JSONObject payload = CWApiActions.generateCancelRegistrationPayload(uid);
		response = CWApiActions.hitCancelRegistrationApi(uid, payload.toString(), 200);
		logMessage("**[INFO]Cancelled Registration Successfully");
	}

	@When("^I hit API to create WFS Transfer Cart$")
	public static void addCWTransferCart(Map<String, String> apiData) {

		JSONObject payload = CWApiActions.generateTransferCartPayload(apiData);
		reTransferpayload = payload.toString();
		logMessage(payload.toString());

		if (apiData.get("status").equalsIgnoreCase("400")) {
			response = CWApiActions.createCWCart(payload.toString(), 400);
		} else {
			response = CWApiActions.createCWCart(payload.toString(), 201);
			logMessage("Transfer Cart created successfully, with:\nCartID: " + cartId);
			scenarioComment = scenarioComment + "Transfer CartId: " + cartId;
		}
	}

	@When("^Create transfer cart without original orderId$")
	public static void createTransferCartwithoutOriginalOrderId(Map<String, String> apiData) {
		JSONObject payload = CWApiActions.generateTransferCartPayloadWithOutOriginalOrderId(apiData);
		response = CWApiActions.createCWCart(payload.toString(), 400);

	}

	@Then("I verify consignment entry status to (.*)")
	public static void getOrderConsignmentDetails(String expectedStatus) {
		response = CWApiActions.getoriginalCommerceOrderIDDetails(uid, 200);
		JsonPath responseMap = JsonPath.from(response);
		String actualStatus = responseMap.get("entries[0].entryStatus");
		Assert.assertEquals(actualStatus, expectedStatus,
				"Value expected: " + expectedStatus + ", Found: " + actualStatus);
		String logmsg = "**[ASSERT PASSED]:Value expected: " + expectedStatus + ", Found: " + actualStatus;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@Then("I get order details")
	public static void getOrderDetails() {
		response = CWApiActions.getOrder(uid, 200);
	}

	@Then("I verify (.*) registration key in order details")
	public static void getRegistrationKeyDetails(String type) {
		response = CWApiActions.getOrder(uid, 200);
		JsonPath responseMap = JsonPath.from(response);

		if (type.equalsIgnoreCase("old and New")) {
			String actualOldKey = responseMap.get("entries[0].oldRegistrationKey");
			String actualNewKey = responseMap.get("entries[0].registrationKey");

			CWApiActions.verifyOldRegKey(actualOldKey);
			CWApiActions.verifyNewRegKey(actualNewKey);

		} else if (type.equalsIgnoreCase("New")) {
			String actualNewKey = responseMap.get("entries[0].registrationKey");
			CWApiActions.verifyNewRegKey(actualNewKey);

		} else if (type.equalsIgnoreCase("old")) {
			String actualOldKey = responseMap.get("entries[0].oldRegistrationKey");
			CWApiActions.verifyOldRegKey(actualOldKey);

		}
	}

	@Then("I verify user is unable to transfer product")
	public static void getTransferErrorMessage(Map<String, String> apiData) {
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = PropFileHandler.readProperty(apiData.get("error"));
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@Then("^I verify error in cart response With Invalid cartId$")
	public static void getInvalidCartDetails() {
		response = CWApiActions.getACart(uid, "Invalid", 400);
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = "Cart not found";
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@Then("^I verify error in cart response With Invalid order type$")
	public static void getInvalidOrderType() {
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = "Invalid Enum Value for Type: Order Type, value: Invalid";
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;
	}

	@Then("^I verify error in order response With Invalid orderId$")
	public static void getInvalidOrderDetails() {
		response = CWApiActions.getOrderDetails(uid, "invalidOrder", 400);
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = PropFileHandler.readProperty("invalidOrder");
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@Then("^I verify error in response Without consignment")
	public static void consignmentStatus() {
		JSONObject payload = CWApiActions.generateCancelRegistrationPayload(uid);
		response = CWApiActions.hitCancelRegistrationWithNoConsignmnet(uid, payload.toString(), 400);
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = "Cancellation is not possible as order is not having any consignment";
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@When("^I create WFS Cart with Invalid Basestore$")
	public static void addCWCartwithInvalidBaseStore(Map<String, String> apiData) {

		JSONObject payload = CWApiActions.generateCreateCartPayload(apiData);
		response = CWApiActions.createCWCartWithInvalidBaseStore(payload.toString());
	}

	@Then("^I verify error while creating cart$")
	public static void verifyCartCreationError(Map<String, String> apiData) {
		JsonPath responseMapGet = JsonPath.from(response);
		String actualMsg = responseMapGet.get("errors[0].message");
		String expectedMsg = PropFileHandler.readProperty(apiData.get("error"));
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);

		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@When("^I create WFS Cart with Invalid Product Code$")
	public static void addCWCartwithInvalidProductCode(Map<String, String> apiData) {

		JSONObject payload = CWApiActions.generateCreateCartPayload(apiData);
		response = CWApiActions.createCWCart(payload.toString(), 400);
	}

   	@Then("I verify product not found error")
	public static void verifyProductNotFoundError() {
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = "No result for the given query";
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;
	}

	@When("I try to place order with invalid CartID")
	public static void placeOrderWithInvalidCartId() {
		response = CWApiActions.placeOrder(uid, "Invalid", 400);

	}

	@Then("I check for error in response")
	public static void verifyErrorInOrderResponse() {
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = "Cart not found";
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@When("I place CW order with invalid BaseStrore")
	public static void placeOrderWithInvalidBasestore() {
		response = CWApiActions.placeOrderWithInvalidBaseStore(uid, cartId);

	}

	@Then("^I verify error for Invalid Basestore$")
	public static void verifyInvalidBasestoreError() {
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = "Base site cengage-b2c-wfs-us1 doesn't exist";
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@Then("I verify (.*) cart is created successfully")
	public static void verifyCartType(String cartType) {
		response = CWApiActions.getACart(uid, cartId, 200);
		CWApiActions.verifyCartTypeInResponse(response, cartType);

	}

	@Then("I hit Order history API")
	public static void getOrderHistory(Map<String, String> apiData) {
		response = CWApiActions.getOrderHistory(apiData.get("StudentUid"), apiData.get("registrationKey"),
				apiData.get("Status"));
	}

	@Then("^I verify error With Invalid (.*)$")
	public static void verifyInvalidError(String expected) {
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = PropFileHandler.readProperty(expected);
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@Then("^I verify the error for invalid ISD code$")
	public static void invalidIsdCode() {
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = "The delivery is not supported for the entered Country";
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	@Then("I verify Order details with Properties")
	public void verifyOrderDetails(Map<String, String> properties) {
		JsonPath responseMap = JsonPath.from(response);
		cwapiActions.varifyOrderDetailsInResponse(responseMap, properties);
		cwapiActions.verifyEntriesInCart(response, properties.get("entries"));
	}

	@Then("I verify Order history API response details with Properties")
	public void verifyOrderHistoryAPIDetails(Map<String, String> properties) {
		JsonPath responseMap = JsonPath.from(response);
		cwapiActions.varifyOrderHistoryDetailsInResponse(responseMap, properties);
	}

	@Then("^verify that response have all order details$")
	public static void verifyAllOrderDetails() {
		int actualOrders = CWApiActions.getActualOrders(response, "orders");
		if (actualOrders > 0) {
			String logmsg = "**[ASSERT PASSED]:Value expected : Greater than 0, Found: " + actualOrders;
			logMessage(logmsg);
			scenarioComment = scenarioComment + "\n" + logmsg;
		}
	}

	@Then("I verify (.*) same productCode in cart response")
	public void verifyProductCodeInCart(int numbers) {
		CWApiActions.verifyProductCodeInCart(response, numbers, "CONTAINER_PRODUCT");
	}

	@Then("I verify Address error for (.*)")
	public void verifyAddressErrorInCart(String address) {
		if (address.equalsIgnoreCase("Empty")) {
			CWApiActions.verifyAddressErrorInCartRespose(response, "line1", 0);
			CWApiActions.verifyAddressErrorInCartRespose(response, "line2", 1);
			CWApiActions.verifyAddressErrorInCartRespose(response, "line3", 2);
		} else if (address.equalsIgnoreCase("EmptyLine1")) {
			CWApiActions.verifyAddressErrorInCartRespose(response, "Emptyline1", 0);
		} else if (address.equalsIgnoreCase("EmptyBilling")) {
			CWApiActions.verifyAddressErrorInCartRespose(response, "line1", 0);
		}
	}

	@Then("verify Cart is not Created Without delivery Address")
	public void verifyErrorWithoutDeliveryAddress() {
		cwapiActions.verifyErrorWithoutDeliveryAddress(response, "cartWithoutDeliveryAddress");

	}

	@Then("^verify invalid delivery address error is thrown$")
	public void verifyInvalidDeliveryAddressError() {
		CWApiActions.verifyInvalidDeliveryAddressError(response, "invalidIsd");

	}

	@Then("^verify non-empty originalCommerceOrderId error is thrown$")
	public static void verifyoriginalCommerceOrderIdError() {
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = "Request should contain a valid, non-empty originalCommerceOrderId";
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;
	}

	@When("^I verify registration can not cancelled again$")
	public static void cancelRegistrationAgain() {

		JSONObject payload = CWApiActions.generateCancelRegistrationPayload(uid);
		response = CWApiActions.hitCancelRegistrationApi(uid, payload.toString(), 400);
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = "consignment entry status is not FULFILLED";
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;
	}

	@When("^Cancel consignment with invalid registration key$")
	public static void cancelRegistrationWithInvalidKey() {

		JSONObject payload = CWApiActions.generateCancelRegistrationPayload(uid, "InvalidRegkey");
		response = CWApiActions.hitCancelRegistrationApi(uid, payload.toString(), 400);
	}

	@Then("^I verify cancel consignment Error$")
	public static void verifyCancelConsignmentError() {
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = "Cancellation is not possible as all registration keys are not part of original order";
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;
	}

	@And("I get registration key")
	public static void getRegistrationKeysFromOrder() {
		response = CWApiActions.getOrder(uid, 200);
		CWApiActions.getRegKeyfromOrder(response);
	}

	@Then("I verify regKey is not changed")
	public static void verifyRegistrationKeysIsNotChanged() {
		response = CWApiActions.getOrder(uid, 200);
		CWApiActions.verifyRegKeyIsNotChanged(response);
	}

	@When("^I hit API to create new CW Cart$")
	public static void createNewCWCart(Map<String, String> apiData) {

		int statusCode = getStatusCode(apiData.get("status"));
		JSONObject payload = CWApiActions.generateCreateCartPayload(apiData);

		response = CWApiActions.createNewCWCart(apiData.get("baseSiteId"), payload.toString(), statusCode);
		if (statusCode == 201) {
			logMessage("Cart created successfully, with:\nCartID: " + cartId);
			scenarioComment = "Cart ID: " + cartId;
			userID = uid;
		}
	}

	@And("^I try to re-transfer the order$")
	public static void reTransferOrder() {
		response = CWApiActions.createCWCart(reTransferpayload, 400);

	}

	@When("^I hit API to create WFS Cart with user info$")
	public static void addCWCartWithUserInfo(Map<String, String> apiData) {

		JSONObject payload = CWApiActions.generateCreateCartPayloadWithUserInfo(apiData);
		response = CWApiActions.createCWCart(payload.toString(), 201);
	}

	@Then("I verify CW user is registered and cart is created")
	public static void verifyCustomerIsRegistered() {
		JsonPath responseMap = JsonPath.from(response);
		CWApiActions.verifyCWCustomerIsRegistered(responseMap);
		logMessage("Cart created successfully, with:\nCartID: " + cartId);
		scenarioComment = "Cart ID: " + cartId + "\nUserID: " + userID;
	}

}
