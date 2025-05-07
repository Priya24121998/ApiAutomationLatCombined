package com.cengage.b2c.placeOrderApplication;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cengage.b2b.validations.OrderPlacementException;
import com.cengage.b2c.orderrepository.CreditCardTypeB2C;
import com.cengage.b2c.orderrepository.IsbnType;
import com.cengage.b2c.orderrepository.Order;
import com.cengage.b2c.orderrepository.OrderOut;
import com.cengage.b2c.orderrepository.OrderOutRepository;
import com.cengage.b2c.orderrepository.OrderRepository;
import com.cengage.b2c.orderrepository.OrderSubscription;
import com.cengage.b2c.orderrepository.OrderSubscriptionRespository;
import com.cengage.b2c.orderrepository.OrderSuscriptionOut;
import com.cengage.b2c.orderrepository.PaymentType;
import com.cengage.b2c.orderrepository.rentalType;
import com.cengage.b2c.orderrepository.userType;
import com.cengage.common.Payload;
import com.cengage.common.PropFileHandler;
import com.cengage.restActions.BaseClass;
import com.cengage.restActions.OrderWorkFlow;
import com.cengage.restActions.OrderWorkflowB2C;
import com.cengage.restActions.placeOrderOutline;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class OrderPlacementControllerB2C {

	private static final Logger logger = LoggerFactory.getLogger(OrderPlacementControllerB2C.class);
	public OrderRepository orderrepository;
	public OrderOutRepository orderoutrepository;
	public static String environmentSelected;
	public static CreditCardTypeB2C creditTypeSelected = null;
	public static String baseStore;
	public static PaymentType paymentTypeSelected;
	public static String storeTypeSelected;
	public static String deliveryModeSelected;
	public static String isbnTypeSelected;
	public static String isbnSelected;
	public static String userId;
	public PropFileHandler prop;
	public OrderOut orderout;
	public OrderSuscriptionOut ordersub;
	public static String orderTypeSelected;
	public static String promoCodeAppliedValue;
	public static String promoCodeValue;
	public static org.json.JSONObject addProdReqPayload = null;

	private OrderServiceB2C orderservice;
	public OrderSubscriptionRespository ordersubRespository;

	public OrderPlacementControllerB2C(OrderServiceB2C orderservice, OrderRepository orderin,
			OrderOutRepository orderoutrepo, OrderSubscriptionRespository ordersubRespository) {
		this.orderservice = orderservice;
		this.orderrepository = orderin;
		this.orderoutrepository = orderoutrepo;
		this.ordersubRespository = ordersubRespository;
	}

	@RequestMapping("/homePage")
	public String homePage() {
		return "homePageB2C";
	}

	@RequestMapping("/placeOrderB2CHome")
	public String placeOrderPageGet(ModelMap model, @RequestParam String store, HttpSession session) {
		session.setAttribute("store", store);
		model.addAttribute("physicalISBNs", orderservice.getPhysicalISBNs(store));
		model.addAttribute("digitalISBNs", orderservice.getDigitalISBNs(store));
		model.addAttribute("placeOrderB2C", orderservice.getInputData(store));
		return "placeOrderB2C";
	}

	@PostMapping("/placeOrderB2CHome")
	public String placeOrderPageAction(@RequestParam("store") String store,
			@RequestParam(value = "env", required = false) String env,
			@RequestParam(value = "userid", required = false) String userId,
			@RequestParam(value = "deliveryMode", required = false) String deliveryMode,
			@RequestParam(value = "isbnType", required = false) IsbnType isbnType,
			@RequestParam(value = "physicalISBN", required = false) String physicalISBN,
			@RequestParam(value = "digitalISBN", required = false) String digitalISBN,
			@RequestParam(value = "bundleISBN", required = false) String bundleISBN,
			@RequestParam(value = "otherISBN", required = false) String otherISBN,
			@RequestParam(value = "combined", required = false) String combined,
			@RequestParam(value = "multipleProd", required = false) String multipleProd,
			@RequestParam(value = "promoCodeApplied", required = false) String promoCodeApplied,
			@RequestParam(value = "promoCode", required = false) String promoCode,
			@RequestParam(value = "paymentType", required = false) PaymentType paymentType,
			@RequestParam(value = "creditCardType", required = false) CreditCardTypeB2C creditCardType, ModelMap model,
			@Valid @ModelAttribute("placeOrderB2C") Order orderobj, BindingResult result) {

		if (result.hasErrors()) {
			model.addAttribute("errorMessage", "Validation errors found!");
			return "placeOrderB2C";
		}

		promoCodeValue = null;
		storeTypeSelected = store;
		orderobj.setEnv(env);
		environmentSelected = env;

		orderobj.setUserid(userId);
		orderobj.setDeliveryMode(deliveryMode);
		deliveryModeSelected = deliveryMode;

		orderobj.setIsbnType(isbnType);
		isbnTypeSelected = isbnType.toString();
		if (isbnType.equals(IsbnType.physical)) {
			orderobj.setPhysicalISBN(physicalISBN);
			isbnSelected = physicalISBN;
		} else if (isbnType.equals(IsbnType.digital)) {
			orderobj.setDigitalISBN(digitalISBN);
			isbnSelected = digitalISBN;
		} else if (isbnType.equals(IsbnType.bundle)) {
			orderobj.setBundleISBN(bundleISBN);
			isbnSelected = bundleISBN;
		} else if (isbnType.equals(IsbnType.other)) {
			orderobj.setOtherISBN(otherISBN);
			isbnSelected = otherISBN;
		}else if (isbnType.equals(IsbnType.combined)) {
			addProdReqPayload = Payload.multipleIsbnAndQuantityGetAndCreatePayloadB2C(multipleProd);
		}

		orderservice.setBaseStore(store);
		orderobj.setPromoCodeApplied(promoCodeApplied);
		promoCodeAppliedValue =promoCodeApplied;
		if(promoCodeApplied.equalsIgnoreCase("yes"))
		{
			orderobj.setPromoCode(promoCode);
			promoCodeValue = promoCode;
			
		}
		orderservice.setPaymentType(paymentType);
		if (paymentType.equals(PaymentType.cc)) {
			orderservice.setCreditCardType(creditCardType);
		}

		logger.info("--------------------Place Order Values section before update-------------------");
		logger.info(String.format("Environment Selected: %s", environmentSelected));
		logger.info(String.format("User id selected: %s", userId));
		logger.info(String.format("Payment type selected: %s", paymentType));
		logger.info(String.format("Creditcard type selected: %s", creditCardType));

		orderrepository.save(orderobj);

		try {
			BaseClass.initializeEnvConditionsBeforeOrderExecution();
			initializationSetTobeDoneForOutParameters();
			executeOrderWorkflow(store, userId, paymentType, creditCardType);
			logger.info("--------------------Place Order Values section after order creation-------------------");
			logger.info(String.format("Environment Selected: %s", environmentSelected));
			logger.info(String.format("User id selected: %s", userId));
			logger.info(String.format("Payment type selected: %s", paymentType));
			logger.info(String.format("Creditcard type selected: %s", creditCardType));
			logger.info(String.format("Order Id: %s", placeOrderOutline.OrderID));

			if (OrderWorkFlow.OrderID != null) {
				model.addAttribute("successMessage", "Order placed successfully!");

			} else {
				model.addAttribute("errorMessage", "Failed to place order. Please try again.");

			}
			model.addAttribute("placeOrderB2C", orderobj);

			try {
				if (OrderWorkFlow.OrderID != null) {
					orderout = orderservice.createOrderOut(userId, paymentType);
					orderoutrepository.save(orderout);
					model.addAttribute("orderMessageb2cAtt", orderout);
				} else {
					model.addAttribute("errorMessage", "Failed to place order. Please try again");
					return "orderMessageb2c";
				}
			} catch (Exception e) {
				model.addAttribute("errorMessage", "Failed to place order. Please try again. Exception : " + e);
				return "orderMessageb2c";
			}

			model.addAttribute("successMessage", "Order placed successfully!");
			model.addAttribute("placeOrderB2C", orderobj);
			return "orderMessageb2c";

		} catch (Exception e) {

			model.addAttribute("errorMessage", "Failed to place order. Please try again.");
			throw new OrderPlacementException("Failed to place order due to exception" + e);
		}

	}

	@RequestMapping("/b2corderHistory")
	public Object showOrderHistory(ModelMap model, @Valid @ModelAttribute("b2corderHistory") OrderOut orderOut) {
		List<OrderOut> orderHistory = orderoutrepository.findAll();
		model.addAttribute("b2corderHistory", orderHistory);
		ResponseEntity.ok(orderHistory);
		return "b2cOrderHistory";
	}

	@GetMapping("/b2cExportOrderDetails")
	@ResponseBody
	public void exportOrderDetails(HttpServletResponse response) throws IOException {
		response.setContentType("text/csv");
		response.setHeader("Content-Disposition", "attachment; filename=\"order_details.csv\"");
		PrintWriter writer = response.getWriter();
		writer.println("ID,Environment,Store,Order ID,User ID,Delivery Mode, Promo Code Applied, Promo code, Payment Type,Date");

		List<OrderOut> orderOutHistory = orderoutrepository.findAll();

		for (OrderOut orderOutData : orderOutHistory) {
			writer.println(orderOutData.getId() + "," + orderOutData.getEnv() + "," + orderOutData.getStore() + ","
					+ orderOutData.getOrderId() + "," + orderOutData.getUserId() + "," + orderOutData.getDeliveryMode()
					+ "," + orderOutData.getPromoCodeApplied()+  "," + orderOutData.getPromoCode()+"," + orderOutData.getPaymentType() + "," + orderOutData.getDate());
		}

		writer.flush();
		writer.close();
	}

	@GetMapping("/subscriptionCreation")
	public String subPageGet(ModelMap model, @RequestParam String store) {
		OrderSubscription subObj = new OrderSubscription();
		subObj.setEnv("QA");
		subObj.setDeliveryMode("standard-us");
		subObj.setUserguid("d8a5983c133d1001:-55c06711:19641f9b02c:-3159");
		model.addAttribute("placeOrderB2CSub", subObj);
		return "subscriptionCreation";
	}

	@PostMapping("/subscriptionCreation")
	public String subPagePost(@RequestParam String store, @RequestParam(value = "env", required = false) String env,
			@RequestParam(value = "userguid", required = false) String userguid,
			@RequestParam(value = "deliveryMode", required = false) String deliveryMode,
			@RequestParam(value = "userType", required = false) userType userType,
			@RequestParam(value = "subscription", required = false) String subscription,
			@RequestParam(value = "subscriptionDuration", required = false) String subscriptionDuration,
			@RequestParam(value = "paymentType", required = false) PaymentType paymentType,
			@RequestParam(value = "creditCardTypeb2c", required = false) CreditCardTypeB2C creditCardType,
			@RequestParam(value = "rentalIsbn", required = false) String rentalIsbn,
			@RequestParam(value = "rentalType", required = false) rentalType rentalType,
			@RequestParam(value = "initialOrder", required = false) String initialOrder,
			@RequestParam(value = "finalOrder", required = false) String finalOrder, ModelMap model,
			@Valid OrderSubscription sub, BindingResult result) {

		sub.setEnv(env);
		sub.setUserguid(userguid);
		sub.setDeliveryMode(deliveryMode);
		sub.setSubscription(subscription);
		sub.setsubscriptionDuration(subscriptionDuration);
		System.out.println(subscriptionDuration);
		sub.setUserType(userType);
		sub.setPaymentType(paymentType);
		sub.setInitialOrder(initialOrder);

		if (initialOrder.equalsIgnoreCase("yes")) {
			sub.setRentalIsbn(rentalIsbn);
		}

		sub.setFinalOrder(finalOrder);

		if (finalOrder.equalsIgnoreCase("yes")) {
			sub.setRentalType(rentalType);
		}

		orderservice.setBaseStore(store);
		orderservice.setPaymentType(paymentType);
		deliveryModeSelected = deliveryMode;

		System.out.println("paymentType: " + paymentType);
		if (paymentType.equals(PaymentType.cc)) {
			sub.setcreditCardTypeb2c(creditCardType);
			orderservice.setCreditCardType(creditCardType);
			System.out.println("Credit card: " + OrderPlacementControllerB2C.creditTypeSelected);
		}

		environmentSelected = env;
		orderTypeSelected = "subscription";
		try {
			BaseClass.initializeEnvConditionsBeforeOrderExecution();
			initializationSetTobeDoneForOutParameters();
			executeOrderWorkflowSubscription(store, userguid, userType, subscription, subscriptionDuration,
					initialOrder, finalOrder, rentalIsbn, rentalType, paymentType, creditCardType);
			model.addAttribute("placeOrderB2CSub", sub);

			try {
				if (OrderWorkFlow.OrderID != null) {
					ordersub = orderservice.createSubOutData(userId, paymentType, rentalType, rentalIsbn);
					model.addAttribute("subscriptionMessageAtt", ordersub);
					ordersubRespository.save(ordersub);
				} else {
					model.addAttribute("errorMessage", "Failed to place order. Please try again");
					return "subscriptionCreationPostExe";
				}
			} catch (Exception e) {
				model.addAttribute("errorMessage", "Failed to place order. Please try again. Exception : " + e);
				return "subscriptionCreationPostExe";
			}

			model.addAttribute("successMessage", "Order placed successfully!");
			model.addAttribute("placeOrderB2CSub", orderout);
			return "subscriptionCreationPostExe";

		} catch (Exception e) {

			model.addAttribute("errorMessage", "Failed to place order. Please try again.");
			throw new OrderPlacementException("Failed to place order due to exception" + e);
		}

	}

	private void initializationSetTobeDoneForOutParameters() {
		OrderWorkflowB2C.OrderID = null;
		OrderWorkflowB2C.subscriptionId = null;
		placeOrderOutline.rentalID = null;
		


	}

	@RequestMapping("/b2cSuborderHistory")
	public Object showSubOrderHistory(ModelMap model, @Valid @ModelAttribute("b2cSuborderHistory") OrderOut orderOut) {
		List<OrderSuscriptionOut> orderHistory = ordersubRespository.findAll();
		model.addAttribute("b2cSuborderHistory", orderHistory);
		ResponseEntity.ok(orderHistory);
		return "b2cSubOrderHistory";
	}

	@GetMapping("/b2cSubExportOrderDetails")
	@ResponseBody
	public void exportSubOrderDetails(HttpServletResponse response) throws IOException {
		response.setContentType("text/csv");
		response.setHeader("Content-Disposition", "attachment; filename=\"order_details.csv\"");
		PrintWriter writer = response.getWriter();
		writer.println(
				"ID,Environment,Store,Order ID,Subscription Id,Rental Type, Rental Isbn,Rental Id,User ID,Delivery Mode, Payment Type,Date");

		List<OrderSuscriptionOut> orderOutHistory = ordersubRespository.findAll();

		for (OrderSuscriptionOut orderOutData : orderOutHistory) {
			writer.println(orderOutData.getId() + "," + orderOutData.getEnv() + "," + orderOutData.getStore() + ","
					+ orderOutData.getOrderId() + "," + orderOutData.getSubscriptionId() + " "
					+ orderOutData.getRentalType() + " " + orderOutData.getRentalIsbn() + " "
					+ orderOutData.getRentalId() + " " + orderOutData.getUserId() + "," + orderOutData.getDeliveryMode()
					+ "," + orderOutData.getPaymentType() + "," + orderOutData.getDate());
		}

		writer.flush();
		writer.close();
	}

	// Helper methods

	public void executeOrderWorkflow(String store, String userId, PaymentType paymentType,
			CreditCardTypeB2C creditCardType) {
		try {
			placeOrderOutline.createCart(userId, baseStore, store, 201);
			if(isbnTypeSelected.equalsIgnoreCase("combined"))
			{
				try {
					placeOrderOutline.addProdToCartFastPacedB2C(baseStore, store, 200, addProdReqPayload);
				} catch (Exception e) {
					System.out.println("Exception :" + e);
					Payload.clearIsbnsStoredInCurrentExecution();

				}
			}
			else
			{
			placeOrderOutline.addB2CProductToCart(baseStore);
			}
			if (baseStore.equals("cengage-b2c-au")) {
				placeOrderOutline.addBillingAddressToCart(baseStore, "AU_address");
				placeOrderOutline.addDeliveryAddressToCart(baseStore, "AU_address");
				placeOrderOutline.getDeliveryModes(baseStore);
				placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-au");
			} else if (baseStore.equals("cengage-b2c-nz")) {
				placeOrderOutline.addBillingAddressToCart(baseStore, "NZ_address");
				placeOrderOutline.addDeliveryAddressToCart(baseStore, "NZ_address");
				placeOrderOutline.getDeliveryModes(baseStore);
				placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-nz");
			} else if (baseStore.equals("cengage-b2c-ca")) {
				placeOrderOutline.addBillingAddressToCart(baseStore, "CA_address");
				placeOrderOutline.addDeliveryAddressToCart(baseStore, "CA_address");
				placeOrderOutline.getDeliveryModes(baseStore);
				placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-ca");
			} else if (baseStore.equals("cengage-b2c-emea")) {
				placeOrderOutline.addBillingAddressToCart(baseStore, "emea_address");
				placeOrderOutline.addDeliveryAddressToCart(baseStore, "emea_address");
				placeOrderOutline.getDeliveryModes(baseStore);
				placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-emea");
			} else if (baseStore.equals("cengage-b2c-us")) {

				placeOrderOutline.addBillingAddressToCart(baseStore, "Taxable_Address");
				placeOrderOutline.addDeliveryAddressToCart(baseStore, "Taxable_Address");
				placeOrderOutline.getDeliveryModes(baseStore);
				placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-us");
			}
			
			if((promoCodeAppliedValue.equalsIgnoreCase("yes"))&& (promoCodeValue!=null))
			{
				placeOrderOutline.applyVouchers(promoCodeValue,baseStore);
			}

			if (paymentTypeSelected.equals(paymentType.cc)) {
				if (creditTypeSelected.equals(creditCardType.MasterCard)) {
					placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Master3", baseStore);
				} else if (creditTypeSelected.equals(creditCardType.Visa)) {
					placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Visa", baseStore);
				} else if (creditTypeSelected.equals(creditCardType.Discover)) {
					placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Discover", baseStore);
				} else if (creditTypeSelected.equals(creditCardType.Amex)) {
					placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Amex3", baseStore);
				}
				placeOrderOutline.placeOrder("B2C", baseStore, store, 201);
			} else if (paymentTypeSelected.equals(paymentType.paypal)) {
				placeOrderOutline.launchFullAuthNewPaypalURLForB2C(baseStore, 200);
				placeOrderOutline.verifyPayPalPortalHasLaunched();
				placeOrderOutline.completeFullAuthNewPaypalTransaction();
				placeOrderOutline.placeOrderUsingPaypalNewFullAuth(baseStore, 200);
			}

			Payload.clearIsbnsStoredInCurrentExecution();

		} catch (Exception e) {
			System.out.println("Exception :" + e);
			Payload.clearIsbnsStoredInCurrentExecution();
		}
	}

	public void executeOrderWorkflowSubscription(String store, String userId, userType userType, String subscription,
			String subscriptionDuration, String initialOrder, String finalOrder, String rentalIsbn,
			rentalType rentalType, PaymentType paymentType, CreditCardTypeB2C creditCardType) {
		try {
			if (userType.equals(userType.create)) {
				// placeOrderOutline.createNewUserAndActivateUser("B2CUS");
				// userId= OrderWorkflowB2C.userID;
				placeOrderOutline.createB2CUserUsingSAPApi("B2CUS");
				userId = placeOrderOutline.userID;

			}
			if (subscription.equalsIgnoreCase("yes")) {
				placeOrderOutline.createCart(userId, baseStore, store, 201);
				placeOrderOutline.addProductToCart(userId, subscriptionDuration);
				if (baseStore.equals("cengage-b2c-au")) {
					placeOrderOutline.addBillingAddressToCart(baseStore, "AU_address");
					placeOrderOutline.addDeliveryAddressToCart(baseStore, "AU_address");
					placeOrderOutline.getDeliveryModes(baseStore);
					placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-au");
				} else if (baseStore.equals("cengage-b2c-nz")) {
					placeOrderOutline.addBillingAddressToCart(baseStore, "NZ_address");
					placeOrderOutline.addDeliveryAddressToCart(baseStore, "NZ_address");
					placeOrderOutline.getDeliveryModes(baseStore);
					placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-nz");
				} else if (baseStore.equals("cengage-b2c-ca")) {
					placeOrderOutline.addBillingAddressToCart(baseStore, "CA_address");
					placeOrderOutline.addDeliveryAddressToCart(baseStore, "CA_address");
					placeOrderOutline.getDeliveryModes(baseStore);
					placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-ca");
				} else if (baseStore.equals("cengage-b2c-emea")) {
					placeOrderOutline.addBillingAddressToCart(baseStore, "emea_address");
					placeOrderOutline.addDeliveryAddressToCart(baseStore, "emea_address");
					placeOrderOutline.getDeliveryModes(baseStore);
					placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-emea");
				} else if (baseStore.equals("cengage-b2c-us")) {

					placeOrderOutline.addBillingAddressToCart(baseStore, "Taxable_Address");
					placeOrderOutline.addDeliveryAddressToCart(baseStore, "Taxable_Address");
					placeOrderOutline.getDeliveryModes(baseStore);
					placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-us");
				}

				if (paymentTypeSelected.equals(paymentType.cc)) {
					if (creditTypeSelected.equals(creditCardType.MasterCard)) {
						placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Master3", baseStore);
					} else if (creditTypeSelected.equals(creditCardType.Visa)) {
						placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Visa", baseStore);
					} else if (creditTypeSelected.equals(creditCardType.Discover)) {
						placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Discover", baseStore);
					} else if (creditTypeSelected.equals(creditCardType.Amex)) {
						placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Amex3", baseStore);
					}
					placeOrderOutline.placeOrder("B2C", baseStore, store, 201);
				} else if (paymentTypeSelected.equals(paymentType.paypal)) {
					placeOrderOutline.launchFullAuthNewPaypalURLForB2C(baseStore, 200);
					placeOrderOutline.verifyPayPalPortalHasLaunched();
					placeOrderOutline.completeFullAuthNewPaypalTransaction();
					placeOrderOutline.placeOrderUsingPaypalNewFullAuth(baseStore, 200);
				}

				placeOrderOutline.logTestData("subscription");

			}

			if (initialOrder.equalsIgnoreCase("yes")) {
				placeOrderOutline.createCart(userId, baseStore, store, 201);
				isbnSelected = rentalIsbn;
				placeOrderOutline.addB2CProductToCart(baseStore);
				placeOrderOutline.addBillingAddressToCart(baseStore, "Taxable_Address");
				placeOrderOutline.addDeliveryAddressToCart(baseStore, "Taxable_Address");
				placeOrderOutline.getDeliveryModes(baseStore);
				placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-us");
				placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Amex3", baseStore);
				placeOrderOutline.placeOrder("B2C", baseStore, store, 201);
				placeOrderOutline.checkRentalPlanID("75.0");
				placeOrderOutline.verifyRentalStatus("ORDERED");
			}

			if (finalOrder.equalsIgnoreCase("yes")) {
				placeOrderOutline.userShouldBeAbleToShipRental();
				placeOrderOutline.verifyRentalStatus("ACTIVE");
				placeOrderOutline.createCart(userId, baseStore, store, 201);
				if (rentalType.equals(rentalType.extension15)) {
					placeOrderOutline.extendRentalForDays("15");

				}
				if (rentalType.equals(rentalType.extension30)) {
					placeOrderOutline.extendRentalForDays("30");
				}

				if (rentalType.equals(rentalType.goodState)) {
					placeOrderOutline.returnOfTextbookAndModifyRentalStateAccordingly("GOOD");
					placeOrderOutline.verifyRentalStatus("GOOD");
					placeOrderOutline.logTestData("rentals");
				}

				if (rentalType.equals(rentalType.badState)) {
					placeOrderOutline.returnOfTextbookAndModifyRentalStateAccordingly("BAD");
					placeOrderOutline.verifyRentalStatus("BAD");
					placeOrderOutline.logTestData("rentals");
				}

				if (rentalType.equals(rentalType.buyout)) {
					placeOrderOutline.rentalBuyout();
				}

				if (rentalType.equals(rentalType.extension30) || rentalType.equals(rentalType.extension15)
						|| rentalType.equals(rentalType.buyout)) {
					placeOrderOutline.addBillingAddressToCart(baseStore, "Taxable_Address");
					placeOrderOutline.addDeliveryAddressToCart(baseStore, "Taxable_Address");
					placeOrderOutline.getDeliveryModes(baseStore);
					placeOrderOutline.putB2CDeliveryModes(baseStore, "standard-us");
					placeOrderOutline.launchCyberSourceAndCompleteCCPayment("Amex3", baseStore);
					placeOrderOutline.placeOrder("B2C", baseStore, store, 201);
					if (rentalType.equals(rentalType.extension15) || rentalType.equals(rentalType.extension30)) {
						placeOrderOutline.verifyRentalStatus("ACTIVE");
						placeOrderOutline.getRentalEndDate();
						if (rentalType.equals(rentalType.extension15)) {
							placeOrderOutline.checkIsRentalExtended(15);
						} else if (rentalType.equals(rentalType.extension30)) {
							placeOrderOutline.checkIsRentalExtended(30);
						}

					}
				}

			}
			else if (finalOrder.equalsIgnoreCase("no")) {
				rentalType = rentalType.noRentalTypeSelected;
			}
			Payload.clearIsbnsStoredInCurrentExecution();

		} catch (Exception e) {
			System.out.println("Exception :" + e);
			Payload.clearIsbnsStoredInCurrentExecution();
		}
	}

}
