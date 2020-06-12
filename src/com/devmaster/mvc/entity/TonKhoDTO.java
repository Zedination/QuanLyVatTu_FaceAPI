package com.devmaster.mvc.entity;

import java.io.Serializable;

public class TonKhoDTO extends BaseDTO implements Serializable {
	private String NamThang;
	private String Mavtu;
	private String SLDau;
	private String TongSLN;
	private String TongSLX;
	private String SLCuoi;
	public String getNamThang() {
		return NamThang;
	}
	public void setNamThang(String namThang) {
		NamThang = namThang;
	}
	public String getMavtu() {
		return Mavtu;
	}
	public void setMavtu(String mavtu) {
		Mavtu = mavtu;
	}
	public String getSLDau() {
		return SLDau;
	}
	public void setSLDau(String sLDau) {
		SLDau = sLDau;
	}
	public String getTongSLN() {
		return TongSLN;
	}
	public void setTongSLN(String tongSLN) {
		TongSLN = tongSLN;
	}
	public String getTongSLX() {
		return TongSLX;
	}
	public void setTongSLX(String tongSLX) {
		TongSLX = tongSLX;
	}
	public String getSLCuoi() {
		return SLCuoi;
	}
	public void setSLCuoi(String sLCuoi) {
		SLCuoi = sLCuoi;
	}
	
	
}
