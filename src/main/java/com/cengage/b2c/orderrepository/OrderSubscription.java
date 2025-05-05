package com.cengage.b2c.orderrepository;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity(name="usersubtable")
public class OrderSubscription {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;
	private String env;
	private String userguid;
	private String deliveryMode;
	private String subscription;
	
	@Enumerated(EnumType.STRING)
	private userType userType;
	private String subscriptionDuration;
	private PaymentType paymentType;
	private CreditCardTypeB2C creditCardTypeb2c;
	private String rentalIsbn;
	
	@Enumerated(EnumType.STRING)
	private rentalType rentalType;
	
	private String initialOrder;
	private String finalOrder;
	
	public OrderSubscription(String env, String userguid, String deliveryMode, String subscription) {
		super();
		this.env = env;
		this.userguid = userguid;
		this.deliveryMode = deliveryMode;
		this.subscription = subscription;
	}
	public OrderSubscription() {
		
	}
	public String getEnv() {
		return env;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setEnv(String env) {
		this.env = env;
	}
	public String getUserguid() {
		return userguid;
	}
	public void setUserguid(String userguid) {
		this.userguid = userguid;
	}
	public String getDeliveryMode() {
		return deliveryMode;
	}
	public void setDeliveryMode(String deliveryMode) {
		this.deliveryMode = deliveryMode;
	}
	public String getSubscription() {
		return subscription;
	}
	public void setSubscription(String subscription) {
		this.subscription = subscription;
	}
	public String getsubscriptionDuration() {
		return subscriptionDuration;
	}
	public void setsubscriptionDuration(String subscriptionDuration) {
		this.subscriptionDuration = subscriptionDuration;
	}
	public userType getUserType() {
		return userType;
	}
	public void setUserType(userType userType) {
		this.userType = userType;
	}
	public PaymentType getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(PaymentType paymentType) {
		this.paymentType = paymentType;
	}
	public CreditCardTypeB2C getcreditCardTypeb2c() {
		return creditCardTypeb2c;
	}
	public void setcreditCardTypeb2c(CreditCardTypeB2C creditCardTypeb2c) {
		this.creditCardTypeb2c = creditCardTypeb2c;
	}
	public String getRentalIsbn() {
		return rentalIsbn;
	}
	public void setRentalIsbn(String rentalIsbn) {
		this.rentalIsbn = rentalIsbn;
	}
	public rentalType getRentalType() {
		return rentalType;
	}
	public void setRentalType(rentalType rentalType) {
		this.rentalType = rentalType;
	}
	public String getInitialOrder() {
		return initialOrder;
	}
	public void setInitialOrder(String initialOrder) {
		this.initialOrder = initialOrder;
	}
	public String getFinalOrder() {
		return finalOrder;
	}
	public void setFinalOrder(String finalOrder) {
		this.finalOrder = finalOrder;
	}
	@Override
	public String toString() {
		return "OrderSubscription [id=" + id + ", env=" + env + ", userguid=" + userguid + ", deliveryMode="
				+ deliveryMode + ", subscription=" + subscription + ", userType=" + userType + ", subscriptionDuration="
				+ subscriptionDuration + ", paymentType=" + paymentType + ", creditCardTypeb2c=" + creditCardTypeb2c
				+ ", rentalIsbn=" + rentalIsbn + ", rentalType=" + rentalType + ", initialOrder=" + initialOrder
				+ ", finalOrder=" + finalOrder + "]";
	}
	
	
}
