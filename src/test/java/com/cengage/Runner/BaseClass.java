package com.cengage.Runner;

import com.cengage.utils.BaseFunctions;
import com.cengage.utils.PropFileHandler;
import com.cengage.utils.ScreenshotGenerator;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.firefox.FirefoxBinary;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.ie.InternetExplorerOptions;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.safari.SafariDriver;
import org.openqa.selenium.safari.SafariOptions;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;
import java.util.concurrent.TimeUnit;

public class BaseClass extends BaseFunctions {
	public static WebDriver driver;
	public static String browser;
	public static String server;
	public static String sheetName;

	public static String noOfUsers;
	ScreenshotGenerator screenShot;
	PropFileHandler prop;
	public static int minstock;
    public static String STUDENT_DASHBOARD_URL="https://qa-www.cengage.com/student/";
	private static DesiredCapabilities cap = new DesiredCapabilities();
	private static ChromeOptions options = null;
	private static EdgeOptions edgeoptions = null;
	private static FirefoxOptions firefoxoptions = null;
	private static SafariOptions safarioptions = null;
	private static InternetExplorerOptions ieoptions = null;
	public static String accountShipTo;
	public static String accountBillTo;
	public static String account;
	public static HashMap<String,String> userCreationDetMap = new HashMap<>();
	public static HashMap<String,String> placeOrderDetMap = new HashMap<>();
	public static List<Map<String, String>> excelRows = new ArrayList<Map<String, String>>();
	public static LinkedHashMap<String, String> columnMapdata = new LinkedHashMap<String, String>();
	public static String storeType;
	public static String deliveryMode;
	public BaseClass() {
		super(driver);
	}

	public void initializeBrowser() {
		logMessage("*************************************** Session Started ***************************************");
		prop = new PropFileHandler();
		browser = System.getProperty("browser");
		server = System.getProperty("server");

		if (server == null || server.isEmpty())
			server = PropFileHandler.readConfigProperty("seleniumserver");

		if (browser == null || browser.isEmpty())
			browser = PropFileHandler.readConfigProperty("browser");

		if (sheetName == null || sheetName.isEmpty())
			sheetName = PropFileHandler.readConfigProperty("sheet");

		logMessage("Server: " + server.toUpperCase());
		logMessage("Browser: " + browser.toUpperCase());

		if (server.equalsIgnoreCase("local")) {
			if (browser.equalsIgnoreCase("chrome")) {
				WebDriverManager.chromedriver().setup();
				driver = new ChromeDriver();
			}

			else if (browser.equalsIgnoreCase("firefox")) {

				WebDriverManager.firefoxdriver().setup();
				driver = setFirefoxDriver();
			}

			else if (browser.equalsIgnoreCase("safari")) {
				driver = new SafariDriver();
			}

			else if (browser.equalsIgnoreCase("IE") || browser.equalsIgnoreCase("Internet Explorer")) {
				WebDriverManager.iedriver().setup();
				driver = new InternetExplorerDriver();
				cap.setCapability(InternetExplorerDriver.INTRODUCE_FLAKINESS_BY_IGNORING_SECURITY_DOMAINS, true);
				cap.setCapability("ignoreZoomSetting", true);
			} else if (browser.equalsIgnoreCase("edge")) {
				WebDriverManager.edgedriver().setup();
				driver = new EdgeDriver();
				cap.setCapability("browserstack.edge.enablePopups", false);
			}
		}

		else if (server.contains("remote")) {
			driver = setRemoteDriver();
		}

		else if (server.contains("lambdatest")) {

			driver = setLambdaTestCapabilities();
		}

		driver.manage().window().maximize();
		driver.manage().deleteAllCookies();
		driver.manage().timeouts().implicitlyWait(
				Integer.parseInt(PropFileHandler.readConfigProperty("implicitTimeOut")), TimeUnit.SECONDS);
		driver.manage().timeouts().pageLoadTimeout(
				Integer.parseInt(PropFileHandler.readConfigProperty("pageLoadTimeOut")), TimeUnit.SECONDS);
		screenShot = new ScreenshotGenerator(driver);
	}

