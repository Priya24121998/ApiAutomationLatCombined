/**
 * The OrderPlacementController class is a Spring MVC controller that handles
 * various operations related to order placement and user creation in a B2B
 * environment. It provides endpoints for placing orders, managing order history,
 * exporting order details, creating users, and managing user creation history.
 * 
 * <p>
 * This controller interacts with services and repositories to perform the
 * following tasks:
 * </p>
 * <ul>
 *   <li>Display home and order placement pages</li>
 *   <li>Process order placement requests with various configurations</li>
 *   <li>Export order details to CSV files</li>
 *   <li>Create B2B users and manage user creation history</li>
 *   <li>Export user details to CSV files</li>
 * </ul>
 * 
 * <p>
 * The controller uses Spring's dependency injection to manage its dependencies
 * and provides validation for user inputs. It also logs important information
 * and errors for debugging and monitoring purposes.
 * </p>
 * 
 * <p>
 * Key features include:
 * </p>
 * <ul>
 *   <li>Dynamic order creation with support for multiple configurations such as
 *       payment type, delivery mode, promo codes, and ISBN types.</li>
 *   <li>Support for creating single or multiple users in different environments
 *       and stores.</li>
 *   <li>Export functionality for both order and user details in CSV format.</li>
 *   <li>Pagination support for user creation history.</li>
 * </ul>
 * 
 * <p>
 * Note: This controller relies on various services, repositories, and utility
 * classes for its operations, such as {@code OrderService}, {@code UserService},
 * {@code OrderRepository}, and {@code placeOrderOutline}.
 * </p>
 * 
 * <p>
 * Exceptions such as {@code OrderPlacementException} and
 * {@code UserCreationException} are thrown in case of validation errors or
 * unexpected issues during order placement or user creation.
 * </p>
 * 
 * <p>
 * Example usage:
 * </p>
 * <pre>
 * // Access the home page
 * GET /home
 * 
 * // Place an order
 * POST /placeOrderHome
 * 
 * // Export order details
 * GET /exportOrderDetails
 * 
 * // Create a B2B user
 * POST /create-b2b-user
 * 
 * // View user creation history
 * GET /userCreationHistory
 * </pre>
 * 
 * @author Priyadharshini M
 * @version 1.0
 * @since 2025
 */
package com.cengage.b2b.placeOrderApplication;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.cengage.common.Payload;
import com.cengage.common.PropFileHandler;
import com.cengage.restActions.BaseClass;
import com.cengage.restActions.OrderWorkFlow;
import com.cengage.restActions.UserCreationWorkflow;
import com.cengage.restActions.placeOrderOutline;
import com.cengage.b2b.orderrepository.CreditCardType;
import com.cengage.b2b.orderrepository.Environment;
import com.cengage.b2b.orderrepository.IsbnType;
import com.cengage.b2b.orderrepository.NoOfUsersType;
import com.cengage.b2b.orderrepository.Order;
import com.cengage.b2b.orderrepository.OrderOut;
import com.cengage.b2b.orderrepository.OrderOutRepository;
import com.cengage.b2b.orderrepository.OrderRepository;
import com.cengage.b2b.orderrepository.OrderType;
import com.cengage.b2b.orderrepository.PaymentType;
import com.cengage.b2b.orderrepository.UserCreation;
import com.cengage.b2b.orderrepository.UserCreationOut;
import com.cengage.b2b.orderrepository.UserOutRepository;
import com.cengage.b2b.orderrepository.UserRepository;
import com.cengage.b2b.validations.OrderPlacementException;
import com.cengage.b2b.validations.UserCreationException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;

@Controller
public class OrderPlacementController {

	private final OrderService orderService;
	private final UserService userservice;
	private final OrderRepository orderRepository;
	private final OrderOutRepository orderOutRepository;
	private final UserRepository userRepository;
	private final UserOutRepository useroutRepository;

	public static String baseStore;
	public String accountNo;
	public static PaymentType paymentTypeSelected = null;
	public static IsbnType isbnTypeSelected = null;
	public static String isbnOptionSelected = null;
	public static CreditCardType creditTypeSelected = null;
	public static OrderType orderTypeSelected = null;
	public static String deliveryModeSelected = null;
	public static String paymentTypeMode = null;
	public static org.json.JSONObject addProdReqPayload = null;
	public static String promoCodeAppliedOut = null;
	public static String promoCodeGet = null;
	public static String environmentSelected = null;
	public static String dropshipRadioSelected =null;
	public static String storeToBeSelected = null;
	OrderOut order;
	UserCreationOut userout;
	UserCreation userin;
	private static final Logger logger = LoggerFactory.getLogger(OrderPlacementController.class);

