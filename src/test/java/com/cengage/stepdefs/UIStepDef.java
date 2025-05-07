package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.UIPageActions;
import com.cengage.utils.PropFileHandler;
import com.cengage.utils.ScreenshotGenerator;

import cucumber.api.Scenario;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.openqa.selenium.NoSuchElementException;

import java.util.Map;

/**
 * @author shiv.mangal
 *
 */
@SuppressWarnings("deprecation")
public class UIStepDef extends BaseClass {
	public UIStepDef() {
		super();
	}

	UIPageActions uiPage = new UIPageActions();
	public static final String BASE_SITE_ID = PropFileHandler.readProperty("baseSiteId");
	
	@Before()
	public void before(cucumber.api.Scenario scenario) {
		ScreenshotGenerator.before(scenario);
	}

	@After
	public void after(cucumber.api.Scenario scenario) {
		ScreenshotGenerator.after(scenario);
	}

	@Given("I open cengage commerce page")
	public void launchCUCommercePage() {
		launchApplication(PropFileHandler.readProperty("Old_Dashboard"));
	}
	
	@Given("I open cengage B2CAU home page")
	public void B2CAUPage() {
		launchApplication(PropFileHandler.readProperty("AU_Dashboard"));
	}
	
	@When("I refresh page")
	public void refreshThePage() {
		refreshPage();
	}

	@When("I click on browser back button")
	public void clickBrowserBack() {
		clickBrowserBackBtn();
	}
	
	@And("Add product to cart")
	public void addProductToCartFromUI() {

		uiPage.studentPageNavigation();
		uiPage.searchForEbookISBN(PropFileHandler.readProperty("eBook80"));
		uiPage.clickOnAddToCartForEbook();
		uiPage.removeItemFromCartUI();
	}
	
	@And("Add the specific product to cart and click checkout")
	public void addTheProductToCartFromUI(Map<String,String> uiData) {
		uiPage.searchForEbookISBN(uiData.get("ISBN"));
		uiPage.clickOnAddToCartForEbook();
		uiPage.clickCheckoutButton();
	}
	
	@And("Fill the billing information in checkout section")
	public void fillCheckOutInformation(Map<String,String> uiData) {
		
      int phone = 1234567890;
      uiPage.fillCheckOutInfoFields(uiData.get("firstName"), uiData.get("lastName"),String.valueOf(phone), uiData.get("addressLine1"),  uiData.get("city"), uiData.get("statecode"), uiData.get("postalcode"));
	}
	
	@When("I click on sidebar sign out button")
	public void clickSidebarSignoutBtn() {
		String env = getEnvironment();
		try {
			if (env.equalsIgnoreCase("Prod")) {
				logMessage("Enviroment Found: " + tier);
				launchApplication(PropFileHandler.readProperty("dashboardPageUrl"));
				UIPageActions.clickUserNameInSidebar();
				uiPage.clickProdSidebarSignoutBtn();
				
			} else {
				UIPageActions.clickSidebarSignoutBtn();
				hardWait(5);
			}
		} catch (NoSuchElementException e) {
			launchApplication(PropFileHandler.readProperty("dashboardPageUrl"));
			UIPageActions.clickSidebarSignoutBtn();
			hardWait(5);
		}
	}

	@Then("I verify order number is displayed")
	public void verifyOrderNumberIsDisplayed() {
		hardWait(20);
		UIPageActions.verifyOrderNumberIsDisplayed(BASE_SITE_ID, userGUID, cartId);
		hardWait(5);
	}
	
    @Then("I will check order number is displayed after completion of paypal order")
	public void verifyOrderNumberIsDisplayedNewPaypal() {
		hardWait(20);
		UIPageActions.verifyNewPaypalOrderNumberIsDisplayed(BASE_SITE_ID, userGUID, cartId);
		hardWait(5);
	}

	@When("I click on Go To Dashboard link")
	public void clickGoToDashboardLink() {
		UIPageActions.clickGoToDashboardLink();
	}

	@Given("I launch (.*) page and login with (.*) user")
	public void launchB2CCommercePage(String baseStore, String user) {
		BaseClass.launchApplication(PropFileHandler.readProperty(baseStore + "_Dashboard"));
		uiPage.loginUser(user);

	}

}
