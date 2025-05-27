/**
 * The {@code UIActions} class is part of the `com.cengage.restActions` package.
 * This class is designed to handle user interface-related actions within the 
 * application. It provides methods and utilities to interact with and manage 
 * UI elements effectively.
 *
 * <p>Usage of this class ensures a clean separation of UI-related logic, 
 * making the codebase more modular and easier to maintain. Developers can 
 * extend or modify the functionality of this class to suit specific UI 
 * interaction requirements.
 *
 * <p><strong>Note:</strong> Ensure that all methods in this class are 
 * thoroughly tested to maintain the integrity of UI interactions.
 *
 * @author Priyadharshini M
 * @version 1.0
 * @since 2025
 */
package com.cengage.restActions;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.cengage.common.BrowserUtils;
import com.cengage.common.PropFileHandler;

public class UIActions extends BrowserUtils{
	
    Logger logger = LoggerFactory.getLogger(getClass());
	
	public UIActions() {
		super();
	}
	
	public static final By creditCardType = By.name("card_type");
	public static final By creditCardNumber = By.name("card_number");
	public static final By creditCardExpiry = By.name("card_expiry_date");
	public static final By creditCardCVN = By.name("card_cvn");
	public static final By submitBtn = By.id("btn_submit");
	public static final By message = By.xpath("//h3[contains(text(),'${option}')]");
	public static final By transactionId = By.xpath("//h3[contains(text(),': transaction_id ,')]");
	public static final By errorMsg = By.xpath("//h2[3]");
	public static final By amExIframe = By.cssSelector("iframe[id='Cardinal-CCA-IFrame']");
	public static final By codeField = By.cssSelector("input[class='input-field']");
	public static final By Submitbtn3ds = By.cssSelector("input[value='SUBMIT']");
	public static final By email = By.cssSelector("input[id='email']");
	public static final By nextBtn = By.cssSelector("button[id='btnNext']");
	public static final By password = By.cssSelector("input[id='password']");
	public static final By loginBtn = By.cssSelector("button[id='btnLogin']");
	public static final By agreeContinueBtnNew = By.cssSelector("button[name='Agree & Continue']");
	public static final By paypalSaveandContinue = By.xpath("//button[@id='consentButton']");
	public static final By paypalContinueReviewOrder = By.xpath("//*[@id='payment-submit-btn']");
	


	
	public static void enterCCDetails(String ccType) {
		String cardType = PropFileHandler.readProperty("CC_Type_" + ccType.replaceAll("\\d", "")).trim();
		String cardNumber = PropFileHandler.readProperty("creditCard_" + ccType).trim();
		String cardExpiryDate = PropFileHandler.readProperty("CC_Expiry").trim();
		String cardCVN;
		if (ccType.contains("Amex"))
			cardCVN = PropFileHandler.readProperty("creditCardAmexCVV").trim();
		else
			cardCVN = PropFileHandler.readProperty("creditCardCVV").trim();

		waitTOSync();
		WebElement creditCardTypeEle =element(creditCardType);
		creditCardTypeEle.click();
		creditCardTypeEle.clear();
		creditCardTypeEle.sendKeys(cardType);
		logMessage("Credit card type: " + cardType);

		WebElement creditCardNumberEle =element(creditCardNumber);
		creditCardNumberEle.click();
		creditCardNumberEle.clear();
		creditCardNumberEle.sendKeys(cardNumber);
		logMessage("Credit card number: " + cardNumber);

		WebElement creditCardExpiryEle =element(creditCardExpiry);
		creditCardExpiryEle.click();
		creditCardExpiryEle.clear();
		creditCardExpiryEle.sendKeys(cardExpiryDate);
		logMessage("Credit card expiry: " + cardExpiryDate);

		WebElement creditCardCVNEle =element(creditCardCVN);
		creditCardCVNEle.click();
		creditCardCVNEle.clear();
		creditCardCVNEle.sendKeys(cardCVN);
		logMessage("Credit card cvv: " + cardCVN);

		waitTOSync();

		element(submitBtn).click();
		logMessage("Credit Card details entered and submitted");
	}
	
	public static void accept3dsPopup(String cardName) {
		hardWait(20);
		switchToiFrame(element(amExIframe));
		element(codeField).click();
		element(codeField).clear();
		element(codeField).sendKeys("1234");
		logMessage("Entered code");
		waitTOSync();
		element(Submitbtn3ds).click();
		logMessage("Clicked on submit button for " + cardName + " validation popup");
		switchToDefaultContent();
	}
	
	public static void verifyMessage(String msg) {
		hardWait(5);
		scrollDown(element(message, msg));
		String actualMsg = element(message, msg).getText();

		System.out.println("Actual Message: "+actualMsg.toLowerCase());
		System.out.println("Expected message: "+msg.toLowerCase());
		System.out.println("Verified " + msg + " message is displayed");

		if (msg.equalsIgnoreCase("accept")) {
			waitForElementToBeVisible(transactionId);
			scrollDown(transactionId);
			String subscriptionId = element(transactionId).getText().split(":")[2].trim();
			PropFileHandler.writeProperty("subscriptionId", subscriptionId);

			System.out.println("Payment created with transactionId id: " + subscriptionId);
		}
		waitTOSync();
	}
	
	public static void enterPayPalEmail(String emailID) {
		element(email).click();
		element(email).clear();
		element(email).sendKeys(emailID);

		logMessage("Entered PayPal email id: " + emailID);
	}
	
	public static void clickNextButton() {
		if (!element_visibility(nextBtn))
			waitForElementToBeClickable(nextBtn);

		element(nextBtn).click();
		logMessage("Clicked on next button");
	}

	public static void enterPayPalPassword(String pass) {
		element(password).click();
		element(password).clear();
		element(password).sendKeys(pass);

		logMessage("Entered PayPal password: " + pass);
	}

	public static void clickOnLoginButton() {
		element(loginBtn).click();
		logMessage("Clicked on login button");
		waitTOSync();
	}
	
	public static void completeNewPaypalTransaction() {
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



	
	
	


}
