package com.cengage.restActions;

import java.io.FileInputStream;
import java.io.FilterInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.util.Assert;

import com.cengage.common.BrowserUtils;
import com.cengage.common.PropFileHandler;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.path.xml.XmlPath;
import io.restassured.response.Response;

public class OrderWorkflowB2C extends OrderWorkFlow {

	public static String scenarioComment;
	public static String subscriptionId, penSub;
	public static FileInputStream fileInputStream;
	static Map<String, String> userInfo = new HashMap<>();
	public static String tier = PropFileHandler.tier;

	public static String addProductToCartUsingPayload(String baseSiteId, String userId, String cartId, String payload,
			int status) {
		String endpoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/entries";
		logMessage("**[INFO] Add Product to cart API: " + endpoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).post(endpoint).then().assertThat().statusCode(status)
				.extract().asString();
		logMessage(response);
		return response;
	}

	public static String placeB2COrder(String baseSiteId, String userId, String cartId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/orders";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		logMessage("Placing order with: " + endPoint);

		logMessage("token: " + token);
		response = RestAssured.given().header("Authorization", token).contentType(ContentType.JSON)
				.queryParam("cartId", cartId).queryParam("termsChecked", "true").queryParam("fields", "FULL")
				.post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		logMessage(response);
		JsonPath responseMap = JsonPath.from(response);
		OrderID = responseMap.get("code");
		PropFileHandler.writeProperty("OrderId", OrderID);
		return response;

	}

