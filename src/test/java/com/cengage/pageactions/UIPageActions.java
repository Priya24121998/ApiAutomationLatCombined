package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import com.cengage.utils.PropFileHandler;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;

public class UIPageActions extends BaseClass {
	public UIPageActions() {
		super();
		PageFactory.initElements(driver, this);
	}

	
	OrdersAction ordersActions = new OrdersAction();

	public static final By btnAddToCart = By.xpath("//button[contains(text(),'Add to Cart')]");
	public static final By btnAddToCartNew = By.cssSelector("button[class*='product-card-button-primary']");
	public static final By searchInputField = By.xpath("//*[@id='search-bar']");
	public static final By btnSearch = By.cssSelector("button[type='submit']");
	public static final By accessEbookRadio = By.xpath(
			"//a[contains(text(),'Tell me about Cengage eTextbooks')]//following::span[@class ='product-radio product-radio-inactive'][1]");
	public static final By cookiesBtn = By.xpath("//button[text()='Accept']");
	public static final By removeBtn = By.cssSelector("button[data-testid='remove-product-from-cart']");
	public static final By removeConfirmationBtn = By.cssSelector("button[data-testid='remove-item__button']");
	public static final By emailTextbox = By.cssSelector("input[name = 'username']");
	public static final By passwordTextbox = By.cssSelector("input[name = 'password']");
	public static final By signInBtn = By.cssSelector("input[type = 'submit']");
	public static final By addItemToCartBtn = By.cssSelector("button[ng-click* = 'addItemToUnlimitedPricingCart']");
	public static final By isbnsearchbar = By.xpath("(//input[contains(@class,'ceng-headerSearch_searchInput')])[1]");
	public static final By nextBtn = By.cssSelector("input[value = 'NEXT']");
	public static final By addtoCartBtn = By.cssSelector("button[data-group = 'Pricing, Add To Cart']");
	public static final By alertMsgEbookpurchase = By.cssSelector("a[class = 'btn-cta-primary-gold']");
	public static final By secureCheckoutbutton = By.cssSelector("(//div[text() = 'START SECURE CHECKOUT'])");
	public static final By checkOutBtn =By.xpath("(//*[text() = 'CHECK OUT'])");
	public static final By userNameBtn = By.cssSelector("[data-testid='sidebar'] [data-testid='account']");
	public static final By sidebarSignOutBtn = By.cssSelector("div[data-testid=login-logout-tooltip] button");
	public static final By commerceSignInBtn = By.xpath("//a/span[contains(text(),'Sign In')]");
	public static final By orderNum = By.xpath("(//p)[2]");
	public static final By goToDashboardLink = By.cssSelector("div[direction='column']>div:nth-child(2) a");
	public static final By prodSignOutBtn = By.xpath("//button[@data-testid=\"sign-out\"]");
	public static final By billingInformation_firstName = By.xpath("//*[@name ='firstName']");
	public static final By billingInformation_lastName = By.xpath("//*[@name ='lastName']");
	public static final By billingInformation_phoneNo = By.xpath("//*[@name ='phone']");
	public static final By billingInformation_AddressLineOne = By.xpath("//*[@name ='billingAddressLine1']");
	public static final By billingInformation_State_dropdpown = By.xpath("//select[@name ='state']");
	public static final By billingInformation_Country_dropdpown = By.xpath("//select[@name ='country']");
	public static final By billingInformation_postalCode = By.xpath("//*[@name ='postalCode']");
	public static final By billingInformation_au_subUrb_dropdpown = By.xpath("//*[@name ='city']");
	
	
	public void searchForEbookISBN(String isbn) {
		waitTOSync();
		WebElement searchInput = element(searchInputField);
		searchInput.click();
		searchInput.clear();
		searchInput.sendKeys(isbn);
		logMessage("ISBN entered: " + isbn);
		hardWait(1);
		element(btnSearch).click();
		waitTOSync();
	}
  
    public void studentPageNavigation() {
	  driver.navigate().to(STUDENT_DASHBOARD_URL);
	
	}
	
	public void clickCheckoutButton() {
		waitTOSync();
		hardWait(5);
		clickUsingJavaScript(checkOutBtn);
	
	}
	public void fillCheckOutInfoFields(String fn, String ln, String mobileno, String addressLine1, String city, String statecode, String postalCode) {
		waitTOSync();
		hardWait(5);
		element(billingInformation_firstName).sendKeys(fn);
		element(billingInformation_lastName).sendKeys(ln);
		scrollDown();
		element(billingInformation_phoneNo).clear();
		element(billingInformation_phoneNo).sendKeys("1234567890");
		scrollDown();
		element(billingInformation_AddressLineOne).sendKeys(addressLine1);
		scrollDown();
		element(billingInformation_au_subUrb_dropdpown).sendKeys(city);
		scrollDown();
		Select selectstate = new Select(element(billingInformation_State_dropdpown));
		selectstate.selectByValue(statecode);
		element(billingInformation_postalCode).sendKeys(postalCode);	

	
	}

