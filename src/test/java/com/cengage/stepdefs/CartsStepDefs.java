package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.CartsActions;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.path.json.JsonPath;
import org.testng.Reporter;

import java.util.Map;

@SuppressWarnings("deprecation")
public class CartsStepDefs extends BaseClass {

	public CartsStepDefs() {
		super();
	}

	CartsActions cartActions = new CartsActions();
	
	public static final String BASE_SITE_ID = PropFileHandler.readProperty("baseSiteId");
	static JsonPath responseMap;



//	Create Cart
	
	@When("I Hit the API to add cart to user account and verify status code")
	public static void addCart() {
		response = CartsActions.createACart(BASE_SITE_ID, userGUID, 201);
	}
	

	@When("I Hit the API to add cart to user account and verify status code E1")
	public static void addCarte1(Map<String, String> apiData) {
		response = CartsActions.createACartToSetShipToBillToAccount(apiData.get("basestore"),userID,apiData.get("status"));
	}
	
	

	@When("I Hit the API to add cart with IP to user account and verify status code")
	public static void addCartWithIP() {
		response = CartsActions.createACartwithIP(BASE_SITE_ID, userGUID, "TestIP", 201);
	}
	
	
	@When("I hit API to create (.*) cart")
	public static void b2BGTOneaddCartToAccount(String user, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		userID = PropFileHandler.readProperty(user + "_User");
		CartsActions.createACart(apiData.get("basestore"), userID, status);
		if (status == 400)
			if (user.equalsIgnoreCase("invalid"))
				CartsActions.verifyCartIsNotCreted("invalidUser");
			else
				CartsActions.verifyCartIsNotCreted(apiData.get("basestore"));
	}

	@When("I want to create anonymous cart")
	public static void createAnonymousCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		userID = "anonymous";
		response = CartsActions.createACart(apiData.get("basestore"), userID, status);

		anonymousCartId = cartId;
		anonymousCartGuid = authenticatedCartGuid;
	}

	@When("I create (.*) cart with ip address")
	public static void addCartToAccountWithIP(String user, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		userID = PropFileHandler.readProperty(user + "_User");
		response = CartsActions.createACartwithIP(apiData.get("basestore"), userID, apiData.get("IP"), status);

		if (status == 400)
			if (user.equalsIgnoreCase("invalid"))
				CartsActions.verifyCartIsNotCreted("invalidUser");
			else
				CartsActions.verifyCartIsNotCreted(apiData.get("basestore"));
	}
	
// Add product to Cart	
	
	@And("User adds (.*) product to cart")
	public void addProductTOCart(String product) {

		String payload = PropFileHandler.readPayloads(product);
		CartsActions.addProductToCartUsingPayload(BASE_SITE_ID, userGUID, cartId, payload, 200);
	}


	@And("User will add rental product (.*) to cart")
	public void addStandAloneRentalProductTOCart(String product) {

		String payload = PropFileHandler.readPayloads("StandAloneRentalSyntax");
		String isbnRunTime = System.getProperty("product");
		if(isbnRunTime== null || isbnRunTime.isEmpty() )
		{
			isbnRunTime =product;
		}
		payload = payload.replaceAll("#replaceRentalValue#", isbnRunTime);
		logMessage(payload);
		CartsActions.addProductToCartUsingPayload(BASE_SITE_ID, userGUID, cartId, payload, 200);
	}



	@And("User add B2B products to cart")
	public static void addB2BProductToCart(Map<String, String> apiData) {

		int status = getStatusCode(apiData.get("status"));
		String payload = PropFileHandler.readPayloads(apiData.get("Product"));
		if (userID.equalsIgnoreCase("anonymous"))
			response = CartsActions.addB2BProductToCart(apiData.get("basestore"), userID, authenticatedCartGuid, payload, status);
		else
			response = CartsActions.addB2BProductToCart(apiData.get("basestore"), userID, cartId, payload, status);
	}

	@And("User will pass B2B products to cart")
	public static void addB2BProductToCartByPassingIsbnAsValue(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String payload = PropFileHandler.readPayloads(apiData.get("Product"));
		if (userID.equalsIgnoreCase("anonymous"))
			response = CartsActions.addB2BProductToCart(apiData.get("basestore"), userID, authenticatedCartGuid, payload, status);
		else
			response = CartsActions.addB2BProductToCart(apiData.get("basestore"), userID, cartId, payload, status);
	}


	@And("User add B2C products to cart")
	public static void addB2CProductToCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String payload = PropFileHandler.readPayloads(apiData.get("Product"));
		if (userID.equalsIgnoreCase("anonymous"))
			response = CartsActions.addProductToCartUsingPayload(apiData.get("basestore"), userID, authenticatedCartGuid, payload,
					status);
		else
			response = CartsActions.addProductToCartUsingPayload(apiData.get("basestore"), userID, cartId, payload, status);
	}

	@And("User add B2C products to cart for the order number {int}")
	public static void addB2CProductToCartForOrderNumber(int order,Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String payload = excelRows.get(order).get("Payload"+order);
		if (userID.equalsIgnoreCase("anonymous"))
			response = CartsActions.addProductToCartUsingPayload(apiData.get("basestore"), userID, authenticatedCartGuid, payload,
					status);
		else
			response = CartsActions.addProductToCartUsingPayload(apiData.get("basestore"), userGUID, cartId, payload, status);
	}


