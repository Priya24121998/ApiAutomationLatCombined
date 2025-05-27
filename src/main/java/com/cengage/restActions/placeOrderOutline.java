/**
 * This class contains REST actions related to placing an order outline.
 * It provides the necessary methods to handle the business logic for
 * creating and managing order outlines in the system.
 *
 * <p>Usage:</p>
 * This class is intended to be used as part of the API layer to handle
 * HTTP requests and responses for order outline operations.
 *
 * <p>Note:</p>
 * Ensure that all required dependencies and configurations are properly
 * set up before using this class.
 *
 */
package com.cengage.restActions;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;

import com.cengage.b2b.placeOrderApplication.*;
import com.cengage.b2c.placeOrderApplication.OrderPlacementControllerB2C;
import com.cengage.common.BrowserUtils;
import com.cengage.common.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;

public class placeOrderOutline extends OrderWorkFlow {

	private OrderWorkFlow placeObj;

	public placeOrderOutline(OrderWorkFlow placeObj) {
		this.placeObj = placeObj;
	}

	private static String authorizationValue;
	public static String userID, rentalID, oldRentalEndDate;
	public static String storeType;
	static Map<String, String> usercreationPayloadHashMap = new HashMap<String, String>();
	static int i = 0;

	public static void getaccessToken() {
		authorizationValue = OrderWorkFlow.getAuthorizationToken();
	}

	public static void createCart(String username, String baseSiteId, String store, int statusCode) {
		userID = username;
		logMessage(userID);
		response = OrderWorkFlow.createACart(baseSiteId, userID, statusCode);

		if (statusCode == 400)
			if (userID.equalsIgnoreCase("invalid"))
				OrderWorkFlow.verifyCartIsNotCreted("invalidUser");
			else
				OrderWorkFlow.verifyCartIsNotCreted(baseSiteId);
	}

	@SuppressWarnings("unchecked")
	public static void setShipToBillTo(String baseSiteId, String store, int statusCode, String account) {
		storeType = baseSiteId;
		int status = statusCode;
		String shipToAccountNo = account;
		String billToAccountNo = account;
		JSONObject payload = new JSONObject();
		payload.put("shipToAccountNumber", shipToAccountNo);
		payload.put("billToAccountNumber", billToAccountNo);

		try {
			response = OrderWorkFlow.addB2S2ToCart(baseSiteId, userID, cartId, payload.toString(), status);
			logMessage("Ship To Bill To Response :" + response);
		} catch (NullPointerException e) {
			logMessage("Exception occured");
		}

	}

	public static void addProdToCart(String baseSiteId, String store, int statusCode) {
		int status = 200;
		String payload = null;
		if (store.equalsIgnoreCase("B2BCA")) {
			payload = PropFileHandler.readPayloads("b2bProduct_ca_ErpPhase");

		} else if (store.equalsIgnoreCase("B2BGT")) {
			payload = PropFileHandler.readPayloads("b2bProduct_gt_ErpPhase");
		} else if (store.equalsIgnoreCase("B2BUS")) {
			payload = PropFileHandler.readPayloads("b2bProduct_us_ErpPhase");
		}

		if (userID.equalsIgnoreCase("anonymous"))
			response = OrderWorkFlow.addB2BProductToCart(baseSiteId, userID, authenticatedCartGuid, payload, status);
		else
			response = OrderWorkFlow.addB2BProductToCart(baseSiteId, userID, cartId, payload, status);
	}

