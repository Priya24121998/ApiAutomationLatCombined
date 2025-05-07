package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.path.xml.XmlPath;
import io.restassured.response.Response;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;




public class UserCreationActions extends BaseClass {

	public UserCreationActions() {
		super();
		PageFactory.initElements(driver, this);
	}

	UIPageActions uiPage = new UIPageActions();
	public static FileInputStream fileInputStream;
	static Map<String, String> userInfo = new HashMap<>();

	public static Map<String, String> emailAndPassOfReturninguserForOktaBySoapApi(String type)
			throws IOException {
		boolean useLetters = true;
		boolean useNumbers = true;
		String generatedString = RandomStringUtils.random(6, useLetters, useNumbers);
		String firstName = getCurrentTimestamp() ;
		String email = type + "_" + tier + "_" + firstName +"_"+  generatedString +"@mailinator.com";

		String generatedToken = generateTokenUsingSOAP(PropFileHandler.readProperty("tokenGenerateSoapAPI"));
		return callInternationalStudentCreationServiceBySoap(generatedToken, email, "B2CUS");
	}

	public static Map<String, String> emailAndPassOfReturninguserForOktaBySoapApiForOtherStores(String type,String store)
			throws IOException {
		boolean useLetters = true;
		boolean useNumbers = true;
		String generatedString = RandomStringUtils.random(6, useLetters, useNumbers);
		String firstName = getCurrentTimestamp();
		String email = type + "_" + tier + "_" + firstName +"_"+ generatedString +"@mailinator.com";

		String generatedToken = generateTokenUsingSOAP(PropFileHandler.readProperty("tokenGenerateSoapAPI"));
		return callInternationalStudentCreationServiceBySoap(generatedToken, email, store);
	}


	public static Map<String, String> CreateUserForDiffStores(String store) throws IOException {
		String firstName = getCurrentTimestamp();
		String tier = System.getProperty("tier");
		if (tier == null || tier.isEmpty()) {
			tier = PropFileHandler.readConfigProperty("tier");
		}

		String email = store + "_" + tier + "_" + firstName + "@mailinator.com";

		String generatedToken = generateTokenUsingSOAP(PropFileHandler.readProperty("tokenGenerateSoapAPI"));
		return callInternationalStudentCreationServiceBySoap(generatedToken, email, store);
	}

	public static String generateTokenUsingSOAP(String token_uri) throws IOException {
		if (tier.equalsIgnoreCase("prod")) {
			fileInputStream = new FileInputStream("src/test/resources/TestData/ProdTokenGenerateAPI.xml");
		} else {
			fileInputStream = new FileInputStream("src/test/resources/TestData/TokenGenerateAPI.xml");
		}
		RestAssured.baseURI = token_uri;
		Response response = RestAssured.given().header("Content-Type", "text/xml").and()
				.body(IOUtils.toString(fileInputStream, "UTF-8")).when().post().then().statusCode(200).and().extract()
				.response();

		XmlPath xmlpath = new XmlPath(response.asString());
		String token = xmlpath.getString("ns3:token");
		String[] arr = token.split("Success");
		String tokenid = arr[1];
		return tokenid;
	}

	public static Map<String, String> callInternationalStudentCreationServiceBySoap(String tokeni, String email, String Store)
	{
		String country;
		String institutionId;
		String region;
		String password;
		country = System.getProperty("country");
		if(country == null || country.isEmpty()) {
			country = PropFileHandler.readProperty(Store + "_country");
		}
		institutionId = System.getProperty("institutionId");
		if(institutionId == null || institutionId.isEmpty()) {
			institutionId= PropFileHandler.readProperty(Store + "_institutionId");
		}
		region = System.getProperty("region");
		if(region == null || region.isEmpty()) {
			region= PropFileHandler.readProperty(Store + "_region");
		}
		password = System.getProperty("password");
		if(password == null || password.isEmpty()) {
			password= "Aa111111";
		}

		String token1 = tokeni;
		RestAssured.baseURI = PropFileHandler.readProperty("soapUserCreationAPI");

		String xmldata = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
				+ "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ssow=\"http://ws.thomsonlearning.com:80/ssows\" xmlns:java=\"java:com.tl.ssows.parameters\" xmlns:java1=\"java:com.tl.ssows\" xmlns:java2=\"java:language_builtins.lang\">"
				+ "<soapenv:Header/>" + "<soapenv:Body>" + "<ssow:addUser>" + "<java:person>" + "<java1:c>" + country
				+ "</java1:c>" + "<java1:givenName>Student</java1:givenName>" + "<java1:sn>QAL</java1:sn>"
				+ "<java1:TLRegion>" + region + "</java1:TLRegion>" + "<java1:TLSchoolAffiliation>" + institutionId
				+ "</java1:TLSchoolAffiliation>" + "<java1:uid>" + email + "</java1:uid>" + "<java1:userPassword>"
				+ password + "</java1:userPassword>" + "<java1:userType>student</java1:userType>" + "</java:person>"
				+ "<java:token>" + token1 + "</java:token>" + "</ssow:addUser>" + "</soapenv:Body>"
				+ "</soapenv:Envelope>";
		String response = RestAssured.given().header("Content-Type", "text/xml;charset=utf-8").and().body(xmldata).when().post()
				.then().statusCode(200).and().extract().asString();

		XmlPath responseMap = XmlPath.from(response);
		String str = responseMap.getString("ns2:guid");
		String[] parts = str.split("Success");
		String temp = parts[0];
		String guid = "";
		for (int i = 1; i < temp.length() - 1; i++)
			guid = guid + temp.charAt(i);
		logMessage("User: " + email);
		logMessage("Password: " + password);
		logMessage("GUID: " + guid);
		userInfo.put("email", email);
		userInfo.put("guid", guid);
		return userInfo;
	}

