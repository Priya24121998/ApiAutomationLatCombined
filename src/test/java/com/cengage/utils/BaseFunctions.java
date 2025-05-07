package com.cengage.utils;

import io.restassured.RestAssured;
import io.restassured.path.json.JsonPath;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.*;
import org.testng.Assert;
import org.testng.Reporter;

import java.io.IOException;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.concurrent.TimeUnit;

public class BaseFunctions
{
	
	static WebDriver driver;
	protected WebDriverWait wait;
	static String parentWindow;
	public static String tier, userID, userGUID, OrderID, subID, cartId, authenticatedCartGuid, subscriptionId, 
					rentalID, penSub,authorizationValue, payPalToken, anonymousCartGuid, anonymousCartId;
	public static String scenarioName, scenarioStatus, scenarioComment;
	public static HashMap<String,String> faulty = new HashMap<>();
	public static String password =null;
	public static HashMap<String,String> userCreation = new HashMap<>();
	public static List<String> faultyAttributes = new ArrayList<>();
	public static String response;
	public static int hashmapcountPlaceOrder = 0;

	public static String couponCodeGet;
	
	public static String[] rentalStatus = new String [16];
	public static String[] rentalId = new String [16];
	static JSONParser parser= new JSONParser();
	static JSONObject obj = null;

	
	protected BaseFunctions(WebDriver webdriver)
	{
		this.driver=webdriver;
		tier=System.getProperty("tier");
		if(tier==null || tier.isEmpty())
			tier=PropFileHandler.readConfigProperty("tier");
	}
	
	
	public static void logMessage(String msg)
	{
		Reporter.log(msg, true);
	}
	
	
	protected WebElement waitForElementToBeVisible(By e) 
	{
		WebElement element=element(e);
		Wait<WebDriver> wait1 = new FluentWait<WebDriver>(driver)
				   .withTimeout(Duration.ofSeconds(20))
				   .pollingEvery(Duration.ofSeconds(3))
				   .ignoring(NoSuchElementException.class)
				   .ignoring(TimeoutException.class);
        return (WebElement) wait1.until(ExpectedConditions.visibilityOf(element));
    }
	
	
	
	protected void waitForUrlToContain(String str) 
	{
		Wait<WebDriver> wait1 = new FluentWait<WebDriver>(driver)
				   .withTimeout(Duration.ofSeconds(20))
				   .pollingEvery(Duration.ofSeconds(3))
				   .ignoring(NoSuchElementException.class);
        wait1.until(ExpectedConditions.urlContains(str));
    }
	
	protected static void waitTOSync() 
	{
		try {
			Thread.sleep(2000);
		} catch (InterruptedException ie) {
		  Thread.currentThread().interrupt();
		} catch (Exception e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		}
	}
	
	
	protected static void hardWait(int sec)
	{
		long waitTime=sec*(long)1000;
		try {
			Thread.sleep(waitTime);
		} catch (InterruptedException ie) {
			  Thread.currentThread().interrupt();
		} catch (Exception e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		}
	}
	
	
	protected void selectDropdownOptionText(By elem, String text)
	{
		WebElement e=element(elem);
		Select sel=new Select(e);
		sel.selectByVisibleText(text);
	}
	
	
	protected WebElement element(WebElement e)
	{
		return e;
	}
	
	
	protected static String getCurrentTimestamp()
	{
		Format formatter = new SimpleDateFormat("ddMMyyHHmmss");
		String timestamp = formatter.format(new Date());
		return timestamp;
	}
	
	
	protected String getRandomString(int length)
	{
		SecureRandom r = new SecureRandom();
		String abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		char c;
		String str=null;

		for(int i=0;i<=length;i++)
		{
			c = abc.charAt(r.nextInt(abc.length()));
			if(str==null)
				str=String.valueOf(c);
			else
				str=str+c;
		}
		return str;
	}
	
	
	protected static String getCurrentDate()
	{
		Format formatter = new SimpleDateFormat("yyyy-MM-dd");
		String timestamp = formatter.format(new Date());
		return timestamp;
	}
	
	
	protected static void clickUsingJavaScript(By elem)
	{
		WebElement e=element(elem);
		((JavascriptExecutor)driver).executeScript("arguments[0].click();", e);
	}
	
	
	protected void clickUsingJavaScript(WebElement e)
	{
		((JavascriptExecutor)driver).executeScript("arguments[0].click();", e);
	}
	
	
	protected void executeJavascript(String script)
	{
		JavascriptExecutor js = (JavascriptExecutor) driver;  
		js.executeScript(script);
	}
	
	
	protected Object executeJavascriptWithReturn(String script) 
	{
		return ((JavascriptExecutor) driver).executeScript(script);
	}
	
