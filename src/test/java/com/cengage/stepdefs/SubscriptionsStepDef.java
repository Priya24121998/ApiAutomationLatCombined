package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.SubscriptionsActions;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

@SuppressWarnings("deprecation")
public class SubscriptionsStepDef extends BaseClass {

	public SubscriptionsStepDef() {
		super();
	}

	
	SubscriptionsActions subsPage = new SubscriptionsActions();
	public static final String BASESITEID = PropFileHandler.readProperty("baseSiteId");
	static String newDate;
	
	@When("I create (.*) subscription plan through API with start date (.*)")
	public void createSubscription(String type, String startDate) {
		SubscriptionsActions.createSubscriptionApi(PropFileHandler.readSKU_PlanID(type), userGUID, 201, startDate, 0);
	}
	
	@When("I create (.*) subscription plan through API with duration (.*)")
	public void createSubscription(String type, int duration) {
		SubscriptionsActions.createSubscriptionApi(PropFileHandler.readSKU_PlanID(type), userGUID, 201, null, duration);
	}

	@When("Create (.*) subscription plan through API with start date (.*) and duration (.*) days")
	public void createSubscription(String type, String startDate, int duration) {
		SubscriptionsActions.createSubscriptionApi(PropFileHandler.readSKU_PlanID(type), userGUID, 201, startDate, duration);
	}

	@When("I purchase (.*) subscription plan through API")
	public void createSubscription(String type) {

		if (type.contains("Pv"))
			SubscriptionsActions.createSubscriptionApi(PropFileHandler.readSKU_PlanID(type), userGUID, 400, null, 0);
		else
			SubscriptionsActions.createSubscriptionApi(PropFileHandler.readSKU_PlanID(type), userGUID, 201, null, 0);
	}

	
	@When("I hit durationchange Api for (.*)")
	public void createDurationChangeCart(String skuGet) {
		String sku = PropFileHandler.readSKU_PlanID(skuGet);
		SubscriptionsActions.durationChange(BASESITEID, userGUID, subscriptionId, sku);
		logMessage("Duration Change Cart created successfully, with:\nCartID: " + cartId + "\nCartGuid: "
				+ authenticatedCartGuid);
	}
	
	@Then("I fetch get details API response value of (.*) field of (.*)")
	public static void fetchAPIResponseOfGivenField(String field, String sub) {
		response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);