	public static String getUserCreationPayload(String userName, String store) {
		String tier = System.getProperty("tier");
		if (tier == null || tier.isEmpty()) {
			tier = PropFileHandler.readConfigProperty("tier");
		}
		userID = (store + "_" + tier + "_" + userName + "_" + getCurrentTimestamp() + "@mailinator.com").toLowerCase();
		String payload = PropFileHandler.readPayloads(store + "_createUser");

		String pay = payload.replaceAll("#replaceValue#", userID);
		return pay;

	}
	public static String getNewUserCreationPayloadRandom(String userName, String store,String account) {

		int length = 5;
		boolean useLetters = true;
		boolean useNumbers = false;
		String generatedString = RandomStringUtils.random(length, useLetters, useNumbers);

		String tier = System.getProperty("tier");
		if (tier == null || tier.isEmpty()) {
			tier = PropFileHandler.readConfigProperty("tier");
		}
		userID = (store + "_" + tier + "_" + userName + "_"+generatedString +"_" + getCurrentTimestamp() + "@mailinator.com").toLowerCase();
		String payload = PropFileHandler.readPayloads(store + "_createNewUser");

		payload = payload.replaceAll("#replaceAccountValue#", account);
		payload = payload.replaceAll("#replaceValue#", userID);
		return payload;

	}
	
	public static String getUserCreationPayloadRandom(String userName, String store) {
		
		int length = 5;
	    boolean useLetters = true;
	    boolean useNumbers = false;
	    String generatedString = RandomStringUtils.random(length, useLetters, useNumbers);

		String tier = System.getProperty("tier");
		if (tier == null || tier.isEmpty()) {
			tier = PropFileHandler.readConfigProperty("tier");
		}
		userID = (store + "_" + tier + "_" + userName + "_"+generatedString +"_" + getCurrentTimestamp() + "@mailinator.com").toLowerCase();
		String payload = PropFileHandler.readPayloads(store + "_createUser");

		String pay = payload.replaceAll("#replaceValue#", userID);
		return pay;

	}

	public static String getUserCreationPayloadwithRegex(String email, String fName, String lName, String store) {
		userID = getemail(email, store).toLowerCase();

		String payload = PropFileHandler.readPayloads(store + "_createUserWithName");
		String repEmail = payload.replaceAll("#replaceValue#", userID);
		String repFname = repEmail.replaceAll("#exchange#", "" + fName + "");
		String pay = repFname.replaceAll("#replaceValue3#", "" + lName + "");
		return pay;

	}

	/**
	 * create B2B user for scenario
	 * 
	 * @param baseSiteId
	 * @param payload
	 * @return
	 */
	public static String createB2BUser(String baseSiteId, String payload) {
		String endPoint = "/" + baseSiteId + "/orgCustomers";
		logMessage("**[INFO] Create User API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		Response response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.body(payload).post(endPoint).then().assertThat().statusCode(201).extract().response();

		return response.asString();

	}

	/**
	 * Create B2B User for regular expression Test cases
	 * 
	 * @param baseSiteId
	 * @param payload
	 * @param Status
	 * @return
	 */
	public static String createB2BUser(String baseSiteId, String payload, String Status) {
		String endPoint = "/" + baseSiteId + "/orgCustomers";
		int status = getStatusCode(Status);
		logMessage("**[INFO] Create User API: " + endPoint);

		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload).post(endPoint).then().assertThat().statusCode(status).extract().asString();

		return response;

	}

