package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.testng.Assert;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.TimeUnit;

public class GetApiActions extends BaseClass {
	public GetApiActions() {
		super();
	}

	/**
	 * Get System Authorization Token
	 * 
	 * @param basestore
	 * @return
	 */
	public static String getAuthorizationToken() {
		String endpoint = PropFileHandler.readProperty("authorization");
		String clientID = PropFileHandler.readProperty("clientId2");
		String secretID = PropFileHandler.readProperty("secretId2");
		response = RestAssured.given().auth().preemptive().basic(clientID, secretID)
				.header("Content-Type", "application/x-www-form-urlencoded")
				.formParam("grant_type", "client_credentials").when().post(endpoint).then().assertThat().statusCode(200)
				.extract().asString();
		JsonPath responseObj = JsonPath.from(response);
		String accessToken = responseObj.get("access_token");
		String tokenType = responseObj.get("token_type");
		tokenType = tokenType.substring(0, 1).toUpperCase() + tokenType.substring(1).toLowerCase();
		return tokenType + " " + accessToken;

	}

	/**
	 * Hit Api to get a baseStore details
	 * 
	 * @param baseSiteId
	 * @param status
	 * @return
	 */
	public static String getBaseStoreDetails(String baseSiteId, String status) {
		String endPoint = "/" + baseSiteId + "/basestores/" + baseSiteId;
		int statusGet = getStatusCode(status);
		logMessage("**[INFO] Get A BaseStore API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		Response responseOut = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(statusGet).extract()
				.response();

		response = responseOut.asString();
		long timeInSeconds = responseOut.timeIn(TimeUnit.SECONDS);
		logMessage("Response time : "+timeInSeconds + " seconds");

		return response;
	}

	/**
	 * Hit API to Get All B2B Root Units
	 * 
	 * @param baseSiteId
	 * @param currentPage
	 * @param pageSize
	 * @param status
	 * @return
	 */
	public static String getAllUnitsDetails(String baseSiteId, String currentPage, String pageSize, String status) {
		String endPoint = "/" + baseSiteId + "/rootUnits";
		int statusGet = getStatusCode(status);
		logMessage("**[INFO] Get all Unit API: " + endPoint);

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		Response responseOut = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").queryParam("currentPage", currentPage).queryParam("pageSize", pageSize)
				.get(endPoint).then().assertThat().statusCode(statusGet).extract().response();

		response = responseOut.asString();
		logMessage(response);
		long timeInSeconds = responseOut.timeIn(TimeUnit.SECONDS);
		logMessage("Response time : "+timeInSeconds + " seconds");

		return response;

	}

	/**
	 * Returns all B2B Root units based on store
	 * 
	 * @param baseSiteId
	 * @param siteId
	 * @param pageSize
	 * @param status
	 * @return
	 */
	public static String getUnitsAssociatedWithBasestore(String baseSiteId, String siteId, String pageSize,
			int status) {
		String endPoint = "/" + baseSiteId + "/orgUnits/rootUnitsBySiteId";
		logMessage("**[INFO] Get Units Associated With Basestore API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("baseSiteId", siteId).queryParam("pageSize", pageSize).get(endPoint).then().assertThat()
				.statusCode(status).extract().asString();
		return response;
	}

	/**
	 * Hit API to get specific B2B unit details
	 * 
	 * @param baseSiteId
	 * @param orgUnit
	 * @param status
	 * @return
	 */
	public static String getSpecificUnitsDetails(String baseSiteId, String orgUnit, String status) {
		String endPoint = "/" + baseSiteId + "/orgUnits/" + orgUnit;
		int statusGet = getStatusCode(status);
		logMessage("**[INFO] Get Specific Unit Details API: " + endPoint);

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		Response responseOut = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(statusGet).extract().response();
		response = responseOut.asString();
		long timeInSeconds = responseOut.timeIn(TimeUnit.SECONDS);
		logMessage("Response time : "+timeInSeconds + " seconds");
		return response;

	}

	/**
	 * Hit Api to get B2B customer Account details
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param status
	 * @return
	 */
	public static String getCustomerAccountDetails(String baseSiteId, String userId, String status) {
		String endPoint = "/" + baseSiteId + "/orgUsers/" + userId + "/accounts";
		int statusGet = getStatusCode(status);
		logMessage("**[INFO] Get User Account Details API: " + endPoint);

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.get(endPoint).then().assertThat().statusCode(statusGet).extract().asString();
		
		return response;

	}

	/**
	 * Hit Api to get B2B user details
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param status
	 * @return
	 */
	public static String getCustomerDetails(String baseSiteId, String userId, String status) {
		String endPoint = "/" + baseSiteId + "/orgUsers/" + userId;
		int statusGet = getStatusCode(status);
		logMessage("**[INFO] Get User Details API: " + endPoint);

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		Response responseOut = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.get(endPoint).then().assertThat().statusCode(statusGet).extract().response();

		response = responseOut.asString();
		logMessage(response);
		long timeInSeconds = responseOut.timeIn(TimeUnit.SECONDS);
		long timeInMilliSeconds = responseOut.timeIn(TimeUnit.MILLISECONDS);
		logMessage("Response time : "+timeInSeconds + " seconds");
		logMessage("Response time : "+timeInMilliSeconds + " ms");
		return response;

	}
	
	
	/**
	 * Hit Api to get B2B user details
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param status
	 * @return
	 */
	public static Response getcustomerprofiles(String baseSiteId, String userId, String status) {
		String endPoint = "/" + baseSiteId + "/orgUsers/" + userId;
		int statusGet = getStatusCode(status);
		logMessage("**[INFO] Get User Details API: " + endPoint);

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		Response response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.get(endPoint).then().assertThat().statusCode(statusGet).extract().response();

		logMessage("**[INFO] Get User Details API: " + response);
		return response;

	}

	/**
	 * Returns a list of products and additional data, such as available facets
	 * 
	 * @param baseSiteId
	 * @param query
	 * @param status
	 * @return
	 */
	public static String productSearchApi(String baseSiteId, String query, int status) {
		String endPoint = "/" + baseSiteId + "/cngproducts/search";
		logMessage("**[INFO] Product Serch API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "FULL").queryParam("query", query).get(endPoint).then().assertThat()
				.statusCode(status).extract().asString();

		return response;

	}

	public static String productSearchApiBYTERM(String baseSiteId, String field, int status) {
		String endPoint = "/" + baseSiteId + "/cngproducts/search";
		logMessage("**[INFO] Product Search API: " + endPoint);
		logMessage("**[INFO] Product Search Fields: " + field);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", field).get(endPoint).then().assertThat().statusCode(status).extract().asString();

		return response;

	}

	/**
	 * Returns a list of products and additional data, such as available facets,
	 * available sorting, and pagination options.
	 * 
	 * @param baseSiteId
	 * @param query
	 * @param sort
	 * @param status
	 * @return
	 */
	public static String productSearchWithSortApi(String baseSiteId, String query, String sort, int status) {
		String endPoint = "/" + baseSiteId + "/products/search";
		logMessage("**[INFO] Product Serch API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("currentPage", 0).queryParam("fields", "FULL").queryParam("pageSize", 20)
				.queryParam("query", query).queryParam("sort", sort).get(endPoint).then().assertThat()
				.statusCode(status).extract().asString();

		return response;

	}

// -->	
	/**
	 * Returns details of a single product according to a product code.
	 * 
	 * @param baseSiteId
	 * @param query
	 * @param status
	 * @return
	 */
	public static String getProductDetailsApi(String baseSiteId, String product, int status) {
		String endPoint = "/" + baseSiteId + "/cngproducts/" + product;
		logMessage("**[INFO] Product details API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "FULL").get(endPoint).then().assertThat().statusCode(status).extract().asString();

		return response;

	}

	/**
	 * Returns details of a single product according to a product code.
	 * 
	 * @param baseSiteId
	 * @param query
	 * @param status
	 * @return
	 */
	public static String getProductDetailsApiQueryParameters(String baseSiteId, String product, String field,
			int status) {
		String endPoint = "/" + baseSiteId + "/cngproducts/" + product;
		logMessage("**[INFO] Product details API: " + endPoint);
		logMessage("**[INFO] Valuen of Fields details API: " + field);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", field).get(endPoint).then().assertThat().statusCode(status).extract().asString();

		return response;

	}

	/**
	 * Returns details of a single product according to a product code. It takes
	 * some addition parameters
	 * 
	 * @param baseSiteId
	 * @param query
	 * @param priceReferenceIds
	 * @param fields
	 * @param status
	 * @return
	 */
	public static String getProductDetailsApi(String baseSiteId, String query, String priceReferenceIds, String fields,
			int status) {
		String endPoint = "/" + baseSiteId + "/cngproducts/" + query;
		logMessage("**[INFO] Product details API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", fields).queryParam("priceReferenceIds", priceReferenceIds).get(endPoint).then()
				.log().all().assertThat().statusCode(status).extract().asString();
		return response;

	}
//-->

	/**
	 * Returns bundle components for a product code.
	 * 
	 * @param baseSiteId
	 * @param product
	 * @param status
	 * @return
	 */
	public static String getBundleComponents(String baseSiteId, String product, int status) {
		String endPoint = "/" + baseSiteId + "/cngproducts/bundleComponents/" + product;
		logMessage("**[INFO] Get bundle components API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(status).extract()
				.asString();
		return response;
	}

	// -->

	/**
	 * Returns bundle components for a product code and get min stock price.
	 * 
	 * @param baseSiteId
	 * @param product
	 * @param status
	 * @return
	 */
	public static String getBundleComponentsAndGetMinStockPrice(String baseSiteId, String product, int status) {
		String endPoint = "/" + baseSiteId + "/cngproducts/bundleComponents/" + product;
		logMessage("**[INFO] Get bundle components API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(status).extract()
				.asString();

		ArrayList stockpr = extractJsonArrayFromResponse(response, "bundleComponents");
		int len = stockpr.size();
		logMessage("**[INFO] Getting bundle component array size = " + len);

		logMessage("**Min Stock count calculation:");
		minstock = Integer.parseInt(extractValueFromJOSNPath("bundleComponents[0].stockCount", response));
		for (int i = 0; i < len; i++) {
			String stockprice = extractValueFromJOSNPath("bundleComponents[" + i + "].stockCount", response);
			logMessage("bundleComponents[" + i + "].stockCount is " + stockprice);

			if (minstock >= Integer.parseInt(stockprice)) {
				minstock = Integer.parseInt(stockprice);
			}

		}
		logMessage("min stockprice is " + minstock);

		return response;

	}

	/**
	 * Retrieves a list of catalogs.
	 * 
	 * @param baseSiteId
	 * @param status
	 * @return
	 */
	public static String getListOfCatalogs(String baseSiteId, int status) {
		String endPoint = "/" + baseSiteId + "/catalogs";
		logMessage("**[INFO] Get list of catalogs API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(status).extract()
				.asString();
		return response;
	}

	/**
	 * Retrieves all credit card payment details made by the customer.
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param status
	 * @return
	 */
	public static String getListOfPaymentInfo(String baseSiteId, String userId, int status) {
		String endPoint = "/" + baseSiteId + "/users/" + userId + "/paymentdetails";
		logMessage("**[INFO] Get list of Saved Payment Info API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(status).extract()
				.asString();
		return response;
	}

	/**
	 * Returns the necessary information for creating a subscription that contacts
	 * the payment provider directly. This information contains the payment provider
	 * URL and a list of parameters that are needed to, create the subscription.
	 * 
	 * @param basesiteId
	 * @param userId
	 * @param cartId
	 * @param statusCode
	 * @return
	 */
	public static String getSopRequestApi(String basesiteId, String userId, String cartId, int statusCode) {
		String endPoint = "/" + basesiteId + "/users/" + userId + "/carts/" + cartId + "/payment/sop/request";
		String baseQuery = PropFileHandler.readProperty("storeBaseURL");
		String query = "https://" + baseQuery + "/cengagewebservicetest/sop/receipt/handler";
		logMessage("**Get SOP Request API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("receiptUrl", query).get(endPoint).then().assertThat().statusCode(statusCode).extract()
				.asString();
		return response;
	}

	/**
	 * Returns the necessary information for creating a subscription that contacts
	 * the payment provider directly. This information contains the payment provider
	 * URL and a list of parameters that are needed to create the subscription.
	 * 
	 * @param basesiteId
	 * @param userId
	 * @param cartId
	 * @param statusCode
	 * @return
	 */
	public static String getSopResponseApi(String basesiteId, String userId, String cartId, int statusCode) {
		String endPoint = "/" + basesiteId + "/users/" + userId + "/carts/" + cartId + "/payment/sop/response";
		logMessage("**Get SOP Response API: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON).when()
				.queryParam("fields", "DEFAULT").queryParam("saveCard", "true").get(endPoint).then().assertThat()
				.statusCode(statusCode).extract().asString();
		return response;
	}

	/**
	 * Retrieves a list of shipping or billing countries. Set the type parameter to
	 * SHIPPING to retrieve the shipping countries. Set the type parameter to
	 * BILLING to retrieve the billing countries. Leave the type parameter blank to
	 * retrieve all of the countries. The list is sorted alphabetically.
	 * 
	 * @param baseSiteId
	 * @param type
	 * @param status
	 * @return
	 */
	public static String getListOfCountries(String baseSiteId, String type, String status) {
		String endPoint = "/" + baseSiteId + "/countries";
		logMessage("**[INFO] Get List of Countries: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").queryParam("type", type).get(endPoint).then().assertThat()
				.statusCode(getStatusCode(status)).extract().asString();
		return response;
	}

	/**
	 * Retrieves the list of regions in a country.
	 * 
	 * @param baseSiteId
	 * @param countryIsoCode
	 * @param status
	 * @return
	 */
	public static String getListOfStates(String baseSiteId, String countryIsoCode, String status) {
		String endPoint = "/" + baseSiteId + "/countries/" + countryIsoCode + "/regions";
		logMessage("**[INFO] Get List of States: " + endPoint);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").get(endPoint).then().assertThat().statusCode(getStatusCode(status))
				.extract().asString();
		return response;
	}

//	Verifications 

	/**
	 * Verify details in SOP Response
	 * 
	 * @param responseMap
	 * @param properties
	 */
	public void verifySOPApiResponse(JsonPath responseMap, Map<String, String> properties) {
		String subscriptionId = PropFileHandler.readProperty(properties.get("subscriptionId"));

		Assert.assertEquals(responseMap.get("cardType.code"), properties.get("cardType"));
		logMessage("**[ASSERT PASSED] cardType is as expected");

		Assert.assertEquals(responseMap.get("subscriptionId"), subscriptionId);
		logMessage("**[ASSERT PASSED] subscriptionId is as expected");

		Assert.assertEquals(responseMap.get("expiryYear"), properties.get("expiryYear"));
		logMessage("**[ASSERT PASSED] expiryYear is as expected");

		Assert.assertTrue(responseMap.get("billingAddress").toString().contains(properties.get("billingAddress")));
		logMessage("**[ASSERT PASSED] deliveryAddress is as expected");
	}

	/**
	 * Verifies iso code and state name in response
	 * 
	 * @param isoCode
	 * @param stateName
	 * @param state
	 */
	public static void verifyState(String isoCode, String stateName, JSONObject state) {
		Assert.assertEquals(isoCode, state.get("isocode"), "**[ASSERT FAILED]: isocode is not as expected[" + isoCode
				+ "],but found: [" + state.get("isocode") + "]");
		logMessage("**[ASSERT PASSED]:  isocode is as expected product " + isoCode);

		Assert.assertEquals(stateName, state.get("name"), "**[ASSERT FAILED]: State is not as expected [" + stateName
				+ "], but found: [" + state.get("name") + "]");
		logMessage("**[ASSERT PASSED]:  State is as expected" + stateName);

	}

	/**
	 * Verifies Details in API response
	 * 
	 * @param responseMap
	 * @param properties
	 */
	public void varifyDetailsInResponse(JsonPath responseMap, Map<String, String> properties) {
		for (String property : properties.keySet()) {
			Assert.assertNotNull(responseMap.get(property),
					"**[ASSERT FAILED]:Value not found for Property " + property);
			if (!properties.get(property).contains("value")) {
				Assert.assertEquals(responseMap.get(property).toString(), properties.get(property));
				String logmsg = "**[ASSERT PASSED]:Value found for Property " + property + " is : "
						+ properties.get(property);
				logMessage(logmsg);
			}
		}
	}

	/**
	 * Verifies Properties in API response
	 * 
	 * @param responseMap
	 * @param properties
	 */
	public void verifyPropertiesInResponse(JsonPath responseMap, Map<String, String> properties) {
		for (String property : properties.keySet()) {
			if (properties.get(property).equalsIgnoreCase("not null")) {
				Assert.assertNotNull(responseMap.get(property),
						"**[ASSERT FAILED]:Value not found for Property " + property);
				logMessage("**[ASSERT PASSED]:Value found for Property " + property);
			} else if (properties.get(property).equalsIgnoreCase("not zero")) {
				Assert.assertTrue(notZero(Double.parseDouble(responseMap.get(property).toString())),
						"**[ASSERT FAILED]:Value  found for Property " + property + " is : "
								+ responseMap.get(property));
				logMessage("**[ASSERT PASSED]:Value found for Property " + property + " is : "
						+ responseMap.get(property));
			} else {
				Assert.assertTrue(responseMap.get(property).toString().contains(properties.get(property)),
						"**[ASSERT FAILED]:Value  found for Property " + property + " is : "
								+ responseMap.get(property));
				logMessage("**[ASSERT PASSED]:Value found for Property " + property + " is : "
						+ responseMap.get(property));
			}
		}
	}

	/**
	 * Verifies B2B Accounts in API response
	 * 
	 * @param responseMap
	 * @param pageSize
	 */
	public void verifyAccountsInResponse(JsonPath responseMap, int pageSize) {
		for (int i = 0; i < pageSize; i++) {
			Assert.assertNotNull(responseMap.get("b2bUnits[" + i + "].accountNumber"),
					"**[ASSERT FAILED]:Value not found for Account Number!");
			logMessage("**[ASSERT PASS]:Value found for Account Number " + i +" And the Account Number is " + responseMap.get("b2bUnits[" + i + "].accountNumber"));
		}
	}

	/**
	 * Verifies B2B Child Accounts in API response
	 *sddcdx
	 * @param responseMap
	 */
	public void verifyChildAccountsInResponse(JsonPath responseMap) {
		JSONArray childArray = extractJsonArrayFromResponse(response,"children");
		int size = childArray.size();
		logMessage(String.valueOf(size));
		for (int i = 0; i < size; i++) {
			Assert.assertNotNull(responseMap.get("children[" + i + "].accountNumber"),
					"**[ASSERT FAILED]:Value not found for child Account Number!");
			logMessage("**[ASSERT PASS]:Value found for child Account Number " + i +" And the child Account Number is " + responseMap.get("children[" + i + "].accountNumber"));
		}
	}

	/**
	 * Verifies B2B intermediate Child Accounts in API response
	 *
	 * @param responseMap
	 */
	public void verifyIntermediateChildAccountsInResponse(JsonPath responseMap) {
		JSONArray childArray = extractJsonArrayFromResponse(response,"shipToAccounts");
		int size = childArray.size();
		logMessage(String.valueOf(size));
		for (int i = 1; i < size; i++) {

			Assert.assertNotNull(responseMap.get("shipToAccounts[" + i + "].parentOrgUnit.intermediateUnit"),
					"**[ASSERT FAILED]:Value not found as intermediateUnit set to true");
			if(responseMap.get("shipToAccounts[" + i + "].parentOrgUnit.intermediateUnit").equals(true))
			{
				logMessage("**[ASSERT PASSED]:Value found as intermediateUnit set to " + responseMap.get("shipToAccounts[" + i + "].parentOrgUnit.intermediateUnit") + " for the child account number " + responseMap.get("shipToAccounts[" + i + "].accountNumber"));
			}

		}
	}



	/**
	 * Verifies Properties in API response
	 * 
	 * @param responseMap
	 * @param property
	 * @param expectedValue
	 */
	public void verifyPropertyInResponse(JsonPath responseMap, String property, String expectedValue) {
		String actualValue = responseMap.get(property);
		Assert.assertEquals(actualValue, expectedValue);
		logMessage("**[ASSERT PASSED]:Value found for " + property + " is : " + actualValue);

	}

	/**
	 * Verifies searched results are sorted in descending order based on Copyright
	 * Date
	 * 
	 * @param response
	 */
	public void verifySearchResultInDesendingOrderForCopyrightDate(String response) {
		JSONArray products = extractJsonArrayFromResponse(response, "products");
		boolean sorted = true;
		for (int i = 0; i < products.size() - 1; i++) {
			String productOne = products.get(i).toString();
			String productTwo = products.get(i + 1).toString();
			if (!checkIfCopyRightYearISLessThan(productOne, productTwo)) {
				sorted = false;
				break;
			}
		}
		Assert.assertTrue(sorted, "**[ASSERT FAIL] Results are not sorted");
		logMessage("**[ASSERT PASSED]  Results are sorted");

	}

	/**
	 * Returns True if productOne copyright date is greater than productTwo
	 * 
	 * @param productOne
	 * @param productTwo
	 * @return
	 */
	public boolean checkIfCopyRightYearISLessThan(String productOne, String productTwo) {
		int copyrightYearOne = Integer.parseInt(extractValueFromJOSNPath("copyrightYear", productOne));
		int copyrightYearTwo = Integer.parseInt(extractValueFromJOSNPath("copyrightYear", productTwo));
		return (copyrightYearOne >= copyrightYearTwo);

	}

	/**
	 * Verifies searched results are sorted in descending order based on Full Title
	 * 
	 * @param response
	 */
	public void verifySearchResultInDesendingOrderForFullTitle(String response) {
		JSONArray products = extractJsonArrayFromResponse(response, "products");
		ArrayList<String> fullTitle = getFullTitleList(products);
		Collections.sort(fullTitle, Collections.reverseOrder());
		boolean sorted = compareFulltitles(products, fullTitle);

		Assert.assertTrue(sorted, "**[ASSERT FAILED] Results are not sorted");
		logMessage("**[ASSERT PASSED]  Results are sorted");
	}

	public ArrayList<String> getFullTitleList(JSONArray products) {
		ArrayList<String> fullTitle = new ArrayList<>();
		for (int i = 0; i < products.size(); i++) {
			fullTitle.add(extractValueFromJOSNPath("fullTitle", products.get(i).toString()));
		}
		return fullTitle;
	}

	/**
	 * Compare Products JSON Array product's full title with Sorted List of Products
	 * Full titles and returns true if both Full titles are matched.
	 * 
	 * @param JSONArray         Products
	 * @param ArrayList<String> fullTitle
	 * @return
	 */
	public boolean compareFulltitles(JSONArray products, ArrayList<String> fullTitle) {
		for (int i = 0; i < products.size(); i++)
			if (!extractValueFromJOSNPath("fullTitle", products.get(i).toString()).equalsIgnoreCase(fullTitle.get(i)))
				return false;

		return true;
	}

	/**
	 * Verifies searched results are sorted in descending order based on Publishing
	 * Date
	 * 
	 * @param response
	 * @throws ParseException
	 */
	public void VerifySearchResultInDesendingOrderForPublishingDate(String response) throws ParseException {
		JSONArray products = extractJsonArrayFromResponse(response, "products");
		boolean sorted = comparePublicationDate(products);

		Assert.assertTrue(sorted, "**[ASSERT FAILED] Results are not sorted");
		logMessage("**[ASSERT PASSED]  Results are sorted");
	}

	public boolean comparePublicationDate(JSONArray products) throws ParseException {
		for (int i = 0; i < products.size() - 1; i++) {
			Date productOne = getPublicationDate(products.get(i).toString());
			Date productTwo = getPublicationDate(products.get(i + 1).toString());

			if (!checkIfPublishingDateISLessThan(productOne, productTwo))
				return false;
		}
		return true;
	}

	public Date getPublicationDate(String product) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(extractDateFromWholeString(extractValueFromJOSNPath("publicationDate", product)));
	}

	public boolean checkIfPublishingDateISLessThan(Date productOne, Date productTwo) {
		int value = productOne.compareTo(productTwo);
		return value >= 0;
	}

	/**
	 * Verifies Expected facet in API Response
	 * 
	 * @param facets
	 * @param facet
	 */
	public void verifyFacetInResponse(JSONArray facets, String facet) {
		boolean found = false;
		for (int i = 0; i < facets.size(); i++) {
			String getFacet = extractValueFromJOSNPath("name", facets.get(i).toString());
			if (facet.equalsIgnoreCase(getFacet)) {
				found = true;
				break;
			}
		}
		Assert.assertTrue(found, "**[ASSERT FAIL] Expected Facet, " + facet + " is not Found in Response");
		logMessage("**[ASSERT PASSED]  Expected Facet, " + facet + " is Found in Response");

	}

	/**
	 * Verifies searched results are sorted in descending order based on Publishing
	 * Date
	 * 
	 * @param response
	 * @throws ParseException
	 */
	public void verifySearchResultInDesendingAndAscendingOrderForPublishingDate(String response, String sortOrder)
			throws ParseException {
		JSONArray products = extractJsonArrayFromResponse(response, "products");
		boolean sorted = true;
		for (int i = 0; i < products.size() - 1; i++) {
			String productOne = products.get(i).toString();
			String productTwo = products.get(i + 1).toString();
			if (!checkIfPublishingDateISLessThan(productOne, productTwo, sortOrder)) {
				sorted = false;
				break;
			}
		}
		Assert.assertTrue(sorted, "**[ASSERT FAILED] Results are not sorted");
		logMessage("**[ASSERT PASSED]  Results are sorted in " + sortOrder + " order");
	}

	/**
	 * Compare productOne Publishing Date and productTwo Publishing Date and returns
	 * true if both productOne and productTwo Publishing Date are in descending and
	 * ascending order.
	 * 
	 * @param productOne
	 * @param productTwo
	 * @return
	 * @throws ParseException
	 */
	public boolean checkIfPublishingDateISLessThan(String productOne, String productTwo, String sortOrder)
			throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date publicationDateOne = sdf.parse(extractValueFromJOSNPath("publicationDate", productOne));
		Date publicationDateTwo = sdf.parse(extractValueFromJOSNPath("publicationDate", productTwo));
		if (sortOrder.equals("asc")
				&& (publicationDateOne.before(publicationDateTwo) || publicationDateTwo.equals(publicationDateOne))
				|| sortOrder.equals("desc") && (publicationDateTwo.before(publicationDateOne)
						|| publicationDateTwo.equals(publicationDateOne)))
			return true;
		return false;
	}

}