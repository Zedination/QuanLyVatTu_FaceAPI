package com.devmaster.mvc.entity;

import java.io.Serializable;

public class IdolsDTO extends BaseDTO implements Serializable {
	private String personId;
	private String name;
	private String userData;
	private String diemDanh;
	
	public IdolsDTO() {
		super();
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserData() {
		return userData;
	}
	public void setUserData(String userData) {
		this.userData = userData;
	}
	public String getDiemDanh() {
		return diemDanh;
	}
	public void setDiemDanh(String diemDanh) {
		this.diemDanh = diemDanh;
	}
	
}
