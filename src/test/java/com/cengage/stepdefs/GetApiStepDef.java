package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.CWApiActions;
import com.cengage.pageactions.CartsActions;
import com.cengage.pageactions.GetApiActions;
import com.cengage.pageactions.OrdersAction;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.testng.Assert;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.Matchers.hasKey;
import static org.hamcrest.Matchers.not;

@SuppressWarnings("deprecation")
public class GetApiStepDef extends BaseClass {

	public GetApiStepDef() {
		super();
	}

	GetApiActions getApi = new GetApiActions();
	CartsActions cartActions = new CartsActions();
	CWApiActions cwapiActions = new CWApiActions();
	OrdersAction ordersActions = new OrdersAction();
	public static final String BASE_SITE_ID = PropFileHandler.readProperty("baseSiteId");

	//	Get APIs
	@Given("I Hit Api to create (.*) Token")
	public static void createWfsToken(String basestore) {
		authorizationValue = GetApiActions.getAuthorizationToken();
		logMessage(basestore + " Token created successfully");
	}

	@And("I hit get basestore details API")
	public static void getBaseStoreDetails(Map<String, String> apiData) {
		response = GetApiActions.getBaseStoreDetails(apiData.get("basestore"), apiData.get("status"));
	}

	@When("I hit get cart details API")
	public static void getB2BCartDetails(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		if (userID.equalsIgnoreCase("anonymous"))
			response = CartsActions.getACart(apiData.get("basestore"), userID, authenticatedCartGuid, status);
		else
			response = CartsActions.getACart(apiData.get("basestore"), userID, cartId, status);
	}

	@Then("User fetches cart details")
	public static void getCartDetails() {
		response = CartsActions.getACart(BASE_SITE_ID, userGUID, cartId, 200);
	}

	@When("I hit get order details API")
	public static void getOrderDetails(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = OrdersAction.getUsersOrder(apiData.get("basestore"), userID, OrderID, status);
	}

	@Then("User get order details")
	public static void getOrderDetails() {
		logMessage("Calling Get Order Api : ");
		response = OrdersAction.getOrder(BASE_SITE_ID, OrderID, 200);
		logMessage("order successfully Retrieve, with:\nID: " + OrderID);
	}

	@And("I hit get all units details")
	public static void getAllUnitsDetails(Map<String, String> apiData) {
		response = GetApiActions.getAllUnitsDetails(apiData.get("basestore"), apiData.get("currentPage"),
				apiData.get("pageSize"), apiData.get("status"));

	}

	@And("I hit get all Org units details")
	public static void getAllOrgUnitsDetails(Map<String, String> apiData) {
		response = GetApiActions.getAllUnitsDetails(apiData.get("basestore"), apiData.get("currentPage"),
				apiData.get("pageSize"), apiData.get("status"));
		
		JsonPath responseMap = JsonPath.from(response);
		ArrayList<String> e1AccountNumber = responseMap.get("b2bUnits.e1AccountNumber");
		logMessage("e1AccountNumber successfully Retrieved: " + e1AccountNumber);
		for(String e1AccNum : e1AccountNumber ) {
			
				if ( e1AccNum != null && e1AccNum.equals("161755") )
					logMessage("e1AccountNumber is : " + e1AccNum);			
		}
	}

	@And("I hit get customer Account details API")
	public static void getCustomerAccount(Map<String, String> apiData) {
		String email = PropFileHandler.readProperty("B2BCreatedUser");
		response = GetApiActions.getCustomerAccountDetails(apiData.get("basestore"), email, apiData.get("status"));

	}

	@And("I hit get user specific accounts deatails API")
	public static void userSpecificAccountsAPI(Map<String, String> apiData) {

		response = GetApiActions.getCustomerAccountDetails(apiData.get("basestore"),userID,apiData.get("status"));
		logMessage(response);
	}

	@And("I hit get b2bca customer Account details API")
	public static void getB2bCaCustomerAccount(Map<String, String> apiData) {
		String email = PropFileHandler.readProperty("B2BCACreatedUser");
		response = GetApiActions.getCustomerAccountDetails(apiData.get("basestore"), email, apiData.get("status"));
	}

	@And("I hit API to get specific orgUnit details")
	public static void getSpecificUnitDetails(Map<String, String> apiData) {
		response = GetApiActions.getSpecificUnitsDetails(apiData.get("basestore"), apiData.get("orgUnitID"),
				apiData.get("status"));
	}