	public static void addProdToCart(String baseSiteId, String store, int statusCode, String isbnType) {
		int status = 200;
		String payload = null;
		if (store.equalsIgnoreCase("B2BCA")) {

			payload = PropFileHandler.readPayloads("b2bProduct_ca_ErpPhase3");
			isbnType = OrderPlacementController.isbnOptionSelected;
			payload = payload.replaceAll("#isbn", isbnType);
			logMessage(payload);
		} else if (store.equalsIgnoreCase("B2BGT")) {
			payload = PropFileHandler.readPayloads("b2bProduct_gt_ErpPhase3");
			isbnType = OrderPlacementController.isbnOptionSelected;
			payload = payload.replaceAll("#isbn", isbnType);
			logMessage(payload);
		} else if (store.equalsIgnoreCase("B2BUS")) {
			payload = PropFileHandler.readPayloads("b2bProduct_us_ErpPhase3");
			isbnType = OrderPlacementController.isbnOptionSelected;
			payload = payload.replaceAll("#isbn", isbnType);
			logMessage(payload);
		}

		if (userID.equalsIgnoreCase("anonymous"))
			response = OrderWorkFlow.addB2BProductToCart(baseSiteId, userID, authenticatedCartGuid, payload, status);
		else
			response = OrderWorkFlow.addB2BProductToCart(baseSiteId, userID, cartId, payload, status);
	}

	public static void addProdToCartFastPaced(String baseSiteId, String store, int statusCode,
			org.json.JSONObject addProdReqPayload) {
		int status = 200;
		String payload = addProdReqPayload.toString();
		System.out.println(payload);
		if (userID.equalsIgnoreCase("anonymous"))
			response = OrderWorkFlow.addB2BProductToCart(baseSiteId, userID, authenticatedCartGuid, payload, status);
		else
			response = OrderWorkFlow.addB2BProductToCart(baseSiteId, userID, cartId, payload, status);
	}

	public static void addProdToCartFastPacedB2C(String baseSiteId, String store, int statusCode,
			org.json.JSONObject addProdReqPayload) {
		int status = 200;
		String payload = addProdReqPayload.toString();
		System.out.println(payload);
		if (userID.equalsIgnoreCase("anonymous"))
			response = OrderWorkflowB2C.addProductToCartUsingPayload(baseSiteId, userID, authenticatedCartGuid, payload,
					status);
		else
			response = OrderWorkflowB2C.addProductToCartUsingPayload(baseSiteId, userID, cartId, payload, status);
	}

	public static void addB2CProductToCart(String basestore) {
		int status = 200;
		String payload = PropFileHandler.readPayloads("b2cAuPayloadSyntax");
		payload = payload.replaceAll("#isbn", OrderPlacementControllerB2C.isbnSelected);
		if (userID.equalsIgnoreCase("anonymous"))
			response = OrderWorkflowB2C.addProductToCartUsingPayload(basestore, userID, authenticatedCartGuid, payload,
					status);
		else
			response = OrderWorkflowB2C.addProductToCartUsingPayload(basestore, userID, cartId, payload, status);
	}

	public static void addDeliveryAddressToCart(String baseStore, String address) {
		int status = 201;
		String payload = PropFileHandler.readPayloads(address);
		OrderWorkflowB2C.addDeliveryAddressToCart(baseStore, userID, cartId, payload, status);
	}

	public static void addBillingAddressToCart(String baseStore, String address) {
		int status = 201;
		String payload = PropFileHandler.readPayloads(address);
		OrderWorkflowB2C.addBillingAddressToCart(baseStore, userID, cartId, payload, status);
	}

	public static void getDeliveryModes(String baseStore) {
		int statusGet = 200;
		if (userID == null) {
			userID = OrderPlacementControllerB2C.userId;

		}
		response = OrderWorkflowB2C.getDeliveryModes(baseStore, userID, cartId, statusGet);
	}

	public static void putB2CDeliveryModes(String basestore, String delmode) {
		int status = 200;
		OrderWorkflowB2C.putDeliveryModes(basestore, userID, cartId, delmode, status);
	}

	public static void setdeliveryMode(String baseSiteId, String delMode) {

		int status = 200;
		OrderWorkFlow.putDeliveryModes(baseSiteId, userID, cartId, delMode, status);
	}

	public static void updatePODetails(String baseSiteId, String poNumber) {
		int status = 200;
		response = OrderWorkFlow.putPONumber(baseSiteId, userID, poNumber, cartId, status);
		OrderWorkFlow.verifyPaymentType(JsonPath.from(response), "ACCOUNT");
	}

