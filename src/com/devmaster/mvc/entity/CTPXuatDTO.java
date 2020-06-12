package com.devmaster.mvc.entity;

import java.io.Serializable;

public class CTPXuatDTO extends BaseDTO implements Serializable{
	private String soPX;
	private String maVTu;
	private String sLXuat;
	private String dGXuat;
	public String getSoPX() {
		return soPX;
	}
	public void setSoPX(String soPX) {
		this.soPX = soPX;
	}
	public String getMaVTu() {
		return maVTu;
	}
	public void setMaVTu(String maVTu) {
		this.maVTu = maVTu;
	}
	public String getsLXuat() {
		return sLXuat;
	}
	public void setsLXuat(String sLXuat) {
		this.sLXuat = sLXuat;
	}
	public String getdGXuat() {
		return dGXuat;
	}
	public void setdGXuat(String dGXuat) {
		this.dGXuat = dGXuat;
	}
	
	
}
