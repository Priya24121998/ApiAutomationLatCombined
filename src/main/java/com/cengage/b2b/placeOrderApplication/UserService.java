/**
 * The {@code UserService} class is part of the Place Order Application module.
 * This class is responsible for handling user-related operations and services
 * within the application. It serves as a central point for managing user data
 * and interactions.
 *
 * <p>Typical responsibilities of this class may include:
 * <ul>
 *   <li>Fetching user details</li>
 *   <li>Validating user information</li>
 *   <li>Managing user-related business logic</li>
 * </ul>
 *
 * <p>Ensure that this class adheres to the application's design principles
 * and integrates seamlessly with other components of the system.
 *
 * @author Priyadharshini M
 * @version 1.0
 * @since 2025
 */
package com.cengage.b2b.placeOrderApplication;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.cengage.b2b.placeOrderApplication.OrderPlacementController;
import com.cengage.b2b.placeOrderApplication.OrderService;
import com.cengage.restActions.OrderWorkFlow;
import com.cengage.restActions.UserCreationWorkflow;
import com.cengage.b2b.orderrepository.NoOfUsersType;
import com.cengage.b2b.orderrepository.Order;
import com.cengage.b2b.orderrepository.PaymentType;
import com.cengage.b2b.orderrepository.UserCreation;
import com.cengage.b2b.orderrepository.UserCreationOut;

import io.restassured.path.json.JsonPath;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;

@Service
public class UserService {
	static List<UserCreationOut> userCreationOutList = new ArrayList<UserCreationOut>();

	public List<String> getStaticAccounts(String store) {

		OrderService service = new OrderService();
		return service.getStaticAccounts(store);

	}

	public UserCreation createUser(NoOfUsersType noofUsers,String env, String store, String userAccount) {

		switch (store) {
		case "B2BUS":
			return new UserCreation(1, env,noofUsers.Single, "0100159146");
		case "B2BCA":
			return new UserCreation(2,env,noofUsers.Single, "0100159015");
		case "B2BGT":
			return new UserCreation(3,env,noofUsers.Single, "0100182537");
		default:
			throw new IllegalArgumentException("Invalid store: " + store);
		}
	}

	public static void createAndActivateNewUser(String basestore, String account) {

		UserCreationWorkflow.createB2BUser(basestore, account, "200");
		UserCreationWorkflow.UserIdGet();
		if (basestore.equals("cengage-b2b-ca")) {
			UserCreationWorkflow.activationApiCanada("Password1");
		} else if (basestore.equals("cengage-b2b-gt")) {
			UserCreationWorkflow.activationApiUnitedStates("Password1");
		} else if (basestore.equals("cengage-b2b-us")) {
			UserCreationWorkflow.activationApiGale("Password1");
		}
	}

	public static UserCreationOut getUserCreateOutDetails(String userId, String account) {

		UserCreationOut usercreobjout = new UserCreationOut();
		usercreobjout.setAccount(account);
		usercreobjout.setEnv(OrderPlacementController.environmentSelected);
		usercreobjout.setPassword("Password1");
		usercreobjout.setEmailId(userId);
		usercreobjout.setUserId(userId);
		usercreobjout.setStore(OrderPlacementController.storeToBeSelected);
		usercreobjout.setDate(OrderWorkFlow.getCurrentTimestamp());

		return usercreobjout;

	}

	public UserCreation createUserOut(NoOfUsersType single, String userAccount) {
		UserCreation usercreobjin = new UserCreation();	
		usercreobjin.setUserAccount(userAccount);
		usercreobjin.setNoOfUsersType(NoOfUsersType.Single);
		return usercreobjin;
	}

	public static List<UserCreationOut> getUserCreateOutListDetails(String userCreationId, String userAccount) {
		UserCreationOut usercreobjout = getUserCreateOutDetails(userCreationId,userAccount);
		userCreationOutList.add(usercreobjout);
		return userCreationOutList;
	}
	
	public static List<UserCreationOut> returnUserCreationList() {

		return userCreationOutList;
	}

	public void clearUserCreationArray() {
		userCreationOutList.clear();
		OrderWorkFlow.OrderID=null;
		
	}


}
