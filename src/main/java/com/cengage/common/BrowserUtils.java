package com.cengage.common;


import java.time.Duration;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Wait;


import io.github.bonigarcia.wdm.WebDriverManager;


public class BrowserUtils {
	
	static WebDriver driver;

	@SuppressWarnings("deprecation")
	public static void launchBrowser(String browserType) {
	
		if (browserType.equalsIgnoreCase("chrome")) {
			WebDriverManager.chromedriver().setup();
			driver = new ChromeDriver();
		}

		else if (browserType.equalsIgnoreCase("edge")) {

			WebDriverManager.edgedriver().setup();
			driver = new EdgeDriver();
		}
		
		

	driver.manage().window().maximize();
	driver.manage().deleteAllCookies();
	}
	
	public static void exitBrowser()
	{
		driver.quit();
	}

	public static void waitForSec(int waitSec) {
		long waitTime=waitSec*(long)1000;
		try {
			Thread.sleep(waitTime);
		} catch (InterruptedException ie) {
			  Thread.currentThread().interrupt();
		} catch (Exception e) {
			logMessage(e.getMessage());
		}
		
	}

	protected static void logMessage(String message) {
		System.out.println(message);
		
	}
	
	public static void launchApplication(String url) {
		driver.get(url);
		logMessage("**[INFO]: Product URL :: " + url);
		hardWait(5);
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
	public static void waitTOSync() 
	{
		try {
			Thread.sleep(2000);
		} catch (InterruptedException ie) {
		  Thread.currentThread().interrupt();
		} catch (Exception e) {
			logMessage(e.getMessage());
		}
	}
	
	
	protected static WebElement element(By elementToken) 
	{
		return driver.findElement(getLocator(elementToken, ""));
    }
	public static void hardWait(int i) {
	try {
		Thread.sleep(i*1000);
	} catch (InterruptedException e) {
		
		e.printStackTrace();
	}
		
	}
	
	protected static void scrollDown(By elem) {
		WebElement element=element(elem);
		((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", element);
	}
	
	protected static void scrollDown(WebElement e) {
		((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", e);
	}

	protected void scrollDown() {
		((JavascriptExecutor) driver).executeScript("window.scrollBy(0,10000)");
	}
	
	protected void scrollToTopOfPage() {
		((JavascriptExecutor) driver).executeScript("window.scrollBy(0,0)");
	}
	
	protected static WebElement waitForElementToBeVisible(By locator) {
	    Wait<WebDriver> wait = new FluentWait<>(driver)
	            .withTimeout(Duration.ofSeconds(20))
	            .pollingEvery(Duration.ofSeconds(3))
	            .ignoring(NoSuchElementException.class)
	            .ignoring(TimeoutException.class);

	    return wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
	}
	
	
	protected static WebElement element(By elementToken, String replacement) 
	{
        return driver.findElement(getLocator(elementToken, replacement));
    }
	
	
	public static void switchToiFrame(WebElement elementToken)
	{
		driver.switchTo().frame(elementToken);
		logMessage("Switched to iFrame");
	}
	
	
	public static void switchToDefaultContent()
	{
		driver.switchTo().defaultContent();
		logMessage("Switched to default content");
	}
	
	public static String getCurrentURL()
	{
		return driver.getCurrentUrl();
	}
	
	
	protected static boolean element_visibility(By elem) {
		boolean flag = false;
		WebElement elementToken;

		try {
			elementToken = element(elem);
			Wait<WebDriver> wait1 = new FluentWait<WebDriver>(driver).withTimeout(Duration.ofSeconds(5))
					.pollingEvery(Duration.ofSeconds(1));
			wait1.until(ExpectedConditions.visibilityOf((WebElement) elementToken));
			if (((WebElement) elementToken).getSize() != null)
				flag = true;
		} catch (TimeoutException excp) {
		} catch (NoSuchElementException n) {
		} catch (WebDriverException w) {
		}
		return flag;
	}
	
	protected static WebElement waitForElementToBeClickable(By elem)
	{
		WebElement e=element(elem);
		Wait<WebDriver> wait1 = new FluentWait<WebDriver>(driver)
				   .withTimeout(Duration.ofSeconds(50))
				   .pollingEvery(Duration.ofSeconds(2))
				   .ignoring(NoSuchElementException.class);
		wait1.until(ExpectedConditions.elementToBeClickable(e));
		return e;
	}
	

}
