package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.ErrorsAndVerificationsActions;
import com.cengage.pageactions.OrdersAction;
import com.cengage.pageactions.UIPageActions;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.path.json.JsonPath;
import org.json.simple.JSONObject;

import java.util.Map;

@SuppressWarnings("deprecation")
public class OrdersStepDef extends BaseClass {

	public OrdersStepDef() {
		super();
	}

	OrdersAction ordersActions = new OrdersAction();
	UIPageActions uiPage = new UIPageActions();
	ErrorsAndVerificationsActions errActions = new ErrorsAndVerificationsActions();
	public static final String BASE_SITE_ID = PropFileHandler.readProperty("baseSiteId");

//	Get API

//	Post API

	@Then("User place order and verify status code")
	public static void placeOrder() {
		response = OrdersAction.placeOrder(BASE_SITE_ID, userGUID, cartId, 201);
		logMessage("Order placed with ID: " + OrderID);
	}

	@Then("I place order using Paypal")
	public void placeOrderUsingPaypal() {
		OrdersAction.placeOrderUsingPayPal(BASE_SITE_ID, userGUID, cartId, 200);
		logMessage("Order placed with ID: " + OrderID);
	}

	@Then("User place order for (.*) cart")
	public static void placeOrder(String site, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		if (site.equalsIgnoreCase("B2C"))
			response = OrdersAction.placeB2COrder(apiData.get("basestore"), userID, cartId, status);
		else if (site.equalsIgnoreCase("B2B"))
			response = OrdersAction.placeB2BOrder(apiData.get("basestore"), userID, cartId, status);

		if (status != 400)
			logMessage("Order placed with ID: " + OrderID);
	}

	@Then("User place order for (.*) cart by passing UserGuid")
	public static void placeOrderUsingUserGuid(String site, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		if (site.equalsIgnoreCase("B2C"))
			response = OrdersAction.placeB2COrder(apiData.get("basestore"), userGUID, cartId, status);
		else if (site.equalsIgnoreCase("B2B"))
			response = OrdersAction.placeB2BOrder(apiData.get("basestore"), userGUID, cartId, status);

		if (status != 400)
			logMessage("Order placed with ID: " + OrderID);
	}



	@Then("User try place (.*) order with alredy purchased cart")
	public static void placeOrderWithOldCart(String site, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		userID = PropFileHandler.readProperty(apiData.get("User"));
		cartId = apiData.get("cartId");
		if (site.equalsIgnoreCase("B2C"))
			response = OrdersAction.placeB2COrder(apiData.get("basestore"), userID, cartId, status);
		else if (site.equalsIgnoreCase("B2B"))
			response = OrdersAction.placeB2BOrder(apiData.get("basestore"), userID, cartId, status);
	}

	@SuppressWarnings("unchecked")
	@Then("Place (.*) order with special shipping Instruction")
	public static void placeB2BOrderWithShipppingInstruction(String site, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));

		JSONObject payload = new JSONObject();
		payload.put("collectNumber", apiData.get("collectNumber"));
		payload.put("deferredShipDate", apiData.get("deferredShipDate"));
		payload.put("specialShippingInstructions", apiData.get("specialShippingInstructions"));

		if (site.equalsIgnoreCase("B2C"))
			response = OrdersAction.placeB2COrderShippingInstructions(apiData.get("basestore"), userID, cartId,
					payload.toString(), status);
		else if (site.equalsIgnoreCase("B2B"))
			response = OrdersAction.placeB2BOrderShippingInstructions(apiData.get("basestore"), userID, cartId,
					payload.toString(), status);

		if (status != 400)
			logMessage("Order placed with ID: " + OrderID);
	}

	@When("User hit Cancel Api to cancel order")
	public void userCancelsTheOrder(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		OrdersAction.orderCancellationApi(apiData.get("basestore"), userID, OrderID, status);
	}
