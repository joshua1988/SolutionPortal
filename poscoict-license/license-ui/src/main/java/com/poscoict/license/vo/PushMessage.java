package com.poscoict.license.vo;


public class PushMessage {
	
	private int OBJECT_ID; // 푸쉬 인덱스
	private int CONTENT_NO; // 글번호
	private String POST_TYPE; // 글 성격 (게시글 / 답글 / 댓글)
	private String BOARD_TYPE; // 게시판 성격 (Q&A / FAQ)
	private String SOLUTION_TYPE; // 솔루션 종류
	private String POST_TITLE; // 글 제목
	private String CONTENT; // 댓글 내용
	private String USER; // 댓글 작성자
	private String CREATED_DATE; // 작성시간
	
	public int getOBJECT_ID() {
		return OBJECT_ID;
	}
	public void setOBJECT_ID(int oBJECT_ID) {
		OBJECT_ID = oBJECT_ID;
	}
	public int getCONTENT_NO() {
		return CONTENT_NO;
	}
	public void setCONTENT_NO(int cONTENT_NO) {
		CONTENT_NO = cONTENT_NO;
	}
	public String getPOST_TYPE() {
		return POST_TYPE;
	}
	public void setPOST_TYPE(String pOST_TYPE) {
		POST_TYPE = pOST_TYPE;
	}
	public String getBOARD_TYPE() {
		return BOARD_TYPE;
	}
	public void setBOARD_TYPE(String bOARD_TYPE) {
		BOARD_TYPE = bOARD_TYPE;
	}
	public String getSOLUTION_TYPE() {
		return SOLUTION_TYPE;
	}
	public void setSOLUTION_TYPE(String sOLUTION_TYPE) {
		SOLUTION_TYPE = sOLUTION_TYPE;
	}
	public String getPOST_TITLE() {
		return POST_TITLE;
	}
	public void setPOST_TITLE(String pOST_TITLE) {
		POST_TITLE = pOST_TITLE;
	}
	public String getCONTENT() {
		return CONTENT;
	}
	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
	}
	public String getUSER() {
		return USER;
	}
	public void setUSER(String uSER) {
		USER = uSER;
	}
	public String getCREATED_DATE() {
		return CREATED_DATE;
	}
	public void setCREATED_DATE(String cREATED_DATE) {
		CREATED_DATE = cREATED_DATE;
	}

	
}
