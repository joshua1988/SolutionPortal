package com.poscoict.license.vo;

public class PushSubscription {

	private String ENDPOINT;
	private String KEY;
	private String SUBSCRIPTION_STATUS;
	
	public PushSubscription(String endpoint, String key, String subscription_status) {
		this.ENDPOINT = endpoint;
		this.KEY = key;
		this.SUBSCRIPTION_STATUS = subscription_status;
	}
	
	public PushSubscription() {
		
	}
	
	public String getENDPOINT() {
		return ENDPOINT;
	}
	public void setENDPOINT(String eNDPOINT) {
		ENDPOINT = eNDPOINT;
	}
	public String getKEY() {
		return KEY;
	}
	public void setKEY(String kEY) {
		KEY = kEY;
	}
	public String getSUBSCRIPTION_STATUS() {
		return SUBSCRIPTION_STATUS;
	}
	public void setSUBSCRIPTION_STATUS(String sUBSCRIPTION_STATUS) {
		SUBSCRIPTION_STATUS = sUBSCRIPTION_STATUS;
	}
	
}
