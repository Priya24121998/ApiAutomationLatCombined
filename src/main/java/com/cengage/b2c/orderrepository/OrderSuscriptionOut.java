package com.cengage.b2c.orderrepository;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity(name="usersubtableout")
public class OrderSuscriptionOut {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String env;
	private String store;
	private String orderId;
	private String subscriptionId;
	private String userId;
	private String deliveryMode;
	private String paymentType;
	private String date;
	
	@Enumerated(EnumType.STRING)
	private rentalType rentalType;
	
	private String rentalId;
	private String rentalIsbn;
	public OrderSuscriptionOut(int id, String env, String store, String orderId, String subscriptionId, String userId,
			String deliveryMode, String paymentType, String date) {
		super();
		this.id = id;
		this.env = env;
		this.store = store;
		this.orderId = orderId;
		this.subscriptionId = subscriptionId;
		this.userId = userId;
		this.deliveryMode = deliveryMode;
		this.paymentType = paymentType;
		this.date = date;
	}
	public OrderSuscriptionOut() {
	
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEnv() {
		return env;
	}
	public void setEnv(String env) {
		this.env = env;
	}
	public String getStore() {
		return store;
	}
	public void setStore(String store) {
		this.store = store;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getSubscriptionId() {
		return subscriptionId;
	}
	public void setSubscriptionId(String subscriptionId) {
		this.subscriptionId = subscriptionId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getDeliveryMode() {
		return deliveryMode;
	}
	public void setDeliveryMode(String deliveryMode) {
		this.deliveryMode = deliveryMode;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getRentalId() {
		return rentalId;
	}
	public void setRentalId(String rentalId) {
		this.rentalId = rentalId;
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
	@Override
	public String toString() {
		return "OrderSuscriptionOut [id=" + id + ", env=" + env + ", store=" + store + ", orderId=" + orderId
				+ ", subscriptionId=" + subscriptionId + ", userId=" + userId + ", deliveryMode=" + deliveryMode
				+ ", paymentType=" + paymentType + ", date=" + date + ", rentalType=" + rentalType + ", rentalId="
				+ rentalId + ", rentalIsbn=" + rentalIsbn + "]";
	}

	
	

}