	@Autowired
	public OrderPlacementController(OrderService orderService, UserService userservice, OrderRepository orderRepository,
			OrderOutRepository orderOutRepository, UserRepository userRepository, UserOutRepository useroutRepository) {
		this.orderService = orderService;
		this.userservice = userservice;
		this.orderRepository = orderRepository;
		this.orderOutRepository = orderOutRepository;
		this.userRepository = userRepository;
		this.useroutRepository = useroutRepository;
	}

	@RequestMapping("/home")
	public String showHomePage() {
		return "homePage";
	}

	@RequestMapping(value = "/placeOrderHome", method = RequestMethod.GET)
	public String showPlaceOrderPage(@RequestParam("store") String store,
			@RequestParam(value = "userid", required = false) String userId,
			@RequestParam(value = "paymentType", required = false) PaymentType paymentType,
			@RequestParam(value = "creditCardType", required = false) CreditCardType creditCardType, ModelMap model) {

		List<String> staticAccounts = orderService.getStaticAccounts(store);
		model.addAttribute("staticAccounts", staticAccounts);
		model.addAttribute("placeOrderAtt", orderService.createOrder(store, userId, paymentType));
		logger.info("Static accounts available :" + staticAccounts);
		
		logger.info("Store: " + store);
		return "placeOrder";
	}

