package com.devmaster.mvc.entity;

import java.io.Serializable;

public class VatTuDTO extends BaseDTO implements Serializable {
	private String maVtu;
	private String tenVtu;
	private String dvTinh;
	private String phanTram;

	public String getMaVtu() {
		return maVtu;
	}

	public void setMaVtu(String maVtu) {
		this.maVtu = maVtu;
	}

	public String getTenVtu() {
		return tenVtu;
	}

	public void setTenVtu(String tenVtu) {
		this.tenVtu = tenVtu;
	}

	public String getDvTinh() {
		return dvTinh;
	}

	public void setDvTinh(String dvTinh) {
		this.dvTinh = dvTinh;
	}

	public String getPhanTram() {
		return phanTram;
	}

	public void setPhanTram(String phanTram) {
		this.phanTram = phanTram;
	}
}