	protected Object executeJavascriptWithReturn(String script,WebElement e) 
	{
		return ((JavascriptExecutor) driver).executeScript(script,e);
	}
	
	
	protected static String getCurrentURL()
	{
		return driver.getCurrentUrl();
	}
	
	
	protected boolean element_visibility(By elem)
	{
		boolean flag=false;
		WebElement elementToken;
		
		try {
			elementToken=element(elem);
		Wait<WebDriver> wait1 = new FluentWait<WebDriver>(driver)
				   .withTimeout(Duration.ofSeconds(5))
				   .pollingEvery(Duration.ofSeconds(1));
		wait1.until(ExpectedConditions.visibilityOf((WebElement) elementToken));
			if(((WebElement) elementToken).getSize()!=null)
				flag = true;
        } catch (TimeoutException excp) {
        }
		catch(NoSuchElementException n) {
		}
		catch(WebDriverException w) {
		}
		return flag;
	}
	
	protected boolean element_visibility(By elem, int timeout)
	{
		boolean flag=false;
		WebElement elementToken;
		
		try {
			elementToken=element(elem);
		Wait<WebDriver> wait1 = new FluentWait<WebDriver>(driver)
				   .withTimeout(Duration.ofSeconds(timeout))
				   .pollingEvery(Duration.ofSeconds(1));
		wait1.until(ExpectedConditions.visibilityOf((WebElement) elementToken));
			if(((WebElement) elementToken).getSize()!=null)
				flag = true;
        } catch (TimeoutException excp) {
        }
		catch(NoSuchElementException n) {
		}
		catch(WebDriverException w) {
		}
		return flag;
	}
	
	protected void waitForElementToDisappear(By element)
	{
		WebElement e=element(element);
		Wait<WebDriver> wait1 = new FluentWait<WebDriver>(driver)
				   .withTimeout(Duration.ofSeconds(20))
				   .pollingEvery(Duration.ofSeconds(2))
				   .ignoring(NoSuchElementException.class);
		wait1.until(ExpectedConditions.invisibilityOf(e));
	}
	
	
	protected WebElement waitForElementToBeClickable(By elem)
	{
		WebElement e=element(elem);
		Wait<WebDriver> wait1 = new FluentWait<WebDriver>(driver)
				   .withTimeout(Duration.ofSeconds(50))
				   .pollingEvery(Duration.ofSeconds(2))
				   .ignoring(NoSuchElementException.class);
		wait1.until(ExpectedConditions.elementToBeClickable(e));
		return e;
	}
	
	
	protected void clickUsingActions(WebElement e)
	{
		Actions action=new Actions(driver);
		action.moveToElement(e).click().build().perform();
	}
	
	protected void MousehoverUsingActions(By element)
	{
		WebElement e=element(element);
		Actions action=new Actions(driver);
		action.moveToElement(e).perform();
	}
	
	protected List<WebElement> elements(By elementToken) 
	{
        return driver.findElements(getLocator(elementToken, ""));
    }
	
	protected static WebElement element(By elementToken) 
	{
		return driver.findElement(getLocator(elementToken, ""));
    }
	
