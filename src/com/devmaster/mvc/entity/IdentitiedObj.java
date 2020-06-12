package com.devmaster.mvc.entity;

import java.util.Arrays;

public class IdentitiedObj {
	private String faceId;
	private Candidates[] candidates;
	
	public IdentitiedObj() {
		super();
	}

	public IdentitiedObj(String faceId, Candidates[] candidates) {
		super();
		this.faceId = faceId;
		this.candidates = candidates;
	}

	public String getFaceId() {
		return faceId;
	}

	public void setFaceId(String faceId) {
		this.faceId = faceId;
	}

	public Candidates[] getCandidates() {
		return candidates;
	}

	public void setCandidates(Candidates[] candidates) {
		this.candidates = candidates;
	}

	@Override
	public String toString() {
		return "IdentitiedObj [faceId=" + faceId + ", candidates=" + Arrays.toString(candidates) + "]";
	}
	
	
}
