package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

public class CybersourceActions extends BaseClass {

	public CybersourceActions() {
		super();
		PageFactory.initElements(driver, this);
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

	/**
	 * Generate cybersource payment url
	 * 
	 * @param baseSiteId
	 * @param userId
	 * @param cartId
	 * @return
	 */
	public String getApplicationPath(String baseSiteId, String userId, String cartId) {
		String cybersourcePath = PropFileHandler.readProperty("CyberSource");
		cybersourcePath = cybersourcePath + "?basesite=" + baseSiteId + "&user=" + userId + "&cart=" + cartId;
		return cybersourcePath;
	}

	/**
	 * Enter credit card details from ui
	 * 
	 * @param ccType
	 */
	public void enterCCDetails(String ccType) {
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

	/**
	 * Verify cybersource response message after entering credit card details
	 * 
	 * @param msg
	 */
	public void verifyMessage(String msg) {
		hardWait(5);
		scrollDown(element(message, msg));
		String actualMsg = element(message, msg).getText();

		Assert.assertTrue(actualMsg.toLowerCase().contains(msg.toLowerCase()),
				"Expected: " + msg.toLowerCase() + ", Found: " + actualMsg.toLowerCase());
		logMessage("Verified " + msg + " message is displayed");

		if (msg.equalsIgnoreCase("accept")) {
			waitForElementToBeVisible(transactionId);
			scrollDown(transactionId);
			String subscriptionId = element(transactionId).getText().split(":")[2].trim();
			PropFileHandler.writeProperty("subscriptionId", subscriptionId);

			logMessage("Payment created with transactionId id: " + subscriptionId);
		}
		waitTOSync();
	}

	/**
	 * verify billing address not found error message
	 */
	public void verifyErrorMessage() {
		hardWait(5);

		waitForElementToBeVisible(errorMsg);
		String actualMsg = element(errorMsg).getText();
		String msg = "null value in entry: bill_to_address_line1=null";

		Assert.assertTrue(actualMsg.toLowerCase().contains(msg.toLowerCase()),
				"**[ASSERT FAILED]:  User is able to Add payment Details without adding billing Address");

		logMessage("**[ASSERT PASSED]:  User is not able to Add payment Details without adding billing Address");

	}

	/**
	 * Enter CC details and expire date and cvv
	 * 
	 * @param ccType
	 * @param exdate
	 * @param cvv
	 */
	public void enterCCDetails(String ccType, String exdate, String cvv) {
		String cardType = PropFileHandler.readProperty("CC_Type_" + ccType.replaceAll("\\d", "")).trim();
		String cardNumber = PropFileHandler.readProperty("creditCard_" + ccType).trim();
		String cardExpiryDate = exdate.trim();
		String cardCVN = cvv.trim();

		waitTOSync();
		element(creditCardType).click();
		element(creditCardType).clear();
		element(creditCardType).sendKeys(cardType);
		logMessage("Credit card type: " + cardType);

		element(creditCardNumber).click();
		element(creditCardNumber).clear();
		element(creditCardNumber).sendKeys(cardNumber);
		logMessage("Credit card number: " + cardNumber);

		element(creditCardExpiry).click();
		element(creditCardExpiry).clear();
		element(creditCardExpiry).sendKeys(cardExpiryDate);
		logMessage("Credit card expiry: " + cardExpiryDate);

		element(creditCardCVN).click();
		element(creditCardCVN).clear();
		element(creditCardCVN).sendKeys(cardCVN);
		logMessage("Credit card cvv: " + cardCVN);

		waitTOSync();

		element(submitBtn).click();
		logMessage("Credit Card details entered and submitted");
	}

	/**
	 * Accept 3DS OTP Authentication Window
	 * 
	 * @param cardName
	 */
	public void accept3dsPopup(String cardName) {
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
}
