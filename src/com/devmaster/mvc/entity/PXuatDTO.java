package com.devmaster.mvc.entity;

import java.io.Serializable;

public class PXuatDTO extends BaseDTO implements Serializable {
	private String soPX;
	private String ngayXuat;
	private String tenKH;
	public String getSoPX() {
		return soPX;
	}
	public void setSoPX(String soPX) {
		this.soPX = soPX;
	}
	public String getNgayXuat() {
		return ngayXuat;
	}
	public void setNgayXuat(String ngayXuat) {
		this.ngayXuat = ngayXuat;
	}
	public String getTenKH() {
		return tenKH;
	}
	public void setTenKH(String tenKH) {
		this.tenKH = tenKH;
	}
	
	
}
