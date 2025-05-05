package com.cengage.b2b.orderrepository;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.Min;

@Entity(name="userouttable")
public class UserCreationOut {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String env;
	private String userId;
	private String store;
	private String password;
	private String account;
	private String emailId;
	private String date;
	
	public UserCreationOut()
	{
		
	}
	public UserCreationOut(int id,String userId, String password, String account, String emailId, String date) {
		super();
		this.id=id;
		this.userId = userId;
		this.password = password;
		this.account = account;
		this.emailId = emailId;
		this.date=date;
		}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
		return "UserCreationOut [id=" + id + ", env=" + env + ", userId=" + userId + ", store=" + store + ", password="
				+ password + ", account=" + account + ", emailId=" + emailId + ", date=" + date + "]";
	}
	
	

}
