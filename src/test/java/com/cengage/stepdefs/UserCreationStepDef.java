package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.OrdersAction;
import com.cengage.pageactions.SubscriptionsActions;
import com.cengage.pageactions.UserCreationActions;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.restassured.path.json.JsonPath;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


@SuppressWarnings("deprecation")
public class UserCreationStepDef extends BaseClass{
	static SubscriptionsActions subPageObj;
	public UserCreationStepDef() {
		super();
	}
	
	UserCreationActions user = new UserCreationActions();
	
	/**
	 * Create User using SAP API for B2C US
	 * @param type
	 * @throws IOException
	 */
	@Given("Create (.*) user")
	public static void registerNewUserForB2cUS(String type) {
		deleteCookies();
		String payload = UserCreationActions.customerPayload(type, "FirstName", "LastName", "B2CUS");
		response = UserCreationActions.registerACustomer(PropFileHandler.readProperty("baseSiteId"), payload, "201");

		JsonPath responseMap = JsonPath.from(response);
		userID = responseMap.get("customerId");
		userGUID = responseMap.get("uid");
		PropFileHandler.writeProperty(type, userID);
		logMessage("User created Successfully: " + userID);

	}

	/**
	 * Create User Using OKTA API for B2C US
	 * @param type
	 * @throws IOException
	 */
	@Given("Create user (.*) and login to application")
	public static void createNewUserAndLogin(String type) throws IOException {
		Map<String, String> userInfo = new HashMap<>();
		deleteCookies();
		userInfo = UserCreationActions.emailAndPassOfReturninguserForOktaBySoapApi(type);
		userID = userInfo.get("email");
		userGUID = userInfo.get("guid");
		PropFileHandler.writeProperty(type, userID);
		UserCreationActions.launchApp();
		UserCreationActions.loginUser(type);
	}

	/**
	 * Create and Activate User Using OKTA API for B2C US
	 * @param type
	 * @throws IOException
	 */
	@Given("Create and activate user (.*)")
	public static void createNewUserAndActivateUser(String type) throws IOException {
		Map<String, String> userInfo = new HashMap<>();
		deleteCookies();
		userInfo = UserCreationActions.emailAndPassOfReturninguserForOktaBySoapApi(type);
		userID = userInfo.get("email");
		userGUID = userInfo.get("guid");
		PropFileHandler.writeProperty(type, userID);
	}

	/**
	 * Create and Activate User Using OKTA API for other stores
	 * @param type
	 * @throws IOException
	 */
	@Given("I need to create and activate (.*) user for (.*) store")
	public static void createNewUserAndActivateUserForOtherStores(String type,String store) throws IOException {
		Map<String, String> userInfo = new HashMap<>();
		deleteCookies();
		userInfo = UserCreationActions.emailAndPassOfReturninguserForOktaBySoapApiForOtherStores(type,store);
		userID = userInfo.get("email");
		userGUID = userInfo.get("guid");
		PropFileHandler.writeProperty(type, userID);
	}

	/**
	 * Create and Activate User Using OKTA API for B2C US n times
	 * @param type
	 * @throws IOException
	 */
	@Given("Create (.*) users and activate it for (.*) store")
	public static void createNewUserAndActivateUsers(String n, String type) throws IOException {
		Map<String, String> userInfo = new HashMap<>();
		int no = Integer.parseInt(n);
		for(int i=0;i<no;i++) {
			deleteCookies();
			userInfo = UserCreationActions.emailAndPassOfReturninguserForOktaBySoapApi(type);
			userID = userInfo.get("email");
			userGUID = userInfo.get("guid");
			PropFileHandler.writeProperty(type, userID);
			password = PropFileHandler.readProperty("userPassword");
			userCreation.put(userID,password);
		}
	}