	public static void placeOrder(String site, String baseSiteId, String store, int statusCode) {
		int status = statusCode;
		if (site.equalsIgnoreCase("B2C")) {

			response = OrderWorkflowB2C.placeB2COrder(baseSiteId, userID, cartId, status);
		} else if (site.equalsIgnoreCase("B2B")) {
			response = OrderWorkFlow.placeB2BOrder(baseSiteId, userID, cartId, status);
		}

		if (status != 400)
			logMessage("Order placed with ID: " + OrderID);
	}

	public static String getApplicationPath(String baseSiteId, String userId, String cartId) {
		String cybersourcePath = PropFileHandler.readProperty("CyberSource");
		cybersourcePath = cybersourcePath + "?basesite=" + baseSiteId + "&user=" + userId + "&cart=" + cartId;
		return cybersourcePath;

	}

	public static void launchCyberSource(String baseSiteId) {
		String applicationPath = placeOrderOutline.getApplicationPath(baseSiteId, userID, cartId);
		BrowserUtils.launchApplication(applicationPath);
	}

	public static void launchCyberSourceAndCompleteCCPayment(String creditCardType, String baseSiteId) {

		try {
			BrowserUtils.launchBrowser("edge");
		} catch (Exception e) {
			logMessage("Exception " + e);
		}

		try {
			BrowserUtils.waitForSec(15);
			placeOrderOutline.launchCyberSource(baseSiteId);
			UIActions.enterCCDetails(creditCardType);
			BrowserUtils.waitForSec(45);
			UIActions.verifyMessage("ACCEPT");
			BrowserUtils.waitForSec(8);
			BrowserUtils.exitBrowser();
		}

		catch (Exception e) {
			BrowserUtils.exitBrowser();
		}

	}

	public static String addPhysicalIsbnToCart(String isbnPhysical) {
		return isbnPhysical;

	}

	public static String addDigitalIsbnToCart(String isbnDigital) {
		return isbnDigital;

	}

	public static String addBundleIsbnToCart(String isbnBundle) {
		return isbnBundle;

	}

	public static void applyPromoCode(String baseStore, String store, int status, String promoCodeGet) {
		int statusGet = 200;
		logMessage("**[INFO] Applying [" + promoCodeGet + "] to cart");
		response = OrderWorkFlow.applyPromocode(baseStore, userID, cartId, promoCodeGet, statusGet);

	}

	public static void launchFullAuthNewPaypalURLForB2C(String baseStore, int status) {

		String applicationPath = OrderWorkflowB2C.getApplicationPathPaypal(baseStore, userID, cartId, status);
		if (status != 400) {
			logMessage(applicationPath);
			OrderWorkflowB2C.getPayPalTokenNew(applicationPath);
			BrowserUtils.launchBrowser("edge");
			BrowserUtils.waitForSec(15);
			BrowserUtils.launchApplication(applicationPath);
		}
	}

	public static void verifyPayPalPortalHasLaunched() {
		OrderWorkflowB2C.verifyPayPalPortalHasLaunched();

	}

	public static void completeFullAuthNewPaypalTransaction() {
		BrowserUtils.hardWait(5);
		try {
			UIActions.enterPayPalEmail(PropFileHandler.readProperty("ppUsername3"));
			UIActions.clickNextButton();
			BrowserUtils.hardWait(3);
			UIActions.enterPayPalPassword(PropFileHandler.readProperty("ppPassword3"));
			UIActions.clickOnLoginButton();
			BrowserUtils.hardWait(3);
			UIActions.completeNewPaypalTransaction();
			BrowserUtils.exitBrowser();
		} catch (Exception e) {
			UIActions.completeNewPaypalTransaction();
			BrowserUtils.exitBrowser();
		}
	}

