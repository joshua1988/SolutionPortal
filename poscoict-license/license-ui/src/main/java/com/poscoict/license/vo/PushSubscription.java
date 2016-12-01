package com.poscoict.license.vo;

public class PushSubscription {

	private String END_POINT;
	private String P256DH_KEY;
	private String SUBSCRIPTION_STATUS;
	
	public PushSubscription(String end_point, String p256dh_key, String subscription_status) {
		this.END_POINT = end_point;
		this.P256DH_KEY = p256dh_key;
		this.SUBSCRIPTION_STATUS = subscription_status;
	}
	
	public String getEND_POINT() {
		return END_POINT;
	}
	public void setEND_POINT(String eND_POINT) {
		END_POINT = eND_POINT;
	}
	public String getP256DH_KEY() {
		return P256DH_KEY;
	}
	public void setP256DH_KEY(String p256dh_KEY) {
		P256DH_KEY = p256dh_KEY;
	}
	public String getSUBSCRIPTION_STATUS() {
		return SUBSCRIPTION_STATUS;
	}
	public void setSUBSCRIPTION_STATUS(String sUBSCRIPTION_STATUS) {
		SUBSCRIPTION_STATUS = sUBSCRIPTION_STATUS;
	}
	
	
}
