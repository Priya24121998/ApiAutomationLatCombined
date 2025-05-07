package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.testng.Assert;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class SubscriptionsActions extends BaseClass {

	public SubscriptionsActions() {
		super();
	}

	JSONParser parserobj = new JSONParser();
	JSONObject objjson = null;

	@SuppressWarnings("unchecked")
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

	public static void activatePendingSubscription(String baseSiteId, String userId, String subid) {
		String endpoint = "/" + baseSiteId + "/customers/" + userId + "/subscriptions/" + subid + "/activate";
		logMessage("**Activate Pending subscription API: " + endpoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").post(endpoint).then().assertThat().statusCode(200).extract()
				.asString();
	}

	@SuppressWarnings("unchecked")
	public static String userCancelSubscription(String baseSiteId, String userId, String subscriptionId) {
		String endPoint = "/" + baseSiteId + "/subscriptions/cancel";
		JSONObject payload = new JSONObject();
		payload.put("customerGUID", userId);
		payload.put("id", subscriptionId);
		logMessage("**Cancel Subscription API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").body(payload.toString()).post(endPoint).then().assertThat()
				.statusCode(200).extract().asString();
		return response;
	}

	@SuppressWarnings("unchecked")
	public static void updateSubscriptionStatus(String baseSiteId, String userId, String id, String status) {
		String endPoint = "/" + baseSiteId + "/subscriptions";
		JSONObject requestParams = new JSONObject();
		requestParams.put("customerGUID", userId);
		requestParams.put("id", id);
		requestParams.put("status", status);
		requestParams.put("modificationReason", "Test");
		requestParams.put("notes", "Updating subscription");
		String token = setAuthorizationHeader();
		RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").body(requestParams).patch(endPoint).then().assertThat()
				.statusCode(201);
	}

	public static String getSubscriptioDetailsForGivenCustomerGUID(String customerguid, int statusCode) {
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		Response responseOut = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("customerGUID", customerguid).queryParam("fields", "DEFAULT")
				.get("cengage-b2c-us/subscriptions").then().assertThat().statusCode(statusCode).extract().response();

		return responseOut.asString();

	}

	public static String getSubscriptionStateDetailsForContractWithCustomerGUID(String guid, int statusCode) {
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		Response responseGet =RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("customerGUID", guid).queryParam("fields", "DEFAULT")
				.get("/cengage-b2c-us/subscriptions/state").then().assertThat().statusCode(statusCode).extract()
				.response();

		return responseGet.asString();
	}

	/**
	 * Change Duration of a subscription(Within tier) based on SKU
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param subscriptionId
	 * @param sku
	 */
	@SuppressWarnings("unchecked")
	public static void durationChange(String baseSiteId, String userId, String subscriptionId, String sku) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/subscriptions/" + subscriptionId;
		logMessage("**[INFO] Duration Change API: " + endPoint);
		JSONObject requestParams = new JSONObject();
		requestParams.put("planExternalSKU", sku);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").body(requestParams).post(endPoint).then().assertThat().statusCode(200)
				.extract().asString();

		JsonPath responseMap = JsonPath.from(response);
		cartId = responseMap.get("code");
		authenticatedCartGuid = responseMap.getString("guid");
	}

	public void verifySubscriptionStatus(String expected, String value) {
		Assert.assertTrue(expected.equalsIgnoreCase(value));
		if (expected.contains("Trial") || expected.contains("Full"))
			logMessage("Subscription type is as expected i.e. " + value);
		else
			logMessage("Subscription status is as expected i.e. " + value);
	}

//	Unused
	public String getSubscriptionPlanDetails(String type, String sku_planID, int statusCode) {
		logMessage(type + ": " + sku_planID);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		Response response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam(type, sku_planID).queryParam("fields", "DEFAULT").get("/cengage-b2c-us/subscriptionplans")
				.then().assertThat().statusCode(statusCode).extract().response();

		String subscriptionDetails = response.body().asString();
		return subscriptionDetails;
	}

	@SuppressWarnings("unchecked")
	public static void updateSubscription(String guid, String id, String dateType, String date, int statusCode) {
		String endpoint = PropFileHandler.readProperty("updateAPI");
		JSONObject requestParams = new JSONObject();
		requestParams.put("customerGUID", guid);
		requestParams.put("id", id);
		requestParams.put("status", "ACTIVE");
		requestParams.put("modificationReason", "User Request Modification");
		requestParams.put("notes", "Updating subscription");
		requestParams.put(dateType, date);

		String token = setAuthorizationHeader();

		RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).body(requestParams)
				.patch(endpoint).then().assertThat().statusCode(statusCode);
	}

	public String addNumOfMonthsToDate(String start, int months) {
	
		String startDate;
		String parts[] = start.split("T");
		startDate = parts[0];
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date d = null;
		String newEndDate = "";
		try {
			d = dateFormat.parse(startDate);
		} catch (java.text.ParseException p) {
		}
		Calendar c = Calendar.getInstance();
		c.setTime(d);
		c.add(Calendar.MONTH, months);
		c.add(Calendar.DATE, -1);
		logMessage("Month no: " + months);
		Date currentDatePlusOne = c.getTime();
	    newEndDate = dateFormat.format(currentDatePlusOne).toString();
		logMessage("New date calculated is: " + newEndDate);
		return newEndDate;
	}

	public void verifyResponseParameterValueIsNotNull(String response, String parameter) {
		try {
			objjson = (JSONObject) parserobj.parse(response);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		try {
			String value = (String) objjson.get(parameter);
			Assert.assertFalse(value == null || value.isEmpty(),
					"**[ASSERT FAILED]: Parameter in response is null or empty");
		} catch (ClassCastException e) {
			try {
				Boolean value = (Boolean) objjson.get(parameter);
				Assert.assertFalse(value == null, "**[ASSERT FAILED]: Parameter in response is null or empty");
			} catch (ClassCastException exp) {
				long value = (Long) objjson.get(parameter);
				Assert.assertTrue(value != 0, "**[ASSERT FAILED]: Parameter in response is null or empty");
			}
		}
	}

}
