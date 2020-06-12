package com.devmaster.mvc.entity;

import java.io.Serializable;

public class BranchDTO extends BaseDTO implements Serializable {

	private static final long serialVersionUID = 1420635747715993129L;

	private String branchCode;
	private String branchName;
	private String location;

	public BranchDTO() {
	}
	
	public BranchDTO(String branchCode, String branchName, String location) {
		this.branchCode = branchCode;
		this.branchName = branchName;
		this.location = location;
	}

	public String getBranchCode() {
		return branchCode;
	}

	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}

	public String getBranchName() {
		return branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	
}