	@And("I hit get customer details API")
	public static void getCustomerDetails(Map<String, String> apiData) {
		String email = PropFileHandler.readProperty("B2BCreatedUser");
		response = GetApiActions.getCustomerDetails(apiData.get("basestore"), email, apiData.get("status"));
	}

	@And("I hit search")
	public static void hitSearchAPI(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = GetApiActions.productSearchApi(apiData.get("basestore"), apiData.get("query"), status);
	}

	@And("I hit API to get a list countries")
	public static void getListOfCountries(Map<String, String> apiData) {
		response = GetApiActions.getListOfCountries(apiData.get("basestore"), apiData.get("type"), apiData.get("status"));
	}

	@And("I hit API to get states assosiated with country")
	public static void getListOfState(Map<String, String> apiData) {
		response = GetApiActions.getListOfStates(apiData.get("basestore"), apiData.get("countryCode"),
				apiData.get("status"));
	}

	@Then("I verify states in API response")
	public static void verifyStatesInResponse(Map<String, String> apiData) {
		JSONArray regions = extractJsonArrayFromResponse(response, "regions");
		int entry = 0;
		for (String isocode : apiData.keySet()) {
			GetApiActions.verifyState(isocode, apiData.get(isocode), (JSONObject) regions.get(entry++));
		}
	}

	@And("I Hit SOP Request API")
	public static void getSopRequestApi(Map<String, String> apiData) {
		int statusCode = getStatusCode(apiData.get("status"));
		if (apiData.get("cartId").equalsIgnoreCase("invalid")) {
			response = CWApiActions.getSopRequestApi(apiData.get("baseSiteId"), userID, "invalid", statusCode);
		} else {
			response = CWApiActions.getSopRequestApi(apiData.get("baseSiteId"), userID, cartId, statusCode);
		}

	}

	@And("I Hit SOP Response API")
	public static void getSopResponseApi(Map<String, String> apiData) {
		int statusCode = getStatusCode(apiData.get("status"));
		if (apiData.get("cartId").equalsIgnoreCase("invalid")) {
			response = CWApiActions.getSopResponseApi(apiData.get("baseSiteId"), userID, "invalid", statusCode);
		} else {
			response = CWApiActions.getSopResponseApi(apiData.get("baseSiteId"), userID, cartId, statusCode);
		}

	}

	@And("I hit PDP search")
	public static void hitPDPSearchAPI(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = GetApiActions.getProductDetailsApi(apiData.get("basestore"), apiData.get("product"), status);
	    logMessage(response);
	}

	@And("I hit product details API")
	public static void getProducyDetailsApi(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = GetApiActions.getProductDetailsApi(apiData.get("basestore"), apiData.get("query"),
				apiData.get("priceReferenceIds"), apiData.get("fields"), status);
	}

	@And("I hit specific product details API by passing pricemaster id as input")
	public static void getProductDetailsApiForPriceCheck(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		String productIsbn = PropFileHandler.readProperty("productIsbn");
		String priceReferenceIds = PropFileHandler.readProperty("cmePriceMasterId");
		response = GetApiActions.getProductDetailsApi(apiData.get("basestore"), productIsbn, priceReferenceIds, apiData.get("fields"), status);
	}

	@And("I need to hit specific product details API by passing priceref id as input")
	public static void getProductDetailsApiForPriceRefIdCheck(Map<String, String> apiData) {
		int statusget = getStatusCode(apiData.get("status"));
		String productIsbn = PropFileHandler.readProperty("productIsbn");
		String priceReferenceIds = PropFileHandler.readProperty("cmePriceRefId");
		response = GetApiActions.getProductDetailsApi(apiData.get("basestore"), productIsbn, priceReferenceIds, apiData.get("fields"), statusget);
	}

	//New code here
	@And("I hit get product details API")
	public static void getProductDetailsApi(Map<String, String> apiData) {
		int statusGet = getStatusCode(apiData.get("status"));
		response = GetApiActions.getProductDetailsApi(apiData.get("basestore"), apiData.get("product"),statusGet);
	}

	@And("I hit to get produts associated with bundle")
	public static void getBundleComponents(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = GetApiActions.getBundleComponents(apiData.get("basestore"), apiData.get("product"), status);
	}

	@And("^I will hit to get products associated with bundle and get the minimum stock price$")
	public static void hitGetProductsAssociatedWithBundleAndGetMinimumStockPrice(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = GetApiActions.getBundleComponentsAndGetMinStockPrice(apiData.get("basestore"), apiData.get("product"), status);
	}


