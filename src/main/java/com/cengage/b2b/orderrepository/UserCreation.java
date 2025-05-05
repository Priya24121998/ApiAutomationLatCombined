package com.cengage.b2b.orderrepository;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Version;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

@Entity(name="usertable")
public class UserCreation {

	@NotNull
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Enumerated(EnumType.STRING)
	private NoOfUsersType noOfUsersType;

	private String env;
	
	private String userAccount;

	private Integer numberOfUsers;

	@Version
	private Integer version;

	public UserCreation(Integer id, String env,NoOfUsersType noOfUsersType, String userAccount) {
		super();
		this.id = id;
		this.env= env;
		this.noOfUsersType = noOfUsersType;
		this.userAccount = userAccount;
	}
	public UserCreation()
	{
		
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public NoOfUsersType getNoOfUsersType() {
		return noOfUsersType;
	}
	public void setNoOfUsersType(NoOfUsersType noOfUsersType) {
		this.noOfUsersType = noOfUsersType;
	}
	public String getUserAccount() {
		return userAccount;
	}
	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}
	public Integer getNumberOfUsers() {
		return numberOfUsers;
	}
	public void setNumberOfUsers(Integer numberOfUsers) {
		this.numberOfUsers = numberOfUsers;
	}
	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
	public String getEnv() {
		return env;
	}
	public void setEnv(String env) {
		this.env = env;
	}
	@Override
	public String toString() {
		return "UserCreation [id=" + id + ", noOfUsersType=" + noOfUsersType + ", userAccount=" + userAccount
				+ ", numberOfUsers=" + numberOfUsers + ", version=" + version + "]";
	}

	

}