	protected WebElement element(By elementToken, String replacement) 
	{
        return driver.findElement(getLocator(elementToken, replacement));
    }
	
	
	protected static By getLocator(By elementToken, String replacement) 
	{
        if (!replacement.isEmpty()) {
            String loc = elementToken.toString().replaceAll("\'", "\\\"");
            String type = loc.split(":", 2)[0].split(",")[0].split("\\.")[1];
            String variable = loc.split(":", 2)[1].replaceAll("\\$\\{.+?\\}", replacement);
            return getBy(type, variable);
        } 
        else {
            return elementToken;
        }
    }

	
	private static By getBy(String locatorType, String locatorValue) 
	{
        switch (Locators.valueOf(locatorType)) 
        {
            case id:
                return By.id(locatorValue);
            case xpath:
                return By.xpath(locatorValue);
            case css:
            case cssSelector:
                return By.cssSelector(locatorValue);
            case name:
                return By.name(locatorValue);
            case classname:
                return By.className(locatorValue);
            case linktext:
                return By.linkText(locatorValue);
            default:
                return By.id(locatorValue);
        }
    }
	
	
	protected void pressEnterKeyOnElement(By elem)
	{
		WebElement e=element(elem);
		Actions ac=new Actions(driver);
		Point point=e.getLocation();
		Dimension s=e.getSize();
		int x=point.getX();
		int y=point.getY();
		int Y	=	s.getHeight();
		int X	=	s.getWidth();
		int XX	=	x/2+x;
		int YY	=	y+Y/2;
		System.out.println("-----------------------"+XX);
		System.out.println("========================"+YY);
		ac.moveByOffset(x+X/2, y+Y/2).click().build().perform();
		ac.sendKeys(Keys.ARROW_DOWN);
		ac.sendKeys(Keys.RETURN);
		
//		ac.moveToElement(e).sendKeys(Keys.ENTER).build().perform();
	}
	
	
	protected void clickElementUsingCoordinates(WebElement e)
	{
		Actions ac=new Actions(driver);
		Point point=e.getLocation();
		int x=point.getX();
		int y=point.getY();
		ac.moveByOffset(x, y).sendKeys(Keys.ENTER).build().perform();
	}
	
	
//	protected WebElement element(WebElement e, String replacement)
//	{
//		String str=e.toString();
//		System.out.println("e.tostring: "+str);
//		String parts[]=str.split("->");
//		System.out.println("***parts[1]: "+parts[1]);
//		String parts1[]=parts[1].split(":");
//		String type=parts1[0].trim();
//		String temp=parts1[1].trim();
//		String locValue= temp.replace(temp.charAt(temp.length()-1), ' ');
//		locValue=locValue.trim()+']';
//		locValue=locValue.replace("${option}", replacement);
//		By locator=getBy(type, locValue);
//		WebElement ele=driver.findElement(locator);
//		return ele;
//	}
	
	
//	private By getBy(String locatorType, String locatorValue) 
//	{
//		switch (locatorType)
//		{
//			case "xpath":
//				return By.xpath(locatorValue);
//			case "css selector":
//			case "cssSelector":
//				return By.cssSelector(locatorValue);
//			case "id":
//				return By.id(locatorValue);
//			case "tag name":
//				return By.tagName(locatorValue);
//			case "name":
//				return By.name(locatorValue);
//			case "link text":
//				return By.linkText(locatorValue);
//			case "class name":
//				return By.className(locatorValue);
//			default:
//				return By.id(locatorValue);
//		}
//	}
	