	@And("I hit product details API to Commonly Used Query Parameters")
	public static void hitPDPSearchAPIQueryParameters(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = GetApiActions.getProductDetailsApiQueryParameters(apiData.get("basestore"), apiData.get("product"),apiData.get("field"), status);
	}


	@And("I hit search request with productSearchApi_BYTERM")
	public static void hitPDPSearchAPIQueryParametersByTerm(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = GetApiActions.productSearchApiBYTERM(apiData.get("basestore"), apiData.get("field"), status);
	}


	@And("I hit to get list of catalogs")
	public static void getListOfCatalogs(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = GetApiActions.getListOfCatalogs(apiData.get("basestore"), status);
	    logMessage(response);
	}

	@And("I hit api to get saved paymentInfo list for (.*)")
	public static void getListOfPaymentInfo(String user, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		userID = PropFileHandler.readProperty(user + "_User");
		response = GetApiActions.getListOfPaymentInfo(apiData.get("basestore"), userID, status);
	}

	@And("I hit API to get units associated with basestore")
	public static void getUnitsAssociatedWithBasestore(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = GetApiActions.getUnitsAssociatedWithBasestore(apiData.get("basestore"), apiData.get("siteId"),
				apiData.get("pageSize"), status);
	}

	@And("I get customer details")
	public static void getCustomerDetail(Map<String, String> apiData) {
		response = GetApiActions.getCustomerDetails(apiData.get("basestore"), userID, apiData.get("status"));
	
	
	}
	
	@And("e1AccountNumber is not being returned in get customer profile")
	public static void getcustomerProfile(Map<String, String> apiData) {
		Response response = GetApiActions.getcustomerprofiles(apiData.get("basestore"), userID, apiData.get("status"));
		response.then().body("$", not(hasKey("e1AccountNumber")));

	
	}
	
	
	@And("I Want to search product with following details")
	public static void hitSearchWithParametersAPI(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = GetApiActions.productSearchWithSortApi(apiData.get("basestore"), apiData.get("query"),
				apiData.get("sort"), status);
		logMessage(response);
	}

	@When("I hit api to get (.*) user order history")
	public static void getOrderHistory(String user, Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		userID = PropFileHandler.readProperty(user + "_User");
		response = OrdersAction.getOrderHistory(apiData.get("basestore"), userID, status);
	}

	//	Search Results
	@Then("I verify search results are in descending order")
	public void verifySearchResults() {
		getApi.verifySearchResultInDesendingOrderForCopyrightDate(response);
	}

	@Then("I check if result is sorted using fullTitle")
	public void verifySortedSearchResults() {
		getApi.verifySearchResultInDesendingOrderForFullTitle(response);
	}

	@Then("I check if result is sorted using PublishingDate")
	public void verifySortUsingPublishingDate() throws ParseException {
		getApi.VerifySearchResultInDesendingOrderForPublishingDate(response);
	}

	@Then("I check if result is sorted (.*) using PublishingDate")
	public void verifySortUsingPublishingDate(String sortOrder) throws ParseException {
		getApi.verifySearchResultInDesendingAndAscendingOrderForPublishingDate(response, sortOrder);
	}

	//	Price and Tax validations

	@When("I verify total amount is (.*)")
	public void verifyTotalAmount(String value) {
		String actualValue = extractValueFromJOSNPath("totalPriceWithTax.value", response);
		compareResponseValue(actualValue, value);
	}

	@And("I want check total amount is not (.*)")
	public void verifyTotalAmountisNot(String value) {
		String actualValue = extractValueFromJOSNPath("totalPriceWithTax.value", response);
		compareNotEqualValues(actualValue, value);
	}

	@And("I verify totalDiscounts amount is (.*)")
	public void verifyTotalDiscountsAmount(String value) {
		String actualValue = extractValueFromJOSNPath("totalDiscounts.value", response);
		compareResponseValue(actualValue, value);
	}

	@And("I want to check totalDiscounts amount is not (.*)")
	public void verifyTotalDiscountsAmountisNot(String value) {
		String actualValue = extractValueFromJOSNPath("totalDiscounts.value", response);
		compareNotEqualValues(actualValue, value);
	}

	@And("I want to check totalTax amount is not (.*)")
	public void verifyTotalTaxAmountisNot(String value) {
		String actualValue = extractValueFromJOSNPath("totalTax.value", response);
		compareNotEqualValues(actualValue, value);
	}

	@Then("I verify totalTax amount is (.*)")
	public void verifyTotalTaxAmountis(String value) {
		String actualValue = extractValueFromJOSNPath("totalTax.value", response);
		compareResponseValue(actualValue, value);
	}

