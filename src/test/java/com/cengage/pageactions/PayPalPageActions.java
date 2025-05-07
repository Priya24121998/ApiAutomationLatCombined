package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

public class PayPalPageActions extends BaseClass {
	public PayPalPageActions() {
		super();
		PageFactory.initElements(driver, this);
	}


	public static final By email = By.cssSelector("input[id='email']");
	public static final By nextBtn = By.cssSelector("button[id='btnNext']");
	public static final By password = By.cssSelector("input[id='password']");
	public static final By loginBtn = By.cssSelector("button[id='btnLogin']");
	public static final By agreeContinueBtnNew = By.cssSelector("button[name='Agree & Continue']");
	public static final By paypalSaveandContinue = By.xpath("//button[@id='consentButton']");
	public static final By paypalContinueReviewOrder = By.xpath("//*[@id='payment-submit-btn']");
	

	public void verifyPayPalPortalHasLaunched() {
		if (browser.equalsIgnoreCase("edge")) {
			waitTOSync();
			waitTOSync();

		}
		hardWait(7);
		if (tier.equalsIgnoreCase("Prod")) {
			Assert.assertTrue(getCurrentURL().contains("paypal"), "**[ASSERT FAILED]: Paypal portal has not launched");
			logMessage("**[ASSERT PASSED]: Paypal portal has launched successfully");
		} else {
			Assert.assertTrue(getCurrentURL().contains("sandbox"), "**[ASSERT FAILED]: Paypal portal has not launched");
			logMessage("**[ASSERT PASSED]: Paypal portal has launched successfully");
		}

	}

	public void enterPayPalEmail(String emailID) {
		element(email).click();
		element(email).clear();
		element(email).sendKeys(emailID);

		logMessage("Entered PayPal email id: " + emailID);
	}

	public void clickNextButton() {
		if (!element_visibility(nextBtn))
			waitForElementToBeClickable(nextBtn);

		element(nextBtn).click();
		logMessage("Clicked on next button");
	}

	public void enterPayPalPassword(String pass) {
		element(password).click();
		element(password).clear();
		element(password).sendKeys(pass);

		logMessage("Entered PayPal password: " + pass);
	}

	public void clickOnLoginButton() {
		element(loginBtn).click();
		logMessage("Clicked on login button");
		waitTOSync();
	}

	public void completePaypalTransaction() {
		hardWait(10);
		try {
			element(paypalSaveandContinue).click();
			logMessage("Clicked on Save and continue button");

		} catch (Exception e) {
			element(agreeContinueBtnNew).click();
			logMessage("Clicked on agree and continue button");
		}
		hardWait(5);
	}
	
	public void completeNewPaypalTransaction() {
		hardWait(10);
		try {
			element(paypalContinueReviewOrder).click();
			logMessage("Clicked on continue to review order option");

		} catch (Exception e) {
			element(paypalContinueReviewOrder).click();
			logMessage("Catch Exception: Clicked on continue to review order option");
		}
		hardWait(5);
	}

	public static String getApplicationPathPaypal(String baseSiteId, String userId, String cartId, int statusCode) {

		String endPoint = "/" + baseSiteId + "/users/" + userId + "/carts/" + cartId + "/payment/hop/request";
		String token = setAuthorizationHeader();
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage(">>Get Paypal Path: " + endPoint);
		response = RestAssured.given().headers("Authorization", token).contentType(ContentType.JSON)
				.queryParam("fields", "DEFAULT").queryParam("paymentMethod", "PAYPAL").get(endPoint).then().assertThat().statusCode(statusCode)
				.extract().asString();
		JsonPath responseMap = JsonPath.from(response);
		if (statusCode != 400)
			return responseMap.get("paymentProviderUrl");

		else
			return response;
	}
	
	public static void getPayPalToken(String appPath) {
		String[] parts = appPath.split("=");
		payPalToken = parts[1];
		logMessage("Token: "+payPalToken);

	}
	
	public static void getPayPalTokenNew(String appPath) {
		String[] parts = appPath.split("=");
		payPalToken = parts[2];
		
		logMessage("token: "+payPalToken);
	}


	
	public void verifyErrorMessage(JsonPath responseMap, String message) {
		String actualMessage = responseMap.getString("errors[0].message");
		Assert.assertTrue(actualMessage.contains(message), "**[ASSERTION FAILED] Error message is::" + actualMessage);
		logMessage("**[ASSERTION PASSED] Verified error message is: " + actualMessage);
	}

}
