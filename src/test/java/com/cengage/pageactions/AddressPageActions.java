package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.testng.Assert;

/**
 * @author shiv.mangal
 *
 */

/**
 *  Sonar issues resolved
 *
 */

public class AddressPageActions extends BaseClass {

	public AddressPageActions() {
		super();
	}

	static JsonPath responseMap;

	/**
	 * Return JSON response as String based on parameters
	 * 
	 * @param baseSiteId 'Example cengage-b2c-us'
	 * @param userId     'Example b2cus_qa_ppcuettocu4_281123185535@mailinator.com'
	 * @param cartId     'Example 0001618718'
	 * @param status     'Example 200'
	 * @return response
	 */
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
		JSONArray deliveryModes = extractJsonArrayFromResponse(response, "deliveryModes");
		for (int i = 0; i < deliveryModes.size(); i++) {
			JSONObject mode = (JSONObject) deliveryModes.get(i);
			logMessage(mode.get("code").toString());
		}
	}

	/**
	 * Use this method to Add delivery mode to cart
	 * 
	 * @param baseSiteId 'Example cengage-b2c-us'
	 * @param userId     'Example b2cus_qa_ppcuettocu4_281123185535@mailinator.com'
	 * @param cartId     'Example 0001618718'
	 * @param mode       'Delivery mode to be added to cart example standard-us'
	 * @param statusCode 'Example 200'
	 */
	public static void putDeliveryModes(String baseSiteId, String userId, String cartId, String mode, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/deliverymode";
		logMessage("Add Delivery Mode To Cart API : " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").queryParam("deliveryModeId", mode).put(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		responseMap = JsonPath.from(response);
		logMessage("Opted for Shippping : " + mode);
	}

	/**
	 * Use this method to remove delivery mode from cart
	 * 
	 * @param baseSiteId 'Example cengage-b2c-us'
	 * @param userId     'Example b2cus_qa_ppcuettocu4_281123185535@mailinator.com'
	 * @param cartId     'Example 0001618718'
	 * @param status 'Example 200'
	 */
	public static void deleteDeliveryModes(String baseSiteId, String userId, String cartId, int status) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/deliverymode";
		logMessage("Remove Delivery Mode From Cart API : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").queryParam("deliveryModeId", "1").delete(endPoint).then().assertThat()
				.statusCode(status).extract().asString();
	}

	/**
	 * Use this method to add billing address to cart
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param payload    : Billing address
	 * @param statusCode
	 */
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

	/**
	 * Use this method to add delivery address to cart
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param payload    : Delivery Address
	 * @param statusCode
	 */
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

	/**
	 * Add bill to/ ship to Account number to B2B cart
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param payload
	 * @param status
	 * @return
	 */
	public static String addB2S2ToCart(String baseSiteId, String userId, String cartId, String payload, int status) {
		String endpoint = "/" + baseSiteId + "/orgUsers/" + userId + "/carts/" + cartId + "/accounts";
		logMessage("**[INFO] Add Bill to  and Ship to Accounts to cart API: " + endpoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).put(endpoint).then().assertThat().statusCode(status)
				.extract().asString();
		if (status != 400)
			logMessage("**[INFO]: Bill to  and Ship to Accounts added to cart");

		return response;
	}

	/**
	 * Use this method to create drop ship address for cart
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param payload
	 * @param status
	 */
	public static void createDropShipAddressForCart(String baseSiteId, String userId, String cartId, String payload,
			int status) {

		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/addresses/drop-ship";
		logMessage("Create Drop-Ship Address To Cart API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(status)
				.extract().asString();

		if (status != 400)
			logMessage("Drop-Ship Address created to cartId: " + cartId);

		responseMap = JsonPath.from(response);
	}

	/**
	 * Use this method to get all address from user account
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param status
	 * @return
	 */
	public static String getAllAddressFromUserAcccount(String baseSiteId, String userId, int status) {

		String endPoint = "/" + baseSiteId + "/users/" + userId + "/addresses";
		logMessage("Get All Address From User Account API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").get(endPoint).then().assertThat().statusCode(status).extract().asString();

		return response;
	}

	/**
	 * Use this method to get a specific address from user account
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param addressId
	 * @param status
	 * @return
	 */
	public static String getSpecificAddressFromUserAcccount(String baseSiteId, String userId, String addressId, int status) {

		String endPoint = "/" + baseSiteId + "/users/" + userId + "/addresses/" + addressId;
		logMessage("Get Specific From User Account Address API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").get(endPoint).then().assertThat().statusCode(status).extract().asString();

		return response;
	}

	/**
	 * Use this method to update a specific address from user account
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param addressId
	 * @param payload
	 * @param status
	 * @return
	 */
	public static String updateSpecificAddressFromUserAcccount(String baseSiteId, String userId, String addressId,
			String payload, int status) {

		String endPoint = "/" + baseSiteId + "/users/" + userId + "/addresses/" + addressId;
		logMessage(" Update Address From User Account API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").body(payload).put(endPoint).then().assertThat().statusCode(status)
				.extract().asString();

		return response;
	}

	/**
	 * Use this method to delete a specific address from user account
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param addressId
	 * @param status
	 * @return
	 */
	public static String deleteSpecificAddressFromUserAcccount(String baseSiteId, String userId, String addressId,
			int status) {

		String endPoint = "/" + baseSiteId + "/users/" + userId + "/addresses/" + addressId;
		logMessage("Delelte Specific Address From User Account API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").delete(endPoint).then().assertThat().statusCode(status).extract()
				.asString();

		return response;
	}

	/**
	 * Extracts AddressID from billing/ delivery address and saves it to property
	 * file for later use.
	 * 
	 * @param type
	 */
	public void getAddressIdAndSaveIt(String type) {
		String addId = responseMap.get("id");
		logMessage("**[INFO]: Adress ID for " + type + ": " + addId);
		PropFileHandler.writeProperty(type + "_AddresID", addId);
	}

	/**
	 * Search delivery mode in Get delivery mode API response
	 * 
	 * @param responseMap
	 * @param expectedDeliveryMode
	 * @param size
	 * @return True if delivery mode is found in response False if delivery mode is
	 *         not found in response
	 */
	public boolean searchDelivaryModesInResponse(JsonPath responseMap, String expectedDeliveryMode, int size) {

		for (int j = 0; j < size; j++) {
			String actualDeliveryMode = responseMap.get("deliveryModes[" + j + "].code");
			if (expectedDeliveryMode.equalsIgnoreCase(actualDeliveryMode)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Extracts the Delivery Cost from the response and Asserts it with the given
	 * expected amount
	 * 
	 * @param response
	 * @param amount
	 */
	public static void verifyDeliveryCostIs(String response, String amount) {

		String delAmount;
		responseMap = JsonPath.from(response);
		delAmount = Float.toString(responseMap.get("deliveryModes[0].deliveryCost.value"));
		logMessage("**[Info] Delivery Amount is : " + delAmount);
		Assert.assertEquals(delAmount, amount, "**[ASSERT FAILED]: Delivery Amount  is not as expected");
		logMessage("**[ASSERT PASSED]: Delivery Amount  is as expected : " + delAmount);
	}

	public static String getShippingMethod(String response) {
		return JsonPath.from(response).get("deliveryMode.code");
	}

}
