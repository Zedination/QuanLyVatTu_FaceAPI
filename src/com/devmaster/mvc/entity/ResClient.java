package com.devmaster.mvc.entity;

public class ResClient {
	private String faceId;
	private FaceRectangle faceRectangle;
	public ResClient() {
		super();
	}
	
	public ResClient(String faceId, FaceRectangle faceRectangle) {
		super();
		this.faceId = faceId;
		this.faceRectangle = faceRectangle;
	}

	public String getFaceId() {
		return faceId;
	}
	public void setFaceId(String faceId) {
		this.faceId = faceId;
	}
	public FaceRectangle getFaceRectangle() {
		return faceRectangle;
	}
	public void setFaceRectangle(FaceRectangle faceRectangle) {
		this.faceRectangle = faceRectangle;
	}
	
}