	@RequestMapping(value = "/placeOrderHome", method = RequestMethod.POST)
	public Object processPlaceOrder(@RequestParam("store") String store,
			@RequestParam(value = "env", required = false) Environment env,
			@RequestParam(value = "userid", required = false) String userId,
			@RequestParam(value = "orderType", required = false) OrderType ordertype,
			@RequestParam(value = "deliveryMode", required = false) String deliveryMode,
			@RequestParam(value = "paymentType", required = false) PaymentType paymentType,
			@RequestParam(value = "creditCardType", required = false) CreditCardType creditCardType,
			@RequestParam(value = "account", required = false) String account,
			@RequestParam(value = "otherAccount", required = false) String otherAccount,
			@RequestParam(value = "isbnType", required = false) IsbnType isbnType,
			@RequestParam(value = "isbnPhysical", required = false) String isbnPhysical,
			@RequestParam(value = "isbnDigital", required = false) String isbnDigital,
			@RequestParam(value = "isbnBundle", required = false) String isbnBundle,
			@RequestParam(value = "addIsbnWithQuantity", required = false) String addIsbnWithQuantity,
			@RequestParam(value = "promoCodeApplied", required = false) String promoCodeApplied,
			@RequestParam(value = "promoCode", required = false) String promoCode,
			@RequestParam(value = "dropshipRadio", required = false) String dropshipRadio,
			ModelMap model,
			@Valid @ModelAttribute("placeOrderAtt") Order orderobj, BindingResult result) {

		// input validation
		if (result.hasErrors()) {

			model.addAttribute("errorMessage", "Validation errors found!");
			throw new OrderPlacementException("Failed to create order due to validation error");

		}
		// updating the values according to chosen value in ui
		orderobj.setEnv(env);
		environmentSelected = env.toString();
		storeToBeSelected = store;
		orderobj.setAccount(account);
		if (account.equalsIgnoreCase("other")) {
			orderobj.setOtherAccount(otherAccount);
			account = otherAccount;

		}
		orderobj.setDeliveryMode(deliveryMode);
		orderService.setOrderType(ordertype);
		orderService.setPaymentType(paymentType);
		if (paymentType.equals(PaymentType.poWithCC)) {
			orderService.setCreditCardType(creditCardType);
		}
		orderService.setIsbnType(isbnType);
		orderService.setDeliveryMode(deliveryMode);

		if (promoCodeApplied.equalsIgnoreCase("yes")) {
			orderobj.setPromoCode(promoCode);
			promoCodeGet = promoCode;

		}
		promoCodeAppliedOut = promoCodeApplied;
		System.out.println("PromoCode: " + promoCodeApplied);
		System.out.println(promoCode);

		if (orderTypeSelected.equals(OrderType.singleOrder)) {
			orderobj.setIsbnType(isbnType);
			orderobj.setIsbnPhysical(isbnPhysical);
			orderobj.setIsbnDigital(isbnDigital);
			orderobj.setIsbnBundle(isbnBundle);
			orderobj.setPromoCodeApplied(promoCodeApplied);

			if (isbnTypeSelected.equals(IsbnType.physical)) {
				isbnOptionSelected = placeOrderOutline.addPhysicalIsbnToCart(isbnPhysical);
			} else if (isbnTypeSelected.equals(IsbnType.digital)) {
				isbnOptionSelected = placeOrderOutline.addDigitalIsbnToCart(isbnDigital);
			} else if (isbnTypeSelected.equals(IsbnType.bundle)) {
				isbnOptionSelected = placeOrderOutline.addBundleIsbnToCart(isbnBundle);
			}

		} else if (orderTypeSelected.equals(OrderType.fastPacedOrder)) {
			addProdReqPayload = Payload.multipleIsbnAndQuantityGetAndCreatePayload(addIsbnWithQuantity);
		}
		orderobj.setDropshipRadio(dropshipRadio);
		dropshipRadioSelected = dropshipRadio;

		orderRepository.save(orderobj);
		logger.info("--------------------Place Order Values section after update-------------------");
		logger.info(String.format("Environment Selected: %s", environmentSelected));
		logger.info(String.format("ISBN Option selected: %s", isbnOptionSelected));
		logger.info(String.format("Account used: %s", account));
		logger.info(String.format("ISBN Selected: %s", isbnTypeSelected));
		logger.info(String.format("Order type selected: %s", orderTypeSelected));
		logger.info(String.format("Promo code applied or not: %s", promoCodeAppliedOut));
		logger.info(String.format("Promo code if applied: %s", promoCode));
		logger.info(String.format("Payment type selected: %s", paymentType));
		logger.info(String.format("Delivery mode selected: %s", deliveryMode));
		logger.info(String.format("Drop ship applied: %s", dropshipRadio));
		orderService.setBaseStore(store);

		// place order execution
		try {
			BaseClass.initializeEnvConditionsBeforeOrderExecution();
			executeOrderWorkflow(store, userId, account, deliveryModeSelected, paymentType, creditCardType);
			logger.info("--------------------Place Order details-------------------");
			logger.info(String.format("User ID: %s", userId));
			logger.info(String.format("Order placed: %s", OrderWorkFlow.OrderID));
			logger.info(String.format("Account used: %s", account));
			logger.info(String.format("Order type selected: %s", orderTypeSelected));
			logger.info(String.format("Promo code applied or not: %s", promoCodeAppliedOut));
			logger.info(String.format("Promo code if applied: %s", promoCode));
			logger.info(String.format("Payment type selected: %s", paymentType));
			logger.info(String.format("Delivery mode selected: %s", deliveryMode));

			if (OrderWorkFlow.OrderID != null) {
				model.addAttribute("successMessage", "Order placed successfully!");

			} else {
				model.addAttribute("errorMessage", "Failed to place order. Please try again.");

			}
			model.addAttribute("placeOrderAtt", orderobj);

			try {
				if (OrderWorkFlow.OrderID != null) {
					order = orderService.createOrderOut(userId, account, promoCodeAppliedOut,paymentTypeMode);
					orderOutRepository.save(order);
					model.addAttribute("orderMessageAtt", order);
					model.addAttribute("orderHistory", order);
				} else {
					model.addAttribute("errorMessage", "Failed to place order. Please try again");
					return "orderMessage";
				}
			} catch (Exception e) {
				model.addAttribute("errorMessage", "Failed to place order. Please try again. Exception : " + e);
				return "orderMessage";
			}
	
			model.addAttribute("successMessage", "Order placed successfully!");
			model.addAttribute("placeOrderAtt", orderobj);
			return "orderMessage";

		} catch (Exception e) {

			model.addAttribute("errorMessage", "Failed to place order. Please try again.");
			throw new OrderPlacementException("Failed to place order due to exception"+e);
		}
	}


	@RequestMapping("/orderHistory")
	public Object showOrderHistory(ModelMap model, @Valid @ModelAttribute("orderHistory") OrderOut orderOut) {
		List<OrderOut> orderHistory = orderOutRepository.findAll();
		model.addAttribute("orderHistory", orderHistory);
		ResponseEntity.ok(orderHistory);
		return "orderHistory";
	}

	@GetMapping("/exportOrderDetails")
	@ResponseBody
	public void exportOrderDetails(HttpServletResponse response) throws IOException {
		response.setContentType("text/csv");
		response.setHeader("Content-Disposition", "attachment; filename=\"order_details.csv\"");
		PrintWriter writer = response.getWriter();
		writer.println("ID,Environment,Store,Order ID,User ID,Account,Delivery Mode, Promo Code Applied or not, PromoCode Value if applicable, Payment Type,Date");

		List<OrderOut> orderOutHistory = orderOutRepository.findAll();

		for (OrderOut orderOutData : orderOutHistory) {
			writer.println(orderOutData.getId() + "," + orderOutData.getEnv() + "," + orderOutData.getStore() + ","
					+ orderOutData.getOrderId() + "," + orderOutData.getUserId() + "," + orderOutData.getAccount() + ","
					+ orderOutData.getDeliveryMode() + "," + orderOutData.getPromoCode() + "," + orderOutData.getPromoCodeGet() + ","+ orderOutData.getPaymentType() + ","
					+ orderOutData.getDate());
		}

		writer.flush();
		writer.close();
	}

