package com.devmaster.mvc.entity;

public class VerifiedObj {
	private Boolean isIdentical;
	private float confidence;

	public VerifiedObj() {
		super();
	}

	public VerifiedObj(Boolean isIdentical, float confidence) {
		super();
		this.isIdentical = isIdentical;
		this.confidence = confidence;
	}

	public Boolean getIsIdentical() {
		return isIdentical;
	}

	public void setIsIdentical(Boolean isIdentical) {
		this.isIdentical = isIdentical;
	}

	public float getConfidence() {
		return confidence;
	}

	public void setConfidence(float confidence) {
		this.confidence = confidence;
	}

	@Override
	public String toString() {
		return "VerifiedObj [isIdentical=" + isIdentical + ", confidence=" + confidence + "]";
	}

}