//	Merge/ Anonymous cart
	
	@And("I hit api to add anonymous cart to (.*) user account")
	public static void mergeACarttoUserAccount(String user, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		userID = PropFileHandler.readProperty(user + "_User");
		response = CartsActions.mergeACarttoUserAccount(apiData.get("basestore"), userID, anonymousCartGuid, status);
	}

	@And("I merge anonymous cart with specified user cart")
	public static void mergeACartWithSpecifiedCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.mergeACarttoUserAccount(apiData.get("basestore"), userID, anonymousCartGuid, authenticatedCartGuid,
				status);
	}

	@And("I merge invalid anonymous cart (.*) user account")
	public static void mergeInvalidCarttoUserAccount(String user, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		userID = PropFileHandler.readProperty(user + "_User");
		response = CartsActions.mergeACarttoUserAccount(apiData.get("basestore"), userID, "Invalid", status);
	}

	@And("I merge anonymous cart with invalid user cart")
	public static void mergeACartWithInvalidCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.mergeACarttoUserAccount(apiData.get("basestore"), userID, anonymousCartGuid, "Invalid", status);
	}

	

	@Then("verify product in cart is (.*)")
	public void verifyProductInCart(String product)  {
		cartActions.verifyProduct(product, extractValueFromJOSNPath("entries[0].product.code", response));
	}
	
	@Then("I verify (.*) product in cart is (.*)")
	public void verifyProductInCart(int number, String product) {
		String result = null;
		JsonPath productPayploadMap = JsonPath.from(PropFileHandler.readPayloads(product));

		for (int i = 0; i < number; i++) {
			result = cartActions
					.verifyMultipleProduct(productPayploadMap.getString("orderEntries[" + i + "].product.code"));
			logMessage(result);
		}
	}
	
	@When("I hit API to get products in cart")
	public static void verifyB2BCartEntries(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		int size = Integer.parseInt(apiData.get("entries"));

		response = CartsActions.getACart(apiData.get("basestore"), userID, cartId, status);
		CartsActions.verifyEntriesInCart(response, size);
		responseMap = JsonPath.from(response);

		for (int i = 0; i < size; i++) {
			CartsActions.verifyProduct(responseMap, i, apiData.get("entries_" + i));
		}

	}
	
	@And("Verify rental extension for (.*)")
	public void verifyExentionProductInCart(String product) {
		String result = null;
		String productPaypload = PropFileHandler.readPayloads(product);
		JsonPath productPayploadMap = JsonPath.from(productPaypload);
		String productCode = productPayploadMap.getString("orderEntries[0].product.code");
		String text = productCode.trim();
		String[] parts = text.split("@@");
		productCode = parts[0];
		result = cartActions.verifyMultipleProduct(productCode + "@@15E");
		logMessage(result);
	}