	/**
	 * Create and Activate User Using OKTA API for B2C US n times at run time
	 * @param type
	 * @throws IOException
	 */
	@Given("I need to create multiple n users and activate it for (.*) store")
	public static void createNewUserAndActivateUsersAtRunTime( String type) throws IOException {
		Map<String, String> userInfo = new HashMap<>();
		noOfUsers = System.getProperty("numberOfUsers");
		if (noOfUsers == null || noOfUsers.isEmpty())
			noOfUsers = PropFileHandler.readConfigProperty("numberOfUsers");
		int no = Integer.parseInt(noOfUsers);
		for(int i=0;i<no;i++) {
			deleteCookies();
			userInfo = UserCreationActions.emailAndPassOfReturninguserForOktaBySoapApi(type);
			userID = userInfo.get("email");
			userGUID = userInfo.get("guid");
			PropFileHandler.writeProperty(type, userID);
			password = PropFileHandler.readProperty("userPassword");
			userCreation.put(userID,password);
		}
	}

	/**
	 * Create and Activate User Using OKTA API for other stores n times at run time
	 * @param type
	 * @throws IOException
	 */
	@Given("I will create n (.*) users and activate it for (.*) store")
	public static void createNewUserAndActivateUsersAtRunTimeForOtherStores( String type,String store) throws IOException {
		Map<String, String> userInfo = new HashMap<>();
		noOfUsers = System.getProperty("numberOfUsers");
		if (noOfUsers == null || noOfUsers.isEmpty())
			noOfUsers = PropFileHandler.readConfigProperty("numberOfUsers");
		int no = Integer.parseInt(noOfUsers);
		for(int i=0;i<no;i++) {
			deleteCookies();
			userInfo = UserCreationActions.emailAndPassOfReturninguserForOktaBySoapApiForOtherStores(type,store);
			userID = userInfo.get("email");
			userGUID = userInfo.get("guid");
			PropFileHandler.writeProperty(type, userID);
			password= System.getProperty("password");
			if(password == null || password.isEmpty()) {
				password = PropFileHandler.readProperty("userPassword");
			}
			userCreation.put(userID,password);
		}
	}

	@And("Clear data in hashmap after creating users")
	public void clearHashData() {
		userCreation.clear();
	}



	/**
	 * Create New User Using OKTA API For any store
	 * @param store
	 * @throws IOException
	 */
	@Given("I want to create (.*) user and login to application")
    public static void createNewUIUserAndLogin(String store) throws IOException
	{
    	Map<String, String> userInfo = new HashMap<>();
		deleteCookies();
		userInfo=UserCreationActions.CreateUserForDiffStores(store);
		
		userID  =  userInfo.get("email");
		userGUID = userInfo.get("guid");
    	
	}
	
	/**
	 * Create User for B2B Stores using SAP API
	 * @param store
	 */
	@And("I hit API to create (.*) User")
	public static void createB2BUser(String store) {
		String basestore = PropFileHandler.readProperty(store+"_BaseStore");
		String payload = UserCreationActions.getUserCreationPayload("automation", store ) ;
		response = UserCreationActions.createB2BUser(basestore, payload);
		
		JsonPath responseMap = JsonPath.from(response);
		userID  =  responseMap.get("uid");
		PropFileHandler.writeProperty(store+"_User", userID);	
		logMessage("User created Successfully:\n" + responseMap.get("email") + " || " + responseMap.get("uid"));
	}
	

	/**
	 * Create User for B2C Stores Using SAP API
	 * @param store
	 */
	@Given("I hit API to create (.*) user")
	public static void createB2CUserUsingSAPApi(String store) {
		String payload = UserCreationActions.customerPayload("automation", "FirstName", "LastName", store);
		response = UserCreationActions.registerACustomer(PropFileHandler.readProperty(store + "_BaseStore"), payload, "201");

		JsonPath responseMap = JsonPath.from(response);
		userID = responseMap.get("customerId");
		userGUID = responseMap.get("uid");
		PropFileHandler.writeProperty(store + "_User", userID);
		PropFileHandler.writeProperty(store + "_UserGuid", userGUID);

		logMessage("User created Successfully: " + userID);
		logMessage("User guid created Successfully: " + userID);
	}
	
