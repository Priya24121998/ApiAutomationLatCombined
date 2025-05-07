package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.AddressPageActions;
import com.cengage.pageactions.CartsActions;
import com.cengage.pageactions.OrdersAction;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.path.json.JsonPath;
import org.json.simple.JSONObject;
import org.testng.Assert;

import java.util.Map;

@SuppressWarnings("deprecation")
public class AddressStepDef extends BaseClass {

	public AddressStepDef() {
		super();
	}

	AddressPageActions addressPage = new AddressPageActions();
	CartsActions cartActions = new CartsActions();
	OrdersAction ordersActions = new OrdersAction();
	public static final String BASE_SITE_ID = PropFileHandler.readProperty("baseSiteId");

	@And("Add (.*) to billing address")
	public void addTaxableBillingAddressToCart(String addType) {
		String payload = PropFileHandler.readPayloads(addType);
		AddressPageActions.addBillingAddressToCart(BASE_SITE_ID, userGUID, cartId, payload, 201);
	}

	@And("User adds (.*) to delivery address")
	public void addDeliveryAddressToCart(String addType) {
		if (addType.equalsIgnoreCase("empty")) {
			String payload = PropFileHandler.readPayloads(addType);
			AddressPageActions.addDeliveryAddressToCart(BASE_SITE_ID, userGUID, cartId, payload, 400);
		} else {
			String payload = PropFileHandler.readPayloads(addType);
			AddressPageActions.addDeliveryAddressToCart(BASE_SITE_ID, userGUID, cartId, payload, 201);
		}
	}

