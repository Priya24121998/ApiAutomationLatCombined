package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.RentalsApiActions;
import com.cengage.pageactions.SubscriptionsActions;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.Assert;

import java.util.Map;

@SuppressWarnings("deprecation")
public class RentalsStepDef extends BaseClass {

	public RentalsStepDef() {
		super();
	}

	RentalsApiActions rentalsPage = new RentalsApiActions();
	SubscriptionsActions subsPage = new SubscriptionsActions();
	public static final String BASESITEID = PropFileHandler.readProperty("baseSiteId");
	static String startDate;
	static String newEndDate;
	static String oldRentalEndDate;
	static String newGUID;
	static String carrierId;
	static String trackingId;

	
	@And("user extend rental for (.*) days")
	public void extendRentalForDays(String days) {
		RentalsApiActions.extendRental(BASESITEID, userGUID, cartId, rentalID, days);
	}

	@And("User hit update Api to (.*) Rental")
	public void updateRental(String type) {
		RentalsApiActions.uppdateRental(BASESITEID, userGUID, rentalID, type);
	}

	@And("User hit rental buyout api")
	public void rentalBuyout() {
		RentalsApiActions.rentalBuyout(BASESITEID, userGUID, cartId, rentalID);
	}

	@And("I get Availible rental count is (.*)")
	public void getAvailibleRetalCount(String count) {
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		String rentalCount = extractValueFromJOSNPath("planEligibility[2].available", response);
		compareResponseValue(count, rentalCount);
		logMessage("**[INFO] Availible Rental Count : " + rentalCount);
	}

	@Then("User hit Api to cancel (.*) rental")
	public void cancelRental(String index) {
		if (index.equalsIgnoreCase("first"))
			RentalsApiActions.uppdateRental(BASESITEID, userGUID, rentalId[0], "CANCELLED");
		else if (index.equalsIgnoreCase("second"))
			RentalsApiActions.uppdateRental(BASESITEID, userGUID, rentalId[1], "CANCELLED");
	}

	@And("User return (.*) rental in (.*) state")
	public void returnOfTextbookAndModifyRentalStateAccordingly(String index, String state) {

		if (index.equalsIgnoreCase("first"))
			rentalsPage.returnOfTextbookAndModifyRentalStateAccordingly(rentalId[0], state, 200);

		else if (index.equalsIgnoreCase("second"))
			rentalsPage.returnOfTextbookAndModifyRentalStateAccordingly(rentalId[1], state, 200);
	}

	@Then("Verify status of (.*) rental is (.*)")
	public void verifyRentalStatus(String index, String expected) {
		String rentalStatus = null;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);

		if (index.equalsIgnoreCase("first"))
			rentalStatus = extractValueFromJOSNPath("rentals[0].rentalState", response);

		else if (index.equalsIgnoreCase("second"))
			rentalStatus = extractValueFromJOSNPath("rentals[1].rentalState", response);