	@And("I register a user using API")
	public static void registerACustomer(Map<String, String> apiData) {
		String payload;
		if (apiData.get("fName").equalsIgnoreCase("read") && apiData.get("lName").equalsIgnoreCase("read")) {
			payload = UserCreationActions.customerPayload(apiData.get("email"), getName("fName"),getName("lName"),
					apiData.get("store"));
		} else {
			payload = UserCreationActions.customerPayload(apiData.get("email"), apiData.get("fName"), apiData.get("lName"),
					apiData.get("store"));
		}
		response = UserCreationActions.registerACustomer(apiData.get("basestore"), payload, apiData.get("status"));
	}

//	Creating Normal B2B User and with regular expression
	@And("I hit b2b user creation API with regex")
	public static void createB2BUserwithRegex(Map<String, String> apiData) {
		String payload;
		if (apiData.get("fName").equalsIgnoreCase("read") && apiData.get("lName").equalsIgnoreCase("read")) {
			payload = UserCreationActions.getUserCreationPayloadwithRegex(apiData.get("email"), getName("fName"),
					getName("lName"), apiData.get("store"));
		} else {
			payload = UserCreationActions.getUserCreationPayloadwithRegex(apiData.get("email"), apiData.get("fName"),
					apiData.get("lName"), apiData.get("store"));
		}
		response = UserCreationActions.createB2BUser(apiData.get("basestore"), payload, apiData.get("status"));
	}
	
	@And("I hit b2b User creation API")
	public static void createB2BUser(Map<String, String> apiData) {
		String payload = UserCreationActions.getUserCreationPayload(apiData.get("email"), apiData.get("store"));
		response = UserCreationActions.createB2BUser(apiData.get("basestore"), payload, apiData.get("status"));
	}

	@And("I need to hit b2b User creation API by passing account number as a input")
	public static void createNewB2BUser(Map<String, String> apiData) {
		String payload = UserCreationActions.getNewUserCreationPayloadRandom(apiData.get("email"), apiData.get("store"),apiData.get("account"));
		logMessage(payload);
		response = UserCreationActions.createB2BUser(apiData.get("basestore"), payload, apiData.get("status"));
	}

	@And("I have to pass b2b User creation API which requires account number as a input")
	public static void createB2BUserByPassingAccountNo(Map<String, String> apiData) {
		String account = PropFileHandler.readProperty("ERPPhase3_"+apiData.get("store")+"_BillTo");
		logMessage(account);
		String payload = UserCreationActions.getNewUserCreationPayloadRandom(apiData.get("email"), apiData.get("store"),account);
		logMessage(payload);
		response = UserCreationActions.createB2BUser(apiData.get("basestore"), payload, apiData.get("status"));
	}

	@And("I need to create (.*)  b2b users for (.*) environment and to activate it and log the results (.*) for user creation for the test case (.*)")
	public static void createNoOfNewB2BUsers(String userCount,String env,String tdType,String tcId,Map<String, String> apiData) {
		int noOfUsers = Integer.parseInt(userCount);
		for(int i=0;i<noOfUsers;i++) {
			String payload = UserCreationActions.getNewUserCreationPayloadRandom(apiData.get("email"), apiData.get("store"), apiData.get("account"));
			logMessage(payload);
			response = UserCreationActions.createB2BUser(apiData.get("basestore"), payload, apiData.get("status"));
			password = apiData.get("password");
			if (env.equalsIgnoreCase("gale")) {
				UserCreationActions.activationApiGale(userID, password);
			} else if (env.equalsIgnoreCase("us")) {
				UserCreationActions.activationApiUnitedStates(userID, password);
			} else if (env.equalsIgnoreCase("canada")) {
				UserCreationActions.activationApiCanada(userID, password);
			}
			if (tdType.equalsIgnoreCase("password")) {
				OrdersAction.logTestDataForUserCreation(tcId);
			}
		}
	}

