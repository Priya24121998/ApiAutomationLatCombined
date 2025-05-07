package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.module.jsv.JsonSchemaValidator;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.testng.Assert;

import java.io.File;
import java.util.Map;

public class CWApiActions extends BaseClass {

	public CWApiActions() {
		super();
	}

	static JsonPath responseObj;
	static JSONParser jsonprs = new JSONParser();
	static String originalCommerceOrderID;
	static String oldRegKey;
	String uid;
	static String response;
	static int regKeyCount = 0;
	static String regKey;
	GetApiActions getApi = new GetApiActions();

	static JsonPath responseMap;

	public static String getCWToken() {

		String endpoint = PropFileHandler.readProperty("authorization");
		String clientID = PropFileHandler.readProperty("CWclientId");
		String secretID = PropFileHandler.readProperty("CWsecretId");

		String response = RestAssured.given().auth().preemptive().basic(clientID, secretID)
				.header("Content-Type", "application/x-www-form-urlencoded")
				.formParam("grant_type", "client_credentials").when().post(endpoint).then().assertThat().statusCode(200)
				.extract().asString();

		responseObj = JsonPath.from(response);

		String accessToken = responseObj.get("access_token");
		String tokenType = responseObj.get("token_type");
		tokenType = tokenType.substring(0, 1).toUpperCase() + tokenType.substring(1).toLowerCase();
	

		return tokenType + " " + accessToken;
	}

