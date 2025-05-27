/**
 * The BaseClass serves as a foundational class for REST actions within the application.
 * It is part of the `com.cengage.restActions` package and provides shared functionality 
 * or utilities that can be extended by other classes to streamline REST API interactions.
 *
 * <p>Usage:</p>
 * <ul>
 *   <li>Extend this class to inherit common REST action behaviors.</li>
 *   <li>Override methods as needed to customize functionality for specific use cases.</li>
 * </ul>
 *
 * <p>Note:</p>
 * Ensure that any extending class adheres to the design principles of this base class 
 * to maintain consistency and reusability across the application.
 */
package com.cengage.restActions;

import java.time.Duration;
import java.util.Calendar;
import java.util.Date;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.cengage.common.PropFileHandler;
import java.text.DateFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import io.restassured.RestAssured;
import io.restassured.path.json.JsonPath;
import org.json.simple.parser.ParseException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Wait;

public class BaseClass {

	static PropFileHandler prop;

	public static String response;
	static JSONParser parser = new JSONParser();
	static JSONObject obj = null;

	public static JSONArray extractJsonArrayFromResponse(String response, String parameter) {
		try {
			obj = (JSONObject) parser.parse(response);
		} catch (ParseException e) {
			logMessage(e.getMessage());
		}
		return (JSONArray) obj.get(parameter);
	}
	

	public static String getAuthorizationToken() {
		String endpoint = PropFileHandler.readProperty("authorization");
		String clientID = PropFileHandler.readProperty("clientId2");
		String secretID = PropFileHandler.readProperty("secretId2");

		response = RestAssured.given().auth().preemptive().basic(clientID, secretID)
				.header("Content-Type", "application/x-www-form-urlencoded")
				.formParam("grant_type", "client_credentials").when().post(endpoint).then().assertThat().statusCode(200)
				.extract().asString();
		JsonPath responseObj = JsonPath.from(response);
		String accessToken = responseObj.get("access_token");
		String tokenType = responseObj.get("token_type");
		tokenType = tokenType.substring(0, 1).toUpperCase() + tokenType.substring(1).toLowerCase();
		return tokenType + " " + accessToken;

	}

	public static String setAuthorizationHeader() {
		RestAssured.useRelaxedHTTPSValidation();
		String endpoint = PropFileHandler.readProperty("authorization");
		String clientID = PropFileHandler.readProperty("clientId");
		String secretID = PropFileHandler.readProperty("secretId");

		String response = RestAssured.given().auth().preemptive().basic(clientID, secretID)
				.header("Content-Type", "application/x-www-form-urlencoded")
				.formParam("grant_type", "client_credentials").when().post(endpoint).then().assertThat().statusCode(200)
				.extract().asString();

		JsonPath responseObj = JsonPath.from(response);

		String accessToken = responseObj.get("access_token");
		String tokenType = responseObj.get("token_type");
		tokenType = tokenType.substring(0, 1).toUpperCase() + tokenType.substring(1).toLowerCase();
		String authorizationValue = tokenType + " " + accessToken;

		return authorizationValue;
	}

	protected static void logMessage(String message) {
		System.out.println(message);

	}

	protected static void logMessageSys(String message) {
		System.out.println(message);

	}

	public static void initializeEnvConditionsBeforeOrderExecution() {
		prop = new PropFileHandler();
	}

	public static String extractValuefromResponse(String response, String parameter) {
		try {
			obj = (JSONObject) parser.parse(response);
		} catch (ParseException e) {
			logMessage(e.getMessage());
		}
		String value = (String) obj.get(parameter);
		return value;
	}

	public static String extractDateFromWholeString(String response) {
		String parts[] = response.split("T");
		return parts[0];
	}


	protected static String getCurrentDate()
	{
		Format formatter = new SimpleDateFormat("yyyy-MM-dd");
		String timestamp = formatter.format(new Date());
		return timestamp;
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
}
