package com.poscoict.license.service;

public class UserException extends Exception {

	private String message = "";
	
	public UserException(){}
	
	public UserException(String message){
		this.message = message;
	}
	
	@Override
	public String getMessage() {
		
		return this.message;
	}
	
}
