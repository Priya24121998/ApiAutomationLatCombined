package com.cengage.b2c.placeOrderApplication;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.cengage.b2c.orderrepository.CreditCardTypeB2C;
import com.cengage.b2c.orderrepository.Order;
import com.cengage.b2c.orderrepository.OrderOut;
import com.cengage.b2c.orderrepository.OrderRepository;
import com.cengage.b2c.orderrepository.OrderSubscription;
import com.cengage.b2c.orderrepository.OrderSuscriptionOut;
import com.cengage.b2c.orderrepository.PaymentType;
import com.cengage.b2c.orderrepository.rentalType;
import com.cengage.restActions.OrderWorkFlow;
import com.cengage.restActions.OrderWorkflowB2C;
import com.cengage.restActions.placeOrderOutline;

import jakarta.servlet.http.HttpSession;


@Service
public class OrderServiceB2C {
	
	@Autowired
	OrderRepository orderrepository;
	
	static List<String> orderList = new ArrayList<String>();

	public Order getInputData(String store)
	{
		Order order = null;
		switch (store.toUpperCase()) {
		case "B2CCA":
			order = new Order(1, "QA", "B2CCA_QA_automation_300125150930@mailinator.com", "standard-ca", PaymentType.cc,
					CreditCardTypeB2C.Visa);
			break;
		case "B2CAU":
			order = new Order(1, "QA", "3ed6b800c0c9dcb1:dce54d0:1961f725aa7:-7f5b", "standard-au", PaymentType.cc,
					CreditCardTypeB2C.Visa);
			break;
		case "B2CNZ":
			order = new Order(1, "QA", "test123_251124114947@yopyy123.wwwrr", "standard-nz", PaymentType.cc,
					CreditCardTypeB2C.Visa);
			break;
		case "B2CEMEA":
			order = new Order(1, "QA", "b2cemea_qa_automation_200225131428@mailinator.com", "standard-emea", PaymentType.cc,
					CreditCardTypeB2C.Visa);
			break;
		case "B2CUS":
			order = new Order(1, "QA", "B2CUS_QA_automation_240724151148@mailinator.com", "standard-us", PaymentType.cc,
					CreditCardTypeB2C.Visa);
			break;
		default:
			throw new IllegalArgumentException("Invalid store: " + store);
		}
		
		return order;
		
	}
	public void setBaseStore(String store) {
		switch (store.toUpperCase()) {
		case "B2CCA":
			OrderPlacementControllerB2C.baseStore = "cengage-b2c-ca";
			break;
		case "B2CAU":
			OrderPlacementControllerB2C.baseStore = "cengage-b2c-au";
			break;
		case "B2CNZ":
			OrderPlacementControllerB2C.baseStore = "cengage-b2c-nz";
			break;
		case "B2CEMEA":
			OrderPlacementControllerB2C.baseStore = "cengage-b2c-emea";
			break;
		case "B2CUS":
			OrderPlacementControllerB2C.baseStore = "cengage-b2c-us";
			break;
		default:
			throw new IllegalArgumentException("Invalid store: " + store);
		}

	}
	
	public void setCreditCardType(CreditCardTypeB2C creditCardType) {
        if (creditCardType != null) {
        	OrderPlacementControllerB2C.creditTypeSelected = creditCardType;
        }
    }

	public OrderOut createOrderOut(String userId, PaymentType paymentType) {
		OrderOut order = new OrderOut();
		order.setStore(OrderPlacementControllerB2C.baseStore);
		order.setEnv(OrderPlacementControllerB2C.environmentSelected);
		order.setOrderId(placeOrderOutline.OrderID);
		order.setUserId(userId != null ? userId : placeOrderOutline.userID);
		order.setPromoCodeApplied(OrderPlacementControllerB2C.promoCodeAppliedValue);
		order.setPromoCode(OrderPlacementControllerB2C.promoCodeValue);
		order.setPaymentType(OrderPlacementControllerB2C.paymentTypeSelected.toString());
		order.setDeliveryMode(OrderPlacementControllerB2C.deliveryModeSelected);
		order.setDate(OrderWorkFlow.getCurrentTimestamp());
		return order;
	}

	public void setPaymentType(PaymentType paymentType) {
		 if (paymentType != null) {
	        	OrderPlacementControllerB2C.paymentTypeSelected = paymentType;
	        }
		
	}
	
	public List<String> getPhysicalISBNs(String store) {

		System.out.println("Store value stored in session : " + store);
		OrderPlacementControllerB2C.storeTypeSelected = store;

		List<String> phyIsbn = null;
		switch (OrderPlacementControllerB2C.storeTypeSelected ) {
		case "B2CAU":
			phyIsbn = Arrays.asList("9780357431948@@NA");
			break;
		case "B2CNZ":
			phyIsbn = Arrays.asList("9780170416771@@NA");
			break;
		case "B2CEMEA":
			phyIsbn = Arrays.asList("9781285743141@@NA");
			break;
		case "B2CCA":
			phyIsbn = Arrays.asList("9781305094765@@NA");
			break;
		case "B2CUS":
			phyIsbn = Arrays.asList("9781305961135@@CU");
			break;
		default:
			phyIsbn = new ArrayList<>();
		}
		return phyIsbn;
	}

	public List<String> getDigitalISBNs(String store) {
		System.out.println("Store value stored in session : " + store);
		OrderPlacementControllerB2C.storeTypeSelected  = store;

		List<String> digIsbn = null;
		switch (OrderPlacementControllerB2C.storeTypeSelected) {
		case "B2CAU":
			digIsbn = Arrays.asList("9781473765870@@1825D", "9780170421294@@1800D");
			break;
		case "B2CNZ":
			digIsbn = Arrays.asList("9780357710852@@1825D", "9780170421294@@1800D");
			break;
		case "B2CEMEA":
			digIsbn = Arrays.asList("9781285946382@@720D", "9780357439159@@360D");
			break;
		case "B2CCA":
			digIsbn = Arrays.asList("9781473765870@@1825D", "9780176599201@@360D");
			break;
		case "B2CUS":
			digIsbn = Arrays.asList("9780176482060@@180D");
			break;
		default:
			digIsbn = new ArrayList<>();
		}
		return digIsbn;
	}

	public List<String> getBundleISBNs() {
		return Arrays.asList("2233445566", "6677889900");
	}
	public OrderSuscriptionOut createSubOutData(String userId, PaymentType paymentType,rentalType rentalType,String rentalIsbn) {
		
		OrderSuscriptionOut order = new OrderSuscriptionOut();
		order.setStore(OrderPlacementControllerB2C.baseStore);
		order.setEnv(OrderPlacementControllerB2C.environmentSelected);
		order.setOrderId(placeOrderOutline.OrderID);
		order.setUserId(userId != null ? userId : placeOrderOutline.userID);
		order.setSubscriptionId(OrderWorkflowB2C.subscriptionId);
		order.setRentalType(rentalType);
		order.setRentalIsbn(rentalIsbn);
		order.setRentalId(placeOrderOutline.rentalID);
		order.setPaymentType(OrderPlacementControllerB2C.paymentTypeSelected.toString());
		order.setDeliveryMode(OrderPlacementControllerB2C.deliveryModeSelected);
		order.setDate(OrderWorkFlow.getCurrentTimestamp());
		return order;
	}
	


//	

}