//  Delete API steps 	

	@Then("I hit API to delete cart entry at position")
	public void verifyPriceValue(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		CartsActions.deleteEntryInCart(apiData.get("basestore"), userID, cartId, apiData.get("position"), status);
	}
	

	@When("I Hit the API to delete cart")
	public void deleteCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		CartsActions.deleteCart(apiData.get("basestore"), userID, cartId, status);
		logMessage("Cart deleted successfully, with CartID: " + cartId);
	}

	
	// Others
	@Then("I check (.*) amount is (.*)")
	public void verifyPriceValue(String priceType, String price) {
		if (price.equalsIgnoreCase("cuEligible")) {
			String cuEligible = PropFileHandler.readProperty("cuEligible");
			logMessage("CU Eligible Product totalPrice Price: " + cuEligible);
			cartActions.verifyPriceValue(priceType, cuEligible);
		} else {
			cartActions.verifyPriceValue(priceType, price);
		}

	}
	
	@When("I hit API to get Tax details")
	public static void verifyB2BCartTaxValue(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.getACart(apiData.get("basestore"), userID, cartId, status);
		responseMap = JsonPath.from(response);
		String tax = Float.toString(responseMap.get("totalTax.value"));
		compareResponseValue(tax, apiData.get("Tax"));

		PropFileHandler.writeProperty("TaxValue", tax);

	}

	@When("I Hit API to get Saved cart")
	public static void verifyB2BSaveCartStatusCode(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.getSaveCart(apiData.get("basestore"), userID, cartId, status);
	}
	
	@When("I Hit API to Saved cart")
	public static void saveCart(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.saveCurrentCart(apiData.get("basestore"), userID, cartId, apiData.get("saveCartName"), status);
	    logMessage(response);
	}
	
	@Then("Verify expirationTime is 2 years from saveTime in resonse")
	public void verifyStartAndExpireDate() throws java.text.ParseException {
		String actualsavedCartDate = extractValueFromJOSNPath("savedCartData.saveTime", response);
		Reporter.log(actualsavedCartDate);
		String expectedExpirationDate = addNumberOfYearsToDate(actualsavedCartDate,2);
		Reporter.log(expectedExpirationDate);
		String actualExpirationDate = extractValueFromJOSNPath("savedCartData.expirationTime", response);
		String actualExpirationDateWithoutTimeStamp = addNumberOfYearsToDateWithoutTimeStamp(actualExpirationDate);
		Reporter.log(actualExpirationDate);
		Reporter.log(actualExpirationDateWithoutTimeStamp);
		containsResponseValue(actualExpirationDateWithoutTimeStamp,expectedExpirationDate);
		}
	
	@And("^User add B2BCA products to cart with invalid product code$")
	public static void userAddB2BCAProductsToCartWithInvalidProductCode(Map<String,String>apiData) {
		int status = getStatusCode(apiData.get("status"));
		String payload = PropFileHandler.readPayloads(apiData.get("Product"));
		if (userID.equalsIgnoreCase("anonymous"))
			response = CartsActions.addB2BUSProductToCart(apiData.get("basestore"), userID, authenticatedCartGuid, payload, status);
		else
			response = CartsActions.addB2BUSProductToCart(apiData.get("basestore"), userID, cartId, payload, status);
	}
	
	@And("^I hit recalculate B2CEMEA cart API$")
	public static void iHitRecalculateB2CEMEACartAPI(Map<String,String>apiData) {
		
		int status = getStatusCode(apiData.get("status"));
		response = CartsActions.recalculateCartApi(apiData.get("basestore"), userID, cartId, status);
	    
	}


	@When("I hit API to create user cart for the order number {int}")
	public void iHitAPIToCreateUserCartForTheOrderNumberOrder(int order,Map<String,String> apiData) {

		int status = getStatusCode(apiData.get("status"));
		userID =excelRows.get(order).get("User"+order);
     	userGUID = excelRows.get(order).get("User Guid"+order);
		logMessage(userGUID);
		CartsActions.createACart(apiData.get("basestore"), userGUID, status);
		if (status == 400)
			if (userGUID.equalsIgnoreCase("invalid"))
				CartsActions.verifyCartIsNotCreted("invalidUser");
			else
				CartsActions.verifyCartIsNotCreted(apiData.get("basestore"));

	}
}