		compareResponseValue(expected, rentalStatus);

	}

	@And("I verify rental count is (.*)")
	public void verifyAvailibleRetalCount(String expectedCount) {
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		String rentalCount = extractValueFromJOSNPath("planEligibility[2].available", response);
		compareResponseValue(expectedCount, rentalCount);
	}

	@And("I transfer rental to latest active subscription")
	public void transferRentaltoLatestSubscription() {
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		String id = extractValuefromResponse(response, "planId");

		RentalsApiActions.rentalTranfer(BASESITEID, userGUID, id, rentalID);

	}

	@And("I verify subscriptionId is latest active subscription")
	public void verifysubscriptionIdOnRental() {
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		String renatlSubsid = extractValueFromJOSNPath("rentals[0].subscriptionId", response);

		String response1 = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		String latestActiveSubsid = extractValuefromResponse(response1, "planId");

		compareResponseValue(latestActiveSubsid, renatlSubsid);
	}

	@And("User add (.*) rental extension for (.*) days")
	public void extendRentalTwoForDays(int count, String days) {

		for (int i = 0; i < count; i++)
			RentalsApiActions.extendRental(BASESITEID, userGUID, cartId, rentalId[i], days);

	}

	@And("I Try to Ship (.*) rentals in one go")
	public void shipMulRentals(int numOfRentals) {
		RentalsApiActions.updateStausOfMulRentals(BASESITEID, OrderID, numOfRentals, 200);
	}

	@And("I Try to Ship Hardcover product at entry number (.*)")
	public void shipHardCover(int num) {
		RentalsApiActions.updateStaus(BASESITEID, OrderID, num, 200);
	}

	@When("User return rental in (.*) state after (.*) days")
	public void returnOfRentalAfterSomeDays(String state, int days) {
		String rentalID;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		String startDateGet = extractValueFromJOSNPath("rentals[0].startDate", response);
		String returnDate = addNumOfDaysToDate(startDateGet, days);
		logMessage(returnDate);
		rentalsPage.returnOfRentalAfterSomeDays(rentalID, state, returnDate, 200);
	}

	@Then("I verify end date of discounted rental and end date Cu is same")
	public void verifyRentalendDatetoCuEndDate() {
		String endDate;
		String rentalendDate;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalendDate = extractValueFromJOSNPath("rentals[0].endDate", response);
		String response1 = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		endDate = extractValueFromJOSNPath("endDate", response1);
		rentalsPage.verifyRentalendDatetoCuEndDate(rentalendDate, endDate);

	}



	@Then("I verify rental purchase available count is (.*) and total maximum count is (.*)")
	public void verifyRentalCount(int expectedavailableRentCount, int expectedMaxCount) {
		int maxRentalCount;
		int rentalavailablecount;
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		rentalavailablecount = extractIntegerValueFromJOSNPath("planEligibility[2].available", response);
		maxRentalCount = extractIntegerValueFromJOSNPath("planEligibility[2].quantity", response);
		rentalsPage.verifyRentalavailableCount(expectedavailableRentCount, rentalavailablecount);
		rentalsPage.verifyRentalMaxCount(expectedMaxCount, maxRentalCount);
	}

	@Then("I verify end date of multiple rentals must be ajusted to new upgraded subscription end date")
	public void verifyMultipleRentalendDateChangeForUpgrade() {
		String endDate;
		String rentalOneEndDate;
		String rentalTwoEndDate;
		String rentalThreeEndDate;
		String responseZero = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalOneEndDate = extractValueFromJOSNPath("rentals[0].endDate", responseZero);
		String responseOne = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalTwoEndDate = extractValueFromJOSNPath("rentals[1].endDate", responseOne);
		String responseTwo = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalThreeEndDate = extractValueFromJOSNPath("rentals[2].endDate", responseTwo);
		String responseThree = SubscriptionsActions.getSubscriptioDetailsForGivenCustomerGUID(userGUID, 200);
		endDate = extractValueFromJOSNPath("subscriptions[1].endDate", responseThree);
		rentalsPage.verifyMultipleRentalendDateforUpgradedCU(rentalOneEndDate, rentalTwoEndDate, rentalThreeEndDate, endDate);
	}

	@Then("Verify value of (.*) from return list of rentals API is (.*)")
	public static void verifyResponseValueFromReturnListOfRentalAPI(String parameter, String value) {
		response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		logMessage(response);
		String actual = extractValueFromJOSNPath("rentals[0]." + parameter, response);

		if (parameter.contains("Date"))
			actual = extractDateFromWholeString(actual);

		compareResponseValue(value, actual);
	}

	@Then("I verify if (.*) start date is startDate of the subscription")
	public static void verifyStartDateIsOldStartDate(String sub) {
		String oldDate = PropFileHandler.readProperty(sub + "_startDate");
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		startDate = extractValuefromResponse(response, "startDate");
		startDate = extractDateFromWholeString(startDate);
		compareResponseValue(oldDate, startDate);
	}

	@Then("I get (.*) latest price and save it")
	public static void getRentalLatestPaidPrice(String typOfPrice) {
		String latestPrice;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		latestPrice = extractValueFromJOSNPath("rentals[0].latestAmountPaid", response);

		PropFileHandler.writeProperty(typOfPrice + "_latestAmountPaid", latestPrice);
		logMessage("**[INFO] " + typOfPrice + "_latestAmountPaid: " + latestPrice);

	}

	@Then("I verify cumulative total price with listPrice when (.*)")
	public static void verifyTotalPriceWithListPrice(String priceType) {
		String listPrice;
		String totalPrice;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		listPrice = extractValueFromJOSNPath("rentals[0].listPrice", response);
		totalPrice = RentalsApiActions.getCumulativeTotalAmountForRental(priceType);

		logMessage("**[INFO] ListPrice: " + listPrice);
		logMessage("**[INFO] TotalPrice: " + totalPrice);
		Assert.assertEquals(totalPrice, listPrice, "**[ASSERT FAILED]: Total  amount is not as expected");
		logMessage("**[ASSERT PASSED]: Total amount is as expected : " + totalPrice);
	}

	@Then("Verify rental duration is increased to (.*)")
	public void checkIsRentalExtended(int days) {

		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		String endDate = extractValueFromJOSNPath("rentals[0].endDate", response);
		endDate = extractDateFromWholeString(endDate);
		String expectedEndDate = addNumOfDaysToDate(oldRentalEndDate, days);
		compareResponseValue(endDate, expectedEndDate);
	}
	
	
	@Then("Verify rental price is fixed to (.*)")
	public static void checkRentalPrice(String expectedPrice) {
		String actualPrice;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		logMessage(response);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		actualPrice = extractValueFromJOSNPath("rentals[0].latestAmountPaid", response);
		
		compareResponseValue(actualPrice, expectedPrice);
		
	}
	//New Code added here//
	@Then("Verify rental plan id is fixed to (.*)")
	public static void checkRentalPlanID(String expectedID) {
		String actualID;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		logMessage(response);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		actualID = extractValueFromJOSNPath("rentals[0].rentalPlanId", response);
		
		compareResponseValue(actualID, expectedID);
		
	}
	 
	
	
	@Then("Verify (.*) rental status in return list of rental API is (.*)")
	public static void verifyMulRentalStatus(int num, String expected) {

		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);

		for (int i = 0; i < num; i++) {
			rentalStatus[i] = extractValueFromJOSNPath("rentals[" + i + "].rentalState", response);
			rentalId[i] = extractValueFromJOSNPath("rentals[" + i + "].rentalId", response);
			logMessage("**[INFO] RentalId : " + rentalId[i]);
			compareResponseValue(rentalStatus[i], expected);
		}

	}

	@Then("I get rentalEndDate")
	public static void getRentalEndDate() {

		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		oldRentalEndDate = extractValueFromJOSNPath("rentals[0].endDate", response);
		logMessage("Rental EndDate: " + oldRentalEndDate);
		PropFileHandler.writeProperty("rentalEndDate", oldRentalEndDate);
	}

	@Then("Verify rental duration for 24 mon CU is maximum 1 year")
	public static void checkRentalEndDateIs1Year() {
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		startDate = extractValueFromJOSNPath("rentals[0].startDate", response);
		String endDate = extractValueFromJOSNPath("rentals[0].endDate", response);
		endDate = extractDateFromWholeString(endDate);
		String end = addNumOfDaysToDate(startDate, 365);

		logMessage("Rental endate is: " + endDate);
		logMessage("calculated endDate is: " + end);

		compareResponseValue(endDate, end);
	}

	@Then("I verify if Rental Start date is start date of the Subscription")
	public static void verifySubsStartDateIsRentalStartDate() {
		String response1 = SubscriptionsActions.getSubscriptioDetailsForGivenCustomerGUID(userGUID, 200);
		String subStartDate = extractValueFromJOSNPath("subscriptions[0].startDate", response1);
		subStartDate = extractDateFromWholeString(subStartDate);

		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		String rentalStartDate = extractValueFromJOSNPath("rentals[0].startDate", response);
		rentalStartDate = extractDateFromWholeString(rentalStartDate);

		logMessage("Rental StartDate is: " + rentalStartDate);
		logMessage("CU StartDate is: " + subStartDate);
		compareResponseValue(rentalStartDate, subStartDate);

	}

	@Then("I verify if start date of the rental is current date")
	public static void verifyRentalStartDateIsCurrentDate() {
		String currentDate = getCurrentDate();
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		startDate = extractValueFromJOSNPath("rentals[0].startDate", response);
		startDate = extractDateFromWholeString(startDate);
		compareResponseValue(currentDate, startDate);
	}

	@Then("I Verify rental enddate is (.*) days later")
	public void checkIsStanaloneRentalEnddate(int days) {

		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		String endDate = extractValueFromJOSNPath("rentals[0].endDate", response);
		endDate = extractDateFromWholeString(endDate);
		String end = addNumOfDaysToDate(startDate, days);
		compareResponseValue(endDate, end);
	}
	
	@Then("Verify able to Update Rental Details")
	public static void userShouldBeAbleToUpdateRental() {
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		RentalsApiActions.updateDetailOfRentalOrder(BASESITEID, rentalID, 200);
	}

	@Then("Verify able to Update Rental Details With DuplicateID")
	public static void userShouldBeAbleToUpdateRentalWithDuplicateID() {
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		RentalsApiActions.updateDetailOfRentalOrderWithDuplicateID(BASESITEID, rentalID, 200);
	}
	
	@Then("Verify able to Update Rental Details WithoutReturnNotes")
	public static void userShouldBeAbleToUpdateRentalWithoutReturnNotes() {
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		RentalsApiActions.updateDetailOfRentalOrderWithoutReturnNotes(BASESITEID, rentalID, 400);
	}

	@Then("Verify user is able to ship rental using API")
	public static void userShouldBeAbleToShipRental() {
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		RentalsApiActions.updateStausOfRentalOrder(BASESITEID, OrderID, rentalID, 200);
	}

	@Then("Verify rental status in return list of rental API is (.*)")
	public static void verifyRentalStatus(String expected) {
		String rentalStatus;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalStatus = extractValueFromJOSNPath("rentals[0].rentalState", response);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		logMessage(response);

		logMessage("**[INFO] RentalId : " + rentalID);
		compareResponseValue(expected, rentalStatus);

	}
	
	//New Code added here//
	
	@Then("Verfiy last amount paid in return list of rental API is fixed to (.*)")
	public static void verifyRentalPrice(String expected) {
		String rentalPrice;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalPrice = extractValueFromJOSNPath("rentals[0].latestAmountPaid", response);
		
		logMessage("**[INFO] RentalPrice : " + rentalPrice);
		compareResponseValue(expected, rentalPrice);
	}
	
	@When("I return rental in (.*) state")
	public void returnOfTextbookAndModifyRentalStateAccordingly(String state) {
		String rentalID;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		rentalsPage.returnOfTextbookAndModifyRentalStateAccordingly(rentalID, state, 200);
	}
	

	@When("I return rental in (.*) state_WithoutReturnNotes")
	public void returnOfTextbookAndModifyRentalStateAccordinglyWithoutReturnNotes(String state) {
		String rentalID;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		RentalsApiActions.returnOfTextbookAndModifyRentalStateAccordinglyWithoutReturnNotes(rentalID, state, 400);
	}
	
	
	

	@And("I hit DPS API to get rnetal duration")
	public static void getDPSApi(Map<String, String> apiData) {
		int status = getStatusCode(apiData.get("status"));
		response = RentalsApiActions.getDPSApi(apiData.get("product"), apiData.get("unlimited"), apiData.get("rentals"),
				status);
	}
	