	public static void addDeliveryAddressToCart(String baseSiteId, String userId, String cartId, String payload,
			int statusCode) {

		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/addresses/delivery";
		logMessage("Add Delivery Address To Cart API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(statusCode)
				.extract().asString();

		responseMap = JsonPath.from(response);
		logMessage("Delivery Address added to cartId: " + cartId);

	}

	public static void addBillingAddressToCart(String baseSiteId, String userId, String cartId, String payload,
			int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/addresses/billing";
		logMessage("Add Billing Address To Cart API :" + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(statusCode)
				.extract().asString();

		responseMap = JsonPath.from(response);
		logMessage("Billing Address added to cartId: " + cartId);
	}

	public static String getDeliveryModes(String baseSiteId, String userId, String cartId, int status) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/deliverymodes";
		logMessage("Get All Delivery Mode API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").get(endPoint).then().assertThat().statusCode(status).extract().asString();

		if (status == 200) {
			responseMap = JsonPath.from(response);
			logMessage("Delivery Modes For Cart id : " + cartId);
			logAllDeliveryModes();
		}
		return response;
	}

	public static void logAllDeliveryModes() {
		JSONArray deliveryModes = BaseClass.extractJsonArrayFromResponse(response, "deliveryModes");
		for (int i = 0; i < deliveryModes.size(); i++) {
			JSONObject mode = (JSONObject) deliveryModes.get(i);
			logMessage(mode.get("code").toString());
		}
	}

	public static String getApplicationPathPaypal(String baseSiteId, String userId, String cartId, int statusCode) {

		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/payment/hop/request";
		String token = setAuthorizationHeader();
		logMessage("token : " + token);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage(">>Get Paypal Path: " + endPoint);
		try {
			response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
					.queryParam("fields", "DEFAULT").queryParam("paymentMethod", "PAYPAL").get(endPoint).then()
					.assertThat().statusCode(statusCode).extract().asString();
			logMessage("response : " + response);
		} catch (Exception e) {
			logMessage("response : " + response);
		}
		JsonPath responseMap = JsonPath.from(response);
		if (statusCode != 400)
			return responseMap.get("paymentProviderUrl");

		else
			return response;
	}

	public static void getPayPalToken(String appPath) {
		String[] parts = appPath.split("=");
		payPalToken = parts[1];
		logMessage("Token: " + payPalToken);

	}

	public static void getPayPalTokenNew(String appPath) {
		String[] parts = appPath.split("=");
		payPalToken = parts[2];

		logMessage("token: " + payPalToken);
	}

	public static void verifyPayPalPortalHasLaunched() {
		BrowserUtils.waitTOSync();
		BrowserUtils.waitTOSync();
		BrowserUtils.hardWait(7);
		if (PropFileHandler.tier.equalsIgnoreCase("Prod")) {
			Assert.isTrue(BrowserUtils.getCurrentURL().contains("paypal"),
					"**[ASSERT FAILED]: Paypal portal has not launched");
			logMessage("**[ASSERT PASSED]: Paypal portal has launched successfully");
		} else {
			Assert.isTrue(BrowserUtils.getCurrentURL().contains("sandbox"),
					"**[ASSERT FAILED]: Paypal portal has not launched");
			logMessage("**[ASSERT PASSED]: Paypal portal has launched successfully");
		}

	}

	public static void placeOrderUsingNewPayPal(String baseSiteId, String userID, String cartId, int statusCode,
			String payerId) {
		String endPoint = "/" + baseSiteId + "/users/" + userID + "/carts/" + cartId + "/payment/hop/response";

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		System.out.println("Placing order with Paypal: " + endPoint);

		response = RestAssured.given().header("Authorization", token).contentType(ContentType.JSON)
				.queryParam("PayerID", payerId).queryParam("token", payPalToken).post(endPoint).then().assertThat()
				.statusCode(statusCode).extract().asString();

		if (statusCode != 400) {
			JsonPath responseMap = JsonPath.from(response);
			OrderID = responseMap.get("code");
			PropFileHandler.writeProperty("OrderId", OrderID);
		}

	}

	public static void createSubscriptionApi(String sku, String guid, int statusCode, String startDate, int duration) {
		logMessage("Creating subscription for SKU: " + sku);
		String timeStamp = getCurrentTimestamp();
		String endpoint = PropFileHandler.readProperty("createSubscription");
		JSONObject requestParams = new JSONObject();

		requestParams.put("customerGUID", guid);
		requestParams.put("paymentSourceId", timeStamp);
		requestParams.put("paymentSourceType", timeStamp);
		requestParams.put("planExternalSKU", sku);

		if (startDate == null && duration != 0)
			requestParams.put("subscriptionDuration", duration);
		else if (startDate != null && duration == 0)
			requestParams.put("startDate", startDate);
		else if (startDate != null && duration != 0) {
			requestParams.put("subscriptionDuration", duration);
			requestParams.put("startDate", startDate);
		}

		String token = setAuthorizationHeader();
		RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(requestParams).when()
				.post(endpoint).then().assertThat().statusCode(statusCode).extract().response();

	}

	public static String getSubscriptionStateDetailsForContractWithCustomerGUID(String guid, int statusCode) {
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		Response responseGet = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("customerGUID", guid).queryParam("fields", "DEFAULT")
				.get("/cengage-b2c-us/subscriptions/state").then().assertThat().statusCode(statusCode).extract()
				.response();

		return responseGet.asString();
	}

	public static String getSubscriptioDetailsForGivenCustomerGUID(String customerguid, int statusCode) {
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		Response responseOut = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("customerGUID", customerguid).queryParam("fields", "DEFAULT")
				.get("cengage-b2c-us/subscriptions").then().assertThat().statusCode(statusCode).extract().response();

		return responseOut.asString();

	}

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

	public static Map<String, String> emailAndPassOfReturninguserForOktaBySoapApi(String type) throws IOException {
		boolean useLetters = true;
		boolean useNumbers = true;
		String generatedString = RandomStringUtils.random(6, useLetters, useNumbers);
		String firstName = getCurrentTimestamp();
		String email = type + "_" + tier + "_" + firstName + "_" + generatedString + "@mailinator.com";

		String generatedToken = generateTokenUsingSOAP(PropFileHandler.readProperty("tokenGenerateSoapAPI"));
		return callInternationalStudentCreationServiceBySoap(generatedToken, email, "B2CUS");
	}

	public static Map<String, String> callInternationalStudentCreationServiceBySoap(String tokeni, String email,
			String Store) {
		String country;
		String institutionId;
		String region;
		String password;
		country = System.getProperty("country");
		if (country == null || country.isEmpty()) {
			country = PropFileHandler.readProperty(Store + "_country");
		}
		institutionId = System.getProperty("institutionId");
		if (institutionId == null || institutionId.isEmpty()) {
			institutionId = PropFileHandler.readProperty(Store + "_institutionId");
		}
		region = System.getProperty("region");
		if (region == null || region.isEmpty()) {
			region = PropFileHandler.readProperty(Store + "_region");
		}
		password = System.getProperty("password");
		if (password == null || password.isEmpty()) {
			password = "Aa111111";
		}

		String token1 = tokeni;
		RestAssured.baseURI = PropFileHandler.readProperty("soapUserCreationAPI");

		String xmldata = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
				+ "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ssow=\"http://ws.thomsonlearning.com:80/ssows\" xmlns:java=\"java:com.tl.ssows.parameters\" xmlns:java1=\"java:com.tl.ssows\" xmlns:java2=\"java:language_builtins.lang\">"
				+ "<soapenv:Header/>" + "<soapenv:Body>" + "<ssow:addUser>" + "<java:person>" + "<java1:c>" + country
				+ "</java1:c>" + "<java1:givenName>Student</java1:givenName>" + "<java1:sn>QAL</java1:sn>"
				+ "<java1:TLRegion>" + region + "</java1:TLRegion>" + "<java1:TLSchoolAffiliation>" + institutionId
				+ "</java1:TLSchoolAffiliation>" + "<java1:uid>" + email + "</java1:uid>" + "<java1:userPassword>"
				+ password + "</java1:userPassword>" + "<java1:userType>student</java1:userType>" + "</java:person>"
				+ "<java:token>" + token1 + "</java:token>" + "</ssow:addUser>" + "</soapenv:Body>"
				+ "</soapenv:Envelope>";
		String response = RestAssured.given().header("Content-Type", "text/xml;charset=utf-8").and().body(xmldata)
				.when().post().then().statusCode(200).and().extract().asString();

		XmlPath responseMap = XmlPath.from(response);
		String str = responseMap.getString("ns2:guid");
		String[] parts = str.split("Success");
		String temp = parts[0];
		String guid = "";
		for (int i = 1; i < temp.length() - 1; i++)
			guid = guid + temp.charAt(i);
		logMessage("User: " + email);
		logMessage("Password: " + password);
		logMessage("GUID: " + guid);
		userInfo.put("email", email);
		userInfo.put("guid", guid);
		return userInfo;
	}

	public static String generateTokenUsingSOAP(String token_uri) throws IOException {
		if (tier.equalsIgnoreCase("prod")) {
			fileInputStream = new FileInputStream("src/test/resources/TestData/ProdTokenGenerateAPI.xml");
		} else {
			fileInputStream = new FileInputStream("src/test/resources/TestData/TokenGenerateAPI.xml");
		}
		RestAssured.baseURI = token_uri;
		Response response = RestAssured.given().header("Content-Type", "text/xml").and()
				.body(IOUtils.toString(fileInputStream, "UTF-8")).when().post().then().statusCode(200).and().extract()
				.response();

		XmlPath xmlpath = new XmlPath(response.asString());
		String token = xmlpath.getString("ns3:token");
		String[] arr = token.split("Success");
		String tokenid = arr[1];
		return tokenid;
	}

	public static String registerACustomer(String baseSiteId, String payload, int Status) {
		String endPoint = "/" + baseSiteId + "/users";
		logMessage("**[INFO] Register Customer Using API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(Status)
				.extract().asString();
		return response;
	}
	


	public static String customerPayload(String email, String fName, String lName, String store) {
		userID = getemail(email, store);
		String entityNumber = PropFileHandler.readProperty(store + "_institutionId");
		String entityName = PropFileHandler.readProperty(store + "_entityName");
		JSONObject requestBody = new JSONObject();
		requestBody.put("uid", userID);
		requestBody.put("firstName", fName);
		requestBody.put("lastName", lName);
		requestBody.put("password", "Aa111111");
		requestBody.put("email", userID);
		requestBody.put("entityNumber", entityNumber);
		requestBody.put("entityName", entityName);

		return requestBody.toString();
	}

	public static String getemail(String email, String store) {
		String newEmail;
		boolean useLetters = true;
		boolean useNumbers = true;
		String generatedString = RandomStringUtils.random(6, useLetters, useNumbers);
		if (email.contains("@")) {
			String emailArr[] = email.split("@");
			newEmail = emailArr[0] + "_" + generatedString + "_"+getCurrentTimestamp() + "@" + emailArr[1];
		} else {
			newEmail = store + "_" + tier + "_" + email + "_" +generatedString+ "_" + getCurrentTimestamp() + "@mailinator.com";
		}
		return newEmail;
	}
	
	public static String returnListOfRentalThatContainingRentalInformation(String guid, int statusCode) {
		RestAssured.baseURI = PropFileHandler.readProperty("listOfRentals");
		String token = setAuthorizationHeader();
		Response response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").get(guid + "/rentals").then().assertThat().statusCode(statusCode)
				.extract().response();

		return  response.body().asString();
	}

	public static void updateStausOfRentalOrder(String baseSiteId, String orderIdGet, String rentalID, int statusCode) {
		String endPoint = "/" + baseSiteId + "/orders/" + orderIdGet + "/statusUpdate";
		JSONObject requestParams = new JSONObject();
		JSONArray entries = new JSONArray();
		JSONObject payload = new JSONObject();

		requestParams.put("carrier", "UPSGND");
		requestParams.put("isbn", "isbn");
		requestParams.put("qtyShipped", 1);
		requestParams.put("entryNumber", 1);
		requestParams.put("rentalId", rentalID);
		requestParams.put("shippingDate", BaseClass.getCurrentDate());
		requestParams.put("orderLineStatus", "SHIPPED");
		requestParams.put("trackingId", "TestTrack123");

		entries.add(requestParams);
		payload.put("entries", entries);

		logMessage("**[INFO]Rental Staus Update Api : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(payload)
				.when().post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();
		logMessage("payload"+ payload);
		logMessage("**[INFO]Rental Staus Update Success");
	}
	
	public static void extendRental(String baseSiteId, String userId, String cartId, String rentalId, String days) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/rentals/" + rentalId
				+ "/extend";

		logMessage("**[INFO]Rental Extension Api : " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("duration", days).queryParam("fields", "DEFAULT").post(endPoint).then().assertThat()
				.statusCode(200).extract().asString();
		logMessage("Rental Extension Added to Cart for Days : " + days);

	}

	public static void returnOfTextbookAndModifyRentalStateAccordingly(String rentalID, String returnState, int statusCode) {
		String endpoint = PropFileHandler.readProperty("base_URI");
		endpoint = endpoint + "/cengage-b2c-us/rentals/" + rentalID + "/returnNotification";
		logMessage(endpoint);
		JSONObject requestParams = new JSONObject();
		String token = setAuthorizationHeader();
		
		requestParams.put("isbn", "isbn");
		requestParams.put("notes", "Returning rental");
		requestParams.put("returnDate", getCurrentDate());
		requestParams.put("returnState", returnState);
		requestParams.put("trackingId", "trackingId_"+ getCurrentTimestamp());
		requestParams.put("carrier", "carrier_"+getCurrentTimestamp());

		RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(requestParams).when()
				.queryParam("rentalId", rentalID).post(endpoint).then().assertThat().statusCode(statusCode).extract()
				.response();
	}

	public static void rentalBuyout(String baseSiteId, String userId, String cartId, String rentalId) {

		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/rentals/" + rentalId
				+ "/purchase";

		logMessage("**[INFO]Rental Buyout Api : " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").post(endPoint).then().assertThat().statusCode(200).extract()
				.asString();

		logMessage("Rental Buyout Added to Cart For CartId : " + cartId);

	}
	
	
}