	public static String updateB2BUser(String baseSiteId, String userID, String payload, String Status) {
		String endPoint = "/" + baseSiteId + "/orgCustomers/" + userID;
		int status = getStatusCode(Status);
		logMessage("**[INFO] Create User API: " + endPoint);

		logMessage(payload);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload).patch(endPoint).then().assertThat().statusCode(status).extract().asString();

		return response;

	}

	public static String updateB2BUserEntity_PATCH(String baseSiteId, String userID, String payload, String Status) {
		String endPoint = "/" + baseSiteId + "/users/" + userID;
		int status = getStatusCode(Status);
		logMessage("**[INFO] Update User API: " + endPoint);

		logMessage(payload);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload).patch(endPoint).then().assertThat().statusCode(status).extract().asString();
		logMessage(response);
		logMessage("**[INFO] EntityNumber EntityName with PATCH method Updated Successfully");
		return response;

	}
	
	public static String updateB2BUserEntity_PUT(String baseSiteId, String userID, String payload, String Status) {
		String endPoint = "/" + baseSiteId + "/users/" + userID;
		int status = getStatusCode(Status);
		logMessage("**[INFO] Update User API: " + endPoint);

		logMessage(payload);
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String response = RestAssured.given().headers("Authorization", authorizationValue).contentType(ContentType.JSON)
				.body(payload).put(endPoint).then().assertThat().statusCode(status).extract().asString();
		logMessage("**[INFO] EntityNumber EntityName with PUT method Updated Successfully");
		return response;

	}
	
	/**
	 * Register users using SAP API
	 * 
	 * @param baseSiteId
	 * @param payload
	 * @param Status
	 * @return
	 */
	public static String registerACustomer(String baseSiteId, String payload, String Status) {
		String endPoint = "/" + baseSiteId + "/users";
		int status = getStatusCode(Status);
		logMessage("**[INFO] Register Customer Using API: " + endPoint);
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		String response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").body(payload).post(endPoint).then().assertThat().statusCode(status)
				.extract().asString();
		return response;
	}

	public static void loginUser(String type) {
		String password;
		password = System.getProperty("password");
		if(password == null || password.isEmpty()) {
			password=  PropFileHandler.readProperty("userPassword");
		}
		hardWait(8);
		try {
			UIPageActions.loginUser(PropFileHandler.readProperty(type), password);
		} catch (NoSuchElementException e) {
			logMessage("User already logged in");
			waitTOSync();
			BaseClass.launchApplication(PropFileHandler.readProperty("dashboardPageUrl"));
			UIPageActions.clickUserNameInSidebar();
			UIPageActions.clickSidebarSignoutBtn();
			launchApp();
			UIPageActions.loginUser(PropFileHandler.readProperty(type), password);
		}
	}
	
	public static void loginAUUser(String type) {
		hardWait(8);
		try {
			UIPageActions.loginUser(PropFileHandler.readProperty(type), PropFileHandler.readProperty("userPassword"));
		} catch (NoSuchElementException e) {
			logMessage("User already logged in");
			waitTOSync();
			BaseClass.launchApplication(PropFileHandler.readProperty("AU_Dashboard"));	
			UIPageActions.clickUserNameInSidebar();
			UIPageActions.clickSidebarSignoutBtn();
			launchApp();
			UIPageActions.loginUser(PropFileHandler.readProperty(type), PropFileHandler.readProperty("userPassword"));
		}
	}
	

	public static void launchApp() {
		try {
			launchApplication(PropFileHandler.readProperty("SSO"));
		} catch (WebDriverException e) {
			waitTOSync();
			launchApplication(PropFileHandler.readProperty("SSO"));
		}
	}
	
	public static void launchB2CAUApp() {
		try {
			launchApplication(PropFileHandler.readProperty("SSO_AU"));
		} catch (WebDriverException e) {
			waitTOSync();
			launchApplication(PropFileHandler.readProperty("SSO_AU"));
		}
	}

	@SuppressWarnings("unchecked")
	public static String customerPayload(String email, String fName, String lName, String store) {
		userID = getemail(email, store);
		String entityNumber = PropFileHandler.readProperty(store + "_institutionId");
		String entityName = PropFileHandler.readProperty(store + "_entityName");
		JSONObject requestBody = new JSONObject();
		requestBody.put("uid", userID);
		requestBody.put("firstName", fName);
		requestBody.put("lastName", lName);
		requestBody.put("password", "Aa111111");
		requestBody.put("email", userID);
		requestBody.put("entityNumber", entityNumber);
		requestBody.put("entityName", entityName);

		return requestBody.toString();
	}

	public void verifyResponseIsGenerated(String response) {
		logMessage("User created Successfully:");
		logMessage(userID + " || " + " " + userGUID);
	}

	@SuppressWarnings("unchecked")
	public static String getUpdateRolesPayload() {
		JSONObject payload = new JSONObject();
		JSONArray roles = new JSONArray();

		roles.add("inquiry-only");
		roles.add("cengage-employee");
		payload.put("roles", roles);

		return payload.toString();

	}

	@SuppressWarnings("unchecked")
	public static String UpdateUserEntity() {
		JSONObject payload = new JSONObject();
		payload.put("entityName", "ARBOR");
		payload.put("entityNumber", "254");
		payload.put("firstName", "Student");
		payload.put("lastName", "QAL");
		return payload.toString();
	}

	
	
	@SuppressWarnings("unchecked")
	public static String changeUserStatusPayload() {
		JSONObject payload = new JSONObject();
		payload.put("accountStatus", "ACTIVE");
		return payload.toString();
	}

	@SuppressWarnings("unused")
	public void verifyRolesInResponse(JsonPath responseMap, Map<String, String> properties) {
		JSONArray roles = responseMap.get("roles");
	}

	/**
	 * verifies customer is created using API
	 * 
	 * @param responseMap
	 */
	public static void verifyCustomerIsRegistered(JsonPath responseMap, String store) {
		String uid = responseMap.get("uid");
		Assert.assertEquals(uid.toLowerCase(), userID.toLowerCase(), "**[ASSERT FAILED]: UserId is not as expected");
		String logmsg = "User created Successfully:\n" + userID.toLowerCase();
		PropFileHandler.writeProperty(store + "_CreatedUser", userID.toLowerCase());
		logMessage(logmsg);
		scenarioComment = scenarioComment + "\n" + logmsg;
	}
	public static String activationApiCanada(String email, String password) {
		RestAssured.baseURI = PropFileHandler.readProperty("ActivationBaseURI");
		String payload = PropFileHandler.readPayloads("ActivationPayloadCanada");
		payload = payload.replaceAll("#replaceEmailValue#",email);
		payload = payload.replaceAll("#replacePasswordValue#",password);
		String endpoint="/api/v1/users?activate=true";

		Response response = RestAssured.given().header("Content-Type", "application/json").header("Accept-Encoding","gzip, deflate,br").header("Authorization","SSWS 00qsJZGR_tCqUvKVtlLh4tlgD-iPw28mrUaDNRhl2i").and()
				.body(payload).when().post(endpoint).then().statusCode(200).and().extract()
				.response();
		logMessage(response.asString());
		return response.asString();

	}

	public static String activationApiGale(String email, String password) {
		RestAssured.baseURI = PropFileHandler.readProperty("ActivationBaseURI");
		String payload = PropFileHandler.readPayloads("ActivationPayloadGale");
		payload = payload.replaceAll("#replaceEmailValue#",email);
		payload = payload.replaceAll("#replacePasswordValue#",password);
		String endpoint="/api/v1/users?activate=true";

		Response response = RestAssured.given().header("Content-Type", "application/json").header("Accept-Encoding","gzip, deflate,br").header("Authorization","SSWS 00qsJZGR_tCqUvKVtlLh4tlgD-iPw28mrUaDNRhl2i").and()
				.body(payload).when().post(endpoint).then().statusCode(200).and().extract()
				.response();
		logMessage(response.asString());
		return response.asString();

	}

	public static String activationApiUnitedStates(String email, String password) {
		RestAssured.baseURI = PropFileHandler.readProperty("ActivationBaseURI");
		String payload = PropFileHandler.readPayloads("ActivationPayloadUS");
		payload = payload.replaceAll("#replaceEmailValue#",email);
		payload = payload.replaceAll("#replacePasswordValue#",password);
		String endpoint="/api/v1/users?activate=true";

		Response response = RestAssured.given().header("Content-Type", "application/json").header("Accept-Encoding","gzip, deflate,br").header("Authorization","SSWS 00qsJZGR_tCqUvKVtlLh4tlgD-iPw28mrUaDNRhl2i").and()
				.body(payload).when().post(endpoint).then().statusCode(200).and().extract()
				.response();
		logMessage(response.asString());
		return response.asString();

	}

}
