package com.devmaster.mvc.entity;

public class AjaxClient {
	private String result;
	private ResClient resClient1;
	private ResClient resClient2;
	public AjaxClient() {
		super();
	}
	
	public AjaxClient(String result, ResClient resClient1, ResClient resClient2) {
		super();
		this.result = result;
		this.resClient1 = resClient1;
		this.resClient2 = resClient2;
	}
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public ResClient getResClient1() {
		return resClient1;
	}
	public void setResClient1(ResClient resClient1) {
		this.resClient1 = resClient1;
	}
	public ResClient getResClient2() {
		return resClient2;
	}
	public void setResClient2(ResClient resClient2) {
		this.resClient2 = resClient2;
	};
	
}
