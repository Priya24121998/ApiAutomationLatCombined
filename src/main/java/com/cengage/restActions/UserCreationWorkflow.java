/**
 * This class is part of the REST actions package and is responsible for handling
 * the user creation workflow in the application. It provides methods and logic
 * to manage the process of creating users, ensuring proper integration with
 * the application's backend services.
 *
 * <p>Usage of this class typically involves invoking its methods to perform
 * user creation tasks as part of an end-to-end workflow. It is designed to
 * work seamlessly within the Spring Boot API project structure.</p>
 *
 * <p>Make sure to configure any necessary dependencies and properties before
 * using this class to ensure proper functionality.</p>
 *
 * @author Your Name
 * @version 1.0
 * @since 2023
 */
package com.cengage.restActions;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.apache.commons.lang3.RandomStringUtils;

import com.cengage.b2b.placeOrderApplication.OrderPlacementController;
import com.cengage.common.Payload;
import com.cengage.common.PropFileHandler;
import com.cengage.b2b.orderrepository.UserCreation;
import com.cengage.b2b.orderrepository.UserCreationOut;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;

public class UserCreationWorkflow extends OrderWorkFlow {
	public static String response;
	private static String authorizationValue;
	private static String userID;
	public static String userCreationId;
	static Payload payloadreq = new Payload();

	public static String getNewUserCreationPayloadRandom(String userName, String store, String account) {

		int length = 5;
		boolean useLetters = true;
		boolean useNumbers = false;
		String generatedString = RandomStringUtils.random(length, useLetters, useNumbers);

		String tier = System.getProperty("tier");
		if (tier == null || tier.isEmpty()) {
			tier = OrderPlacementController.environmentSelected;
		}
		userID = (store + "_" + tier + "_" + userName + "_" + generatedString + "_" + 123 + getCurrentTimestamp()
				+ "@mailinator.com").toLowerCase();
		
		String payload =null;
		if(OrderPlacementController.storeToBeSelected.equalsIgnoreCase("B2BCA"))
		{
		payload = payloadreq.userCreationRequestPayload();
		}
		else if(OrderPlacementController.storeToBeSelected.equalsIgnoreCase("B2BUS"))
		{
		payload = payloadreq.userCreationRequestPayloadUnitedStates();
		}
		else if(OrderPlacementController.storeToBeSelected.equalsIgnoreCase("B2BGT"))
		{
		payload = payloadreq.userCreationRequestPayloadGale();
		}
		payload = payload.replaceAll("#replaceAccountValue#", account);
		payload = payload.replaceAll("#replaceValue#", userID);
		return payload;

	}

	public static String createB2BUser(String baseSiteId, String account, String Status) {
		getAuthorizationToken();
		logMessage("Auth Value: " + getAuthorizationToken());
		String payload = UserCreationWorkflow.getNewUserCreationPayloadRandom("automation", "B2B", account);
		logMessage("Payload: " + payload);
		String endPoint = "/" + baseSiteId + "/orgCustomers";
		int status = 201;
		RestAssured.baseURI = PropFileHandler.readProperty("base_URI");
		logMessage("endPoint: " + endPoint);
		response = RestAssured.given().headers("Authorization", getAuthorizationToken()).contentType(ContentType.JSON)
				.body(payload).post(endPoint).then().assertThat().statusCode(status).extract().asString();

		logMessage("Response: " + response);
		return response;

	}

	public static String activationApiCanada(String password) {

		RestAssured.baseURI = PropFileHandler.readProperty("ActivationBaseURI");
		String payload = payloadreq.activationReqPayloadB2bCanada();
		payload = payload.replaceAll("#replaceEmailValue#", userID);
		payload = payload.replaceAll("#replacePasswordValue#", password);
		String endpoint = "/api/v1/users?activate=true";

		response = RestAssured.given().header("Content-Type", "application/json")
				.header("Accept-Encoding", "gzip, deflate,br")
				.header("Authorization", "SSWS 00qsJZGR_tCqUvKVtlLh4tlgD-iPw28mrUaDNRhl2i").and().body(payload).when()
				.post(endpoint).then().statusCode(200).and().extract().response().asString();
		logMessage(response);
		return response;

	}

	public static String activationApiUnitedStates(String password) {
		RestAssured.baseURI = PropFileHandler.readProperty("ActivationBaseURI");
		String payload = payloadreq.activationReqPayloadB2bUnitedStates();
		payload = payload.replaceAll("#replaceEmailValue#", userID);
		payload = payload.replaceAll("#replacePasswordValue#", password);
		String endpoint = "/api/v1/users?activate=true";

		response = RestAssured.given().header("Content-Type", "application/json")
				.header("Accept-Encoding", "gzip, deflate,br")
				.header("Authorization", "SSWS 00qsJZGR_tCqUvKVtlLh4tlgD-iPw28mrUaDNRhl2i").and().body(payload).when()
				.post(endpoint).then().statusCode(200).and().extract().response().asString();
		logMessage(response);
		return response;

	}

	public static String activationApiGale(String password) {

		RestAssured.baseURI =PropFileHandler.readProperty("ActivationBaseURI");
		String payload = payloadreq.activationReqPayloadB2bGale();
		payload = payload.replaceAll("#replaceEmailValue#", userID);
		payload = payload.replaceAll("#replacePasswordValue#", password);
		String endpoint = "/api/v1/users?activate=true";

		response = RestAssured.given().header("Content-Type", "application/json")
				.header("Accept-Encoding", "gzip, deflate,br")
				.header("Authorization", "SSWS 00qsJZGR_tCqUvKVtlLh4tlgD-iPw28mrUaDNRhl2i").and().body(payload).when()
				.post(endpoint).then().statusCode(200).and().extract().response().asString();
		logMessage(response);
		return response;
	}

	public static String getCurrentTimestamp() {
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return now.format(formatter);
	}
	
	public static String UserIdGet() {
		JsonPath js = new JsonPath(response);
		userCreationId = js.getString("customerId");
		logMessage(userCreationId);
		return userCreationId;

	}

	

}