//	Put API

	@And("I want to update status of order")
	public void updateOrderStaus(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		OrdersAction.updateOrderStaus(apiData.get("basestore"), OrderID, apiData.get("ISBN"), apiData.get("orderlineStatus"), status);
	}

//	Put API

	@And("I want to update ShipmentStatus of order")
	public void updateOrderShipmentStatus(Map<String, String> apiData) {
		
		int status = getStatusCode(apiData.get("status"));
		OrdersAction.updateShipmentOrderStatus(apiData.get("basestore"), OrderID, apiData.get("ISBN"),apiData.get("orderlineStatus"),apiData.get("qtyShipped"),apiData.get("qtyCancelled"),apiData.get("qtyBackOrdered"),status);
	}

	@And("I put PO number details using API")
	public static void setPONumberToCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = OrdersAction.putPONumber(apiData.get("basestore"), userID, apiData.get("PONumber"), cartId,
				status);
		ErrorsAndVerificationsActions.verifyPaymentType(JsonPath.from(response), "ACCOUNT");
	}


//	Error and Verifications

	@And("I verify Order status is (.*)")
	public static void verifyOrderStatus(String expectedStatus) {
		response = OrdersAction.getOrder(BASE_SITE_ID, OrderID, 200);
		ErrorsAndVerificationsActions.verifyOrderStatus(JsonPath.from(response), expectedStatus);
	}

	@Then("User place order without payment details")
	public static void placeOrderWithoutPaymentDetails() {
		response = OrdersAction.placeOrder(BASE_SITE_ID, userGUID, cartId, 400);
		ErrorsAndVerificationsActions.verifyErrorMessage(JsonPath.from(response), "CC Payment is failing due to Reason Code");
	}

	@Then("User place order with Incorrect CartId")
	public static void placeOrderWithIncorrectcartId() {
		response = OrdersAction.placeOrder(BASE_SITE_ID, userGUID, "incorrect", 400);
		ErrorsAndVerificationsActions.verifyErrorMessage(JsonPath.from(response), "Cart not found.");
	}

	@When("I hit API to get delivery mode in Order")
	public static void verifyB2BDeliveryModeInOrder(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = OrdersAction.getOrder(apiData.get("basestore"), OrderID, status);
		compareResponseValue(JsonPath.from(response).get("deliveryMode.code"), apiData.get("deliveryMode"));
	}

	@Then("Verify Tax appears as (.*)")
	public void verifyTaxAmount(String amount) {
		ordersActions.verifyTaxDetails(JsonPath.from(response), amount);
	}

//	Log Test Data
	@And("Test Data for (.*) and (.*) details")
	public void logTestData(String tcId, String tdType) {
		if (tdType.equalsIgnoreCase("cart")) {
			OrdersAction.logTestDataCart(tcId);
		} else if (tdType.equalsIgnoreCase("order")) {
			OrdersAction.logTestDataOrder(tcId);
		}

	}

	@And("log the test Data for (.*) and (.*) details after user creation")
	public void logTestDataForNewUser(String tcId, String tdType) {
		if (tdType.equalsIgnoreCase("password")) {
			OrdersAction.logTestDataForUserCreation(tcId);
		}
	}

	@And("I log Test Data for (.*)")
	public void logTestData(String userType) {
		if (userType.equalsIgnoreCase("Cart")) {
			OrdersAction.logTestDataCart();
		} else if (userType.contains("CU24")) {
			OrdersAction.logTestDataForCU24(userType);
		} else {
			OrdersAction.getOrder(BASE_SITE_ID, OrderID, 200);
			if (userType.equalsIgnoreCase("subscription")) {
				OrdersAction.logTestDataForSubs();
			} else if (userType.equalsIgnoreCase("rentals")) {
				OrdersAction.logTestDataForRentals();
			} else if (userType.equalsIgnoreCase("discountedRentals")) {
				OrdersAction.logTestDataForDiscountedRentals();
			} else if (userType.equalsIgnoreCase("Normal")) {
				OrdersAction.logTestData();
			}
		}
	}

}
