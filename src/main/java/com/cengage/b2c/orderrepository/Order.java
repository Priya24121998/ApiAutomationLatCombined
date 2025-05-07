package com.cengage.b2c.orderrepository;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity(name="b2cusertable")
public class Order {
	

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@NotBlank(message = "Environment cannot be blank")
	private String env;
	
	@NotBlank(message = "User Id cannot be blank")
	private String userid;
	
	@Enumerated(EnumType.STRING)
	@NotNull(message = "Payment type cannot be null")
	private PaymentType paymentType;
	
	@NotBlank(message = "Delivery Mode cannot be blank")
	private String deliveryMode;
	
	@Enumerated(EnumType.STRING)
	@NotNull(message = "ISBN type cannot be null")
	private IsbnType isbnType;
	
	private CreditCardTypeB2C creditCardType;
	private String physicalISBN;
	private String digitalISBN;
	private String bundleISBN;
	private String otherISBN;
	private String multipleProd;
	private String promoCodeApplied;
	private String promoCode;
	public Order()
	{
		
	}
	
	
	public Order(Integer id, String env,String userid,String deliveryMode,PaymentType paymentType ,CreditCardTypeB2C creditCardType) {
		super();
		this.id=id;
		this.env=env;
		this.userid = userid;
		this.deliveryMode = deliveryMode;
		this.paymentType = paymentType;
		this.creditCardType=creditCardType;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEnv() {
		return env;
	}
	public void setEnv(String env) {
		this.env = env;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPhysicalISBN() {
		return physicalISBN;
	}
	public void setPhysicalISBN(String physicalISBN) {
		this.physicalISBN = physicalISBN;
	}
	public String getDigitalISBN() {
		return digitalISBN;
	}
	public void setDigitalISBN(String digitalISBN) {
		this.digitalISBN = digitalISBN;
	}
	public String getBundleISBN() {
		return bundleISBN;
	}
	public void setBundleISBN(String bundleISBN) {
		this.bundleISBN = bundleISBN;
	}
	public String getOtherISBN() {
		return otherISBN;
	}
	public void setOtherISBN(String otherISBN) {
		this.otherISBN = otherISBN;
	}
	public IsbnType getIsbnType() {
		return isbnType;
	}
	public void setIsbnType(IsbnType isbnType) {
		this.isbnType = isbnType;
	}
	public PaymentType getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(PaymentType paymentType) {
		this.paymentType = paymentType;
	}
	public CreditCardTypeB2C getCreditCardType() {
		return creditCardType;
	}
	public void setCreditCardType(CreditCardTypeB2C creditCardType) {
		this.creditCardType = creditCardType;
	}
	
	public String getDeliveryMode() {
		return deliveryMode;
	}
	public void setDeliveryMode(String deliveryMode) {
		this.deliveryMode = deliveryMode;
	}


	public String getMultipleProd() {
		return multipleProd;
	}


	public void setMultipleProd(String multipleProd) {
		this.multipleProd = multipleProd;
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


	@Override
	public String toString() {
		return "Order [id=" + id + ", env=" + env + ", userid=" + userid + ", paymentType=" + paymentType
				+ ", deliveryMode=" + deliveryMode + ", isbnType=" + isbnType + ", creditCardType=" + creditCardType
				+ ", physicalISBN=" + physicalISBN + ", digitalISBN=" + digitalISBN + ", bundleISBN=" + bundleISBN
				+ ", otherISBN=" + otherISBN + ", multipleProd=" + multipleProd + ", promoCodeApplied="
				+ promoCodeApplied + ", promoCode=" + promoCode + "]";
	}

	
	

}