	@Then("I get cuEligible price and save it")
	public void getCuEligibleOrderDetails() {
		String cuEligible = extractValueFromJOSNPath("totalPrice.value", response);
		logMessage("CU Eligible Product totalPrice: " + cuEligible);
		PropFileHandler.writeProperty("cuEligible", cuEligible);
	}

	@And("I want to get totalPrice and save it")
	public void getTotalPrice() {
		String totalPrice = extractValueFromJOSNPath("totalPrice.value", response);
		PropFileHandler.writeProperty("totalPrice", totalPrice);
		logMessage("**[INFO]:Total Price Value: " + totalPrice);

	}

	@Then("I verify totalPrice is recalculated")
	public void verifyTotalPriceIsRecalculated() {
		double totalPrice = Double.parseDouble(PropFileHandler.readProperty("totalPrice"));
		double latestTotalPrice = Double.parseDouble(extractValueFromJOSNPath("totalPrice.value", response));
		Assert.assertTrue(checkIfValueGreaterThan(latestTotalPrice, totalPrice));
		logMessage("**[ASSERT PASSED]:Actual Total Price Value " + latestTotalPrice
				+ " is recalculated, Previous value: " + totalPrice);
	}

	// Others
	@Then("I verify following details in API response")
	public void verifyPropertiesInResponse(Map<String, String> properties) {
		getApi.verifyPropertiesInResponse(JsonPath.from(response), properties);
	}


	@And("I will compare the specific (.*) in API response with (.*) value")
	public void verifyCmePropertyInResponse(String property, String expectedKey) {
		String expectedValue = PropFileHandler.readProperty(expectedKey);
		getApi.verifyPropertyInResponse(JsonPath.from(response), property, expectedValue);
	}



	@Then("I verify results in response")
	public void verifyDetailsInResponse(Map<String, String> apiData) {
		getApi.varifyDetailsInResponse(JsonPath.from(response), apiData);
	}

	@And("I look for (.*) in API response")
	public void verifyPropertyInResponse(String property) {
		String expectedValue = PropFileHandler.readProperty("B2BCreatedUser");
		getApi.verifyPropertyInResponse(JsonPath.from(response), property, expectedValue);
	}

	@And("I will get the respective (.*) in API response")
	public void verifyB2bCaPropertyInResponse(String property) {
		String expectedValue = PropFileHandler.readProperty("B2BCACreatedUser");
		getApi.verifyPropertyInResponse(JsonPath.from(response), property, expectedValue);
	}
	@And("Get the appropriate B2BGale (.*) in API response")
	public void verifyB2bCGalePropertyInResponse(String property) {
		String expectedValue = PropFileHandler.readProperty("B2BGT_User");
		getApi.verifyPropertyInResponse(JsonPath.from(response), property, expectedValue);
	}
	@And("I will get the appropriate B2BGale (.*) in API response")
	public void verifyB2bCGalePropertyInResponseLat(String property) {
		String expectedValue = PropFileHandler.readProperty("B2BGTOne_User");
		getApi.verifyPropertyInResponse(JsonPath.from(response), property, expectedValue);
	}

	@Then("I verify (.*) Account Numbers in API response")
	public void verifyAccountsInResponse(int pagesize) {
		getApi.verifyAccountsInResponse(JsonPath.from(response), pagesize);
	}

	@Then("I verify child accounts in API response")
	public void verifyChildAccountsInResponse() {
		getApi.verifyChildAccountsInResponse(JsonPath.from(response));
	}

	@Then("I verify ship to intermediate Unit child accounts set to true in API response")
	public void verifyIntermediateFnChildAccountsInResponse() {
		getApi.verifyIntermediateChildAccountsInResponse(JsonPath.from(response));
	}


	@And("I verify paymentType")
	public void verifyPaymentType() {
		cartActions.verifyPaymentType(JsonPath.from(response), "ACCOUNT");
	}

	@Then("I verify (.*) facet in api response")
	public void verifyFacetInResponse(String facet) {
		JSONArray facets = extractJsonArrayFromResponse(response, "facets");
		getApi.verifyFacetInResponse(facets, facet);
	}

	@Then("I verify SOP error")
	public static void verifySOPError(Map<String, String> apiData) {
		JsonPath responseMap = JsonPath.from(response);
		String actualMsg = responseMap.get("errors[0].message");
		String expectedMsg = PropFileHandler.readProperty(apiData.get("error"));
		Assert.assertTrue(actualMsg.contains(expectedMsg), "Value expected: " + expectedMsg + ", Found: " + actualMsg);
		String logString = "**[ASSERT PASSED]:Value expected : " + expectedMsg + ", Found: " + actualMsg;
		logMessage(logString);
		scenarioComment = scenarioComment + "\n" + logString;
	}

