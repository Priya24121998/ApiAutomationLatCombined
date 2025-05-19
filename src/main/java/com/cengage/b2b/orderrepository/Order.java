package com.cengage.b2b.orderrepository;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;


@Entity(name = "orderin")
public class Order {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@NotNull(message = "Environment cannot be null")
	@Enumerated(EnumType.STRING)
	private Environment env;

	@NotBlank(message = "User ID cannot be blank")
	private String userid;

	@NotBlank(message = "Account cannot be blank")
	@Size(min = 5, message = "Account must be at least 5 characters long")
	private String account;

	@NotBlank(message = "Delivery mode cannot be blank")
	private String deliveryMode;

	@Enumerated(EnumType.STRING)
	@NotNull(message = "Order type cannot be null")
	private OrderType orderType;

	@Enumerated(EnumType.STRING)
	@NotNull(message = "Payment type cannot be null")
	private PaymentType paymentType;

	@Enumerated(EnumType.STRING)
    @NotNull(message = "ISBN type cannot be null")
	private IsbnType isbnType;


    @Size(max = 17, message = "ISBN Physical must be 17 characters or less")
	private String isbnPhysical;

    @Size(max = 17, message = "ISBN Digital must be 17 characters or less")
	private String isbnDigital;
    

    @Size(max = 17, message = "ISBN Bundle must be 17 characters or less")
	private String isbnBundle;

	private String promoCodeApplied;
	
	private String promoCode;

	@Enumerated(EnumType.STRING)
	private CreditCardType creditCardType;

	private String addIsbnWithQuantity;

	private String otherAccount;
	
	private String dropshipRadio;

	public Order() {
	}

	public Order(int id, Environment env, String userid, String account, String deliveryMode, PaymentType paymentType) {
		super();
		this.id = id;
		this.env = env;
		this.userid = userid;
		this.account = account;
		this.deliveryMode = deliveryMode;
		this.paymentType = paymentType;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Environment getEnv() {
		return env;
	}

	public void setEnv(Environment env) {
		this.env = env;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getDeliveryMode() {
		return deliveryMode;
	}

	public void setDeliveryMode(String deliveryMode) {
		this.deliveryMode = deliveryMode;
	}

	public PaymentType getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(PaymentType paymentType) {
		this.paymentType = paymentType;
	}

	public CreditCardType getCreditCardType() {
		return creditCardType;
	}

	public void setCreditCardType(CreditCardType creditCardType) {
		this.creditCardType = creditCardType;
	}

	public IsbnType getIsbnType() {
		return isbnType;
	}

	public void setIsbnType(IsbnType isbnType) {
		this.isbnType = isbnType;
	}

	public String getIsbnPhysical() {
		return isbnPhysical;
	}

	public void setIsbnPhysical(String isbnPhysical) {
		this.isbnPhysical = isbnPhysical;
	}

	public String getIsbnDigital() {
		return isbnDigital;
	}

	public void setIsbnDigital(String isbnDigital) {
		this.isbnDigital = isbnDigital;
	}

	public OrderType getOrderType() {
		return orderType;
	}

	public void setOrderType(OrderType orderType) {
		this.orderType = orderType;
	}

	public String getIsbnBundle() {
		return isbnBundle;
	}

	public void setIsbnBundle(String isbnBundle) {
		this.isbnBundle = isbnBundle;
	}

	public String getAddIsbnWithQuantity() {
		return addIsbnWithQuantity;
	}

	public void setAddIsbnWithQuantity(String addIsbnWithQuantity) {
		this.addIsbnWithQuantity = addIsbnWithQuantity;
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

	public String getOtherAccount() {
		return otherAccount;
	}

	public void setOtherAccount(String otherAccount) {
		this.otherAccount = otherAccount;
	}

	public String getDropshipRadio() {
		return dropshipRadio;
	}

	public void setDropshipRadio(String dropshipRadio) {
		this.dropshipRadio = dropshipRadio;
	}

	@Override
	public String toString() {
		return "Order [id=" + id + ", env=" + env + ", userid=" + userid + ", account=" + account + ", deliveryMode="
				+ deliveryMode + ", orderType=" + orderType + ", paymentType=" + paymentType + ", isbnType=" + isbnType
				+ ", isbnPhysical=" + isbnPhysical + ", isbnDigital=" + isbnDigital + ", isbnBundle=" + isbnBundle
				+ ", promoCodeApplied=" + promoCodeApplied + ", promoCode=" + promoCode + ", creditCardType="
				+ creditCardType + ", addIsbnWithQuantity=" + addIsbnWithQuantity + ", otherAccount=" + otherAccount
				+ ", dropshipRadio=" + dropshipRadio + "]";
	}

}