	private WebDriver setLambdaTestCapabilities() {

		
		String username_lt = PropFileHandler.readConfigProperty("username_lt");
		String accesskey_lt = PropFileHandler.readConfigProperty("accesskey_lt");
		String gridURL_LambdaTest = PropFileHandler.readConfigProperty("gridURL_LambdaTest");

		String os_lt = System.getProperty("os");
		if (os_lt == null || os_lt.isEmpty()) {
			os_lt = PropFileHandler.readConfigProperty("os_lt");
			if (os_lt.equalsIgnoreCase("Mac"))
				os_lt = "OS X";
		}
		logMessage("OS: " + os_lt.toUpperCase());

		String os_version_lt = System.getProperty("osVersion");
		if (os_version_lt == null || os_version_lt.isEmpty()) {
			if (os_lt.equalsIgnoreCase("Windows"))
				os_version_lt = PropFileHandler.readConfigProperty("windowsOsVersion_lt");
			if (os_lt.equalsIgnoreCase("Mac") || os_lt.equals("OS X"))
				os_version_lt = PropFileHandler.readConfigProperty("macOsVersion_lt");
		}
		logMessage("OS Version: " + os_version_lt.toUpperCase());

		String browser_version_lt = PropFileHandler.readConfigProperty("browser_version_lt");
		logMessage("browser Version: " + browser_version_lt);
		browser =  PropFileHandler.readConfigProperty("browser");

		if (browser.equalsIgnoreCase("chrome")) {
			
			cap.setCapability("browserName", "chrome");
			cap.setCapability("version", browser_version_lt);
			cap.setCapability("platform", os_version_lt);
			cap.setCapability("build", "APIEX");
			cap.setCapability("name", "APIEX");
			cap.setCapability("network", true);
			cap.setCapability("visual", true);
			cap.setCapability("video", true);
			cap.setCapability("console", true);
			cap.setCapability("terminal", true);
			cap.setCapability("tunnel", false);
			try {
				driver = new RemoteWebDriver(new URL("https://" + username_lt + ":" + accesskey_lt + gridURL_LambdaTest),
						cap);
			} catch (MalformedURLException e) {
				logMessage("Invalid grid URL");
			} catch (Exception e) {
				logMessage(e.getMessage());
			}
		}

		else if (browser.equalsIgnoreCase("Firefox")) {
	     	cap.setCapability("browserName", "Firefox"); // To specify the browser
			cap.setCapability("version", browser_version_lt); // To specify the browser version
			cap.setCapability("platform", os_version_lt); // To specify the OS
			cap.setCapability("build", "APTIEX"); // To identify the test
			cap.setCapability("name", " APTIEX");
			cap.setCapability("build", System.getProperty("build")); // To identify the test
			cap.setCapability("name", System.getProperty("name"));
			cap.setCapability("network", true); // To enable network logs
			cap.setCapability("visual", true); // To enable step by step screenshot
			cap.setCapability("video", true); // To enable video recording
			cap.setCapability("console", true); // To capture console logs
			cap.setCapability("tunnel", false);
			try {
				driver = new RemoteWebDriver(new URL("https://" + username_lt + ":" + accesskey_lt + gridURL_LambdaTest),
						cap);
			} catch (MalformedURLException e) {
				logMessage("Invalid grid URL");
			} catch (Exception e) {
				logMessage(e.getMessage());
			}

		} else if (browser.equalsIgnoreCase("Edge")) {
			cap.setCapability("browserName", "Edge");
			cap.setCapability("version", browser_version_lt);
			cap.setCapability("platform", os_version_lt);
			cap.setCapability("build", "APIEX");
			cap.setCapability("name", "APIEX");
			cap.setCapability("network", true);
			cap.setCapability("visual", true);
			cap.setCapability("video", true);
			cap.setCapability("console", true);
			cap.setCapability("tunnel", false);
			try {
				driver = new RemoteWebDriver(new URL("https://" + username_lt + ":" + accesskey_lt + gridURL_LambdaTest),
						cap);
			} catch (MalformedURLException e) {
				logMessage("Invalid grid URL");
			} catch (Exception e) {
				logMessage(e.getMessage());
			}

		}
		return driver;

	}

	protected WebDriver setRemoteDriver() {
		if (browser.equalsIgnoreCase("chrome")) {
			 options = new ChromeOptions();
		} else if (browser.equalsIgnoreCase("firefox"))
			firefoxoptions = new FirefoxOptions();
		else if (browser.equalsIgnoreCase("Safari"))
			safarioptions = new SafariOptions();
		else if ((browser.equalsIgnoreCase("ie")) || (browser.equalsIgnoreCase("internet explorer")))
			ieoptions = new InternetExplorerOptions();
		else if (browser.equalsIgnoreCase("edge")) {
			System.setProperty("webdriver.edge.driver", "src/test/resources/SeleniumWebdrivers/msedgedriver.exe");
			edgeoptions = new EdgeOptions();
			
		}

		String seleniumhubaddress = null;
		seleniumhubaddress = System.getProperty("vm.IP");
		if (seleniumhubaddress == null || seleniumhubaddress.isEmpty())
			seleniumhubaddress = PropFileHandler.readConfigProperty("seleniumserverhost");
		logMessage("Selenium hub address: " + seleniumhubaddress);

		URL selserverhost = null;
		try {
			selserverhost = new URL(seleniumhubaddress);
		} catch (MalformedURLException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		}

		RemoteWebDriver remoteDriver = null;
		if(browser.equalsIgnoreCase("chrome")) {
			 remoteDriver = new RemoteWebDriver(selserverhost, options);
		}
		else if(browser.equalsIgnoreCase("edge")) {
			 remoteDriver = new RemoteWebDriver(selserverhost, edgeoptions);
		}
		
		else if(browser.equalsIgnoreCase("firefox")) {
			 remoteDriver = new RemoteWebDriver(selserverhost, firefoxoptions);
		}
		
		else if(browser.equalsIgnoreCase("safari")) {
			 remoteDriver = new RemoteWebDriver(selserverhost, safarioptions);
		}
		else if(browser.equalsIgnoreCase("ie")) {
			 remoteDriver = new RemoteWebDriver(selserverhost, ieoptions);
		}
		
		
		logMessage("Target Hub Address : " + selserverhost);

		return remoteDriver;
	}

	
	public static void launchApplication(String url) {
		driver.get(url);
		logMessage("**[INFO]: Product URL :: " + url);
		hardWait(5);
	}

	@SuppressWarnings("unused")
	private static WebDriver setFirefoxDriver() {
		System.setProperty("webdriver.gecko.driver", "src/test/resources/SeleniumWebdrivers/geckodriver.exe");
		File pathBinary = new File("C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe");
		FirefoxBinary firefoxBinary = new FirefoxBinary(pathBinary);
		FirefoxProfile options = new FirefoxProfile();
		return new FirefoxDriver();
	}

	public void closeSession() {
		driver.quit();
		logMessage("*************************************** Session closed ***************************************");
	}

	public void quitSession() {
		driver.close();
		logMessage("*************************************** Window closed ***************************************");
	}

	public void launchProduct(String Product, String url) {
		driver.get(url);
		logMessage("**[Info]: " + Product + " URL :: " + url);
	}
}