//	Unused
	
	@When("I hit update rental API to update (.*) field with value (.*)")
	public static void updateRental(String field, String value) {
		response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		if (field.contains("GUID")) {
			newGUID = getCurrentTimestamp();
			value = newGUID;
		}
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		RentalsApiActions.updateRental(rentalID, field, value);
	}
	
	@Then("I verify end date must be adjusted to the new subscription end date when cu upgrade to Cuet to CuFull")
	public void verifyRentalendDateChangeForUpgrade() {
		String endDate;
		String rentalendDate;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalendDate = extractValueFromJOSNPath("rentals[0].endDate", response);
		String response1 = SubscriptionsActions.getSubscriptioDetailsForGivenCustomerGUID(userGUID, 200);
		endDate = extractValueFromJOSNPath("subscriptions[1].endDate", response1);
		rentalsPage.verifyRentalendDatetoCuEndDate(rentalendDate, endDate);
	}
	

	@Then("I verify if current date is start date of the subscription")
	public static void verifyStartDateIsCurrentDate() {
		String currentDate = getCurrentDate();
		String response = SubscriptionsActions.getSubscriptionStateDetailsForContractWithCustomerGUID(userGUID, 200);
		startDate = extractValuefromResponse(response, "startDate");
		startDate = extractDateFromWholeString(startDate);
		compareResponseValue(currentDate, startDate);
	}
	
	@Then("I verify rental state is (.*)")
	public void verifyRentalState(String expectedState) {
		String actualState;
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		actualState = extractValuefromResponse(response, "rentalState");
		rentalsPage.verifyRentalState(expectedState, actualState);
	}

	@Then("I verify if return rental details API is returning valid response")
	public static void returnRentalDetailsForGivenCustomerGuidAndRentalID() {
		response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		logMessage("Rental ID: " + rentalID);
		response = RentalsApiActions.returnRentalDetailsForGivenCustomerGuidAndRentalID(userGUID, rentalID, 200);
		compareResponseValue(rentalID, extractValuefromResponse(response, "rentalId"));
	}
	
	@Then("I verify if return rental details API is returning valid returnTrackingInfo")
	public static void returnRentalDetailsForreturnTrackingInfo() {
		response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		logMessage("Rental ID: " + rentalID);
		response = RentalsApiActions.returnRentalDetailsForGivenCustomerGuidAndRentalID(userGUID, rentalID, 200);
		carrierId = extractValueFromJOSNPath("returnTrackingInfo.carrier", response);
		trackingId = extractValueFromJOSNPath("returnTrackingInfo.trackingId", response);
		compareResponseValue(rentalID, extractValuefromResponse(response, "rentalId"));
		logMessage("Carrier ID: " + carrierId);
		logMessage("Tracking ID: " + trackingId);
		
		
	}
	
	
	@Then("Verify Buyout amount is returned by return rental details API")
	public static void verifyBuyoutAmtIsReturned() {
		response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);
		rentalID = extractValueFromJOSNPath("rentals[0].rentalId", response);
		response = RentalsApiActions.returnRentalDetailsForGivenCustomerGuidAndRentalID(userGUID, rentalID, 200);
		double amount = extractIntegerValuefromResponse(response, "buyoutPrice");
		verifyIfResponseValueIsNotEmpty(String.valueOf(amount));
	}
	

	@Then("An error should be thrown when invalid rental ID is entered for return rental details API")
	public static void verifyErrorWithReturnRentalDetailsAPIWithInvalidRentalID() {
		response = RentalsApiActions.returnRentalDetailsForGivenCustomerGuidAndRentalID(userGUID, "00000000", 400);
	}

//	Obsolute
//	@Then("I verify user is able to ship (.*) rental")
	public static void userShouldBeAbleToShipMultipleRental(int count) {
		String response = RentalsApiActions.returnListOfRentalThatContainingRentalInformation(userGUID, 200);

		for (int i = 0; i < count; i++) {
			rentalId[i] = extractValueFromJOSNPath("rentals[" + i + "].rentalId", response);
			logMessage("**[INFO] RentalId : " + rentalId[i]);
			RentalsApiActions.shippingNotificationOfARental(rentalId[i], 200);
		}
	}

}