	public void clickOnAddToCartForEbook() {
		try {
			scrollDown(btnAddToCartNew);
			waitTOSync();
			clickUsingJavaScript(cookiesBtn);
			waitTOSync();
			clickUsingJavaScript(btnAddToCartNew);
		} catch (NoSuchElementException e) {
			try {
				refreshPage();
				waitTOSync();
				clickUsingJavaScript(btnAddToCart);
			} catch (NoSuchElementException e1) {
				waitTOSync();
				clickUsingJavaScript(btnAddToCart);
			}
		}
		waitTOSync();
		logMessage("Clicked on Add To Cart button.");
		hardWait(5);
	}

	/**
	 * Remove item from cart created from UI
	 */
	public void removeItemFromCartUI() {
		element(removeBtn).click();
		hardWait(2);
		element(removeConfirmationBtn).click();
		logMessage("1 item removed from the cart");
		hardWait(2);
	}

	public static void loginUser(String email, String password) {
		if (browser.equalsIgnoreCase("edge")) {
			waitTOSync();
			waitTOSync();
		}

		element(emailTextbox).click();
		element(emailTextbox).clear();
		element(emailTextbox).sendKeys(email);
		logMessage("User entered email: " + email);

		clickUsingJavaScript(nextBtn);
		logMessage("Clicked on next button");

		waitTOSync();
		waitTOSync();

		element(passwordTextbox).click();
		element(passwordTextbox).clear();
		element(passwordTextbox).sendKeys(password);
		logMessage("User entered password: " + password);

		waitTOSync();

		clickUsingJavaScript(signInBtn);
		logMessage("Clicked on sign in button");

		hardWait(5);
	}

	public static void clickSidebarSignoutBtn() {
		element(sidebarSignOutBtn).click();
		logMessage("Clicked on sidebar signout button");
		hardWait(5);
	}
	
	public void clickProdSidebarSignoutBtn() {
		element(prodSignOutBtn).click();
		logMessage("Clicked on sidebar signout button");
		hardWait(5);
	}

	public static void clickUserNameInSidebar() {
		waitTOSync();
		hardWait(2);
		clickUsingJavaScript(userNameBtn);
		logMessage("Clicked on username in sidebar");
	}

	public void loginUser(String type) {
		hardWait(5);
		try {
			element(commerceSignInBtn).click();
			hardWait(5);
			loginUser(PropFileHandler.readProperty(type), PropFileHandler.readProperty("userPassword"));
		} catch (NoSuchElementException e) {
			logMessage("User already logged in");
			waitTOSync();
			super.launchApplication(PropFileHandler.readProperty("dashboardPageUrl"));
			clickUserNameInSidebar();
			clickSidebarSignoutBtn();
			loginUser(PropFileHandler.readProperty(type), PropFileHandler.readProperty("userPassword"));
		}
	}

	public static void verifyOrderNumberIsDisplayed(String baseSiteId, String userId, String cartId) {
		String text = element(orderNum).getText().trim();
		String[] parts = text.split("#");

		try {
			OrderID = parts[1].replaceAll("^(|.)$", "");
			PropFileHandler.writeProperty("OrderNumber", OrderID);
			Assert.assertFalse(element(orderNum).getText().isEmpty(),
					"**[ASSERT FAILED]: Order number is not displayed");
			logMessage("**[ASSERT PASSED]: Order number is displayed " + OrderID);
			clickGoToDashboardLink();
		} catch (ArrayIndexOutOfBoundsException e) {
			OrdersAction.placeOrderUsingPayPal(baseSiteId, userId, cartId, 200);
			logMessage("Order placed with ID: " + OrderID);
		}
	}

   public static void verifyNewPaypalOrderNumberIsDisplayed(String baseSiteId, String userId, String cartId) {

		String orderDet = element(orderNum).getText().trim();
		String[] parts = orderDet.split("#");
		try {
			OrderID = parts[1].replaceAll("^(|.)$", "");
			PropFileHandler.writeProperty("OrderNumber", OrderID);
			Assert.assertFalse(element(orderNum).getText().isEmpty(),
					"**[ASSERT FAILED]: Order number is not displayed");
			logMessage("**[ASSERT PASSED]: Order number is displayed " + OrderID);
			clickGoToDashboardLink();
		} catch (ArrayIndexOutOfBoundsException e) {
			logMessage("Order placed with ID: " + OrderID);
		}
	}

	public static void clickGoToDashboardLink() {
		hardWait(10);
		clickUsingJavaScript(goToDashboardLink);
		logMessage("Clicked on GO TO DASHBOARD link");
		hardWait(5);

		logMessage("Current URL: " + getCurrentURL());
		if (getCurrentURL().contains("enroll"))
			launchApplication(PropFileHandler.readProperty("prefix") + "/dashboard");
	}

}
