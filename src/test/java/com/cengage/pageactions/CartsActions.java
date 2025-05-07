package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import org.json.simple.JSONArray;
import org.testng.Assert;

import java.util.ArrayList;




public class CartsActions extends BaseClass {

	public CartsActions() {
		super();
	}

	/**
	 * Hit API to create a cart
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param statusCode
	 */
	public static String createACart(String baseSiteId, String userId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts";
		logMessage("**[INFO] Create Cart API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

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
	
	/**
	 * Hit API to create a cart
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param statusCode
	 */
	public static String createACartToSetShipToBillToAccount(String baseSiteId, String userId, String statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts";
		logMessage("**[INFO] Create Cart API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
int statusCode1 = getStatusCode(statusCode);
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").post(endPoint).then().assertThat().statusCode(statusCode1).extract()
				.asString();

		if (statusCode1 != 400) {
			JsonPath responseMap = JsonPath.from(response);
			cartId = responseMap.get("code");
			authenticatedCartGuid = responseMap.getString("guid");
			logMessage("Cart created successfully, with:\nCartID: " + cartId + "\nCartGuid: " + authenticatedCartGuid);
		} else {
			cartId = "Not Created";
		}
		return response;
	}


	/**
	 * Hit API to create a cart with IP Address
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param ip:        eg testip
	 * @param statusCode
	 * @return
	 */
	public static String createACartwithIP(String baseSiteId, String userId, String ip, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts";
		logMessage("**[INFO] Create Cart API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").queryParam("ipAddress", ip).post(endPoint).then().assertThat()
				.statusCode(statusCode).extract().asString();

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

	/**
	 * Merge anonymous cart with active user account it takes old cart id and create
	 * new cart
	 * 
	 * @param baseSiteId
	 * @param userId:      Authenticated User
	 * @param oldCartGuid: anonymous cart guid
	 * @param statusCode
	 * @return
	 */
	public static String mergeACarttoUserAccount(String baseSiteId, String userId, String oldCartGuid, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts";
		logMessage("**[INFO] Merge cart to user account API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("oldCartId", oldCartGuid).post(endPoint).then().assertThat().statusCode(statusCode)
				.extract().asString();
		if (statusCode != 400) {
			JsonPath responseMap = JsonPath.from(response);
			cartId = responseMap.get("code");
			authenticatedCartGuid = responseMap.getString("guid");
			logMessage("**[INFO] Cart Merged successfully, with:\nCartID: " + cartId + "\nCartGuid: "
					+ authenticatedCartGuid);
		} else {
			cartId = "Cart Not Merged";
		}

		return response;
	}

	/**
	 * Merge anonymous cart with active user account it takes old cart id
	 * (anonymous) and specified cart from user Account products in anonymous cart
	 * will be added to specified user cart.
	 * 
	 * @param baseSiteId
	 * @param userId:            Authenticated User
	 * @param oldCartGuid:       anonymous cart guid
	 * @param specifiedCartGuid: Authenticated User cart guid
	 * @param statusCode
	 * @return
	 */
	public static String mergeACarttoUserAccount(String baseSiteId, String userId, String oldCartGuid,
			String specifiedCartGuid, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts";
		logMessage("**[INFO] Merge cart to user account API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("oldCartId", oldCartGuid).queryParam("toMergeCartGuid", specifiedCartGuid).post(endPoint)
				.then().assertThat().statusCode(statusCode).extract().asString();
		
		return response;
	}

	/**
	 * Add product to cart
	 * 
	 * @param baseSiteId
	 * @param userId:    Authenticated user
	 * @param cartId:    cartID
	 * @param payload:   Product payload
	 * @param status:    expected API status code eg: 201
	 * @return String response
	 */
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

	/**
	 * Add product to cart
	 * 
	 * @param baseSiteId
	 * @param userId:    Authenticated user
	 * @param cartId:    cartID
	 * @param payload:   Product payload
	 * @param status:    expected api status code eg: 201
	 * @return String response
	 */
	public static String addB2BProductToCart(String baseSiteId, String userId, String cartId, String payload, int status) {
		String endpoint = "/" + baseSiteId + "/orgUsers/" + userId + "/carts/" + cartId + "/entries";
		logMessage("**[INFO] Add Product to cart API: " + endpoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").body(payload).post(endpoint).then().assertThat().statusCode(status)
				.extract().asString();

		String productCode = verifyProductAddedToCart(response) ;
		logMessage("**[INFO]: Product added to cart: "+ productCode);
		return response;
	}
	
	public static String verifyProductAddedToCart(String response){
		compareResponseValue(extractValueFromJOSNPath("bulkCartModificationList[0].cartModification.statusCode", response), "success");
		return extractValueFromJOSNPath("bulkCartModificationList[0].productCode", response);
	}

	/**
	 * Get cart details
	 * 
	 * @param baseSiteId
	 * @param userId:    Authenticated User/ anonymous
	 * @param cartId:    cartID
	 * @param statusCode
	 * @return String response
	 */
	public static String getACart(String baseSiteId, String userId, String cartId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId;
		logMessage("**[INFO] Get Cart API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").get(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		return response;
	}

	/**
	 * Delete Cart API
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param statusCode
	 */
	public static void deleteCart(String baseSiteId, String userId, String cartId, int statusCode) {

		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId;
		logMessage("**[INFO] Delete Cart API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");

		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.delete(endPoint).then().assertThat().statusCode(statusCode).extract().asString();

	}

	/**
	 * Delete entries from cart
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param entryNumber
	 * @param statusCode
	 */
	public static void deleteEntryInCart(String baseSiteId, String userId, String cartId, String entryNumber, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/entries/" + entryNumber;
		logMessage("**[INFO] Deletes Cart Entry API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").delete(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
	}

	/**
	 * Hit API to Get info of Saved cart
	 *
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param statusCode
	 */
	public static String getSaveCart(String baseSiteId, String userId, String cartId, int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/savedcart";
		logMessage("**[INFO] Get Save Cart API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
 
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "FULL").get(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		return response;
	}
	
	
	/**
	 * Hit API to Save a cart
	 *
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param saveCartName
	 * @param statusCode
	 */
	public static String saveCurrentCart(String baseSiteId, String userId, String cartId, String saveCartName,int statusCode) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/save";
		logMessage("**[INFO] Save Current Cart API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
 
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("saveCartName", saveCartName).patch(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		return response;
	}
	

	// ------------------------------------------------Verifications--------------------------------------------------

	public void verifyProduct(String product, String actualProduct) {
		Assert.assertEquals(actualProduct, product, "**[ASSERT FAILED]: Product is not as last product");
		logMessage("**[ASSERT PASSED]:  Product is as last product " + actualProduct);
	}

	public String verifyMultipleProduct(String product) {
		JsonPath responseMap = JsonPath.from(response);
		ArrayList<String> entries = responseMap.get("entries");
		for (int i = 0; i < entries.size(); i++) {
			String getProduct = responseMap.getString("entries[" + i + "].product.code");
			if (product.equalsIgnoreCase(getProduct))
				return ("**[ASSERT PASSED]:  Product is Added to cart " + getProduct);
		}
		Assert.fail("**[ASSERT FAILED]: Product is not Added to cart");
		return null;
	}

	public void verifyPriceValue(String priceType, String price) {
		String actualPrice = extractValueFromJOSNPath(priceType + ".value", response);
		compareResponseValue(actualPrice, price);

	}

	public static void verifyCartIsNotCreted(String errMsg) {
		JsonPath responseMap = JsonPath.from(response);
		String expectedError = PropFileHandler.readProperty(errMsg);
		String actualError = responseMap.get("errors[0].message");
		compareResponseValue(actualError, expectedError);
	}

	public void verifyPaymentType(JsonPath responseMap, String paymentType) {
		String actualPaymentType = responseMap.get("paymentType.code");
		Assert.assertEquals(actualPaymentType, paymentType, "**[ASSERTION FAILED] Expected Payment Type:" + paymentType
				+ ",Actual Payment Type: " + actualPaymentType);
		logMessage("**[ASSERTION PASSED] Verified Payment Type is: " + actualPaymentType);
	}

	public static void verifyEntriesInCart(String response, int size) {
		JSONArray entries = extractJsonArrayFromResponse(response, "entries");
		int actualSize = entries.size();
		Assert.assertEquals(actualSize, size);
		logMessage("**[ASSERT PASSED] entries Are as expected : " + size + " entries");

	}

	public static void verifyProduct(JsonPath responseMap, int atEntry, String product) {
		String getProduct = responseMap.getString("entries[" + atEntry + "].product.code");
		Assert.assertEquals(getProduct, product, "**[ASSERT FAILED]: Product is not as expected product");
		logMessage("**[ASSERT PASSED]:  Product is  as expected product " + getProduct);

	}

	public void verifCouponIsRemoved(JsonPath responseMap) {
		Assert.assertNull(responseMap.get("deliveryOrderGroups[0].entries[0].appliedCoupons[0].code"),
				"**[ASSERTION FAILED] Coupon is Not Removed");
		logMessage("**[ASSERTION PASSED] Coupon is Removed");
	}
	
	//Newly Added code
	public static String addB2BUSProductToCart(String baseSiteId, String userId, String cartId, String payload, int status) {
		String endpoint = "/" + baseSiteId + "/orgUsers/" + userId + "/carts/" + cartId + "/entries";
		logMessage("**[INFO] Add Product to cart API: " + endpoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").body(payload).post(endpoint).then().assertThat().statusCode(status)
				.extract().asString();

		return response;
	}
	
	
	public static String recalculateCartApi(String baseSiteId, String userId, String cartId, int status) {
		String endpoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/recalculate";
		logMessage("**[INFO] Recalculate cart API: " + endpoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("fields", "FULL").post(endpoint).then().assertThat().statusCode(status)
				.extract().asString();

		return response;
	}
	
	

}
