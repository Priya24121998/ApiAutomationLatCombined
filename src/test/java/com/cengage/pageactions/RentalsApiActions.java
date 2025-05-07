package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.testng.Assert;

public class RentalsApiActions extends BaseClass {

	public RentalsApiActions() {
		super();
	}
	
	/**
	 * DPS API to get Rental duration
	 * 
	 * @param product
	 * @param unlimited
	 * @param rentals
	 * @param status
	 * @return
	 */
	public static String getDPSApi(String product, String unlimited, String rentals, int status) {
		String endPoint = "https://dps.cengage.com/api/price/" + product;
		logMessage("**[INFO] Get DPS Details API: " + endPoint);
		response = RestAssured.given().contentType(ContentType.JSON)
				.queryParam("guid", "273cb4dc3a562d75:649ccec4:187fb225944:-781b").queryParam("unlimited", unlimited)
				.queryParam("rentals", rentals).get(endPoint).then().assertThat().statusCode(status).extract()
				.asString();
		return response;

	}

	/**
	 * Get Rentals for Given User GUID
	 * 
	 * @param guid
	 * @param statusCode
	 * @return
	 */
	public static String returnListOfRentalThatContainingRentalInformation(String guid, int statusCode) {
		RestAssured.baseURI = PropFileHandler.readProperty("listOfRentals");
		String token = setAuthorizationHeader();
		Response response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").get(guid + "/rentals").then().assertThat().statusCode(statusCode)
				.extract().response();

		return  response.body().asString();
		
	}

	/**
	 * Get Rental details for a specific Rental ID
	 * 
	 * @param guid
	 * @param rentalID
	 * @param statusCode
	 * @return
	 */
	public static String returnRentalDetailsForGivenCustomerGuidAndRentalID(String guid, String rentalID, int statusCode) {
		String endpoint = PropFileHandler.readProperty("base_URI");
		endpoint = endpoint + "/cengage-b2c-us/customers/" + guid + "/rentals/" + rentalID;
		String token = setAuthorizationHeader();
		Response response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").get(endpoint).then().assertThat().statusCode(statusCode).extract()
				.response();

		return response.body().asString();
	
	}

	/**
	 * Hit API to extend rental duration to 15/ 30 days
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param rentalId
	 * @param days
	 */
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

	/**
	 * Hit API to Buy out Rental
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param rentalId
	 */
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