	public static String createCWCart(String payload, int statusCode) {
		String endPoint = "/cengage-b2c-wfs-us/carts";
		logMessage("**[INFO] Create Cart API : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		String response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload).post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		responseMap = JsonPath.from(response);
		cartId = responseMap.get("code");
		return response;
	}

	public static String createNewCWCart(String basesiteId, String payload, int statusCode) {
		String endPoint = "/" + basesiteId + "/carts";
		logMessage("**[INFO] Create Cart API : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload).post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		JsonPath responseMapGet = JsonPath.from(response);
		cartId = responseMapGet.get("code");
		return response;
	}

	public static String createCWCartDuplicateRegKey(String payload, int statusCode) {
		String endPoint = "/cengage-b2c-wfs-us/carts";
		logMessage("**[INFO] Create Cart API : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload).post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		responseMap = JsonPath.from(response);
		return response;
	}

	public static String getACart(String userId, String cartId, int statusCode) {
		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/carts/" + cartId;
		logMessage("**Get Cart API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		responseMap = JsonPath.from(response);
		return response;

	}

	public static String getCartDetals(String userId, int statusCode) {

		String endPointGet = "/cengage-b2c-wfs-us/users/" + userId + "/carts/" + cartId;
		logMessage("**Get Cart API: " + endPointGet);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").get(endPointGet).then().assertThat().statusCode(statusCode).extract()
				.asString();
		responseMap = JsonPath.from(response);
		return response;

	}

	public static String getOrderDetails(String userId, String invalidOrder, int statusCode) {
		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/orders/" + invalidOrder;
		logMessage("**Get Order API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();

		responseMap = JsonPath.from(response);
		return response;

	}

	public static String getACartFor(String userId, String cartId, int statusCode) {
		String endPointGet = "/cengage-b2c-wfs-us/users/" + userId + "/carts/" + cartId;
		logMessage("**Get Cart API Response: " + endPointGet);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").get(endPointGet).then().assertThat().statusCode(statusCode).extract()
				.asString();
		responseMap = JsonPath.from(response);
		return response;

	}

	public static JSONObject getStudentPayload() {
		String payload = PropFileHandler.readPayloads("student");
		JSONObject obj = new JSONObject();
		try {
			obj = (JSONObject) jsonprs.parse(payload);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject getStudentPayload(String email, String fName, String lName) {
		JSONObject requestParams = new JSONObject();
		userID = GetApiActions.getemail(email, "CW");

		requestParams.put("uid", userID);
		if (fName.equalsIgnoreCase("read") && lName.equalsIgnoreCase("read")) {
			requestParams.put("firstName", GetApiActions.getName("fName"));
			requestParams.put("lastName", GetApiActions.getName("lName"));
		} else {
			requestParams.put("firstName", fName);
			requestParams.put("lastName", lName);
		}
		requestParams.put("email", userID);

		return requestParams;
	}

	public static JSONObject getdeliveryAddressPayload(String addressType) {
		String payload = PropFileHandler.readPayloads("deliveryAddress_" + addressType);
		JSONObject obj = new JSONObject();
		try {
			obj = (JSONObject) jsonprs.parse(payload);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject returnStudentUpfrontPaymentPortion(String value) {
		JSONObject requestParams = new JSONObject();
		requestParams.put("currencyIso", "USD");
		requestParams.put("value", value);
		return requestParams;
	}

	public static String getContainerPayload(String value) {
		
		return PropFileHandler.readPayloads(value);
	}

	public static  String getuniqueRegistrationkey() {
		regKeyCount++;
		regKey = "regKey_" + getCurrentTimestamp() + regKeyCount;
		PropFileHandler.writeProperty("regKey", regKey);
		return regKey;
	}

	public String getsameRegistrationkey() {
		logMessage("duplicate reg key :-" + regKey);
		return regKey;
	}

	public static String getuniqueCSRkey() {
	
		return "csrKey_" + getCurrentTimestamp();
	}

	@SuppressWarnings("unchecked")
	public static JSONArray createSingleEntry(Map<String, String> apiData) {

		JSONArray orderEntries = new JSONArray();
		JSONObject requestParams = new JSONObject();

		requestParams = createEntriyForCart(apiData.get("taxToBePaidUpfront"), apiData.get("payerModel"),
				apiData.get("paymentFrequency"), apiData.get("paymentMethod"), apiData.get("productCode"));
		orderEntries.add(requestParams);
		return orderEntries;

	}

	@SuppressWarnings("unchecked")
	public static JSONArray createSingleEntryForSameRegKey(Map<String, String> apiData) {

		JSONArray orderEntries = new JSONArray();
		JSONObject requestParams = new JSONObject();

		requestParams = createEntriyForCarWithSameRegKey(apiData.get("taxToBePaidUpfront"), apiData.get("payerModel"),
				apiData.get("paymentFrequency"), apiData.get("paymentMethod"));
		orderEntries.add(requestParams);
		return orderEntries;

	}

	@SuppressWarnings("unchecked")
	public static JSONArray createMultipleEntries(Map<String, String> apiData) {

		JSONArray orderEntries = new JSONArray();
		JSONObject requestParams = new JSONObject();
		int count = Integer.parseInt(apiData.get("entries"));

		for (int i = 0; i < count; i++) {

			requestParams = createEntriyForCart(apiData.get("taxToBePaidUpfront_" + i), apiData.get("payerModel_" + i),
					apiData.get("paymentFrequency_" + i), apiData.get("paymentMethod_" + i),
					apiData.get("productCode"));
			orderEntries.add(requestParams);
		}
		return orderEntries;

	}

	@SuppressWarnings("unchecked")
	public static JSONObject createEntriyForCart(String taxToBePaidUpfront, String payerModel, String paymentFrequency,
			String paymentMethod, String productCode) {

		JSONObject requestParams = new JSONObject();
		JSONObject paramProduct = new JSONObject();
		JSONObject paramPricePaid = new JSONObject();
		JSONObject taxablePortion = new JSONObject();

		paramPricePaid.put("currencyIso", "USD");
		paramPricePaid.put("value", "600");

		taxablePortion.put("currencyIso", "USD");
		taxablePortion.put("value", "600");

		paramProduct.put("code", productCode);

		requestParams.put("registrationKey", getuniqueRegistrationkey());
		requestParams.put("quantity", "1");
		requestParams.put("productMediaCode", "PMC001");
		requestParams.put("digital", "true");
		requestParams.put("taxToBePaidUpfront", taxToBePaidUpfront);
		requestParams.put("payerModel", payerModel);
		requestParams.put("paymentFrequency", paymentFrequency);
		requestParams.put("provisionActionRequest", "P");
		requestParams.put("paymentMethod", paymentMethod);
		requestParams.put("taxablePortion", taxablePortion);
		requestParams.put("product", paramProduct);
		requestParams.put("pricePaid", paramPricePaid);
		requestParams.put("containerItem", getContainerPayload("containerItem"));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject createEntriyForCarWithSameRegKey(String taxToBePaidUpfront, String payerModel,
			String paymentFrequency, String paymentMethod) {

		JSONObject requestParams = new JSONObject();
		JSONObject paramProduct = new JSONObject();
		JSONObject paramPricePaid = new JSONObject();
		JSONObject taxablePortion = new JSONObject();

		paramPricePaid.put("currencyIso", "USD");
		paramPricePaid.put("value", "600");

		taxablePortion.put("currencyIso", "USD");
		taxablePortion.put("value", "600");

		paramProduct.put("code", "CONTAINER_PRODUCT");

		requestParams.put("registrationKey", regKey);
		requestParams.put("quantity", "1");
		requestParams.put("productMediaCode", "PMC001");
		requestParams.put("digital", "true");
		requestParams.put("taxToBePaidUpfront", taxToBePaidUpfront);
		requestParams.put("payerModel", payerModel);
		requestParams.put("paymentFrequency", paymentFrequency);
		requestParams.put("provisionActionRequest", "P");
		requestParams.put("paymentMethod", paymentMethod);
		requestParams.put("taxablePortion", taxablePortion);
		requestParams.put("product", paramProduct);
		requestParams.put("pricePaid", paramPricePaid);
		requestParams.put("containerItem", getContainerPayload("containerItem"));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateCreateCartPayload(Map<String, String> apiData) {

		JSONObject requestParams = new JSONObject();

		requestParams.put("student", getStudentPayload());
		requestParams.put("deliveryAddress", getdeliveryAddressPayload(apiData.get("addressType")));
		requestParams.put("orderType", apiData.get("orderType"));
		requestParams.put("studentUpfrontPaymentPortion",
				returnStudentUpfrontPaymentPortion(apiData.get("studentUpfrontPaymentPortion")));
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));
		requestParams.put("entries", createSingleEntry(apiData));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateCreateCartPayloadWithUserInfo(Map<String, String> apiData) {

		JSONObject requestParams = new JSONObject();

		requestParams.put("student",
				getStudentPayload(apiData.get("email"), apiData.get("fName"), apiData.get("lName")));
		requestParams.put("deliveryAddress", getdeliveryAddressPayload(apiData.get("addressType")));
		requestParams.put("orderType", apiData.get("orderType"));
		requestParams.put("studentUpfrontPaymentPortion",
				returnStudentUpfrontPaymentPortion(apiData.get("studentUpfrontPaymentPortion")));
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));
		requestParams.put("entries", createSingleEntry(apiData));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateCreateCartPayloadWithoutAddress(Map<String, String> apiData) {

		JSONObject requestParams = new JSONObject();

		requestParams.put("student", getStudentPayload());
		requestParams.put("orderType", apiData.get("orderType"));
		requestParams.put("studentUpfrontPaymentPortion",
				returnStudentUpfrontPaymentPortion(apiData.get("studentUpfrontPaymentPortion")));
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));
		requestParams.put("entries", createSingleEntry(apiData));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateCreateCartPayloadWithSameRegKey(Map<String, String> apiData) {

		JSONObject requestParams = new JSONObject();

		requestParams.put("student", getStudentPayload());
		requestParams.put("deliveryAddress", getdeliveryAddressPayload(apiData.get("addressType")));
		requestParams.put("orderType", apiData.get("orderType"));
		requestParams.put("studentUpfrontPaymentPortion",
				returnStudentUpfrontPaymentPortion(apiData.get("studentUpfrontPaymentPortion")));
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));
		requestParams.put("entries", createSingleEntryForSameRegKey(apiData));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateCreateCartPayloadWithMulEntries(Map<String, String> apiData) {

		JSONObject requestParams = new JSONObject();

		requestParams.put("student", getStudentPayload());
		requestParams.put("deliveryAddress", getdeliveryAddressPayload(apiData.get("addressType")));
		requestParams.put("orderType", apiData.get("orderType"));
		requestParams.put("studentUpfrontPaymentPortion",
				returnStudentUpfrontPaymentPortion(apiData.get("studentUpfrontPaymentPortion")));
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));
		requestParams.put("entries", createMultipleEntries(apiData));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateCreateCartPayloadWithCSRkey(Map<String, String> apiData) {

		JSONObject requestParams = new JSONObject();

		requestParams.put("student", getStudentPayload());
		requestParams.put("csrKey", getuniqueCSRkey());
		requestParams.put("deliveryAddress", getdeliveryAddressPayload(apiData.get("addressType")));
		requestParams.put("orderType", apiData.get("orderType"));
		requestParams.put("studentUpfrontPaymentPortion",
				returnStudentUpfrontPaymentPortion(apiData.get("studentUpfrontPaymentPortion")));
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));
		requestParams.put("entries", createSingleEntry(apiData));

		return requestParams;
	}

	public static String getTaxValueDetilsFromResponse(String response) {

		JsonPath responseMapGet = JsonPath.from(response);
		Float taxValue = responseMapGet.get("totalTax.value");
		return taxValue.toString();
	}

	public static void updateDeliveryAddressToCart(String userId, String cartId, String payload, int statusCode) {
		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/carts/" + cartId + "/addresses/delivery";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(statusCode)
				.extract().asString();

		logMessage("Delivery Address Updated to cartId: " + cartId);

	}

	public static String addBillingAddressToCart(String userId, String cartId, String payload, int statusCode) {

		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/carts/" + cartId + "/addresses/billing";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(statusCode)
				.extract().asString();

		logMessage("Billing Address Added to cartId: " + cartId);
		return response;
	}

	public static String addBillingAddressWithInvalidBaseSiteId(String userId, String cartId, String payload, int statusCode,
			String baseId) {

		String endPoint = baseId + "/users/" + userId + "/carts/" + cartId + "/addresses/billing";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(statusCode)
				.extract().asString();

		logMessage("Error Message: " + response);

		return response;
	}

	public static String invalidIsdDeliveryAddress(String userId, String cartId, String payload, int statusCode) {

		String endPoint = "/cengage-b2c-wfs-us/users/ " + userId + "/carts/" + cartId + "/addresses/delivery";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(statusCode)
				.extract().asString();

		logMessage("Error Message: " + response);

		return response;
	}

	public static String placeOrder(String userId, String cartId, int statusCode) {
		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/orders";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage("Placing order with: " + endPoint);

		String response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").queryParam("cartId", cartId).post(endPoint).then().assertThat()
				.statusCode(statusCode).extract().asString();

		JsonPath responseMap = JsonPath.from(response);
		OrderID = responseMap.get("code");

		return response;
	}

	public static void verifyErrormsg(String response) {
		JsonPath responseMap = JsonPath.from(response);
		String err = responseMap.get("errors[0].message");

		Assert.assertEquals(err, "Each address line can be of maximum size 40 ");
		String logmsg = "**[ASSERT PASSED]: Error message is as Expected : " + err;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	public static void verifyPaymentErrorMessage(String response) {
		JsonPath responseMapGet = JsonPath.from(response);
		String actualMessage = responseMapGet.get("errors[0].message");

		Assert.assertEquals(actualMessage, "CC Payment is failing due to Reason Code",
				"**[ASSERTION FAILED] Error message is::" + actualMessage);
		logMessage("**[ASSERTION PASSED] Verified error message is: " + actualMessage);

	}

	public void validateCartResponseWithJsonScema(String userId, String cartId) {
		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/carts/" + cartId;
		logMessage("**Get Cart API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
		.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat()
		.body(JsonSchemaValidator.matchesJsonSchema(new File("src/test/resources/TestData/cartSchema.json")))
		.statusCode(200);
	}

	public void varifyCartDetailsInResponse(JsonPath responseMap, Map<String, String> properties) {
		for (String property : properties.keySet()) {
			Assert.assertNotNull(responseMap.get(property),
					"**[ASSERT FAILED]:Value not found for Property " + property);
			if (!properties.get(property).contains("value")) {
				Assert.assertEquals(responseMap.get(property).toString(), properties.get(property));
				logMessage(
						"**[ASSERT PASSED]:Value found for Property " + property + " is : " + properties.get(property));
			}
		}

		Assert.assertEquals(responseMap.get("code"), cartId);
		logMessage("**[ASSERT PASSED] CartId is as expected");

		Assert.assertEquals(responseMap.get("entries[0].registrationKey"), regKey);
		logMessage("**[ASSERT PASSED] regKey is as expected");

		Assert.assertNotNull(responseMap.get("entries[0].containerItem"),
				"**[ASSERT FAILED]:Value not found for containerItem ");
		logMessage("**[ASSERT PASSED] containerItem is Not Empty");

		Assert.assertNotNull(responseMap.get("containerHeader"),
				"**[ASSERT FAILED]:Value not found for containerHeader ");
		logMessage("**[ASSERT PASSED] containerHeader is Not Empty");

		Assert.assertTrue(responseMap.get("deliveryAddress").toString().contains("Pennsylvania"));
		logMessage("**[ASSERT PASSED] deliveryAddress is as expected");

	}

	public void verifyEntriesInCart(String response, String size) {
		JSONArray entries = extractJsonArrayFromResponse(response, "entries");

		String[] parts = size.split("_");

		int actualSize = entries.size();
		int expectedSize = Integer.parseInt(parts[1]);

		Assert.assertEquals(actualSize, expectedSize);
		logMessage("**[ASSERT PASSED] entries Are as expected : " + expectedSize + " entries");

	}

	public void verifyEntriesInCart(String response, int expectedSize) {
		JSONArray entries = extractJsonArrayFromResponse(response, "entries");
		int actualSize = entries.size();
		Assert.assertEquals(actualSize, expectedSize);
		String logmsg = "**[ASSERT PASSED] entries Are as expected : " + expectedSize + " entries";
		logMessage(logmsg);

	}

	public void verifyRegistrationKeysInCart(String response, int number) {
		String regKeyGet = null;
		JsonPath responseMapGet = JsonPath.from(response);
		for (int i = 0; i < number; i++) {
			if (i > 0) {
				Assert.assertNotEquals(regKeyGet, responseMapGet.get("entries[" + i + "].registrationKey"));
			}
			regKeyGet = responseMapGet.get("entries[" + i + "].registrationKey");
		}

		String logmsg = "**[ASSERT PASSED] registrationKeys are unique ";
		logMessage(logmsg);
	}

	@SuppressWarnings("unchecked")
	public static void createConsignment() {
		String endPoint = "cengage-b2c-wfs-us/orders/" + OrderID + "/statusUpdate";
		logMessage("**[INFO] Create Consignment API : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		originalCommerceOrderID = OrderID;
		PropFileHandler.writeProperty("originalCommerceOrderID", originalCommerceOrderID);

		JSONArray entries = new JSONArray();
		JSONObject requestParams = new JSONObject();
		JSONObject payload = new JSONObject();

		requestParams.put("orderLineStatus", "SUBMITTED");
		requestParams.put("registrationKey", regKey);
		requestParams.put("brimContractItemNumber", "1234");
		requestParams.put("brimProviderContractNumber", "12345");
		entries.add(requestParams);
		payload.put("entries", entries);

		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload.toString()).post(endPoint).then().assertThat().statusCode(200).extract().asString();

		logMessage("**[INFO]Consignment Created Successfully");
	}

	@SuppressWarnings("unchecked")
	public JSONObject createCartSameRegKey(Map<String, String> apiData) {

		JSONObject requestParams = new JSONObject();

		requestParams.put("student", getStudentPayload());
		requestParams.put("deliveryAddress", getdeliveryAddressPayload(apiData.get("addressType")));
		requestParams.put("orderType", apiData.get("orderType"));
		requestParams.put("studentUpfrontPaymentPortion",
				returnStudentUpfrontPaymentPortion(apiData.get("studentUpfrontPaymentPortion")));
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));
		requestParams.put("entries", createDuplicateRegKey(apiData));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public JSONArray createDuplicateRegKey(Map<String, String> apiData) {

		JSONArray orderEntries = new JSONArray();
		JSONObject requestParams = new JSONObject();

		requestParams = createEntriyDuplicateReg(apiData.get("taxToBePaidUpfront"), apiData.get("payerModel"),
				apiData.get("paymentFrequency"), apiData.get("paymentMethod"));
		orderEntries.add(requestParams);
		return orderEntries;

	}

	@SuppressWarnings("unchecked")
	public JSONObject createEntriyDuplicateReg(String taxToBePaidUpfront, String payerModel, String paymentFrequency,
			String paymentMethod) {
		String duplicateReg = regKey;
		logMessage("duplicate:-" + duplicateReg);
		JSONObject requestParams = new JSONObject();
		JSONObject paramProduct = new JSONObject();
		JSONObject paramPricePaid = new JSONObject();
		JSONObject taxablePortion = new JSONObject();

		paramPricePaid.put("currencyIso", "USD");
		paramPricePaid.put("value", "1000");

		taxablePortion.put("currencyIso", "USD");
		taxablePortion.put("value", "900");

		paramProduct.put("code", "CONTAINER_PRODUCT");

		requestParams.put("registrationKey", duplicateReg);
		requestParams.put("quantity", "1");
		requestParams.put("productMediaCode", "PMC001");
		requestParams.put("digital", "true");
		requestParams.put("taxToBePaidUpfront", taxToBePaidUpfront);
		requestParams.put("payerModel", payerModel);
		requestParams.put("paymentFrequency", paymentFrequency);
		requestParams.put("provisionActionRequest", "P");
		requestParams.put("paymentMethod", paymentMethod);
		requestParams.put("taxablePortion", taxablePortion);
		requestParams.put("product", paramProduct);
		requestParams.put("pricePaid", paramPricePaid);
		requestParams.put("containerItem", getContainerPayload("containerItem"));

		return requestParams;
	}

	public void verifyErrorRegKey(String response) {
		JsonPath responseMapGet = JsonPath.from(response);
		String duplicatReg = responseMapGet.get("errors[0].message");
		Assert.assertTrue(duplicatReg.contains("There exists an entry with the registration key"));
		logMessage("**[ASSERT PASSED]: Error message is as Expected : " + duplicatReg);
	}

	public static String getOrder(String userId, int statusCode) {
		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/orders/" + OrderID;

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage("Calling get Order API : " + endPoint);
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "FULL").get(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();

		return response;
	}

	public static String getAllTheBasestore() {
		String endPoint = "/basesites";

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage("Calling get basesites API : " + endPoint);

		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(200).extract()
				.asString();

		return response;
	}

	public static void verifyBasestoreDetailsInResponse(String response, Map<String, String> data) {

		responseMap = JsonPath.from(response);
		int i = 0;

		for (String baseSite : data.keySet()) {
			Assert.assertEquals(responseMap.get("baseSites[" + i + "].uid"), data.get(baseSite));
			if (responseMap.get("baseSites[" + i + "].name").toString().contains(baseSite)) {
				logMessage("**[ASSERT PASSED]:Value found for baseSite " + baseSite + " is : "
						+ responseMap.get("baseSites[" + i + "].uid"));
				i++;

			}
		}
	}

	public static String updateDelivaryAddressToCart(String userId, String cartId, String payload, int statusCode) {

		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/carts/" + cartId + "/addresses/delivery";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(statusCode)
				.extract().asString();

		logMessage("Delivery Address Updated for cartId: " + cartId);

		return response;
	}

	public void validateOrderResponse(String userId, int statusCode) {
		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/orders/" + OrderID;

		logMessage("Calling get Order API : " + endPoint);

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).get(endPoint)
		.then().assertThat()
		.body(JsonSchemaValidator.matchesJsonSchema(new File("src/test/resources/TestData/orderSchema.json")))
		.statusCode(200);

		logMessage("**[ASSERT PASSED]: Response matches with JSON Schema");

	}

	public void verifyOrderResponse(JsonPath responseMap) {

		Assert.assertNotNull(responseMap.get("paymentInfo.accountHolderName"));
		logMessage("**[ASSERT PASSED]:Value found for response field accountHolderName is : "
				+ responseMap.get("paymentInfo.accountHolderName"));

		Assert.assertNotNull(responseMap.get("code"));
		logMessage("**[ASSERT PASSED]:Value found for response field code is : " + responseMap.get("code"));

		Assert.assertNotNull(responseMap.get("paymentInfo.subscriptionId"));
		logMessage("**[ASSERT PASSED]:Value found for response field subscriptionId is : "
				+ responseMap.get("paymentInfo.subscriptionId"));

	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateExtensionCartPayload(Map<String, String> apiData) {
		JSONObject requestParams = new JSONObject();
		requestParams.put("student", getStudentPayload());
		requestParams.put("originalCommerceOrderID", originalCommerceOrderID);
		requestParams.put("deliveryAddress", getdeliveryAddressPayload(apiData.get("addressType")));
		requestParams.put("orderType", apiData.get("orderType"));
		requestParams.put("studentUpfrontPaymentPortion",
				returnStudentUpfrontPaymentPortion(apiData.get("studentUpfrontPaymentPortion")));
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));
		requestParams.put("entries", createExtensionCartEntry(apiData));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONArray createExtensionCartEntry(Map<String, String> apiData) {

		JSONArray orderEntries = new JSONArray();
		JSONObject requestParams = new JSONObject();

		requestParams = createExtensionEntryForCart(apiData.get("taxToBePaidUpfront"), apiData.get("payerModel"),
				apiData.get("paymentFrequency"));
		orderEntries.add(requestParams);
		return orderEntries;

	}

	@SuppressWarnings("unchecked")
	public static JSONObject createExtensionEntryForCart(String taxToBePaidUpfront, String payerModel,
			String paymentFrequency) {

		JSONObject requestParams = new JSONObject();
		JSONObject paramProduct = new JSONObject();
		JSONObject paramPricePaid = new JSONObject();
		JSONObject taxablePortion = new JSONObject();

		paramPricePaid.put("currencyIso", "USD");
		paramPricePaid.put("value", "300");

		taxablePortion.put("currencyIso", "USD");
		taxablePortion.put("value", "300");

		paramProduct.put("code", "CONTAINER_PRODUCT");

		requestParams.put("registrationKey", regKey);
		requestParams.put("quantity", "1");
		requestParams.put("productMediaCode", "ONE");
		requestParams.put("digital", "true");
		requestParams.put("taxToBePaidUpfront", taxToBePaidUpfront);
		requestParams.put("payerModel", payerModel);
		requestParams.put("paymentFrequency", paymentFrequency);
		requestParams.put("provisionActionRequest", "P");
		requestParams.put("paymentMethod", "");
		requestParams.put("taxablePortion", taxablePortion);
		requestParams.put("product", paramProduct);
		requestParams.put("pricePaid", paramPricePaid);
		requestParams.put("containerItem", getContainerPayload("containerItem"));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateCancelRegistrationPayload(String userID) {

		JSONObject requestParams = new JSONObject();

		requestParams.put("orderId", OrderID);
		requestParams.put("userId", userID);
		requestParams.put("orderType", "CANCEL");
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));

		requestParams.put("cancellationRequestEntryInputs", createcancellationRequestEntryInputs());

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONArray createcancellationRequestEntryInputs() {

		JSONArray orderEntries = new JSONArray();
		JSONObject requestParams = new JSONObject();

		JSONObject registrationRefund = new JSONObject();

		registrationRefund.put("currencyIso", "USD");
		registrationRefund.put("value", "600");

		requestParams.put("registrationKey", regKey);
		requestParams.put("quantity", "1");
		requestParams.put("provisionActionRequest", "D");
		requestParams.put("containerItem", getContainerPayload("containerItem"));

		requestParams.put("registrationRefundAfterTax", registrationRefund);

		orderEntries.add(requestParams);
		return orderEntries;

	}

	public static String hitCancelRegistrationApi(String userID, String payload, int statusCode) {
		String endPoint = "/cengage-b2c-wfs-us/users/" + userID + "/orders/" + OrderID + "/registrations/cancellation";
		logMessage("**[INFO] Cancel Registration API : " + endPoint);

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		Response resp= RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload).post(endPoint).then().assertThat().statusCode(statusCode).extract().response();

		return resp.asString();
	}

	public static String hitCancelRegistrationWithNoConsignmnet(String userID, String payload, int statusCode) {
		String endPointGet = "/cengage-b2c-wfs-us/users/" + userID + "/orders/" + OrderID + "/registrations/cancellation";
		logMessage("**[INFO] Cancel Registration API : " + endPointGet);

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		Response resp= RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload).post(endPointGet).then().assertThat().statusCode(statusCode).extract().response();

		return resp.asString();
	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateTransferCartPayload(Map<String, String> apiData) {

		if (originalCommerceOrderID == null) {
			originalCommerceOrderID = PropFileHandler.readProperty("originalCommerceOrderID");
		}

		JSONObject requestParams = new JSONObject();

		requestParams.put("student", getStudentPayload());
		requestParams.put("originalCommerceOrderID", originalCommerceOrderID);
		requestParams.put("deliveryAddress", getdeliveryAddressPayload(apiData.get("addressType")));
		requestParams.put("orderType", apiData.get("orderType"));
		requestParams.put("studentUpfrontPaymentPortion",
				returnStudentUpfrontPaymentPortion(apiData.get("studentUpfrontPaymentPortion")));
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));
		requestParams.put("entries", createTransferCartEntry(apiData));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateTransferCartPayloadWithOutOriginalOrderId(Map<String, String> apiData) {

		JSONObject requestParams = new JSONObject();

		requestParams.put("student", getStudentPayload());
		requestParams.put("deliveryAddress", getdeliveryAddressPayload(apiData.get("addressType")));
		requestParams.put("orderType", apiData.get("orderType"));
		requestParams.put("studentUpfrontPaymentPortion",
				returnStudentUpfrontPaymentPortion(apiData.get("studentUpfrontPaymentPortion")));
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));
		requestParams.put("entries", createTransferCartEntry(apiData));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONArray createTransferCartEntry(Map<String, String> apiData) {

		JSONArray orderEntries = new JSONArray();
		JSONObject requestParams = new JSONObject();

		requestParams = createTransferEntryForCart(apiData.get("taxToBePaidUpfront"), apiData.get("payerModel"),
				apiData.get("paymentFrequency"));
		orderEntries.add(requestParams);
		return orderEntries;

	}

	@SuppressWarnings("unchecked")
	public static JSONObject createTransferEntryForCart(String taxToBePaidUpfront, String payerModel,
			String paymentFrequency) {

		oldRegKey = regKey;

		JSONObject requestParams = new JSONObject();
		JSONObject paramProduct = new JSONObject();
		JSONObject paramPricePaid = new JSONObject();
		JSONObject taxablePortion = new JSONObject();

		paramPricePaid.put("currencyIso", "USD");
		paramPricePaid.put("value", "0");

		taxablePortion.put("currencyIso", "USD");
		taxablePortion.put("value", "0");

		paramProduct.put("code", "CONTAINER_PRODUCT");

		requestParams.put("registrationKey", getuniqueRegistrationkey());
		requestParams.put("oldRegistrationKey", oldRegKey);
		requestParams.put("quantity", "1");
		requestParams.put("productMediaCode", "ONE");
		requestParams.put("digital", "true");
		requestParams.put("taxToBePaidUpfront", taxToBePaidUpfront);
		requestParams.put("payerModel", payerModel);
		requestParams.put("paymentFrequency", paymentFrequency);
		requestParams.put("provisionActionRequest", "P");
		requestParams.put("paymentMethod", "");
		requestParams.put("taxablePortion", taxablePortion);
		requestParams.put("product", paramProduct);
		requestParams.put("pricePaid", paramPricePaid);
		requestParams.put("containerItem", getContainerPayload("containerItem"));

		return requestParams;
	}

	public static String getoriginalCommerceOrderIDDetails(String userId, int statusCode) {
		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/orders/" + originalCommerceOrderID;

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage("Calling get Order API : " + endPoint);
		Response resp = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(statusCode).extract()
				.response();
		return resp.asString();
	}

	public static void verifyOldRegKey(String actualValue) {

		Assert.assertEquals(actualValue, oldRegKey, "Value expected for Old RegKey: " + oldRegKey + ", Found: " + actualValue);
		logMessage("**[ASSERT PASSED]:Value expected for Old RegKey: " + oldRegKey + ", Found: " + actualValue);

	}

	public static void verifyNewRegKey(String actualValue) {

		Assert.assertEquals(actualValue, regKey, "Value expected for New RegKey: " + regKey + ", Found: " + actualValue);
		logMessage("**[ASSERT PASSED]:Value expected for New RegKey:" + regKey + ", Found: " + actualValue);

	}

	public static String createCWCartWithInvalidBaseStore(String payload) {
		String endPoint = "/cengage-b2c-wfs-us1/carts";
		logMessage("**[INFO] Create Cart API : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		Response respOut= RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload).post(endPoint).then().assertThat().statusCode(400).extract().response();

		return respOut.asString();
	}

	public static String placeOrderWithInvalidBaseStore(String userId, String cartId) {
		String endPoint = "/cengage-b2c-wfs-us1/users/" + userId + "/orders";
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage("Placing order with: " + endPoint);

		Response respOut= RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").queryParam("cartId", cartId).post(endPoint).then().assertThat()
				.statusCode(400).extract().response();

		return respOut.asString();
	}

	public static void verifyCartTypeInResponse(String response, String expectedCartType) {
		JsonPath responseMapGet = JsonPath.from(response);
		String actualType = responseMapGet.get("orderType");
		Assert.assertTrue(expectedCartType.equalsIgnoreCase(actualType),
				"Value expected: " + expectedCartType + ", Found: " + actualType);
		logMessage("**[ASSERT PASSED]:Value expected : " + expectedCartType + ", Found: " + actualType);

	}

	public static String getOrderHistory(String userId, String regKey, String statusCodeGet) {

		String endPoint = "/cengage-b2c-wfs-us/users/" + userId + "/order/history";
		int statusCode = Integer.parseInt(statusCodeGet);

		if (regKey.equalsIgnoreCase("valid")) {
			regKey = PropFileHandler.readProperty("regKey");
		}

		logMessage("**Get Order History API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		Response respOut= RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.when().queryParam("registrationID", regKey).get(endPoint).then().assertThat().statusCode(statusCode)
				.extract().response();

		return respOut.asString();

	}

	public void varifyOrderDetailsInResponse(JsonPath responseMap, Map<String, String> properties) {

		for (String property : properties.keySet()) {
			Assert.assertNotNull(responseMap.get(property),
					"**[ASSERT FAILED]:Value not found for Property " + property);
			if (!properties.get(property).contains("value")) {
				Assert.assertEquals(responseMap.get(property).toString(), properties.get(property));
				logMessage(
						"**[ASSERT PASSED]:Value found for Property " + property + " is : " + properties.get(property));

			}
		}

		Assert.assertEquals(responseMap.get("code"), OrderID);
		logMessage("**[ASSERT PASSED] CartId is as expected");

		try {
			Assert.assertEquals(responseMap.get("entries[0].registrationKey"), regKey);
			logMessage("**[ASSERT PASSED] regKey is as expected");
		} catch (AssertionError e) {
			Assert.assertEquals(responseMap.get("entries[1].registrationKey"), regKey);
			logMessage("**[ASSERT PASSED] regKey is as expected");
		}

		Assert.assertNotNull(responseMap.get("entries[0].containerItem"),
				"**[ASSERT FAILED]:Value not found for containerItem ");
		logMessage("**[ASSERT PASSED] containerItem is Not Empty");

		Assert.assertNotNull(responseMap.get("containerHeader"),
				"**[ASSERT FAILED]:Value not found for containerHeader ");
		logMessage("**[ASSERT PASSED] containerHeader is Not Empty");

		Assert.assertTrue(responseMap.get("deliveryAddress").toString().contains("Hawaii"));
		logMessage("**[ASSERT PASSED] deliveryAddress is as expected");
	}

	public void varifyOrderHistoryDetailsInResponse(JsonPath responseMap, Map<String, String> properties) {

		for (String property : properties.keySet()) {
			Assert.assertNotNull(responseMap.get(property),
					"**[ASSERT FAILED]:Value not found for Property " + property);
			if (!properties.get(property).contains("value")) {
				Assert.assertEquals(responseMap.get(property).toString(), properties.get(property));
				logMessage(
						"**[ASSERT PASSED]:Value found for Property " + property + " is : " + properties.get(property));

			}
		}

		Assert.assertEquals(responseMap.get("orders[0].code"), OrderID);
		logMessage("**[ASSERT PASSED] CartId is as expected");

		try {
			Assert.assertEquals(responseMap.get("orders[0].entries[0].registrationKey"), regKey);
			logMessage("**[ASSERT PASSED] regKey is as expected");
		} catch (AssertionError e) {
			Assert.assertEquals(responseMap.get("orders[0].entries[1].registrationKey"), regKey);
			logMessage("**[ASSERT PASSED] regKey is as expected");
		}

		Assert.assertNotNull(responseMap.get("orders[0].entries[0].containerItem"),
				"**[ASSERT FAILED]:Value not found for containerItem ");
		logMessage("**[ASSERT PASSED] containerItem is Not Empty");

		Assert.assertNotNull(responseMap.get("orders[0].containerHeader"),
				"**[ASSERT FAILED]:Value not found for containerHeader ");
		logMessage("**[ASSERT PASSED] containerHeader is Not Empty");

		Assert.assertTrue(responseMap.get("orders[0].deliveryAddress").toString().contains("Hawaii"));
		logMessage("**[ASSERT PASSED] deliveryAddress is as expected");
	}

	public static int getActualOrders(String response, String parameter) {

		JSONArray orders = extractJsonArrayFromResponse(response, parameter);
		return orders.size();
		
	}

	public static void verifyProductCodeInCart(String response, int number, String productCode) {
		JsonPath responseMap = JsonPath.from(response);
		for (int i = 0; i < number; i++) {
			Assert.assertEquals(productCode, responseMap.get("entries[" + i + "].product.code"));
			String logmsg = "**[ASSERT PASSED] productCode for entry " + i + " is matched ";
			logMessage(logmsg);
			scenarioComment = scenarioComment + "\n" + logmsg;
		}
	}

	public static void verifyAddressErrorInCartRespose(String response, String errMsg, int lineNo) {
		JsonPath responseMap = JsonPath.from(response);
		String expectedErrMsg = PropFileHandler.readProperty(errMsg);
		Assert.assertTrue(responseMap.get("errors[" + lineNo + "].message").toString().contains(expectedErrMsg));
		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedErrMsg + ", Found: "
				+ responseMap.get("errors[" + lineNo + "].message");
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;

	}

	public void verifyErrorWithoutDeliveryAddress(String response, String errMsg) {
		JsonPath responseMapGet = JsonPath.from(response);
		String expectedErrMsg = PropFileHandler.readProperty(errMsg);
		Assert.assertTrue(responseMapGet.get("errors[0].message").toString().contains(expectedErrMsg));
		logMessage("**[ASSERT PASSED]:Value expected : " + expectedErrMsg + ", Found: "
				+ responseMapGet.get("errors[0].message"));

	}

	public static void verifyInvalidDeliveryAddressError(String response, String errMsg) {
		JsonPath responseMap = JsonPath.from(response);
		String expectedErrMsg = PropFileHandler.readProperty(errMsg);
		Assert.assertTrue(responseMap.get("errors[0].message").toString().contains(expectedErrMsg),
				"**[ASSERT FAILED]:Value expected : " + expectedErrMsg + ", Found: "
						+ responseMap.get("errors[0].message"));

		String logmsg = "**[ASSERT PASSED]:Value expected : " + expectedErrMsg + ", Found: "
				+ responseMap.get("errors[0].message");
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject generateCancelRegistrationPayload(String userID, String regKey) {

		JSONObject requestParams = new JSONObject();

		requestParams.put("orderId", OrderID);
		requestParams.put("userId", userID);
		requestParams.put("orderType", "CANCEL");
		requestParams.put("containerHeader", getContainerPayload("containerHeader"));

		requestParams.put("cancellationRequestEntryInputs", createcancellationRequestEntryInputs(regKey));

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static JSONArray createcancellationRequestEntryInputs(String regKey) {

		JSONArray orderEntries = new JSONArray();
		JSONObject requestParams = new JSONObject();

		JSONObject registrationRefund = new JSONObject();

		registrationRefund.put("currencyIso", "USD");
		registrationRefund.put("value", "600");

		requestParams.put("registrationKey", regKey);
		requestParams.put("quantity", "1");
		requestParams.put("provisionActionRequest", "D");
		requestParams.put("containerItem", getContainerPayload("containerItem"));

		requestParams.put("registrationRefundAfterTax", registrationRefund);

		orderEntries.add(requestParams);
		return orderEntries;

	}

	public static void getRegKeyfromOrder(String response) {
		String regKeyGet = null;
		JsonPath responseMapGet = JsonPath.from(response);

		regKeyGet = responseMapGet.get("entries[0].registrationKey");
		PropFileHandler.writeProperty("oldRegKey", regKeyGet);
		logMessage("**[INFO] registrationKeys:" + regKeyGet);
	}

	public static void verifyRegKeyIsNotChanged(String response) {
		String regKey = null;
		String oldRegKey = PropFileHandler.readProperty("oldRegKey");
		JsonPath responseMap = JsonPath.from(response);
		regKey = responseMap.get("entries[0].registrationKey");

		Assert.assertEquals(regKey, oldRegKey);

		String logmsg = "**[ASSERT PASSED] registrationKey is not changed: " + regKey;
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;
	}

	public static String getSopRequestApi(String basesiteId, String userId, String cartId, int statusCode) {

		String endPoint = "/" + basesiteId + "/users/" + userId + "/carts/" + cartId + "/payment/sop/request";
		String baseQuery = PropFileHandler.readProperty("storeBaseURL");
		String query = "https://" + baseQuery + "/cengagewebservicetest/sop/receipt/handler";
		logMessage("**Get SOP Request API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		Response resp= RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.when().queryParam("receiptUrl", query).get(endPoint).then().assertThat().statusCode(statusCode)
				.extract().response();

		return resp.asString();

	}

	public static String getSopResponseApi(String basesiteId, String userId, String cartId, int statusCode) {

		String endPoint = "/" + basesiteId + "/users/" + userId + "/carts/" + cartId + "/payment/sop/response";
		logMessage("**Get SOP Response API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").queryParam("saveCard", "true")
				.get(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		return response;

	}

	public void verifySOPApiResponse(JsonPath responseMap, Map<String, String> properties) {
		String subscriptionId = PropFileHandler.readProperty(properties.get("subscriptionId"));

		Assert.assertEquals(responseMap.get("cardType.code"), properties.get("cardType"));
		logMessage("**[ASSERT PASSED] cardType is as expected");

		Assert.assertEquals(responseMap.get("subscriptionId"), subscriptionId);
		logMessage("**[ASSERT PASSED] subscriptionId is as expected");

		Assert.assertEquals(properties.get("expiryYear"), responseMap.get("expiryYear"));
		logMessage("**[ASSERT PASSED] expiryYear is as expected");

		Assert.assertTrue(responseMap.get("billingAddress").toString().contains(properties.get("billingAddress")));
		logMessage("**[ASSERT PASSED] deliveryAddress is as expected");

	}

	public void verifySOPApiRequestResponse(JsonPath responseMap) {
		Assert.assertNotNull(responseMap.get("parameters[0].key"));
		Assert.assertNotNull(responseMap.get("parameters[0].value"));
		Assert.assertNotNull(responseMap.get("parameters[1].key"));
		Assert.assertNotNull(responseMap.get("parameters[1].value"));
		Assert.assertNotNull(responseMap.get("parameters[2].key"));
		Assert.assertNotNull(responseMap.get("parameters[2].value"));
		logMessage("**[ASSERT PASSED] Response are in Key Value Pair");
	}

	public static void verifyCWCustomerIsRegistered(JsonPath responseMap) {

		String uidGet = responseMap.get("student.uid");
		Assert.assertEquals(uidGet, userID, "**[ASSERT FAILED]: UserId is not as expected");
		logMessage("User created Successfully:" + userID);
	}


}