		String date1 = extractValueFromJOSNPath(field, response);
		date1 = extractDateFromWholeString(date1);
		PropFileHandler.writeProperty(sub + "_" + field, date1);
	}
	

	
	@Then("I verify (.*) API response value of (.*) field is (.*)")
	public static void verifyAPIResponseValueForAPariticularField(String apiGet, String field, String expectedValue) {
		String value;
		if (apiGet.equalsIgnoreCase("get state"))
			response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		else if (apiGet.equalsIgnoreCase("get details"))
			response = SubscriptionsActions.getSubscriptioDetailsForGivenCustomerGUID(userGUID, 200);

		value = extractValuefromResponse(response, field);

		if (field.contains("Date"))
			value = extractDateFromWholeString(value);

		compareResponseValue(value, expectedValue);
	}

	@When("I get subscription deatils using API")
	public static void getSubsDetails() {
		response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		subscriptionId = extractValuefromResponse(response, "planId");
		logMessage("**[INFO]: SubscriptionID : " + subscriptionId);
	}
	
	
	@Then("User hit Cancel Api to cancel (.*) subscription")
	public void cancelSubscriptionUsingApi(String subType) {
		if (subType.equalsIgnoreCase("PENDING"))
			SubscriptionsActions.userCancelSubscription(BASESITEID, userGUID, penSub);
		else
			SubscriptionsActions.userCancelSubscription(BASESITEID, userGUID, subscriptionId);
	}
	
	@Then("I update subscription status to (.*)")
	public static void updateSubscriptionUsingApi(String status) {
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		subscriptionId = extractValuefromResponse(response, "planId");
		SubscriptionsActions.updateSubscriptionStatus(BASESITEID, userGUID, subscriptionId, status);
	}

	@When("I Activate pending subscription")
	public void activatePendingSub() {
		SubscriptionsActions.activatePendingSubscription(BASESITEID, userGUID, penSub);
	}

	@And("I verify pending Subscription is (.*)")
	public static void verifyPendingSubscription(String type) {
		String response = SubscriptionsActions.getSubscriptioDetailsForGivenCustomerGUID(userGUID, 200);
		String subscriptionStatus = extractValueFromJOSNPath("subscriptions[0].subscriptionStatus", response);

		if (subscriptionStatus.equalsIgnoreCase("PENDING")) {
			logMessage("**[ASSERT PASSED]: Actual response value: [" + subscriptionStatus
					+ "], matches with exepcted [PENDING] value");
			String subscriptiontype = extractValueFromJOSNPath("subscriptions[0].subscriptionPlanId", response);
			compareResponseValue(subscriptiontype, type);
			penSub = extractValueFromJOSNPath("subscriptions[0].id", response);
			logMessage("**[INFO]: Pending SubscriptionID : " + penSub);
		} else {
			subscriptionStatus = extractValueFromJOSNPath("subscriptions[1].subscriptionStatus", response);
			compareResponseValue(subscriptionStatus, "PENDING");
			String subscriptiontype = extractValueFromJOSNPath("subscriptions[1].subscriptionPlanId", response);
			compareResponseValue(subscriptiontype, type);
			penSub = extractValueFromJOSNPath("subscriptions[1].id", response);
			logMessage("**[INFO]: Pending SubscriptionID : " + penSub);
		}
	}
	
	@Then("I verify pending subscription status is (.*)")
	public void verifyPendingSubscriptionIs(String type) {
		String response = SubscriptionsActions.getSubscriptioDetailsForGivenCustomerGUID(userGUID, 200);
		String id = extractValueFromJOSNPath("subscriptions[0].id", response);

		if (id.equalsIgnoreCase(penSub)) {
			String subscriptionStatus = extractValueFromJOSNPath("subscriptions[0].subscriptionStatus",
					response);
			compareResponseValue(subscriptionStatus, type);
		} else {
			String subscriptionStatus = extractValueFromJOSNPath("subscriptions[1].subscriptionStatus",
					response);
			compareResponseValue(subscriptionStatus, type);
		}
	}

	@When("I update pending subscription status to (.*)")
	public static void updatePendingSubscriptionUsingApi(String status) {
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		subscriptionId = extractValuefromResponse(response, "planId");
		SubscriptionsActions.updateSubscriptionStatus(BASESITEID, userGUID, penSub, status);
	}
	
	@Then("I Verify Subscription enddate is (.*) days later")
	public void checkSubscriptionEnddate(int days) {
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		String endDate = extractValueFromJOSNPath("endDate", response);
		String startDate = extractValueFromJOSNPath("startDate", response);
		endDate = extractDateFromWholeString(endDate);
		String end = addNumOfDaysToDate(startDate, days);
		compareResponseValue(endDate, end);

	}

	@Then("I Verify Subscription enddate is (.*) months later")
	public void checkSubscriptionEnddateMonth(int months) {

		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		String endDate = extractValueFromJOSNPath("endDate", response);
		String startDate = extractValueFromJOSNPath("startDate", response);
		logMessage("Start Date Actual"+startDate);
		endDate = extractDateFromWholeString(endDate);
		String end = subsPage.addNumOfMonthsToDate(startDate, months);
		logMessage("End Date Expected"+endDate);
		logMessage("End Date Actual"+end);
		compareResponseValue(endDate, end);

	}

	@Then("User verify subscription is (.*)")
	public void verifySubscriptionIs(String type) {
		String response = SubscriptionsActions.getSubscriptioDetailsForGivenCustomerGUID(userGUID, 200);
		String id = extractValueFromJOSNPath("subscriptions[0].id", response);

		if (id.equalsIgnoreCase(subscriptionId)) {
			String subscriptionStatus = extractValueFromJOSNPath("subscriptions[0].subscriptionStatus",
					response);
			compareResponseValue(subscriptionStatus, type);
		} else {
			String subscriptionStatus = extractValueFromJOSNPath("subscriptions[1].subscriptionStatus",
					response);
			compareResponseValue(subscriptionStatus, type);
		}
	}


	@Then("I verify (.*) subscription has been created")
	public void verifySubscriptionIsCreated(String type) {
		String subscriptionType;
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		subsPage.verifySubscriptionStatus("ACTIVE", extractValuefromResponse(response, "contractStatus"));
		subscriptionType = extractValuefromResponse(response, "subscriptionPlan");
		if (type.equals("Trial"))
			subsPage.verifySubscriptionStatus("CU-Trial-14", subscriptionType);
		else if (type.equalsIgnoreCase("4 months"))
			subsPage.verifySubscriptionStatus("Full-Access-120", subscriptionType);
		else if (type.equalsIgnoreCase("12 months"))
			subsPage.verifySubscriptionStatus("Full-Access-365", subscriptionType);
		else if (type.equalsIgnoreCase("24 months"))
			subsPage.verifySubscriptionStatus("Full-Access-730", subscriptionType);
	}
	
//	Unused
	@Then("I verify if all expected values are returned by get subscription state API")
	public void getSubscriptionStateDetailsForContractWithCustomerGUID() {
		String rental = null;
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		logMessage(response);
		subsPage.verifyResponseParameterValueIsNotNull(response, "contractStatus");
		subsPage.verifyResponseParameterValueIsNotNull(response, "endDate");
		subsPage.verifyResponseParameterValueIsNotNull(response, "planId");
		subsPage.verifyResponseParameterValueIsNotNull(response, "startDate");
		subsPage.verifyResponseParameterValueIsNotNull(response, "subscriptionPlan");
		subsPage.verifyResponseParameterValueIsNotNull(response, "subscriptionTier");
		if (tier.equalsIgnoreCase("perf"))
			rental = extractValueFromJOSNPath("planEligibility[5].available", response);
		else {
			rental = extractValueFromJOSNPath("planEligibility[2].available", response);
			logMessage("Available rental value: " + rental);
			verifyIfResponseValueIsNotEmpty(rental);
		}
	}
	
	@Then("I add (.*) days to (.*)")
	public static void addDays(int days, String dateType) {
		String date;
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		date = extractValuefromResponse(response, dateType);
		newDate = addNumOfDaysToDate(date, days);
	}

	
	@When("Update (.*) to new calculated date for (.*)")
	public static void updateDateToNewDate(String dateType, String sub) {
		String id;
		String date = null;
		response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		id = extractValuefromResponse(response, "planId");
		SubscriptionsActions.updateSubscription(userGUID, id, dateType, newDate, 201);
		response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		date = extractValuefromResponse(response, dateType);
		compareResponseValue(extractDateFromWholeString(date), newDate);
		PropFileHandler.writeProperty(sub + "_" + dateType, newDate);
	}
	
}