	@GetMapping("/create-b2b-user")
	public String getUserCreateInputDetails(@RequestParam("store") String store,
			@RequestParam(value = "env", required = false) String env,
			@RequestParam(value = "userAccount", required = false) String userAccount,
			@RequestParam(value = "noOfUsersType", required = false) NoOfUsersType noOfUsersType, ModelMap map) {

		List<String> staticAccounts = userservice.getStaticAccounts(store);
		map.addAttribute("staticUserAccounts", staticAccounts);
		map.addAttribute("userCreationAtt", userservice.createUser(noOfUsersType.Single, "QA", store, userAccount));
		System.out.println(store);
		System.out.println(staticAccounts);
		userservice.clearUserCreationArray();
		return "b2bUserCreate";

	}

	@PostMapping("/create-b2b-user")
	public String createUsers(@RequestParam(value = "store", required = true) String store,
			@RequestParam(value = "env", required = false) String env,
			@RequestParam(value = "userAccount", required = false) String userAccount,
			@RequestParam(value = "noOfUsersType", required = false) NoOfUsersType noOfUsersType,
			@RequestParam(value = "numberOfUsers", required = false) Integer numberOfUsers, ModelMap map,
			@Valid @ModelAttribute("userCreationAtt") UserCreation usercreobj, BindingResult result) {

		Integer noOfUserToBeSelected = 1;
		if (result.hasErrors()) {
			System.out.println("Validation errors found!");

			result.getAllErrors().forEach(error -> {
				System.out.println(error.getObjectName() + ": " + error.getDefaultMessage());
			});

			throw new UserCreationException("Failed to create user");
		}

		System.out.println(store);
		usercreobj.setId(usercreobj.getId());
		usercreobj.setEnv(env);
		environmentSelected = env;
		System.out.println("Environment selected :" + env);
		usercreobj.setNoOfUsersType(noOfUsersType);
		usercreobj.setUserAccount(userAccount);
		if (noOfUsersType.equals(NoOfUsersType.Multiple)) {
			usercreobj.setNumberOfUsers(numberOfUsers);
			noOfUserToBeSelected = numberOfUsers;
		}
		usercreobj.setVersion(2);
		System.out.println(userAccount);
		BaseClass.initializeEnvConditionsBeforeOrderExecution();

		for (int i = 0; i < noOfUserToBeSelected; i++) {
			if (store.equals("B2BCA")) {
				storeToBeSelected = store;
				UserService.createAndActivateNewUser("cengage-b2b-ca", userAccount);
				System.out.println(UserCreationWorkflow.userCreationId);
			} else if (store.equals("B2BUS")) {
				storeToBeSelected = store;
				UserService.createAndActivateNewUser("cengage-b2b-us", userAccount);
			} else if (store.equals("B2BGT")) {
				storeToBeSelected = store;
				UserService.createAndActivateNewUser("cengage-b2b-gt", userAccount);
			}
			map.addAttribute("userCreationAtt", usercreobj);
			userin = userservice.createUserOut(NoOfUsersType.Single, userAccount);
			userRepository.findByUserAccount(userAccount);
			// userRepository.save(usercreobj);

			try {
				if (UserCreationWorkflow.userCreationId != null) {

					userout = UserService.getUserCreateOutDetails(UserCreationWorkflow.userCreationId, userAccount);
					map.addAttribute("userMessageAtt", userout);
					useroutRepository.save(userout);
					map.addAttribute("successMessage", "User is created successfully!");
				}
			} catch (Exception e) {
				map.addAttribute("errorMessage", "Failed to create user. Please try again.");
				logger.error("Error creating user", e);
				throw new UserCreationException("Failed to create user");

			}
			map.addAttribute("userList",
					UserService.getUserCreateOutListDetails(UserCreationWorkflow.userCreationId, userAccount));
		}

		return "postb2bMutlipleUserCreation";
	}

