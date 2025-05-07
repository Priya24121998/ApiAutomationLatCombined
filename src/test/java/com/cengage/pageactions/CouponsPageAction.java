package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import org.testng.Assert;

public class CouponsPageAction extends BaseClass {

	public CouponsPageAction() {
		super();
	}

	/**
	 * Hit API to Add various percentage/ product base discount coupons to cart
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param coupon
	 * @param statusCode
	 */
	public static String applyCoupon(String baseSiteId, String userId, String cartId, String coupon, int statusCode) {
		String endpoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/vouchers";
		logMessage("**Add coupon to cart API: " + endpoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.queryParam("voucherId", coupon).post(endpoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		
		return response ;
	}

	/**
	 * HIt API to add external discount promocodes  to cart
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param coupon
	 * @param statusCode
	 */
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

	
	/**
	 * Hit API to remove Coupon from cart
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @param coupon
	 * @param statusCode
	 */
	public static void removeCoupon(String baseSiteId, String userId, String cartId, String coupon, int statusCode) {
		String endpoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/vouchers/" + coupon;
		logMessage("**Remove Coupon API: " + endpoint);

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String token = setAuthorizationHeader();
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON).when()
				.delete(endpoint).then().assertThat().statusCode(statusCode).extract().asString();

	}

	/**
	 * Verifies that api is returning proper error message.
	 * @param responseMap
	 */
	public void getCouponErrorMsg(JsonPath responseMap) {
		String msg = responseMap.getString("errors[0].message");
		String typ = responseMap.getString("errors[0].type");

		Assert.assertEquals(msg, "The coupon code is not valid.", "**[ASSERT FAILED]: Error message mismatch");
		logMessage("**[ASSERT PASSED]: Error message MATCHED");

		Assert.assertEquals(typ, "VoucherOperationError", "**[ASSERT FAILED]: Error Type Mismatch");
		logMessage("**[ASSERT PASSED]: Error Type MATCHED");
	}

	/**
	 * Verifies that api is returning proper error message. 
	 * @param responseMap
	 * @param message
	 */
	public void verifyErrorMessage(JsonPath responseMap, String message) {
		String actualMessage = responseMap.getString("errors[0].message");
		Assert.assertTrue(actualMessage.contains(message), "**[ASSERTION FAILED] Error message is::" + actualMessage);
		logMessage("**[ASSERTION PASSED] Verified error message is: " + actualMessage);
	}

	/**
	 * Verifies that  given response does not have any coupon applied on it 
	 * @param responseMap
	 */
	public static void verifCouponIsRemoved(JsonPath responseMap) {
		Assert.assertNull(responseMap.get("appliedCoupons[0].code"), "**[ASSERTION FAILED] Coupon is Not Removed");
		logMessage("**[ASSERTION PASSED] Coupon is Removed");
	}

	
	/**
	 * Search coupon in resonponse and match with Expected coupon
	 * @param responseMap
	 * @param expectedCoupon
	 * @param size
	 * @return
	 */
	public static boolean searchCoupon(JsonPath responseMap, String expectedCoupon, int size) {

		for (int j = 0; j < size; j++) {
			String actualCoupon = responseMap.get("appliedCoupons[" + j + "].code");
			if (expectedCoupon.equalsIgnoreCase(actualCoupon)) {
				return true;
			}
		}
		return false;
	}

}
