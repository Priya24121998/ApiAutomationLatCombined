package com.cengage.b2c.orderrepository;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;

@Entity(name = "b2corderout")
public class OrderOut {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String env;

	private String store;

	private String orderId;

	private String userId;

	private String deliveryMode;
	private String paymentType;
	private String promoCodeApplied;
	private String promoCode;
	private String date;

	public OrderOut() {

	}

	public OrderOut(int id, String env, String store, String orderId, String userId, String deliveryMode,
			String paymentType, String date) {
		super();
		this.id = id;
		this.env = env;
		this.store = store;
		this.orderId = orderId;
		this.userId = userId;
		this.deliveryMode = deliveryMode;
		this.paymentType = paymentType;
		this.date = date;
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

	public String getPromoCodeApplied() {
		return promoCodeApplied;
	}

	public void setPromoCodeApplied(String promoCodeApplied) {
		this.promoCodeApplied = promoCodeApplied;
	}

	public String getPromoCode() {
		return promoCode;
	}

	public void setPromoCode(String promoCode) {
		this.promoCode = promoCode;
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

	@Override
	public String toString() {
		return "OrderOut [id=" + id + ", env=" + env + ", store=" + store + ", orderId=" + orderId + ", userId="
				+ userId + ", deliveryMode=" + deliveryMode + ", paymentType=" + paymentType + ", promoCodeApplied="
				+ promoCodeApplied + ", promoCode=" + promoCode + ", date=" + date + "]";
	}

}
