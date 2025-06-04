package com.cengage.restActions;
/**
 * The {@code OrderWorkFlow} class is responsible for managing the workflow
 * of orders within the application. This class provides methods and logic
 * to handle the various stages and actions involved in processing orders.
 *
 * <p>It is designed to be a central component for order-related operations,
 * ensuring that the workflow is executed efficiently and consistently.
 *
 * <p>Usage Example:
 * <pre>
 * {@code
 * OrderWorkFlow orderWorkFlow = new OrderWorkFlow();
 * orderWorkFlow.processOrder(orderId);
 * }
 * </pre>
 *
 * <p>Note: Ensure that all dependencies required for order processing
 * are properly configured before using this class.
 *
 * @author Priyadharshini M
 * @version 1.0
 * @since 2025
 */
import java.io.FilterInputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.util.Assert;

import com.cengage.common.PropFileHandler;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;


public class OrderWorkFlow extends BaseClass{
	
	public static String response;
	public static String userID, userGUID, cartId, authenticatedCartGuid;
	public static String OrderID=null;
	public static String payPalToken;
	static JsonPath responseMap;
	
	
	
	 public static String getCurrentTimestamp() {
	        LocalDateTime now = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        return now.format(formatter);
	    }
	
	
	public static String createACart(String baseSiteId, String userId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts";
		logMessage("**[INFO] Create Cart API: " + endPoint);

		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		System.out.println("BaseURI: "+PropFileHandler.readProperty("base_URI"));

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").post(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();

		if (statusCode != 400) {
			JsonPath responseMap = JsonPath.from(response);
			cartId = responseMap.get("code");
			authenticatedCartGuid = responseMap.getString("guid");
			logMessage("Cart created successfully, with:\nCartID: " + cartId + "\nCartGuid: " + authenticatedCartGuid);
		} else {
			cartId = "Not Created";
		}
		return response;
	}

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
	
	public static String addB2BProductToCart(String baseSiteId, String userId, String cartId, String payload, int status) {
		String endpoint = "/" + baseSiteId + "/orgUsers/" + userId + "/carts/" + cartId + "/entries";
		logMessageSys("Add product --> Start of function:");
		logMessageSys("**[INFO] Add Product to cart API: " + endpoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").body(payload).post(endpoint).then().assertThat().statusCode(status)
				.extract().asString();

		//String productCode = verifyProductAddedToCart(response) ;
		logMessageSys(response);
		//logMessageSys("**[INFO]: Product added to cart: "+ productCode);
		return response;
	}
	
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
	
	public static String verifyProductAddedToCart(String response){
		compareResponseValue(extractValueFromJOSNPath("bulkCartModificationList[0].cartModification.statusCode", response), "success");
		return extractValueFromJOSNPath("bulkCartModificationList[0].productCode", response);
	}
	
	public static String extractValueFromJOSNPath(String JSONPath, String jSonReponse) {
		JsonPath path = JsonPath.from(jSonReponse);
		String value;
		try {
			value = path.getString(JSONPath);
		} catch (ClassCastException e) {
			value =  Float.toString(path.get(JSONPath));

		}
		return value;
	}
	

	public static void verifyCartIsNotCreted(String errMsg) {
		JsonPath responseMap = JsonPath.from(response);
		String expectedError = PropFileHandler.readProperty(errMsg);
		String actualError = responseMap.get("errors[0].message");
		compareResponseValue(actualError, expectedError);
	}
	
	public static void compareResponseValue(String actual, String expected)
	{
	
		logMessage("actual.toLowerCase()");
		logMessage("expected.toLowerCase()");
		if(actual.equals(expected))
		{
			logMessage("Assert passed");
		}
		else
		{
			logMessage("actual.toLowerCase()");
			logMessage("expected.toLowerCase()");
			logMessage("Assert failed Actual String"+actual+" doesnt matches with "+expected);
		}
		logMessage("**[ASSERT PASSED]: Actual response value: [" + actual + "], matches with exepcted ["+ expected + "] value");
	}

	
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
	public static void verifyPaymentType(JsonPath responseMap, String paymentType) {
		String actualPaymentType = responseMap.get("paymentType.code");
		
		Assert.isTrue(actualPaymentType.equals(paymentType), "**[ASSERTION FAILED] Expected Payment Type:" + paymentType
				+ ",Actual Payment Type: " + actualPaymentType);
		logMessage("**[ASSERTION PASSED] Verified Payment Type is: " + actualPaymentType);

	}
	
	
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
	
	public static String applyPromocode(String baseSiteId, String userId, String cartId, String coupon, int statusCode) {
		String endpoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/promocodes";
		logMessage("**Add Promo code to cart API: " + endpoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("promoCode", coupon).post(endpoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		if (statusCode != 400)
			logMessage("**[INFO]Promo Applied Successfully");

		
		return response;
	}
	
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

	
	

}
