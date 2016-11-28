package com.poscoict.license.vo;

public class PushSubscription {

	private String ENDPOINT;
//	private Boolean SUBSCRIPTION_FLAG;

	public PushSubscription(String endpoint) {
		this.ENDPOINT = endpoint;
	}
	
	public PushSubscription() {
		// TODO Auto-generated constructor stub
	}
	
	public String getENDPOINT() {
		return ENDPOINT;
	}

	public void setENDPOINT(String eNDPOINT) {
		ENDPOINT = eNDPOINT;
	}
	
	
}
