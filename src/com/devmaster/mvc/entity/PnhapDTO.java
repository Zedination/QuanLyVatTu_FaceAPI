package com.devmaster.mvc.entity;

import java.io.Serializable;

public class PnhapDTO extends BaseDTO implements Serializable {
	private String soPN;
	private String ngayNhap;
	private String soDH;
	public String getSoPn() {
		return soPN;
	}
	public void setSoPn(String soPn) {
		this.soPN = soPn;
	}
	public String getNgayNhap() {
		return ngayNhap;
	}
	public void setNgayNhap(String ngayNhap) {
		this.ngayNhap = ngayNhap;
	}
	public String getSoDH() {
		return soDH;
	}
	public void setSoDH(String soDH) {
		this.soDH = soDH;
	}
	
}
