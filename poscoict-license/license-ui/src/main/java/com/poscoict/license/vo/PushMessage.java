package com.poscoict.license.vo;


public class PushMessage {
	
	private int OBJECT_ID; // 푸쉬 인덱스
	private int CONTENT_NO; // 글번호
	private Boolean SENT_FLAG;
	private String POST_TYPE; // 글 성격 (게시글 / 답글 / 댓글)
	private String BOARD_TYPE; // 게시판 성격 (Q&A / FAQ)
	private String SOLUTION_TYPE; // 솔루션 종류
	private String POST_TITLE; // 글 제목
	private String CONTENT; // 댓글 내용
	private String USER; // 댓글 작성자
	private String CREATED_DATE; // 작성시간
	
	public PushMessage(int object_id, int content_no, Boolean sent_flag, String post_type, 
			String board_type, String solution_type, String post_title, String content, String user, String created_date) {
		this.OBJECT_ID = object_id;
		this.CONTENT_NO = content_no;
		this.SENT_FLAG= sent_flag;
		this.POST_TYPE = post_type;
		this.BOARD_TYPE = board_type;
		this.SOLUTION_TYPE = solution_type;
		this.POST_TITLE = post_title;
		this.CONTENT = content;
		this.USER = user;
		this.CREATED_DATE = created_date;
	}
	
	public PushMessage() {
		// TODO Auto-generated constructor stub
	}

	public int getOBJECT_ID() {
		return OBJECT_ID;
	}
	public void setOBJECT_ID(int oBJECT_ID) {
		OBJECT_ID = oBJECT_ID;
	}
	public Boolean getSENT_FLAG() {
		return SENT_FLAG;
	}
	public void setSENT_FLAG(Boolean sENT_FLAG) {
		SENT_FLAG = sENT_FLAG;
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