	@And("I need to create n number b2b users for (.*) environment and to activate it and log the results (.*) for user creation for the test case (.*)")
	public static void createNoOfNewB2BUsersWayTwo(String env,String tdType,String tcId,Map<String, String> apiData) {
		noOfUsers = System.getProperty("numberOfUsers");
		if (noOfUsers == null || noOfUsers.isEmpty())
			noOfUsers = PropFileHandler.readConfigProperty("numberOfUsers");
		int no = Integer.parseInt(noOfUsers);
		for(int i=0;i<no-1;i++) {
			String payload = UserCreationActions.getNewUserCreationPayloadRandom(apiData.get("email"), apiData.get("store"), apiData.get("account"));
			logMessage(payload);
			response = UserCreationActions.createB2BUser(apiData.get("basestore"), payload, apiData.get("status"));
			password = apiData.get("password");
			if (env.equalsIgnoreCase("gale")) {
				UserCreationActions.activationApiGale(userID, password);
			} else if (env.equalsIgnoreCase("us")) {
				UserCreationActions.activationApiUnitedStates(userID, password);
			} else if (env.equalsIgnoreCase("canada")) {
				UserCreationActions.activationApiCanada(userID, password);
			}
			if (tdType.equalsIgnoreCase("password")) {
				OrdersAction.logTestDataForUserCreation(tcId);
			}
		}
	}

	@And("I have to create and activate n number b2b (.*) users at run time for (.*) environment and to activate it and log the results (.*) for user creation for the test case (.*)")
	public static void createNoOfNewB2BUsersWayThree(String storeType, String env,String tdType,String tcId,Map<String, String> apiData) {

		noOfUsers = System.getProperty("numberOfUsers");
		if (noOfUsers == null || noOfUsers.isEmpty())
			noOfUsers = PropFileHandler.readConfigProperty("numberOfUsers");

		if (storeType.equalsIgnoreCase("gale")) {
			account = System.getProperty("b2bgaleErpaccount");
			if (account == null || account.isEmpty()){
				account = PropFileHandler.readProperty("b2bgaleErpaccount");
			}
		} else if (storeType.equalsIgnoreCase("us")) {
			account = System.getProperty("b2bUsErpAccount");
			if (account == null || account.isEmpty()){
				account = PropFileHandler.readProperty("b2bUsErpAccount");
			}

		} else if (storeType.equalsIgnoreCase("canada")) {
			account = System.getProperty("b2bcaErpAccount");
			if (account == null || account.isEmpty()){
				account = PropFileHandler.readProperty("b2bcaErpAccount");
			}

		}
		int no = Integer.parseInt(noOfUsers);
		for(int i=0;i<=no-1;i++) {
			String payload = UserCreationActions.getNewUserCreationPayloadRandom(apiData.get("email"), apiData.get("store"), account);
			logMessage(payload);
			response = UserCreationActions.createB2BUser(apiData.get("basestore"), payload, apiData.get("status"));
			password = apiData.get("password");
			if (storeType.equalsIgnoreCase("gale")) {
				UserCreationActions.activationApiGale(userID, password);
				logMessage(account);
				logMessage(userID);
				logMessage(password);
				userCreationDetMap.put("username "+i,userID);
				userCreationDetMap.put("password "+i,password);
				userCreationDetMap.put("account "+i,account);
			} else if (storeType.equalsIgnoreCase("us")) {
				UserCreationActions.activationApiUnitedStates(userID, password);
				logMessage(account);
				logMessage(userID);
				logMessage(password);
				userCreationDetMap.put("username "+i,userID);
				userCreationDetMap.put("password "+i,password);
				userCreationDetMap.put("account "+i,account);
			} else if (storeType.equalsIgnoreCase("canada")) {
				UserCreationActions.activationApiCanada(userID, password);
				logMessage(account);
				logMessage(userID);
				logMessage(password);
				userCreationDetMap.put("username "+i,userID);
				userCreationDetMap.put("password "+i,password);
				userCreationDetMap.put("account "+i,account);
			}
			if (tdType.equalsIgnoreCase("password")) {
				OrdersAction.logTestDataForUserCreation(tcId);
			}
		}
	}