	@SuppressWarnings("unchecked")
	@And("User set bill to ship to account number")
	public static void addB2S2ToCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));

		JSONObject payload = new JSONObject();
		payload.put("shipToAccountNumber", apiData.get("shipToAccountNumber"));
		payload.put("billToAccountNumber", apiData.get("billToAccountNumber"));

		try {
			if (apiData.get("cartID").equalsIgnoreCase("invalid")) {
				cartId = apiData.get("cartID");
				response = AddressPageActions.addB2S2ToCart(apiData.get("basestore"), userID, cartId, payload.toString(),
						status);
			}
		} catch (NullPointerException e) {
			response = AddressPageActions.addB2S2ToCart(apiData.get("basestore"), userID, cartId, payload.toString(), status);
		}

	}

	@And("User will set specific bill to ship to account number")
	public static void addShipToBillTo(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));

		String shipToAccountNo = PropFileHandler.readProperty(tier.toUpperCase()+apiData.get("store")+"_ShipTo");
		String billToAccountNo =PropFileHandler.readProperty(tier.toUpperCase()+apiData.get("store")+"_BillTo");
		JSONObject payload = new JSONObject();
		payload.put("shipToAccountNumber", shipToAccountNo);
		payload.put("billToAccountNumber", billToAccountNo);

		try {
			if (apiData.get("cartID").equalsIgnoreCase("invalid")) {
				cartId = apiData.get("cartID");
				response = AddressPageActions.addB2S2ToCart(apiData.get("basestore"),userID, cartId, payload.toString(),
						status);
			}
		} catch (NullPointerException e) {
			response = AddressPageActions.addB2S2ToCart(apiData.get("basestore"), userID, cartId, payload.toString(), status);
		}

	}

	@And("User will call set bill to ship to Put Api in (.*) store")
	public static void billToShipTo(String store,Map<String, String> apiData) {
		storeType = apiData.get("basestore");
		int status = getStatusCode(apiData.get("status"));
		String shipToAccountNo = PropFileHandler.readProperty("ERPPhase3_"+store+"_ShipTo");
		String billToAccountNo =PropFileHandler.readProperty("ERPPhase3_"+store+"_BillTo");
		JSONObject payload = new JSONObject();
		payload.put("shipToAccountNumber", shipToAccountNo);
		payload.put("billToAccountNumber", billToAccountNo);

		try {
			if (apiData.get("cartID").equalsIgnoreCase("invalid")) {
				cartId = apiData.get("cartID");
				response = AddressPageActions.addB2S2ToCart(apiData.get("basestore"), userID, cartId, payload.toString(),
						status);
			}
		} catch (NullPointerException e) {
			response = AddressPageActions.addB2S2ToCart(apiData.get("basestore"), userID, cartId, payload.toString(), status);
		}

	}

	@Then("I get delivery modes")
	public static void getDeliveryModes() {
		response = AddressPageActions.getDeliveryModes(BASE_SITE_ID, userGUID, cartId, 200);
	}

	@When("I hit API to get all delivery modes")
	public static void getB2BDeliveryModes(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = AddressPageActions.getDeliveryModes(apiData.get("basestore"), userID, cartId, status);
	}

	@Then("User gets all delivery modes")
	public static void getDeliveryModes(Map<String, String> apiData) {
		int statusGet = getStatusCode(apiData.get("status"));
		response = AddressPageActions.getDeliveryModes(apiData.get("basestore"), userID, cartId, statusGet);
	}

	@Then("I put (.*) as shipping mode")
	public void putDeliveryModes(String mode) {
		AddressPageActions.putDeliveryModes(BASE_SITE_ID, userGUID, cartId, mode, 200);
	}

	@Then("I hit API to Set  delivery modes")
	public void setDeliveryModes(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		AddressPageActions.putDeliveryModes(apiData.get("basestore"), userID, cartId, apiData.get("code"), status);
	}

	@And("I hit API to Set 1D delivery modes")
	public void setOneDDeliveryModes(Map<String, String> apiData) {
		String code="1D";
		int status = getStatusCode(apiData.get("status"));
		AddressPageActions.putDeliveryModes(apiData.get("basestore"), userID, cartId, code, status);
	}

	@When("User puts delivery mode")
	public void putDeliveryModes(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		AddressPageActions.putDeliveryModes(apiData.get("basestore"), userID, cartId, apiData.get("mode"), status);
	}

	@When("User puts delivery mode by passing userGuid")
	public void putDeliveryModesUsingUserGuid(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		AddressPageActions.putDeliveryModes(apiData.get("basestore"), userGUID, cartId, apiData.get("mode"), status);
	}


	@Then("I verify shipping method is (.*)")
	public static void verifyShippingMethod(String method) {
		response = OrdersAction.getOrder(BASE_SITE_ID, OrderID, 200);
		String actualMethod = AddressPageActions.getShippingMethod(response);
		compareResponseValue(actualMethod, method);
	}

	@Then("I verify some delivery modes")
	public void verifyDeliveryModes(Map<String, String> apiData) {
		int size = Integer.parseInt(apiData.get("codes"));
		boolean flag = false;
		for (int i = 0; i < size; i++) {
			flag = addressPage.searchDelivaryModesInResponse(JsonPath.from(response), apiData.get("code_" + i), size);
			Assert.assertTrue(flag, "**[ASSERT FAILED]: Delivery Code is not found in response");
			logMessage("**[ASSERT PASSED]:  Delivery Code is found in response " + apiData.get("code_" + i));
		}
	}

	@And("I hit API to Set drop ship address")
	public static void setDropShip(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String payload = PropFileHandler.readPayloads(apiData.get("address"));
		try {
			if (apiData.get("cartID").equalsIgnoreCase("invalid")) {
				cartId = apiData.get("cartID");
				AddressPageActions.createDropShipAddressForCart(apiData.get("basestore"), userID, cartId, payload, status);
			}
		} catch (NullPointerException e) {
			AddressPageActions.createDropShipAddressForCart(apiData.get("basestore"), userID, cartId, payload, status);
		}
	}

	@Then("I hit API to delete delivery modes")
	public void deleteDeliveryModes(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		AddressPageActions.deleteDeliveryModes(apiData.get("basestore"), userID, cartId, status);
	}

	@When("User adds delivery address to cart")
	public void addDeliveryAddressToCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String payload = PropFileHandler.readPayloads(apiData.get("address"));
		AddressPageActions.addDeliveryAddressToCart(apiData.get("basestore"), userID, cartId, payload, status);
	}

	@When("User adds delivery address to cart by passing userGuid")
	public void addDeliveryAddressToCartUsingUserGuid(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String payload = PropFileHandler.readPayloads(apiData.get("address"));
		AddressPageActions.addDeliveryAddressToCart(apiData.get("basestore"), userGUID, cartId, payload, status);
	}

	@And("User adds billing address to cart")
	public void addBillingAddressToCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String payload = PropFileHandler.readPayloads(apiData.get("address"));
		AddressPageActions.addBillingAddressToCart(apiData.get("basestore"), userID, cartId, payload, status);
	}

	@And("User adds billing address to cart by passing userGuid")
	public void addBillingAddressToCartUsingUserGuid(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String payload = PropFileHandler.readPayloads(apiData.get("address"));
		AddressPageActions.addBillingAddressToCart(apiData.get("basestore"), userGUID, cartId, payload, status);
	}

	@When("I hit API to get delivery mode in cart")
	public static void verifyB2BDeliveryModeInCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.getACart(apiData.get("basestore"), userID, cartId, status);
		String delMode = JsonPath.from(response).get("deliveryMode.code");
		compareResponseValue(delMode, apiData.get("deliveryMode"));

	}

	@When("I hit API to get Address details")
	public static void verifyB2BCartAddress(Map<String, String> apiData) {
		response = CartsActions.getACart(apiData.get("basestore"), userID, cartId,
				getStatusCode(apiData.get("status")));
		JsonPath responseMap = JsonPath.from(response);
		String town = responseMap.get("deliveryAddress.town");
		String line1 = responseMap.get("deliveryAddress.line1");
		compareResponseValue(town, apiData.get("town"));
		compareResponseValue(line1, apiData.get("line1"));

	}

	@And("I verify delivery cost is (.*)")
	public void verifyDeliveryCostIs(String amount) {
		AddressPageActions.verifyDeliveryCostIs(response, amount);
	}

	@When("I get (.*) address id and save it")
	public void getAddressIdAndSaveIt(String addressType) {
		addressPage.getAddressIdAndSaveIt(addressType);

	}

	@And("I want to read (.*) address details")
	public static void getSpecificAddressDetails(String addressType, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String addId = PropFileHandler.readProperty(addressType + "_AddresID");
		response = AddressPageActions.getSpecificAddressFromUserAcccount(apiData.get("basestore"), userID, addId, status);

	}

	@When("I verify (.*) AddressId in Response")
	public void verifyAddressIdInResponse(String addressType) {
		String expectedAddressId = PropFileHandler.readProperty(addressType + "_AddresID");
		String actualAddressId = extractValueFromJOSNPath("id", response);
		compareResponseValue(actualAddressId, expectedAddressId);
	}
	
	@Then("I verify user is gets an error on passing other ship to,bill to account number")
	public void verifyErrorWhenPassingOtherShipToBillToAccountNumber() {
		String billToError = "Bill To Account Number is not valid";
		String shipToError = "Ship To Account Number is not valid";

		JsonPath responseMap = JsonPath.from(response);
		compareResponseValue(shipToError, responseMap.get("errors[0].message"));
		compareResponseValue(billToError, responseMap.get("errors[1].message"));

	}


	@And("I want to update (.*) address details")
	public static void updateSpecificAddressDetails(String addressType, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String addId = PropFileHandler.readProperty(addressType + "_AddresID");
		String payload = PropFileHandler.readPayloads(apiData.get("Address"));
		response = AddressPageActions.updateSpecificAddressFromUserAcccount(apiData.get("basestore"), userID, addId, payload,
				status);

	}

	@And("Try to delete (.*) address details")
	public static void deleteSpecificAddressDetails(String addressType, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String addId = PropFileHandler.readProperty(addressType + "_AddresID");
		response = AddressPageActions.deleteSpecificAddressFromUserAcccount(apiData.get("basestore"), userID, addId, status);

	}


}