	@RequestMapping("/userCreationHistory")
	public String showUserCreationHistory(@RequestParam(value = "page", defaultValue = "1") int page, ModelMap model) {
		int pageSize = 15;
		PageRequest pageRequest = PageRequest.of(page - 1, pageSize);
		Page<UserCreationOut> userCreationHistoryPage = useroutRepository.findAll(pageRequest);
		model.addAttribute("userCreationHistory", userCreationHistoryPage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", userCreationHistoryPage.getTotalPages());
		return "userCreationHistory";
	}

	@GetMapping("/exportUserDetails")
	@ResponseBody
	public void exportUserDetails(HttpServletResponse response) throws IOException {
		response.setContentType("text/csv");
		response.setHeader("Content-Disposition", "attachment; filename=\"user_details.csv\"");
		PrintWriter writer = response.getWriter();
		writer.println("ID,Environment,Store,User ID,Account,Date");

		List<UserCreationOut> userCreationHistory = UserService.returnUserCreationList();

		for (UserCreationOut userCreation : userCreationHistory) {
			writer.println(userCreation.getId() + "," + userCreation.getEnv() + "," + userCreation.getStore() + ","
					+ userCreation.getUserId() + "," + userCreation.getAccount() + "," + userCreation.getDate());
		}

		writer.flush();
		writer.close();
	}

	@PostMapping("/downloadCsvFileForCurrentExecution")
	@ResponseBody
	public void downloadCsvFileForCurrentExecution(HttpServletResponse response) throws IOException {
		response.setContentType("text/csv");
		response.setHeader("Content-Disposition", "attachment; filename=\"userDetailsCurrentExe.csv\"");
		PrintWriter writer = response.getWriter();
		writer.println("ID,Environment,User ID,Account");

		List<UserCreationOut> userCreationHistory = useroutRepository.findAll();

		for (UserCreationOut userCreation : userCreationHistory) {
			writer.println(userCreation.getId() + "," + userCreation.getEnv() + "," + userCreation.getUserId() + ","
					+ userCreation.getAccount());
		}

		writer.flush();
		writer.close();
	}

	// Helper methods

	public void executeOrderWorkflow(String store, String userId, String accountNo, String deliveryMode,
			PaymentType paymentType, CreditCardType creditCardType) {
		try {
			OrderWorkFlow.OrderID=null;
			placeOrderOutline.createCart(userId, baseStore, store, 201);
			placeOrderOutline.setShipToBillTo(baseStore, store, 202, accountNo);
			if (orderTypeSelected.equals(OrderType.singleOrder)) {
				placeOrderOutline.addProdToCart(baseStore, store, 200, isbnOptionSelected);
			} else if (orderTypeSelected.equals(OrderType.fastPacedOrder)) {
				try {
					placeOrderOutline.addProdToCartFastPaced(baseStore, store, 200, addProdReqPayload);
				} catch (Exception e) {
					System.out.println("Exception :" + e);
					Payload.clearIsbnsStoredInCurrentExecution();

				}

			}
			if (promoCodeAppliedOut.equalsIgnoreCase("yes")) {
				placeOrderOutline.applyPromoCode(baseStore, store, 200, promoCodeGet);
			} else {
				System.out.println("No promo code is applied");
			}
			placeOrderOutline.setdeliveryMode(baseStore, deliveryMode);
			if(dropshipRadioSelected.equalsIgnoreCase("yes"))
			{
				placeOrderOutline.setDropShip(baseStore,"dropShipAddress");
			}
			if (paymentTypeSelected.equals(paymentType.poOnly)) {
				paymentTypeMode = "PO";
				placeOrderOutline.updatePODetails(baseStore, "PO1234567");
			} else if (paymentTypeSelected.equals(paymentType.poWithCC)) {
				placeOrderOutline.updatePODetails(baseStore, "PO12345678");
				if (creditTypeSelected.equals(creditCardType.MasterCard)) {
					paymentTypeMode = "CC-Master";
					placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Master3", baseStore);
				} else if (creditTypeSelected.equals(creditCardType.Visa)) {
					paymentTypeMode = "CC-Visa";
					placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Visa", baseStore);
				} else if (creditTypeSelected.equals(creditCardType.Discover)) {
					paymentTypeMode = "CC-Discover";
					placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Discover", baseStore);
				} else if (creditTypeSelected.equals(creditCardType.Amex)) {
					paymentTypeMode = "CC-Amex";
					placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Amex3", baseStore);
				}

			}

			placeOrderOutline.placeOrder("B2B", baseStore, store, 200);
			Payload.clearIsbnsStoredInCurrentExecution();

		} catch (Exception e) {
			System.out.println("Exception :" + e);
			Payload.clearIsbnsStoredInCurrentExecution();
		}
	}

}
