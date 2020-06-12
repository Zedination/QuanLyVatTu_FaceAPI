package com.devmaster.mvc.entity;

import java.util.List;

public class IdentityObjSendToApi {
	private String personGroupId;
	private List<String> faceIds;
	private int maxNumOfCandidatesReturned;
	public IdentityObjSendToApi(String personGroupId, List<String> faceIds, int maxNumOfCandidatesReturned) {
		super();
		this.personGroupId = personGroupId;
		this.faceIds = faceIds;
		this.maxNumOfCandidatesReturned = maxNumOfCandidatesReturned;
	}
	public String getPersonGroupId() {
		return personGroupId;
	}
	public void setPersonGroupId(String personGroupId) {
		this.personGroupId = personGroupId;
	}
	public List<String> getFaceIds() {
		return faceIds;
	}
	public void setFaceIds(List<String> faceIds) {
		this.faceIds = faceIds;
	}
	public int getMaxNumOfCandidatesReturned() {
		return maxNumOfCandidatesReturned;
	}
	public void setMaxNumOfCandidatesReturned(int maxNumOfCandidatesReturned) {
		this.maxNumOfCandidatesReturned = maxNumOfCandidatesReturned;
	}
	@Override
	public String toString() {
		return "IdentityObjSendToApi [personGroupId=" + personGroupId + ", faceIds=" + faceIds
				+ ", maxNumOfCandidatesReturned=" + maxNumOfCandidatesReturned + "]";
	}
	
}
