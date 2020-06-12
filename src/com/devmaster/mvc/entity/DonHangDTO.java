package com.devmaster.mvc.entity;

import java.io.Serializable;

public class DonHangDTO extends BaseDTO implements Serializable {
	private String soDH;
	private String ngaydh;
	private String mancc;
	
	public String getSodh() {
		return soDH;
	}

	public void setSodh(String soDH) {
		this.soDH = soDH;
	}

	public String getNgaydh() {
		return ngaydh;
	}

	public void setNgaydh(String ngaydh) {
		this.ngaydh = ngaydh;
	}

	public String getMancc() {
		return mancc;
	}

	public void setMancc(String mancc) {
		this.mancc = mancc;
	}

	public DonHangDTO() {
	}
	
	
	
	
}
