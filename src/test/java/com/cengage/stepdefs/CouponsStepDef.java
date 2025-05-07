package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.CartsActions;
import com.cengage.pageactions.CouponsPageAction;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.path.json.JsonPath;
import org.testng.Assert;

import java.util.Map;

@SuppressWarnings("deprecation")
public class CouponsStepDef extends BaseClass {

	public CouponsStepDef() {
		super();
	}

	CouponsPageAction couponPage = new CouponsPageAction();
	CartsActions cartActions = new CartsActions();
	public static final String BASE_SITE_ID = PropFileHandler.readProperty("baseSiteId");

	@Then("User Apply Coupon (.*)")
	public static void applyCoupon(String coupon) {
		if (coupon.equalsIgnoreCase("invalid")) {
			response = CouponsPageAction.applyCoupon(BASE_SITE_ID, userGUID, cartId, coupon, 400);
		} else {

			String code = PropFileHandler.readProperty(coupon);
			response = CouponsPageAction.applyCoupon(BASE_SITE_ID, userGUID, cartId, code, 200);
		}
	}

	@When("I try to apply vouchers")
	public static void applyVouchers(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String coupon = PropFileHandler.readProperty(apiData.get("voucherID"));
		logMessage("**[INFO] Applying [" + coupon + "] to cart");
		response = CouponsPageAction.applyCoupon(apiData.get("basestore"), userID, cartId, coupon, status);
	}

	@When("I will try to apply vouchers by passing UserGuid")
	public static void applyVouchersUsingGuid(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String coupon = PropFileHandler.readProperty(apiData.get("voucherID"));
		logMessage("**[INFO] Applying [" + coupon + "] to cart");
		response = CouponsPageAction.applyCoupon(apiData.get("basestore"), userGUID, cartId, coupon, status);
	}

	@When("I try to apply promocode")
	public static void applyPromoCode(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String coupon = PropFileHandler.readProperty(apiData.get("promoCode"));
		logMessage("**[INFO] Applying [" + coupon + "] to cart");
		response = CouponsPageAction.applyPromocode(apiData.get("basestore"), userID, cartId, coupon, status);
	}

	@When("I will try to apply promocode by passing UserGuid")
	public static void applyPromoCodeUsingGuid(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String coupon = PropFileHandler.readProperty(apiData.get("promoCode"));
		logMessage("**[INFO] Applying [" + coupon + "] to cart");
		response = CouponsPageAction.applyPromocode(apiData.get("basestore"), userGUID, cartId, coupon, status);
	}


	@When("I want to apply B2B coupon")
	public static void applyB2BVouchers(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String coupon = PropFileHandler.readProperty("B2BUSPromo");
		logMessage("**[INFO] Applying [" + coupon + "] to cart");
		response = CouponsPageAction.applyPromocode(apiData.get("basestore"), userID, cartId, coupon, status);
	}

//	Remove Coupons
	@When("I try to remove promocode")
	public void removeCoupon(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String coupon = PropFileHandler.readProperty(apiData.get("promoCode"));
		CouponsPageAction.removeCoupon(apiData.get("basestore"), userID, cartId, coupon, status);
	}

	@When("I Want to remove b2b promocode")
	public void removeb2bCoupon(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String coupon = PropFileHandler.readProperty("B2BUSPromo");
		CouponsPageAction.removeCoupon(apiData.get("basestore"), userID, cartId, coupon, status);
	}

	@Then("I verify B2C coupon is Removed")
	public static void verifyB2CCouponRemoved(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.getACart(apiData.get("basestore"), userID, cartId, status);
		CouponsPageAction.verifCouponIsRemoved(JsonPath.from(response));
	}

	@Then("I verify coupon is Removed")
	public static void verifyB2BCouponRemoved(Map<String, String> apiData) {
		int statusGet = getStatusCode(apiData.get("status"));
		response = CartsActions.getACart(apiData.get("basestore"), userID, cartId, statusGet);
		CouponsPageAction.verifCouponIsRemoved(JsonPath.from(response));
	}

// Coupons Applied Checks 
	@Then("I verify coupon is applied")
	public static void verifyB2BCoupon(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.getACart(apiData.get("basestore"), userID, cartId, status);
		JsonPath responseMap = JsonPath.from(response);
		try {
			couponCodeGet = responseMap.get("appliedCoupons[0].voucherCode");
			compareResponseValue(couponCodeGet, PropFileHandler.readProperty(apiData.get("promoCode")));
		} catch (NullPointerException e) {
			couponCodeGet = responseMap.get("deliveryOrderGroups[0].entries[0].appliedCoupons[0].code");
			compareResponseValue(couponCodeGet, PropFileHandler.readProperty(apiData.get("promoCode")));
		}
	}

	@Then("I verify B2C coupon is applied")
	public static void verifyB2CCoupon(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.getACart(apiData.get("basestore"), userID, cartId, status);
		JsonPath responseMap = JsonPath.from(response);
		String couponCode = responseMap.get("appliedCoupons[0].code");
		compareResponseValue(couponCode, PropFileHandler.readProperty(apiData.get("voucherID")));
	}

	@Then("I will verify B2C coupon is applied by passing UserGuid")
	public static void verifyB2CCouponUsingUserGuid(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.getACart(apiData.get("basestore"), userGUID, cartId, status);
		JsonPath responseMap = JsonPath.from(response);
		String couponCode = responseMap.get("appliedCoupons[0].code");
		compareResponseValue(couponCode, PropFileHandler.readProperty(apiData.get("voucherID")));
	}

	@Then("I verify (.*) B2C coupons are applied")
	public static void verifyB2CCoupon(int numbers, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		boolean flag = false;
		response = CartsActions.getACart(apiData.get("basestore"), userID, cartId, status);
		JsonPath responseMap = JsonPath.from(response);
		for (int i = 0; i < numbers; i++) {
			String coupon = PropFileHandler.readProperty(apiData.get("voucherID_" + i));
			flag = CouponsPageAction.searchCoupon(responseMap, coupon, numbers);
			Assert.assertTrue(flag, "**[ASSERT FAILED]: Actual response value does not match expected value");
			logMessage("**[ASSERT PASSED]: Actual response value: ["+coupon+"], matches with exepcted ["+coupon+"] value");
		}
	}

//	Error And Verifications
	@Then("I verify Coupon Error Msg")
	public void verifycouponErroMsg() {
		couponPage.getCouponErrorMsg(JsonPath.from(response));
	}

	@Then("I verifies Promocode Error massage")
	public void verifyErrorMsg(Map<String, String> apiData) {
		couponPage.verifyErrorMessage(JsonPath.from(response), apiData.get("Msg"));
	}

}
