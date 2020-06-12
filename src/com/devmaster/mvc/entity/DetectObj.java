package com.devmaster.mvc.entity;

public class DetectObj {
	private String faceId;

	@Override
	public String toString() {
		return "DetectObj [faceId=" + faceId + "]";
	}

	public DetectObj() {
		super();
	}

	public String getFaceId() {
		return faceId;
	}

	public void setFaceId(String faceId) {
		this.faceId = faceId;
	}
	
}