	@And("Get the key and value pairs stored in user creation hashmap")
	public void hashKeyValueGetUserCreation() {
		for(Map.Entry<String,String> usercreation: userCreationDetMap.entrySet())
		{
			logMessage(usercreation.getKey() +" : "+ usercreation.getValue());
		}
	}

	@And("Store the key and value pairs of order and userId stored in place order hashmap for user {int} and of payment type {string}")
	public void hashKeyValueOrderDet(int n,String paymentType) {
		placeOrderDetMap.put("Order"+n,OrderID);
		placeOrderDetMap.put("User"+n,userID);
		placeOrderDetMap.put("PaymentType"+n,paymentType);
		placeOrderDetMap.put("storeType"+n,storeType);

		logMessage(placeOrderDetMap.get("Order"+n));
		logMessage(placeOrderDetMap.get("User"+n));
		logMessage(placeOrderDetMap.get("PaymentType"+n));
		logMessage(placeOrderDetMap.get("storeType"+n));
	}

	@And("I will store the key and value pairs of {string} in place order hashmap for user {int}")
	public static void hashKeyValueOrderDetStore(String parameter, int n) {

		JsonPath js = new JsonPath(response);
		if(parameter.equalsIgnoreCase("accountBillTo"))
		{
		    if (storeType.equals("cengage-b2b-gt"))
			{
				accountBillTo = js.getString("orgCustomer.defaultBillToAccount");
			}
			else if (storeType.equals("cengage-b2b-ca"))
			{
				accountBillTo = js.getString("orgCustomer.defaultBillToAccount");
			}
			else if (storeType.equals("cengage-b2b-us"))
			{
				accountBillTo = js.getString("orgCustomer.defaultBillToAccount");
			}
			placeOrderDetMap.put("accountBillTo"+n,accountBillTo);
			logMessage(placeOrderDetMap.get("accountBillTo"+n));
		}


		if(parameter.equalsIgnoreCase("accountShipTo"))
		{
			if (storeType.equals("cengage-b2b-gt"))
			{
				accountShipTo = js.getString("orgCustomer.defaultShipToAccount");
			}
			else if (storeType.equals("cengage-b2b-ca"))
			{
				accountShipTo = js.getString("orgCustomer.defaultShipToAccount");
			}
			else if (storeType.equals("cengage-b2b-us"))
			{
				accountShipTo = js.getString("orgCustomer.defaultShipToAccount");
			}
			placeOrderDetMap.put("accountShipTo"+n,accountShipTo);
			logMessage(placeOrderDetMap.get("accountShipTo"+n));
		}
		if(parameter.equalsIgnoreCase("deliveryMode"))
		{
			deliveryMode = js.getString("deliveryMode.code");
			placeOrderDetMap.put("deliveryMode"+n,deliveryMode);
			logMessage(placeOrderDetMap.get("deliveryMode"+n));
		}

		if(parameter.equalsIgnoreCase("couponCode"))
		{

			placeOrderDetMap.put("couponCode"+n,couponCodeGet);
			logMessage(placeOrderDetMap.get("couponCode"+n));
		}

		if(parameter.contains("accountType"))
		{
			String[] accountDet= parameter.split("-");
			placeOrderDetMap.put("accountType"+n,accountDet[1]);
			logMessage(placeOrderDetMap.get("accountType"+n));
		}
		placeOrderDetMap.put("Order"+n,OrderID);
		placeOrderDetMap.put("User"+n,userID);
		placeOrderDetMap.put("storeType"+n,storeType);
		logMessage(placeOrderDetMap.get("Order"+n));
		logMessage(placeOrderDetMap.get("User"+n));
		logMessage(placeOrderDetMap.get("storeType"+n));
	}








