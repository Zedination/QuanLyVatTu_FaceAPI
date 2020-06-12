package com.devmaster.mvc.entity;

public class Candidates {
	private String personId;
	private String confidence;
	public Candidates(String personId, String confidence) {
		super();
		this.personId = personId;
		this.confidence = confidence;
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String getConfidence() {
		return confidence;
	}
	public void setConfidence(String confidence) {
		this.confidence = confidence;
	}
	
	
}
