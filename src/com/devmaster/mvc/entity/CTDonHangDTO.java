package com.devmaster.mvc.entity;

import java.io.Serializable;

public class CTDonHangDTO extends BaseDTO implements Serializable {
	private String soDH;
	private String mavtu;
	private String sldat;
	
	public String getSodh() {
		return soDH;
	}

	public void setSodh(String sodh) {
		this.soDH = sodh;
	}

	public String getMavtu() {
		return mavtu;
	}

	public void setMavtu(String mavtu) {
		this.mavtu = mavtu;
	}

	public String getSldat() {
		return sldat;
	}

	public void setSldat(String sldat) {
		this.sldat = sldat;
	}

	public CTDonHangDTO() {
	}
}
