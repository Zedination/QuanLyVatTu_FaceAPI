package com.devmaster.mvc.entity;

public class VerifyObjSendToAPI {
	private String faceId1;
	private String faceId2;

	public VerifyObjSendToAPI(String faceId1, String faceId2) {
		super();
		this.faceId1 = faceId1;
		this.faceId2 = faceId2;
	}

	public VerifyObjSendToAPI() {
		super();
	}

	public String getFaceId1() {
		return faceId1;
	}

	public void setFaceId1(String faceId1) {
		this.faceId1 = faceId1;
	}

	public String getFaceId2() {
		return faceId2;
	}

	public void setFaceId2(String faceId2) {
		this.faceId2 = faceId2;
	}

	@Override
	public String toString() {
		return "VerifyObjSendToAPI [faceId1=" + faceId1 + ", faceId2=" + faceId2 + "]";
	}

}
