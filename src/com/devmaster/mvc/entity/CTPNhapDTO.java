package com.devmaster.mvc.entity;

import java.io.Serializable;

public class CTPNhapDTO extends BaseDTO implements Serializable {
	private String soPN;
	private String maVTu;
	private String sLNhap;
	private String dGNhap;
	public String getSoPN() {
		return soPN;
	}
	public void setSoPN(String soPN) {
		this.soPN = soPN;
	}
	public String getMaVTu() {
		return maVTu;
	}
	public void setMaVTu(String maVTu) {
		this.maVTu = maVTu;
	}
	public String getsLNhap() {
		return sLNhap;
	}
	public void setsLNhap(String sLNhap) {
		this.sLNhap = sLNhap;
	}
	public String getdGNhap() {
		return dGNhap;
	}
	public void setdGNhap(String dGNhap) {
		this.dGNhap = dGNhap;
	}
	
	
}