	public String executeScript(String value) {
		return (String)((JavascriptExecutor) driver).executeScript(value);
	}
	
	
	public void cssJavaScriptUsingAction(String csslocation, String Action, String setValue) {
		waitTOSync();

		String js = "document.querySelector(\"" + csslocation + "\")" + Action + "= '" + setValue + "';";
		System.out.println(js);
		((JavascriptExecutor) driver).executeScript(js);
	}
	
	
	public static void deleteCookies()
	{
		driver.manage().deleteAllCookies();
		logMessage("All cookies have been deleted");
	}
	
	
	public void clickBrowserBackBtn()
	{
		waitTOSync();
		driver.navigate().back();
		logMessage("Clicked on browser back button");
	}
	
	
	public void switchToNewTab() {
		hardWait(5);
		parentWindow = driver.getWindowHandle();
		Set<String> handles = driver.getWindowHandles();

		for(String winHandle : handles) {
			if (!parentWindow.equalsIgnoreCase(winHandle)) {
				driver.switchTo().window(winHandle);
				break;
			}
		}
		waitTOSync();
		waitTOSync();
		logMessage("[INFO]: Switched to new window having URL: " + getCurrentURL());
	}
	
	
	public void switchToNewtabSafari()
	{
		ArrayList<String> tabs = new ArrayList<String> (driver.getWindowHandles());
		driver.switchTo().window(tabs.get(0));
		waitTOSync();
		logMessage("[INFO]: Switched to new window having URL: " + getCurrentURL());
	}
	
	
	public void closeCurrentWindow()
	{
		driver.close();
		logMessage("Closed current window");
		driver.switchTo().window(parentWindow);
		logMessage("Switched back to original window");
	}
	