	/**
	 * Hit API to Update rental
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param rentalId
	 * @param type
	 */
	@SuppressWarnings("unchecked")
	public static void uppdateRental(String baseSiteId, String userId, String rentalId, String type) {

		String endPoint = "/" + baseSiteId + "/rentals/" + rentalId;

		JSONObject payload = new JSONObject();
		payload.put("customerGUID", userId);
		payload.put("notes", type);
		payload.put("status", type);

		logMessage("**[INFO]Rental Update Api : " + endPoint);
		logMessage(">>payload: " + payload);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "BASIC").body(payload).post(endPoint).then().assertThat().statusCode(200)
				.extract().asString();

	}

	/**
	 * Hit API to Transfer Rental from 1 user guid to another
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param subsId
	 * @param rentalId
	 */
	@SuppressWarnings("unchecked")
	public static void rentalTranfer(String baseSiteId, String userId, String subsId, String rentalId) {
		String endPoint = "/" + baseSiteId + "/customers/" + userId + "/rentals/transferSubscription";
		JSONArray rentalIds = new JSONArray();
		rentalIds.add(rentalId);
		JSONObject payload = new JSONObject();
		payload.put("subscriptionId", subsId);
		payload.put("rentalIds", rentalIds);
		logMessage("**[INFO]Rental Transfer Api : " + endPoint);
		logMessage(payload.toString());
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(200)
				.extract().asString();

		logMessage("Rental Transfer to SubscriptionId : " + subsId);

	}

	/**
	 * Update Rental Status to Shipped
	 * 
	 * @param baseSiteId
	 * @param orderIdGet
	 * @param rentalID
	 * @param statusCode
	 */
	@SuppressWarnings("unchecked")
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
		requestParams.put("shippingDate", getCurrentDate());
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
	
	
	/**
	 * Update Rental Status to Shipped
	 * 
	 * @param baseSiteId
	 * @param rentalID
	 * @param statusCode
	 */
	@SuppressWarnings("unchecked")
	public static void updateDetailOfRentalOrder(String baseSiteId, String rentalID, int statusCode) {
		String endPoint = "/" + baseSiteId + "/rentals/" + rentalID ;
		
		String id = getCurrentTimestamp();
		JSONObject requestParams = new JSONObject();
		JSONArray entries = new JSONArray();
		JSONObject payload = new JSONObject();

		requestParams.put("trackingId", "Track_"+id);
		requestParams.put("carrier", "Carrier_"+ id);
	
		entries.add(requestParams);
		payload.put("rentalReturn", entries);
		payload.put("status", "Active");
		payload.put("notes", "activating standalone ");
		 

		logMessage("**[INFO]Rental Staus Update Api : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(payload)
				.when().post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();
		logMessage("**[INFO]Rental Staus Update Success");
	}
	
	/**
	 * Update Rental Status to Shipped
	 * 
	 * @param baseSiteId
	 * @param rentalID
	 * @param statusCode
	 */
	@SuppressWarnings("unchecked")
	public static void updateDetailOfRentalOrderWithDuplicateID(String baseSiteId, String rentalID, int statusCode) {
		String endPoint = "/" + baseSiteId + "/rentals/" + rentalID ;
		
		
		JSONObject requestParams = new JSONObject();
		JSONArray entries = new JSONArray();
		JSONObject payload = new JSONObject();

		requestParams.put("trackingId", "Duplicate_ID");
		requestParams.put("carrier", "Duplicate_ID");
	
		entries.add(requestParams);
		payload.put("rentalReturn", entries);
		payload.put("status", "Active");
		payload.put("notes", "activating standalone ");
		 

		logMessage("**[INFO]Rental Staus Update Api : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(payload)
				.when().post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();
		logMessage("**[INFO]Rental Staus Update Success");
	}
	
	
	/**
	 * Update Rental Status to Shipped
	 * 
	 * @param baseSiteId
	 * @param rentalID
	 * @param statusCode
	 */
	@SuppressWarnings("unchecked")
	public static void updateDetailOfRentalOrderWithoutReturnNotes(String baseSiteId, String rentalID, int statusCode) {
		String endPoint = "/" + baseSiteId + "/rentals/" + rentalID ;
		
		String id = getCurrentTimestamp();
		JSONObject requestParams = new JSONObject();
		JSONArray entries = new JSONArray();
		JSONObject payload = new JSONObject();

		requestParams.put("trackingId", "Track_"+id);
		requestParams.put("carrier", "Carrier_"+ id);
	
		entries.add(requestParams);
		payload.put("rentalReturn", entries);
		payload.put("status", "Active");
			 

		logMessage("**[INFO]Rental Staus Update Api : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(payload)
				.when().post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();
		logMessage("**[INFO] Update Detail Of Rental Order Without Return Notes Success");
	}
	
	
	
	
	

	/**
	 * Update Status of multiple Rentals to Shipped
	 * 
	 * @param baseSiteId
	 * @param orderIdGet
	 * @param numOfRentals
	 * @param statusCode
	 */
	@SuppressWarnings("unchecked")
	public static void updateStausOfMulRentals(String baseSiteId, String orderIdGet, int numOfRentals, int statusCode) {
		String endPoint = "/" + baseSiteId + "/orders/" + orderIdGet + "/statusUpdate";
		JSONArray entries = new JSONArray();
		JSONObject payload = new JSONObject();
		
		for (int i =0; i< numOfRentals; i++) {
			entries.add(rentalShippingPayload(rentalId[i], i+1));
		}
		payload.put("entries", entries);

		logMessage(payload.toString());

		logMessage("**[INFO]Rental Staus Update Api : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(payload)
				.when().post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		logMessage("**[INFO]Rental Staus Update Success");
	}

	/**
	 * Create rental shipping Payload
	 * 
	 * @param rentalId
	 * @param entryNumber
	 * @return
	 */
	@SuppressWarnings("unchecked")
	static
	JSONObject rentalShippingPayload(String rentalId, int entryNumber) {

		JSONObject requestParams = new JSONObject();
		requestParams.put("carrier", "UPSGND");
		requestParams.put("isbn", "isbn");
		requestParams.put("qtyShipped", 1);
		requestParams.put("entryNumber", entryNumber);
		requestParams.put("rentalId", rentalId);
		requestParams.put("shippingDate", getCurrentDate());
		requestParams.put("orderLineStatus", "SHIPPED");
		requestParams.put("trackingId", "TestTrack123");

		return requestParams;
	}

	@SuppressWarnings("unchecked")
	public static void updateStaus(String baseSiteId, String orderIdGet, int entryNumber, int statusCode) {
		String endPoint = "/" + baseSiteId + "/orders/" + orderIdGet + "/statusUpdate";
		JSONArray entries = new JSONArray();
		JSONObject payload = new JSONObject();

		entries.add(rentalShippingPayload("", entryNumber));
		payload.put("entries", entries);

		logMessage(payload.toString());

		logMessage("**[INFO]Rental Staus Update Api : " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(payload)
				.when().post(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

		logMessage("**[INFO]Order Staus Update Success");
	}

	/**
	 * Hit API to return Rental and modify its state
	 * @param rentalID
	 * @param returnState
	 * @param statusCode
	 */
	@SuppressWarnings("unchecked")
	public void returnOfTextbookAndModifyRentalStateAccordingly(String rentalID, String returnState, int statusCode) {
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
	
	/**
	 * Hit API to return Rental and modify its state
	 * @param rentalID
	 * @param returnState
	 * @param statusCode
	 */
	@SuppressWarnings("unchecked")
	public static void returnOfTextbookAndModifyRentalStateAccordinglyWithoutReturnNotes(String rentalID, String returnState, int statusCode) {
		String endpoint = PropFileHandler.readProperty("base_URI");
		endpoint = endpoint + "/cengage-b2c-us/rentals/" + rentalID + "/returnNotification";
		logMessage(endpoint);
		JSONObject requestParams = new JSONObject();
		String token = setAuthorizationHeader();
		
		requestParams.put("isbn", "isbn");
		requestParams.put("returnDate", getCurrentDate());
		requestParams.put("returnState", returnState);
		requestParams.put("trackingId", "trackingId_"+ getCurrentTimestamp());
		requestParams.put("carrier", "carrier_"+getCurrentTimestamp());

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(requestParams).when()
				.queryParam("rentalId", rentalID).post(endpoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		logMessage(requestParams.toJSONString());
		logMessage(response);
	}
	
	
	
	/**
	 * Hit API to return Rental after some days and modify its state
	 * @param rentalID
	 * @param returnState
	 * @param returnDate
	 * @param statusCode
	 */
	@SuppressWarnings("unchecked")
	public void returnOfRentalAfterSomeDays(String rentalID, String returnState, String returnDate, int statusCode) {
		String endpoint = PropFileHandler.readProperty("base_URI");
		endpoint = endpoint + "/cengage-b2c-us/rentals/" + rentalID + "/returnNotification";
		logMessage(endpoint);
		JSONObject requestParams = new JSONObject();
		String token = setAuthorizationHeader();

		requestParams.put("isbn", "isbn");
		requestParams.put("notes", "Returning rental");
		requestParams.put("returnDate", returnDate);
		requestParams.put("returnState", returnState);

		RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(requestParams).when()
				.queryParam("rentalId", rentalID).post(endpoint).then().assertThat().statusCode(statusCode).extract()
				.response();
	}

	public static String getCumulativeTotalAmountForRental(String priceType) {
		
		double purchasedlatestAmountPaid = Double
				.parseDouble(PropFileHandler.readProperty("purchased_latestAmountPaid"));
		double extendedlatestAmountPaid = Double
				.parseDouble(PropFileHandler.readProperty("extended_latestAmountPaid"));
		double variablelatestAmountPaid = Double
				.parseDouble(PropFileHandler.readProperty(priceType + "_latestAmountPaid"));

		double total = purchasedlatestAmountPaid + extendedlatestAmountPaid + variablelatestAmountPaid;
	
		return  String.format("%.2f", total);
	}

	public void verifyRentalState(String expected, String actual) {
		Assert.assertEquals(actual, expected, "**[ASSERT FAILED]: Rental state is not as expected");
		logMessage("**[ASSERT PASSED]: Rental state is as expected");
	}

	public void verifyRentalendDatetoCuEndDate(String rentalendDate, String endDate) {
		String rentEndDate;
		String cuEndDate;
		String[] rentDateStr = rentalendDate.split("T");
		rentEndDate = rentDateStr[0];

		String[] cuDateStr = endDate.split("T");
		cuEndDate = cuDateStr[0];

		logMessage("Rental endate is: " + rentEndDate);
		logMessage("CU endDate is: " + cuEndDate);

		Assert.assertEquals(rentEndDate, cuEndDate, "**[ASSERT FAILED]: Rental end date is not same as cu end date");
		logMessage("**[ASSERT PASSED]: Rental end date is same as cu end date");

	}

	public void verifyRentalavailableCount(int expectedAvailableRentCount, int rentalAvailablecount) {
		Assert.assertEquals(rentalAvailablecount, expectedAvailableRentCount,
				"**[ASSERT FAILED]: Rental expected available count not equals to actual available count");
		logMessage("**[ASSERT PASSED]: Rental expected available count is equals to actual available count");

	}

	public void verifyRentalMaxCount(int expectedMaxCount, int maxRentalCount) {

		Assert.assertEquals(expectedMaxCount, maxRentalCount,
				"**[ASSERT FAILED]: Rental expected maximum count not equals to actual maximum count");
		logMessage("**[ASSERT PASSED]: Rental expected maximum count is equals to actual maximum count");

	}

	public void verifyMultipleRentalendDateforUpgradedCU(String rentalOneEndDate, String rentalTwoEndDate,
			String rentalThreeEndDate, String endDate) {
		String rentOneEndDate;
		String cuEndDate;
		String rentTwoEndDate;
		String rentThreeEndDate;

		String[] rentOneDateStr = rentalOneEndDate.split("T");
		rentOneEndDate = rentOneDateStr[0];

		String[] rentTwoDateStr = rentalTwoEndDate.split("T");
		rentTwoEndDate = rentTwoDateStr[0];

		String[] rentThreeDateStr = rentalThreeEndDate.split("T");
		rentThreeEndDate = rentThreeDateStr[0];

		String[] cuDateStr = endDate.split("T");
		cuEndDate = cuDateStr[0];

		logMessage("1st Rental endate is: " + rentOneEndDate);
		logMessage("2nd Rental endate is: " + rentTwoEndDate);
		logMessage("3rd Rental endate is: " + rentThreeEndDate);

		logMessage("CU endDate is: " + cuEndDate);

		Assert.assertTrue(rentOneEndDate.equals(cuEndDate),
				"**[ASSERT FAILED]: 1st Rental end date is not same as cu end date");
		logMessage("**[ASSERT PASSED]: 1st Rental end date is same as cu end date");

		Assert.assertTrue(rentTwoEndDate.equals(cuEndDate),
				"**[ASSERT FAILED]: 2nd Rental end date is not same as cu end date");
		logMessage("**[ASSERT PASSED]: 2nd Rental end date is same as cu end date");

		Assert.assertTrue(rentThreeEndDate.equals(cuEndDate),
				"**[ASSERT FAILED]: 3rd Rental end date is not same as cu end date");
		logMessage("**[ASSERT PASSED]: 3rd Rental end date is same as cu end date");

	}



//	Unused

	@SuppressWarnings("unchecked")
	public static void updateRental(String rentalID, String field, String value) {
		String endpoint = PropFileHandler.readProperty("base_URI");
		endpoint = endpoint + "/cengage-b2c-us/rentals/" + rentalID;
		logMessage(endpoint);
		logMessage("Updating rental's " + field + " with value: " + value);
		JSONObject requestParams = new JSONObject();
		String token = setAuthorizationHeader();

		requestParams.put(field, value);
		requestParams.put("notes", "Testing");

		RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(requestParams).when()
				.queryParam("rentalId", rentalID).post(endpoint).then().assertThat().statusCode(200).extract()
				.response();
	}

	@SuppressWarnings("unchecked")
	public static String shippingNotificationOfARental(String rentalID, int statusCode) {
		String endpoint = PropFileHandler.readProperty("base_URI");
		endpoint = endpoint + "/cengage-b2c-us/rentals/" + rentalID + "/shippingNotification";
		JSONObject requestParams = new JSONObject();
		String token = setAuthorizationHeader();

		requestParams.put("carrier", "UPS");
		requestParams.put("isbn", "isbn");
		requestParams.put("shippingDate", getCurrentDate());
		requestParams.put("shippingStatus", "SHIPPED");
		requestParams.put("trackingId", "TestTrack123");

		Response response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.body(requestParams).queryParam("rentalId", rentalID).when().post(endpoint).then().assertThat()
				.statusCode(statusCode).extract().response();
		return response.body().asString();
		
	}

}