	public static void placeOrderUsingPaypalNewFullAuth(String basestore, int status) {
		if (basestore.equalsIgnoreCase("cengage-b2c-au")) {
			String payerId = PropFileHandler.readProperty("payerIdB2CAU");
			OrderWorkflowB2C.placeOrderUsingNewPayPal(basestore, userID, cartId, status, payerId);

		} else if (basestore.equalsIgnoreCase("cengage-b2c-us")) {
			String payerId = PropFileHandler.readProperty("payerIdB2CUS");
			OrderWorkflowB2C.placeOrderUsingNewPayPal(basestore, userID, cartId, status, payerId);
		} else if (basestore.equalsIgnoreCase("cengage-b2c-ca")) {
			String payerId = PropFileHandler.readProperty("payerIdB2CCA");
			OrderWorkflowB2C.placeOrderUsingNewPayPal(basestore, userID, cartId, status, payerId);
		} else if (basestore.equalsIgnoreCase("cengage-b2c-emea")) {
			String payerId = PropFileHandler.readProperty("payerIdB2CEMEA");
			OrderWorkflowB2C.placeOrderUsingNewPayPal(basestore, userID, cartId, status, payerId);
		}
		logMessage("Order placed with ID: " + OrderID);

	}

	public static void createSubscription(String user, String type) {

		userGUID = user;
		if (type.contains("Pv"))
			OrderWorkflowB2C.createSubscriptionApi(PropFileHandler.readSKU_PlanID(type), userGUID, 400, null, 0);
		else
			OrderWorkflowB2C.createSubscriptionApi(PropFileHandler.readSKU_PlanID(type), userGUID, 201, null, 0);
	}

	public static void verifyAPIResponseValueForAPariticularField(String apiGet, String field, String expectedValue) {
		String value;
		if (apiGet.equalsIgnoreCase("get state"))
			response = OrderWorkflowB2C.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		else if (apiGet.equalsIgnoreCase("get details"))
			response = OrderWorkflowB2C.getSubscriptioDetailsForGivenCustomerGUID(userGUID, 200);

		value = BaseClass.extractValuefromResponse(response, field);

		if (field.contains("Date")) {
			value = BaseClass.extractDateFromWholeString(value);
		}

		compareResponseValue(value, expectedValue);
	}

	public static void addProductToCart(String product) {

		String payload = PropFileHandler.readPayloads(product);
		OrderWorkflowB2C.addProductToCartUsingPayload(PropFileHandler.readProperty("baseSiteId"), userGUID, cartId,
				payload, 200);
	}

	public static void addProductToCart(String userId, String product) {
		String payload = null;
		if (product.equalsIgnoreCase("4")) {
			payload = PropFileHandler.readPayloads("4Mon_Payload");
		} else if (product.equalsIgnoreCase("12")) {
			payload = PropFileHandler.readPayloads("12Mon_Payload");
		}
		userGUID = userId;
		logMessage(userGUID);
		OrderWorkflowB2C.addProductToCartUsingPayload(PropFileHandler.readProperty("baseSiteId"), userGUID, cartId,
				payload, 200);
	}

	public static void logTestData(String userType) {
		if (userType.equalsIgnoreCase("Cart")) {
			OrderWorkflowB2C.logTestDataCart();
		} else if (userType.contains("CU24")) {
			OrderWorkflowB2C.logTestDataForCU24(userType);
		} else {
			OrderWorkflowB2C.getOrder(PropFileHandler.readProperty("baseSiteId"), OrderID, 200);
			if (userType.equalsIgnoreCase("subscription")) {
				OrderWorkflowB2C.logTestDataForSubs();
			} else if (userType.equalsIgnoreCase("rentals")) {
				OrderWorkflowB2C.logTestDataForRentals();
			} else if (userType.equalsIgnoreCase("discountedRentals")) {
				OrderWorkflowB2C.logTestDataForDiscountedRentals();
			} else if (userType.equalsIgnoreCase("Normal")) {
				OrderWorkflowB2C.logTestData();
			}
		}
	}