	@Given("^I hit b2bgale user creation api$")
	public static void createB2BGaleUserUsingAPI(Map<String, String> apiData) {
		String payload = UserCreationActions.getUserCreationPayloadRandom(apiData.get("email"), apiData.get("store"));
		response = UserCreationActions.createB2BUser(apiData.get("basestore"), payload, apiData.get("status"));
	}
	@And("I hit API to update (.*) customer Entitydetails_PATCH")
	public static void updateB2BUserEntitydetailsPATCH(String store , Map<String, String> apiData) {
		String payload = UserCreationActions.UpdateUserEntity();
		response = UserCreationActions.updateB2BUserEntity_PATCH(apiData.get("basestore"), userID, payload, apiData.get("status"));
	}
	
	@And("I hit API to update (.*) customer Entitydetails_PUT")
	public static void updateB2BUserEntitydetails(String store, Map<String, String> apiData) {
		String payload = UserCreationActions.UpdateUserEntity();
		response = UserCreationActions.updateB2BUserEntity_PUT(apiData.get("basestore"), userID, payload, apiData.get("status"));
	}

	@And("I hit API to update b2b customer details")
	public static void updateB2BUser(Map<String, String> apiData) {
		String payload = UserCreationActions.getUpdateRolesPayload();
		response = UserCreationActions.updateB2BUser(apiData.get("basestore"), userID, payload, apiData.get("status"));
	}

	@And("I hit API to update b2b customer status")
	public static void updateB2BUserStatus(Map<String, String> apiData) {
		String payload =UserCreationActions.changeUserStatusPayload();
		response = UserCreationActions.updateB2BUser(apiData.get("basestore"), userID, payload, apiData.get("status"));
	}
	
	@Then("I verify roles in API response")
	public void verifyRolesInResponse(Map<String, String> Properties) {
		user.verifyRolesInResponse(JsonPath.from(response), Properties);
	}
	
	@Then("I verify (.*) customer is registered")
	public void verifyCustomerIsRegistered(String store) {
		UserCreationActions.verifyCustomerIsRegistered(JsonPath.from(response), store);
	}	

//----------------------------------------------------------------------------------------------------------	
	@And("Run this step using comand")
	 public void createNewUserAndLogin() throws IOException	 
		{
			String api = System.getProperty("api"); 
			String store = System.getProperty("store");
			int num = Integer.parseInt(System.getProperty("num"));
			if(api.equalsIgnoreCase("sap")) {
				for(int i=0;i<num;i++)
		    	{
					createB2CUserUsingSAPApi(store);
		    	}
			} else {
				for(int i=0;i<num;i++)
		    	{
					createNewUIUserAndLogin(store);
		    	}
			}
		}
	
	@Given("create (.*) user with (.*) Api for (.*) store")
    public void createNewUserAndLogin(int num, String api, String store) throws IOException
	{
		if(api.equalsIgnoreCase("sap")) {
			for(int i=0;i<num;i++)
	    	{
				createB2CUserUsingSAPApi(store);
	    	}
		} else {
			for(int i=0;i<num;i++)
	    	{
				createNewUIUserAndLogin(store);
	    	}
		}

    	
	}

	@Then("I will hit B2BCA activation API")
	public static void hitActivationApi(Map<String,String> apiData) {
		UserCreationActions.activationApiCanada(apiData.get("email"), apiData.get("password"));
	}
	@Then("I will hit B2BCA activation API by creating the password")
	public static void hitActivationCanadaApi(Map<String,String> apiData) {
		password = apiData.get("password");
		UserCreationActions.activationApiCanada(userID,password);
	}

	@Then("I will hit B2BGT activation API by creating the password")
	public static void hitActivationGaleApi(Map<String,String> apiData) {
		password = apiData.get("password");
		UserCreationActions.activationApiGale(userID,password);
	}

	@Then("I will hit B2BUS activation API by creating the password")
	public static void hitActivationUsApi(Map<String,String> apiData) {
		password = apiData.get("password");
		UserCreationActions.activationApiUnitedStates(userID,password);
	}



}
