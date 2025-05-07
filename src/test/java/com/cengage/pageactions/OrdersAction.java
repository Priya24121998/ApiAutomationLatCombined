package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.testng.Assert;

public class OrdersAction extends BaseClass {

	public OrdersAction() {
		super();
	}

	/**
	 * Hit API to Place Order
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param statusCode
	 */
	public static String placeOrder(String baseSiteId, String userId, String cartId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/orders";
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage("Placing order with: " + endPoint);

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").queryParam("cartId", cartId).post(endPoint).then().assertThat()
				.statusCode(statusCode).extract().asString();

		JsonPath responseMap = JsonPath.from(response);
		OrderID = responseMap.get("code");
		PropFileHandler.writeProperty("OrderId", OrderID);

		return response;
	}

	/**
	 * Hit API to Place orders
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param statusCode
	 */
	public static String placeB2COrder(String baseSiteId, String userId, String cartId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/orders";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		logMessage("Placing order with: " + endPoint);

		response = RestAssured.given().header("Authorization", token).contentType(ContentType.JSON)
				.queryParam("cartId", cartId).queryParam("termsChecked", "true").queryParam("fields", "FULL")
				.post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		JsonPath responseMap = JsonPath.from(response);
		OrderID = responseMap.get("code");
		PropFileHandler.writeProperty("OrderId", OrderID);
		return response;

	}

	/**
	 * Hit API to place B2B Orders
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param statusCode
	 */
	public static String placeB2BOrder(String baseSiteId, String userId, String cartId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/orgUsers/" + userId + "/orders";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		logMessage("Placing order with: " + endPoint);

		response = RestAssured.given().header("Authorization", token).contentType(ContentType.JSON)
				.queryParam("cartId", cartId).queryParam("termsChecked", "true").queryParam("fields", "FULL")
				.post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();
		
		JsonPath responseMap = JsonPath.from(response);
		OrderID = responseMap.get("code");
		PropFileHandler.writeProperty("OrderId", OrderID);
		return response;
	}