	public static void createNewUserAndActivateUser(String type) throws IOException {

		// creation and activation
		Map<String, String> userInfo = new HashMap<>();
		userInfo = OrderWorkflowB2C.emailAndPassOfReturninguserForOktaBySoapApi(type);
		userID = userInfo.get("email");
		userGUID = userInfo.get("guid");
		PropFileHandler.writeProperty(type, userID);
	}

	public static void createB2CUserUsingSAPApi(String store) {
		String payload = OrderWorkflowB2C.customerPayload("automation", "FirstName", "LastName", store);
		response = OrderWorkflowB2C.registerACustomer(PropFileHandler.readProperty(store + "_BaseStore"), payload, 201);

		JsonPath responseMap = JsonPath.from(response);
		userID = responseMap.get("customerId");
		userGUID = responseMap.get("uid");
		PropFileHandler.writeProperty(store + "_User", userID);
		PropFileHandler.writeProperty(store + "_UserGuid", userGUID);

		logMessage("User created Successfully: " + userID);
		logMessage("User guid created Successfully: " + userGUID);
	}

	public static void checkRentalPlanID(String expectedID) {
		String actualID;
		String response = OrderWorkflowB2C.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		logMessage(response);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		actualID = extractValueFromJOSNPath("rentals[0].rentalPlanId", response);

		compareResponseValue(actualID, expectedID);

	}

	public static void verifyRentalStatus(String expected) {
		String rentalStatus;
		String response = OrderWorkflowB2C.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalStatus = extractValueFromJOSNPath("rentals[0].rentalState", response);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		logMessage(response);

		logMessage("**[INFO] RentalId : " + rentalID);
		compareResponseValue(expected, rentalStatus);

	}

	public static void getRentalEndDate() {

		String response = OrderWorkflowB2C.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		oldRentalEndDate = extractValueFromJOSNPath("rentals[0].endDate", response);
		logMessage("Rental EndDate: " + oldRentalEndDate);
		PropFileHandler.writeProperty("rentalEndDate", oldRentalEndDate);
	}

	public static void userShouldBeAbleToShipRental() {
		String response = OrderWorkflowB2C.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		OrderWorkflowB2C.updateStausOfRentalOrder(PropFileHandler.readProperty("baseSiteId"), OrderID, rentalID, 200);
	}

	public static void extendRentalForDays(String days) {
		OrderWorkflowB2C.extendRental(PropFileHandler.readProperty("baseSiteId"), userGUID, cartId, rentalID, days);
	}

	public static void checkIsRentalExtended(int days) {

		String response = OrderWorkflowB2C.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		String endDate = extractValueFromJOSNPath("rentals[0].endDate", response);
		endDate = extractDateFromWholeString(endDate);
		String expectedEndDate = addNumOfDaysToDate(oldRentalEndDate, days);
		compareResponseValue(endDate, expectedEndDate);
	}

	public static void returnOfTextbookAndModifyRentalStateAccordingly(String state) {
		String rentalID;
		String response = OrderWorkflowB2C.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		OrderWorkflowB2C.returnOfTextbookAndModifyRentalStateAccordingly(rentalID, state, 200);
	}

	public static void rentalBuyout() {
		OrderWorkflowB2C.rentalBuyout(PropFileHandler.readProperty("baseSiteId"), userID, cartId, rentalID);
	}

	public static void applyVouchers(String coupon, String baseStore) {
		int status = 200;
		logMessage("**[INFO] Applying [" + coupon + "] to cart");
		response = OrderWorkflowB2C.applyCoupon(baseStore, userID, cartId, coupon, status);
	}

	public static void setDropShip(String basestore, String address) {
		int status = 201;
		String payload = PropFileHandler.readPayloads(address);
		try {
			OrderWorkFlow.createDropShipAddressForCart(basestore, userID, cartId, payload, status);
		} catch (NullPointerException e) {
			OrderWorkFlow.createDropShipAddressForCart(basestore, userID, cartId, payload, status);
		}
	}

}
