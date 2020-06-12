package com.devmaster.mvc.entity;

public class ResponseObj {
	private String responseText;
	private int statusCode;

	public ResponseObj(String responseText, int statusCode) {
		super();
		this.responseText = responseText;
		this.statusCode = statusCode;
	}

	public ResponseObj() {
		super();
	}

	public String getResponseText() {
		return responseText;
	}

	public void setResponseText(String responseText) {
		this.responseText = responseText;
	}

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}

	@Override
	public String toString() {
		return "ResponseObj [responseText=" + responseText + ", statusCode=" + statusCode + "]";
	}

}
