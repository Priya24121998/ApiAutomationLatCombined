package com.cengage.b2b.orderrepository;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

@Entity(name="orderout")
public class OrderOut {

	@Id
	@GeneratedValue
	private int id;
	private String env;
	private String store;
	private String orderId;
	private String userId;
	private String account;
	private String deliveryMode;
	private String promoCode;
	private String promoCodeGet;
	private String paymentType;
	private  String date;
	public OrderOut()
	{
		
	}
	public OrderOut(int id,String orderId, String userId,String account, String deliveryMode, String paymentType, String date) {
		super();
		this.id= id;
		this.orderId = orderId;
		this.userId = userId;
		this.account = account;
		this.deliveryMode = deliveryMode;
		this.paymentType = paymentType;
		this.date = date;
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
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	
	public String getPromoCode() {
		return promoCode;
	}
	public void setPromoCode(String promoCode) {
		this.promoCode = promoCode;
	}
	public String getPromoCodeGet() {
		return promoCodeGet;
	}
	public void setPromoCodeGet(String promoCodeGet) {
		this.promoCodeGet = promoCodeGet;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStore() {
		return store;
	}
	public void setStore(String store) {
		this.store = store;
	}
	public String getEnv() {
		return env;
	}
	public void setEnv(String env) {
		this.env = env;
	}
	@Override
	public String toString() {
		return "OrderOut [id=" + id + ", env=" + env + ", store=" + store + ", orderId=" + orderId + ", userId="
				+ userId + ", account=" + account + ", deliveryMode=" + deliveryMode + ", promoCode=" + promoCode
				+ ", promoCodeGet=" + promoCodeGet + ", paymentType=" + paymentType + ", date=" + date + "]";
	}

}