	@Then("I verify SOP api response")
	public void verifySOPApiResponse(Map<String, String> properties) {
		JsonPath responseMap = JsonPath.from(response);
		cwapiActions.verifySOPApiResponse(responseMap, properties);
	}

	@Then("I verify SOP api Request")
	public void verifySOPApiRequestResponse() {
		JsonPath responseMap = JsonPath.from(response);
		cwapiActions.verifySOPApiRequestResponse(responseMap);
	}

	@And("I wait for (.*) sec")
	public void waitForSec(int sec) {
		hardWait(sec);
		logMessage("Waited For " + sec + " seconds");
	}

	// Not Used
	@Then("I verify Tax is calculated")
	public void verifyTaxCalculation() {
		String taxValue = CWApiActions.getTaxValueDetilsFromResponse(response);
		Assert.assertFalse(taxValue.equalsIgnoreCase("0.0"), "**[ASSERT FAILED]: Tax Amount  is not as expected");
		logMessage("**[ASSERT PASSED]: Tax Amount  is as expected : " + taxValue);
	}

	@Then("I get previousOrder from response")
	public void getOrderId() {
		String previousOrder = OrderID;
		PropFileHandler.writeProperty("previousOrderId", previousOrder);
	}

	@Then("I verify previousOrderId in API response")
	public void verifyPreviousOrderIdInResponse() {
		Map<String, String> properties = new HashMap<>();
		String previousOrderId = PropFileHandler.readProperty("previousOrder");
		properties.put("previousOrderId", previousOrderId);
		getApi.verifyPropertiesInResponse(JsonPath.from(response), properties);

	}

	@And("^I will hit get B2BUS customer details API$")
	public static void hitB2BUSCustomerDetailsAPI(Map<String, String> apiData) {
		String email = PropFileHandler.readProperty("B2BUS_CreatedUser");
		response = GetApiActions.getCustomerDetails(apiData.get("basestore"), email, apiData.get("status"));
	}

	@And("^I will find B2BUS (.*) in API response$")
	public void verifyB2CUSCustomerIdInResponse(String property) {
		String expectedValue = PropFileHandler.readProperty("B2BUS_CreatedUser");
		getApi.verifyPropertyInResponse(JsonPath.from(response), property, expectedValue);
	}

	@And("^I will hit get B2BUS customer account details API$")
	public static void hitB2BUSCustomerAccountDetailsAPI(Map<String, String> apiData) {
		String email = PropFileHandler.readProperty("B2BUS_CreatedUser");
		response = GetApiActions.getCustomerAccountDetails(apiData.get("basestore"), email, apiData.get("status"));
	}

	@And("^I will hit get B2BGale customer details API$")
	public static void hitB2BGaleCustomerDetailsAPI(Map<String, String> apiData) {
		String email = PropFileHandler.readProperty("B2BGT_User");
		response = GetApiActions.getCustomerDetails(apiData.get("basestore"), email, apiData.get("status"));
	}

	@And("^I will be hitting get B2BGale customer details API$")
	public static void hitB2BGaleCustomerDetailsApiLat(Map<String, String> apiData) {
		String email = PropFileHandler.readProperty("B2BGTOne_User");
		response = GetApiActions.getCustomerDetails(apiData.get("basestore"), email, apiData.get("status"));
	}



	@And("^I will look for B2BGale (.*) in API response$")
	public void verifyB2CGaleCustomerIdInResponse(String property) {
		String expectedValueGet = PropFileHandler.readProperty("B2BGT_User");
		getApi.verifyPropertyInResponse(JsonPath.from(response), property, expectedValueGet);
	}

	@And("^I will hit get B2BGale customer account details API$")
	public static void hitB2BGaleCustomerAccountDetailsAPI(Map<String, String> apiData){
		String email = PropFileHandler.readProperty("B2BGT_User");
		response = GetApiActions.getCustomerAccountDetails(apiData.get("basestore"), email, apiData.get("status"));
	}

	@And("^I will be hitting get B2BGale customer account details API$")
	public static void hitB2BGaleCustomerAccountDetailsAPILat(Map<String, String> apiData){
		String email =  PropFileHandler.readProperty("B2BGTOne_User");
		response = GetApiActions.getCustomerAccountDetails(apiData.get("basestore"), email, apiData.get("status"));
		logMessage(response);
	}

}
