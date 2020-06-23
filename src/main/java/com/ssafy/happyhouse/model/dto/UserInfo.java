package com.ssafy.happyhouse.model.dto;

public class UserInfo {
	private String id;
	private String password;
	private String name;
	private String address;
	private String contact;
	private boolean isAdmin;

	public UserInfo() {
		super();
	}

	public UserInfo(String id, String password, String name, String address, String contact, boolean isAdmin) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.address = address;
		this.contact = contact;
		this.isAdmin = isAdmin;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public boolean getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

}