	protected void scrollDown(By elem) {
		WebElement element=element(elem);
		((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", element);
	}
	
	protected void scrollDown(WebElement e) {
		((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", e);
	}

	protected void scrollDown() {
		((JavascriptExecutor) driver).executeScript("window.scrollBy(0,10000)");
	}
	
	protected void scrollToTopOfPage() {
		((JavascriptExecutor) driver).executeScript("window.scrollBy(0,0)");
	}
	
	public void closeCengageSurveyPopup(){
		hardWait(2);
		try{
			if(driver.findElement(By.cssSelector(".QSIPopOver>div:nth-child(1)")).isDisplayed())
			{
				executeScript("document.querySelector(\".QSIPopOver img[src*='close']\").click()");
				logMessage("Handled Cengage survey popup");
			}
				hardWait(2);
		}
		catch(Exception e){
			System.out.println("Cengage survey popup not displayed.");
		}
	}
	
	public static boolean compareDate(Date date1,Date date2,String operator){
		boolean result = false;
		if(operator.equals("="))
			result = date1.equals(date2);
		else if(operator.equals("<"))
			result =  date1.before(date2);
        else if(operator.equals(">"))
          result =  date1.after(date2);
        else if(operator.equals(">="))
          result =  date1.after(date2)||date1.equals(date2);
        else if(operator.equals("<="))
          result =  date1.before(date2)||date1.equals(date2);
		
		return result;
	}
	
	public static long betweenDates(Date firstDate, Date secondDate) throws IOException
	{
	    return ChronoUnit.DAYS.between(firstDate.toInstant(), secondDate.toInstant());
	}
	
	
	public void refreshPage()
	{
		driver.navigate().refresh();
		logMessage("Page is refreshed");
	}

	
	protected void hoverOnElement(WebElement e)
	{
		Actions ac=new Actions(driver);
		ac.moveToElement(e).build().perform();
	}
		
	public void clickXpathUsingJS(String locator) 
	{
		String js = "var xPathRes = document.evaluate(\"" + locator
				+ "\",document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null );"
				+ "xPathRes.singleNodeValue.click();";
		((JavascriptExecutor) driver).executeScript(js);
	}
	
	
	public static String getSelectorAsString(By by) 
	{
        String str = by.toString();
        return str.substring(str.indexOf(" ") , str.length());
      }
	
//	public void closefirstWindow()
//	{	
//		driver.switchTo().window(parentWindow);
//		logMessage("Switched back to original window");
//		driver.close();
//		logMessage("Closed current window");
//		driver.switchTo().window(parentWindow);
//		logMessage("Switched back to original window");
//	}
	
	public static int getStatusCode(String status_code) {
		int statusCode = 200;
		try {
			statusCode = Integer.parseInt(status_code);
		}catch (NumberFormatException e) {
			   System.out.println(e);
		}
		return statusCode;
	}
	
	public static JSONArray extractJsonArrayFromResponse(String response, String parameter)  
	{
		try {
			obj = (JSONObject) parser.parse(response);
		} catch (ParseException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		}
		return (JSONArray) obj.get(parameter);
	}
	
	
	public void switchToiFrame(WebElement elementToken)
	{
		driver.switchTo().frame(elementToken);
		logMessage("Switched to iFrame");
	}
	
	
	public void switchToDefaultContent()
	{
		driver.switchTo().defaultContent();
		logMessage("Switched to default content");
	}
	
	public static void verifyIfResponseValueIsNotEmpty(String value)
	{
		Assert.assertTrue(value!=null, "**[ASSERT FAILED]: Response value is blank");
		logMessage("**[ASSERT PASSED]: Response value is not blank");
	}
	
	public static String extractValuefromResponse(String response, String parameter)  
	{
		try {
			obj = (JSONObject) parser.parse(response);
		} catch (ParseException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		}
		String value = (String) obj.get(parameter);		
		return value;
	}

	public static String extractValueFromJOSNPath(String JSONPath, String jSonReponse) {
		JsonPath path = JsonPath.from(jSonReponse);
		String value;
		try {
			value = path.getString(JSONPath);
		} catch (ClassCastException e) {
			value =  Float.toString(path.get(JSONPath));

		}
		return value;
	}
	
	public static String extractDateFromWholeString(String response)
	{
		String parts[]=response.split("T");
		return parts[0];
	}
	
	public static int extractIntegerValuefromResponse(String response, String parameter)  
	{
		JSONParser parser = new JSONParser();
		try {
			obj = (JSONObject) parser.parse(response);
		} catch (ParseException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		}
		try {
			int value=(int) obj.get(parameter);
			logMessage(parameter+": "+value);
			return value;
		}catch(ClassCastException exp) {
			double value=(double) obj.get(parameter);
			logMessage(parameter+": "+value);
			return (int) value;
		}
	}
	
	public int extractIntegerValueFromJOSNPath(String JSONPath, String jSonReponse) 
	{
		JsonPath path = JsonPath.from(jSonReponse);
		int value;
		
		value = path.getInt(JSONPath);
		logMessage("extractIntegerValueFromJOSNPath value:" + value);
			
		return value;
	}
	
	public boolean extractBooleanValuefromResponse(String response, String parameter)  
	{
		try {
			obj = (JSONObject) parser.parse(response);
		} catch (ParseException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		}
		Boolean value = (Boolean) obj.get(parameter);
		return value;
	}
	
	public static String setAuthorizationHeader()  
	{
		RestAssured.useRelaxedHTTPSValidation();
		String endpoint = PropFileHandler.readProperty("authorization");
		String clientID = PropFileHandler.readProperty("clientId");
		String secretID = PropFileHandler.readProperty("secretId");

		String response = RestAssured.given()
				.auth().preemptive()
				.basic(clientID, secretID)
				.header("Content-Type", "application/x-www-form-urlencoded")
				.formParam("grant_type", "client_credentials").when().post(endpoint).then()
				.assertThat().statusCode(200)
				.extract().asString();

		JsonPath responseObj = JsonPath.from(response);

		String accessToken = responseObj.get("access_token");
		String tokenType = responseObj.get("token_type");
		tokenType = tokenType.substring(0, 1).toUpperCase() + tokenType.substring(1).toLowerCase();
		String authorizationValue = tokenType + " " + accessToken;

		return authorizationValue;
	}
	
	public static void compareResponseValue(String actual, String expected)
	{
		Assert.assertEquals(actual.toLowerCase(), expected.toLowerCase(), "**[ASSERT FAILED]: Actual response value does not match expected value");
		logMessage("**[ASSERT PASSED]: Actual response value: [" + actual + "], matches with exepcted ["+ expected + "] value");
	}
	
	public void containsResponseValue(String actual, String expected)
	{
		Assert.assertTrue(actual.toLowerCase().contains(expected.toLowerCase()), "**[ASSERT FAILED]: Actual response value does not match expected value");
		logMessage("**[ASSERT PASSED]: Actual response value: [" + actual + "], matches with exepcted ["+ expected + "] value");
	}
	
	public void compareNotEqualValues(String actual, String expected)
	{
		Assert.assertNotEquals(actual.toLowerCase(), expected.toLowerCase(), "**[ASSERT FAILED]: Actual response matches with expected value");
		logMessage("**[ASSERT PASSED]: Actual response  value: [" + actual + "],does not matches with exepcted ["+ expected + "] value");
	}
	
	@SuppressWarnings("unused")
	public void verifyEndDateIsNumOfDaysAfterStartDate(String start, String end, int days)
	{
		String startDate, endDate;
		String parts[]=start.split("T");
		startDate=parts[0];
		parts=end.split("T");
		endDate=parts[0];
		
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date d=null;
		try {
			d = dateFormat.parse(startDate);
		}catch(java.text.ParseException p) {
		}
        Calendar c = Calendar.getInstance();
        c.setTime(d);
        c.add(Calendar.DATE, days);
        Date currentDatePlusOne = c.getTime();
        String newEndDate=dateFormat.format(currentDatePlusOne).toString();
	}
	
	
	public static String addNumOfDaysToDate(String start, int days)
	{
		String startDate;
		String parts[]=start.split("T");
		startDate=parts[0];
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date d=null;
		try {
			d = dateFormat.parse(startDate);
		}catch(java.text.ParseException p) {
		}
        Calendar c = Calendar.getInstance();
        c.setTime(d);
        c.add(Calendar.DATE, days);
        Date currentDatePlusOne = c.getTime();
        String newEndDate=dateFormat.format(currentDatePlusOne).toString();
        logMessage("New date calculated is: "+newEndDate);
        return newEndDate;
	}
	
	protected String addNumberOfYearsToDate(String actualDate, int addNoOfYear)  {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ", Locale.getDefault());
		Date currentDate;
		String date = null;
		try {
			currentDate = sdf.parse(actualDate);
//			System.out.println(currentDate);      
			Calendar cal = Calendar.getInstance();
			cal.setTime(currentDate);
			cal.add(Calendar.YEAR, addNoOfYear);
			//cal.add(Calendar.DATE, -1);
			Date modifiedDate = cal.getTime();
//			System.out.println(modifiedDate);
			Format formatter = new SimpleDateFormat("yyyy-MM-dd");
			 date = formatter.format(modifiedDate);
//			System.out.println(date);
		} catch (java.text.ParseException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		}
		
		return date;
		
	}
	
	protected String addNumberOfYearsToDateWithoutTimeStamp(String actualDateWithTimeStamp) throws java.text.ParseException  {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = sdf.parse(actualDateWithTimeStamp);
		String expecdate = sdf.format(date);
		return expecdate;
	
	}
	
	
	public static String getemail(String email, String store) {
		String newEmail;
		if (email.contains("@")) {
			String emailArr[] = email.split("@");
			newEmail = emailArr[0] + "_" + getCurrentTimestamp() + "@" + emailArr[1];
		} else {
			newEmail = store + "_" + tier + "_" + email + "_" + getCurrentTimestamp() + "@mailinator.com";
		}
		return newEmail;
	}
	
	public static String getName(String name) {
		return PropFileHandler.readPayloads(name);
	}


	public boolean notZero(double value) {
		if (value > 0)
			return true;
		else
			return false;

	}
	
	public boolean checkIfValueGreaterThan(double actual, double expected) {
		return actual > expected ? true : false;
	}

	public String getEnvironment() {
		tier=System.getProperty("tier");
		if(tier==null || tier.isEmpty())
			tier=PropFileHandler.readConfigProperty("tier");
		return tier;
	}
	
	
}