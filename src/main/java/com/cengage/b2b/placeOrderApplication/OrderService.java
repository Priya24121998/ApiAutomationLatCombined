/**
 * The {@code OrderService} class is part of the Place Order Application module.
 * This class is responsible for handling the business logic related to order processing.
 * It provides methods to manage and process customer orders in the system.
 *
 * <p>Package: {@code com.cengage.b2b.placeOrderApplication}</p>
 *
 * <p>Usage:</p>
 * <pre>
 * {@code
 * OrderService orderService = new OrderService();
 * orderService.processOrder(order);
 * }
 * </pre>
 *
 * <p>Note: Ensure that all dependencies required for order processing are properly configured.</p>
 */
package com.cengage.b2b.placeOrderApplication;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cengage.b2b.orderrepository.CreditCardType;
import com.cengage.b2b.orderrepository.Environment;
import com.cengage.b2b.orderrepository.IsbnType;
import com.cengage.b2b.orderrepository.Order;
import com.cengage.b2b.orderrepository.OrderOut;
import com.cengage.b2b.orderrepository.OrderRepository;
import com.cengage.b2b.orderrepository.OrderType;
import com.cengage.b2b.orderrepository.PaymentType;
import com.cengage.restActions.OrderWorkFlow;
import com.cengage.restActions.placeOrderOutline;


@Service
public class OrderService {
	
	@Autowired
    private OrderRepository orderRepository;
	public static int orderCount=0;
	private static List<Order> ordertestdata = new ArrayList();
	private static List<OrderOut> ordertestoutdata = new ArrayList();
	private static int count =1;
	
	
	
	public List<Order> getOrderHistory() {
		
		return orderRepository.findAll();
	}

    
    public List<String> getStaticAccounts(String store) {
		switch (store) {
		case "B2BCA":
			return List.of("0100159015", "0100135740","0100109380","0100114534","84000381");
		case "B2BUS":
			return List.of("0100159146", "0100163833","0100114420","4198424");
		case "B2BGT":
			return List.of("0100182537", "0100177038","0100112405","375223");
		default:
			throw new IllegalArgumentException("Invalid store: " + store);
		}
	}
    
    public OrderOut createOrderOut(String userId, String accountNo, String promocode,String paymentTypeMode) {
		OrderOut order = new OrderOut();
		order.setStore(OrderPlacementController.storeToBeSelected);
		order.setEnv(OrderPlacementController.environmentSelected);
		order.setOrderId(OrderWorkFlow.OrderID);
		order.setUserId(userId != null ? userId : placeOrderOutline.userID);
		order.setAccount(accountNo);
		order.setPromoCode(OrderPlacementController.promoCodeAppliedOut);
		if(OrderPlacementController.promoCodeAppliedOut.equalsIgnoreCase("yes"))
		{
			order.setPromoCodeGet(OrderPlacementController.promoCodeGet);
			
		}
		order.setPaymentType(paymentTypeMode);
		order.setDeliveryMode(OrderPlacementController.deliveryModeSelected);
		order.setDate(OrderWorkFlow.getCurrentTimestamp());
		return order;
	}
    
    public void setOrderType(OrderType ordertype) {
        if (ordertype != null) {
            OrderPlacementController.orderTypeSelected = ordertype;
        }
    }
	
	public void setPaymentType(PaymentType paymentType) {
        if (paymentType != null) {
        	OrderPlacementController.paymentTypeSelected = paymentType;
        }
    }

	public void setCreditCardType(CreditCardType creditCardType) {
        if (creditCardType != null) {
        	OrderPlacementController.creditTypeSelected = creditCardType;
        }
    }
	
	
	public Order createOrder(String store, String userId, PaymentType paymentType) {
		if (paymentType != null) {
			OrderPlacementController.paymentTypeSelected = paymentType;
		}
		switch (store) {
		case "B2BUS":
			OrderPlacementController.storeToBeSelected = store;
			return new Order(1, Environment.QA,userId != null ? userId : "b2bus_qa_automation_itrro_100225063533@mailinator.com",
					"0100159146", "GD", OrderPlacementController.paymentTypeSelected);
		case "B2BCA":
			OrderPlacementController.storeToBeSelected = store;
			return new Order(2,Environment.QA, userId != null ? userId : "B2BCA_qa_automation_0100159015_lat@mailinator.com",
					"0100159015", "GD", OrderPlacementController.paymentTypeSelected);
		case "B2BGT":
			OrderPlacementController.storeToBeSelected = store;
			return new Order(3,Environment.QA, userId != null ? userId : "galenew_qa_automation_hgqsv_210225063439@mailinator.com",
					"0100182537", "GD", OrderPlacementController.paymentTypeSelected);
		default:
			throw new IllegalArgumentException("Invalid store: " + store);
		}
	}
	
	public void setBaseStore(String store) {
		switch (store.toUpperCase()) {
		case "B2BCA":
			OrderPlacementController.baseStore = "cengage-b2b-ca";
			break;
		case "B2BGT":
			OrderPlacementController.baseStore = "cengage-b2b-gt";
			break;
		case "B2BUS":
			OrderPlacementController.baseStore = "cengage-b2b-us";
			break;
		default:
			throw new IllegalArgumentException("Invalid store: " + store);
		}
	}



	public void setIsbnType(IsbnType isbnType) {
        if (isbnType != null) {
        	OrderPlacementController.isbnTypeSelected = isbnType;
        }
    }

	public void setDeliveryMode(String deliveryMode) {
		
		 if (deliveryMode != null) {
	        	OrderPlacementController.deliveryModeSelected = deliveryMode;
	        }
	}

	
	
	
	

}
