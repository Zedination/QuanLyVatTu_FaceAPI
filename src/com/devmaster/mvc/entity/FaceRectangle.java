package com.devmaster.mvc.entity;

public class FaceRectangle {
	private String top;
	private String left;
	private String width;
	private String height;
	public FaceRectangle(String top, String left, String width, String height) {
		super();
		this.top = top;
		this.left = left;
		this.width = width;
		this.height = height;
	}
	public FaceRectangle() {
		super();
	}
	public String getTop() {
		return top;
	}
	public void setTop(String top) {
		this.top = top;
	}
	public String getLeft() {
		return left;
	}
	public void setLeft(String left) {
		this.left = left;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	@Override
	public String toString() {
		return "FaceRectangle [top=" + top + ", left=" + left + ", width=" + width + ", height=" + height + "]";
	}
	
}
