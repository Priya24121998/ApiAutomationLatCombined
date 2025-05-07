package com.cengage.pageactions;
/**
 * @author shiv.mangal
 *
 */

import com.cengage.Runner.BaseClass;
import io.restassured.path.json.JsonPath;
import org.testng.Assert;

import java.util.ArrayList;

public class ErrorsAndVerificationsActions extends BaseClass{

	public ErrorsAndVerificationsActions() {
		super();
	}

	
	/**
	 * Extracts the Address ID from the billing/ delivery address and Asserts if the
	 * Address is generated or not
	 * 
	 * @param type
	 */
	public void verifyAddressIsAddedToCart( JsonPath responseMap , String type) {
		String addressID = responseMap.get("id");

		Assert.assertNotNull(addressID, "**[ASSERT FAILED]:Value not found for AddressID ");
		logMessage("**[ASSERT PASSED]:" + type + " is successfully added to cart with: " + addressID);
	}
	
	/**
	 * Takes error message string as argument and Asserts it with actual error message extracted from API response   
	 * @param message
	 */
	public static void verifyErrorMessage(JsonPath responseMap,String message) {
		String actualMessage;
		
		try {
			actualMessage = responseMap.getString("errors[0].message");
			Assert.assertTrue(actualMessage.contains(message), "**[ASSERTION FAILED] Error message is::" + actualMessage);
			logMessage("**[ASSERTION PASSED] Verified error message is: " + actualMessage);
		} 
		catch (IllegalArgumentException e) {
			actualMessage = responseMap.getString("bulkCartModificationList[0].errorList.errors[0].message");
			compareResponseValue(actualMessage, message);
		}	
	}
	
	/**
	 * Verifies that API is returning correct error message with correct error type 
	 * 
	 */
	public void verifyTypeOfError(JsonPath responseMap) {
		ArrayList<String> errType = responseMap.get("errors");
		logMessage("Number of Error is : " + errType.size());
		for (int i = 0; i < errType.size(); i++) {
			compareResponseValue(responseMap.get("errors[" + i + "].type"), "ValidationError");
		}
	}
	
	/**
	 *  Verifies that API is returning correct error message with correct error type at given index
	 * @param atEntry
	 */
	public void verifyErrormsg(JsonPath responseMap,int atEntry) {
		String err = responseMap.get("errors[" + atEntry + "].message");

		Assert.assertEquals(err, "Each address line can be of maximum size 40 ");
		logMessage("**[ASSERT PASSED]: Error message is as Expected : " + err);

	}
	
	//------------------------------------------------Cart Error Verifications --------------------------------------------------
		public String warningMessage(JsonPath responseMap) {

			return responseMap.getString("bulkCartModificationList[0].cartModification.statusMessage");
			
		}

		public String errorMessage(JsonPath responseMap) {

			return responseMap.getString("bulkCartModificationList[0].errorList.errors[0].message");
			
		}

		public String errorMessage(JsonPath responseMap, String i) {

			return responseMap.getString("bulkCartModificationList[" + i + "].errorList.errors[0].message");
			
		}
		
	

		public static void verifyPaymentType(JsonPath responseMap, String paymentType) {
			String actualPaymentType = responseMap.get("paymentType.code");
			Assert.assertEquals(actualPaymentType, paymentType, "**[ASSERTION FAILED] Expected Payment Type:" + paymentType
					+ ",Actual Payment Type: " + actualPaymentType);
			logMessage("**[ASSERTION PASSED] Verified Payment Type is: " + actualPaymentType);

		}

		public static void verifyOrderStatus(JsonPath responseMap, String orderStatus) {
			String actualstatus = responseMap.get("status");
			Assert.assertEquals(actualstatus, orderStatus,
					"**[ASSERTION FAILED] Expected status:" + orderStatus + ",Actual Status: " + actualstatus);
			logMessage("**[ASSERTION PASSED] Verified ordere status is: " + actualstatus);

		}		
		
	
	// --------------------------------------------Not Used--------------------------------------------------------------- 	
		public void verifyDeliveryAddress(JsonPath responseMap, boolean available) {

			if (available) {
				Assert.assertTrue(responseMap.get("deliveryAddress").toString().contains("New South Wales"));
				String logmsg = "**[ASSERT PASSED]:Value found for Shipping Address";
				logMessage(logmsg);
			} else {
				Assert.assertNull(responseMap.get("deliveryAddress"),
						"**[ASSERTION FAILED] Value found for Shipping Address");
				logMessage("**[ASSERTION PASSED] Value not found for Shipping Address");
			}
		}

		public void verifyDelivaryModesInResponse(JsonPath responseMap, int atEntry, String code) {
			String getCode = responseMap.getString("deliveryModes[" + atEntry + "].code");
			Assert.assertEquals(getCode, code, "**[ASSERT FAILED]: Delivery Code is not as expected Delivery Code");
			logMessage("**[ASSERT PASSED]:  Delivery Code is  as expected Delivery Code " + getCode);

		}


		public void verifyStockPriceMinMatchesWithMinBundleCompStock(JsonPath responseMap) {
			
			int  minstockActual= responseMap.getInt("stock.stockLevel");
			
			logMessage("minstock Actual value seen in the response is " +minstockActual);
			logMessage("minstock Expected value seen in the response is " +minstock);
		    Assert.assertTrue(minstock==minstockActual, "Actual stock level value found in PDP response matches with minimum bundle component stock count");
		}
	


}