	/**
	 * Hit API to place B2B Order With Special Shipping Instruction
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param payload
	 * @param statusCode
	 */
	public static String placeB2BOrderShippingInstructions(String baseSiteId, String userId, String cartId, String payload,
			int statusCode) {
		String endPoint = "/" + baseSiteId + "/orgUsers/" + userId + "/orders";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage("Placing order with: " + endPoint);

		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "FULL").queryParam("cartId", cartId).queryParam("termsChecked", "true")
				.body(payload).post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		JsonPath responseMap = JsonPath.from(response);
		OrderID = responseMap.get("code");
		PropFileHandler.writeProperty("OrderId", OrderID);
		return response;
	}

	/**
	 * Hit API to place B2C Order with Special Shipping Instructions
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param payload
	 * @param statusCode
	 */
	public static String placeB2COrderShippingInstructions(String baseSiteId, String userId, String cartId, String payload,
			int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/orders";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage("Placing order with: " + endPoint);

		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "FULL").queryParam("cartId", cartId).queryParam("termsChecked", "true")
				.body(payload).post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		JsonPath responseMap = JsonPath.from(response);
		OrderID = responseMap.get("code");
		PropFileHandler.writeProperty("OrderId", OrderID);
		return response;
	}

	/**
	 * Hit API to place order using Paypal
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param statusCode
	 */
	public static void placeOrderUsingPayPal(String baseSiteId, String userId, String cartId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/payment/hop/response";

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		logMessage("Placing order with Paypal: " + endPoint);

		response = RestAssured.given().header("Authorization", token).contentType(ContentType.JSON)
				.queryParam("token", payPalToken).post(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();

		if (statusCode != 400) {
			JsonPath responseMap = JsonPath.from(response);
			OrderID = responseMap.get("code");
			PropFileHandler.writeProperty("OrderId", OrderID);
		}

	}

	/**
	 * Hit API to place order using Paypal
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param statusCode
	 */
	public static void placeOrderUsingNewPayPal(String baseSiteId, String userID, String cartId, int statusCode,
			String payerId) {
		String endPoint = "/" + baseSiteId + "/users/" + userID + "/carts/" + cartId + "/payment/hop/response";

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		logMessage("Placing order with Paypal: " + endPoint);

		response = RestAssured.given().header("Authorization", token).contentType(ContentType.JSON)
				.queryParam("PayerID", payerId).queryParam("token", payPalToken).post(endPoint).then().assertThat()
				.statusCode(statusCode).extract().asString();

		if (statusCode != 400) {
			JsonPath responseMap = JsonPath.from(response);
			OrderID = responseMap.get("code");
			PropFileHandler.writeProperty("OrderId", OrderID);
		}

	}

	/**
	 * Hit API to get Order details using system order details API
	 * 
	 * @param baseSiteId
	 * @param orderId
	 * @param statusCode
	 * @return
	 */
	public static String getOrder(String baseSiteId, String orderId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/orders/" + orderId;
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage(">>Get Order: " + endPoint);
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "FULL").get(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		return response;
	}

	/**
	 * Hit API to get Order details using user order details API
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param orderId
	 * @param statusCode
	 * @return
	 */
	public static String getUsersOrder(String baseSiteId, String userId, String orderId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/orders/" + orderId;
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage(">>Get Order: " + endPoint);
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		
		return response;
	}

	/**
	 * Hit API to get order History Based on the user profile
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param statusCode
	 * @return
	 */
	public static String getOrderHistory(String baseSiteId, String userId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/orders";
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage(">>Get Order History: " + endPoint);
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).get(endPoint)
				.then().assertThat().statusCode(statusCode).extract().asString();
		return response;
	}

	/**
	 * Hit API to Set PO number Details in B2B cart before placing order
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param pONumber
	 * @param cartId
	 * @param statusCode
	 * @return
	 */
	public static String putPONumber(String baseSiteId, String userId, String pONumber, String cartId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/paymenttype";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage("Set PO Number to Cart API: " + endPoint);
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "FULL").queryParam("paymentType", "ACCOUNT")
				.queryParam("purchaseOrderNumber", pONumber).put(endPoint).then().assertThat().statusCode(statusCode)
				.extract().asString();
		return response;
	}

	/**
	 * Hit API to Update order status
	 * 
	 * @param baseSiteId
	 * @param orderIdGet
	 * @param status
	 * @param statusCode
	 */
	@SuppressWarnings("unchecked")
	public static void updateOrderStaus(String baseSiteId, String orderIdGet, String isbn, String status, int statusCode) {
		String endPoint = "/" + baseSiteId + "/orders/" + orderIdGet + "/statusUpdate";
		JSONObject requestParams = new JSONObject();
		JSONArray entries = new JSONArray();
		JSONObject payload = new JSONObject();

		requestParams.put("carrier", "UPSGND");
		requestParams.put("isbn", isbn);
		requestParams.put("qtyShipped", 1);
		requestParams.put("entryNumber", 1);
		requestParams.put("shippingDate", getCurrentDate());
		requestParams.put("orderLineStatus", status);
		requestParams.put("trackingId", "TestTrack123");

		entries.add(requestParams);
		payload.put("entries", entries);

		logMessage("**[INFO]Order status Update Api : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(payload)
				.when().post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		logMessage("**[INFO]Order status Update Success");
	}

	
	/**
	 * Hit API to Update order status
	 * 
	 * @param baseSiteId
	 * @param orderIdGet
	 * @param status
	 * @param statusCode
	 */
	
	@SuppressWarnings("unchecked")
	public static String updateShipmentOrderStatus(String baseSiteId, String orderIdGet, String isbn, String status,String qtyShipped, String qtyCancelled,String qtyBackOrdered, int statusCode) {
		String endPoint = "/" + baseSiteId + "/orders/" + orderIdGet + "/statusUpdate";
		JSONObject requestParams = new JSONObject();
		JSONArray entries = new JSONArray();
		JSONObject payload = new JSONObject();

		requestParams.put("carrier", "UPSGND");
		requestParams.put("isbn", isbn);
		requestParams.put("qtyShipped", String.valueOf(qtyShipped) );
		requestParams.put("qtyCancelled", String.valueOf(qtyCancelled));
		requestParams.put("qtyBackOrdered", String.valueOf(qtyBackOrdered));
		requestParams.put("entryNumber", 1);
		requestParams.put("rentalId", "");
		requestParams.put("shippingDate", getCurrentDate());
		requestParams.put("orderLineStatus", status);
		requestParams.put("trackingId", "TestTrack123");

		entries.add(requestParams);
		payload.put("entries", entries);
		logMessage("**[INFO]Order status Update Api : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
	    response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(payload)
				.when().post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();
		
	    if(statusCode==200) {
	    	logMessage("**[INFO]Order status Update Success");
	    }
	    else {
	    	String ErrorMessage = extractValueFromJOSNPath("errors[0].message", response);
	    	logMessage("**[INFO]Order status Update Error Message :"+ ErrorMessage);
	    	
	    }
	    
		return response;
	}


	/**
	 * Hit API to cancel order/ only work for digital orders
	 * 
	 * @param baseSiteId
	 * @param userID
	 * @param orderIdGet
	 * @param statusCode
	 */
	@SuppressWarnings("unchecked")
	public static void orderCancellationApi(String baseSiteId, String userID, String orderIdGet, int statusCode) {

		String endPoint = "/" + baseSiteId + "/users/" + userID + "/orders/" + orderIdGet + "/cancellation";

		JSONObject requestParams = new JSONObject();
		JSONArray cancellationRequestEntryInputsParams = new JSONArray();
		JSONObject params = new JSONObject();

		params.put("orderEntryNumber", "1");
		params.put("quantity", "1");
		cancellationRequestEntryInputsParams.add(params);
		requestParams.put("cancellationRequestEntryInputs", cancellationRequestEntryInputsParams);

		logMessage("**endPoint: " + endPoint);

		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.body(requestParams.toString()).post(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
	}

//	Log Test Data

	public static void logTestDataForSubs() {
		String subsID = extractValueFromJOSNPath("subscriptionId", response);
		PropFileHandler.writeProperty("SubID", subsID);
		subscriptionId = subsID;
		String userID = extractValueFromJOSNPath("user.emailId", response);
		String userGUID = extractValueFromJOSNPath("user.uid", response);
		String orderID = extractValueFromJOSNPath("code", response);

		scenarioComment = "UserID: " + userID + "\nGUID: " + userGUID + "\nOrderID: " + orderID + "\nSubID: " + subsID;
		logMessage("UserID: " + userID + " || GUID: " + userGUID + " || OrderID: " + orderID + " || SubID: " + subsID);
	}

	public static void logTestDataForDiscountedRentals() {

		String subsID = extractValueFromJOSNPath("subscriptionId", response);
		String userID = extractValueFromJOSNPath("user.emailId", response);
		String userGUID = extractValueFromJOSNPath("user.uid", response);
		String orderID = extractValueFromJOSNPath("code", response);
		String rentalsID = extractValueFromJOSNPath("rentalId", response);

		scenarioComment = "UserID: " + userID + "\nGUID: " + userGUID + "\nOrderID: " + orderID + "\nRentals: "
				+ rentalsID + "\nSubID: " + subsID;
		logMessage("UserID: " + userID + " || GUID: " + userGUID + " || OrderID: " + orderID + " || Rentals: "
				+ rentalsID + " || SubID: " + subsID);
	}

	public static void logTestData() {

		String userID = extractValueFromJOSNPath("user.emailId", response);
		String userGUID = extractValueFromJOSNPath("user.uid", response);
		String orderID = extractValueFromJOSNPath("code", response);

		scenarioComment = "UserID: " + userID + "\nGUID: " + userGUID + "\nOrderID: " + orderID;
		logMessage("UserID: " + userID + " || GUID: " + userGUID + " || OrderID: " + orderID);
	}

	public static void logTestDataCart(String tcId) {
		scenarioComment = "\nUserID: " + userID + "\nCartID: " + cartId;
		logMessage("Test Case ID: " + tcId + "\nUserID: " + userID + "\nCartID: " + cartId);

	}

	public static void logTestDataForUserCreation(String tcId) {
		scenarioComment = "\nUsername: " + userID + "\nPassword: " + password;
		logMessage("Test Case ID: " + tcId + "\nUserID: " + userID + "\nPassword: " + password);

	}


	public static void logTestDataOrder(String tcId) {
		scenarioComment = "\nUserID: " + userID + "\nOrderID: " + OrderID;
		logMessage("Test Case ID: " + tcId + "\nUserID: " + userID + "\nOrderID: " + OrderID);

	}

	public static void logTestDataCart() {
		scenarioComment = "UserID: " + userID + "\nGUID: " + userGUID + "\nCartID: " + cartId;
		logMessage("UserID: " + userID + " || GUID: " + userGUID + " || CartID: " + cartId);

	}

	public static void logTestDataForRentals() {

		String userID = extractValueFromJOSNPath("user.emailId", response);
		String userGUID = extractValueFromJOSNPath("user.uid", response);
		String orderID = extractValueFromJOSNPath("code", response);
		String rentalsID = extractValueFromJOSNPath("rentalId", response);

		scenarioComment = "UserID: " + userID + "\nGUID: " + userGUID + "\nOrderID: " + orderID + "\nRentals: "
				+ rentalsID;
		logMessage("UserID: " + userID + " || GUID: " + userGUID + " || OrderID: " + orderID + " || Rentals: "
				+ rentalsID);
	}

	public static void logTestDataForCU24(String userType) {
		if (userType.contains("Pending")) {
			scenarioComment = "UserID: " + userID + "\nGUID: " + userGUID + "\nSubID: " + subscriptionId
					+ "\nPending SubID:: " + penSub;
			logMessage("UserID: " + userID + " || GUID: " + userGUID + " || SubID: " + subscriptionId
					+ " || Pending SubID: " + penSub);
		} else {
			scenarioComment = "UserID: " + userID + "\nGUID: " + userGUID + "\nSubID: " + subscriptionId;
			logMessage("UserID: " + userID + " || GUID: " + userGUID + " || SubID: " + subscriptionId);
		}

	}

//	Others

	public void verifyTaxDetails(JsonPath responseMap, String amount) {
		String taxAmount = Float.toString(responseMap.get("totalTax.value"));
		logMessage("**[Info] Tax Amount : " + taxAmount);
		Assert.assertTrue(taxAmount.equalsIgnoreCase(amount), "**[ASSERT FAILED]: Tax Amount  is not as expected");
		logMessage("**[ASSERT PASSED]: Tax Amount  is as expected : " + taxAmount);
	}

}
