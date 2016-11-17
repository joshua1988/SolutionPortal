package com.poscoict.license.consts;

import java.io.File;

public class Consts {
	
	//게시판 구분
	public static enum SubCategory {
		NOTICE("NOTICE","Notice"),
		GLUE("GLUE","Glue"),
		GLUEMASTER("GLUEMASTER","GlueMaster"),
		UCUBE("UCUBE","u-CUBE"),   
		POSBEE("POSBEE","PosBee"),
		GLUEMOBILE("GLUEMOBILE","GlueMobile");
		  
		private String category;
		private String categoryToString;
		
		SubCategory(String category, String categoryToString) {   
			this.category = category;   
			this.categoryToString = categoryToString;
		}   
		  
		public String getCategory() {   
			return category;   
		}   
		
		public String getCategoryToString(){
			return categoryToString;
		}
	}
	public static final String[] SUB_CATEGORY = {SubCategory.GLUE.getCategoryToString(),
												SubCategory.UCUBE.getCategoryToString(),
												SubCategory.POSBEE.getCategoryToString()};
	
	public static final String rolePrefix = "ROLE_";
	
	//유저 코드
	public static final String POSCO_ICT_CODE = "0001";
	
	public static final String GUEST_USER = "guest";
	public static final String GLUE_ADMIN_USER = "glue";
	public static final String POSBEE_ADMIN_USER = "posbee";
	public static final String UCUBE_ADMIN_USER = "ucube";
	
	//유저 구분
	public static final String USERLV_ADMIN = "D";			// 관리자
	public static final String USERLV_PUBLIC = "U";			// 고객
	public static final String USERLV_GUEST = "G";			// 게스트
	public static final String USERLV_ORDER_COMPANY = "S";	// 수주사
	public static final String USERLV_CUSTOM_USER = "C";	// 생성 유저
	
	// 예비 고객 상태 코드
	public static enum ProgressStatus {   
		P("P","진행중"),
		C("C","등록요청"),
		R("R","반려"),   
		G("G","삭제"),
		F("F","등록완료"),
		M("M","수정");
		  
		private String progressStatus;
		private String progressStatusToString;
		
		ProgressStatus(String progressStatus, String progressStatusToString) {   
			this.progressStatus = progressStatus;   
			this.progressStatusToString = progressStatusToString;
		}   
		  
		public String getProgressStatus() {   
			return progressStatus;   
		}   
		
		public String getProgressStatusToString(){
			return progressStatusToString;
		}
	}
	
	// 프로젝트 폴더 ROOT_ID
	public static final String PROJECT_ROOT_ID = "PROJECT_ROOT_ID";
	public static final String PROJECT_GLUE_ROOT_ID = "PROJECT_GLUE_ROOT_ID";
	public static final String PROJECT_GLUEMASTER_ROOT_ID = "PROJECT_GLUEMASTER_ROOT_ID";
	public static final String PROJECT_GLUEMOBILE_ROOT_ID = "PROJECT_GLUEMOBILE_ROOT_ID";
	public static final String PROJECT_UCUBE_ROOT_ID = "PROJECT_UCUBE_ROOT_ID";
	public static final String PROJECT_POSBEE_ROOT_ID = "PROJECT_POSBEE_ROOT_ID";
	
	// 파일 패스
	public static final String GLUE_FRAMEWORK_FILE_HOME = "D:"+File.separator+"files"+File.separator+"GlueFramework"+File.separator;
	public static final String GLUE_MASTER_FILE_HOME = "D:"+File.separator+"files"+File.separator+"GlueMaster"+File.separator;
	public static final String GLUE_MOBILE_FILE_HOME = "D:"+File.separator+"files"+File.separator+"GlueMobile"+File.separator;
	public static final String UCUBE_FILE_HOME = "D:"+File.separator+"files"+File.separator+"uCUBE"+File.separator;
	public static final String LICENSE_FILE_HOME = "D:"+File.separator+"files"+File.separator+"license"+File.separator;
	public static final String BOARD_ATTACH_FILE_HOME = "D:"+File.separator+"files"+File.separator+"BoardAttach"+File.separator;
	public static final String ETC_FILE_HOME = "D:"+File.separator+"files"+File.separator+"etc"+File.separator;
	public static final String POSBEE_FILE_HOME = "D:"+File.separator+"files"+File.separator+"PosBee"+File.separator;
	
	// PDF 폰트 파일 경로
	public static final String FONT_FILE_PATH = "D:"+File.separator+"files"+File.separator+"CREATEPDF"+File.separator+"TTF"+File.separator+"GulimChe.ttf";
	// PDF 이미지 파일 경로
	public static final String SIGNET_IMG_PATH = "D:"+File.separator+"files"+File.separator+"CREATEPDF"+File.separator+"IMG"+File.separator+"signet.jpg";
	// PDF 파일 생성 경로
	public static final String PDF_PATH = "D:"+File.separator+"files"+File.separator+"CREATEPDF"+File.separator+"PDF_DOWN"+File.separator;
	// 이미지 파일 생성 경로
	public static final String IMG_PATH = "D:"+File.separator+"files"+File.separator+"CREATEPDF"+File.separator+"IMG_DOWN"+File.separator;
	// 이미지 포맷
	public static final String IMG_FORMAT = "gif";
	// 이미지 temp 폴더
	public static final String IMG_TEMP_FOLDER = "/jsp/certificateDownload";
	
	
	public static final String MENU_NOTICE = "1010";
	public static final String FUNCTION_NOTICE_WRITE = "1011";	
	
	public static final String MENU_GLUE = "2010";
	public static final String FUNCTION_GLUE_ADMIN = "2020";
	public static final String FUNCTION_GLUE_WRITE = "2011";
	public static final String FUNCTION_GLUE_WRITE_NOTICE = "2012";
	public static final String FUNCTION_GLUE_WRITE_QNA = "2013";
	public static final String FUNCTION_GLUE_REPLY_BOARD_QNA = "2014";
	public static final String FUNCTION_GLUE_WRITE_FAQ = "2015";
	public static final String FUNCTION_GLUE_WRITE_TECH = "2016";	
	public static final String FUNCTION_GLUE_WRITE_OLDTECH = "2018";  
	public static final String FUNCTION_GLUE_REPLY = "2017";
	
	public static final String MENU_GLUEMASTER = "3010";
	public static final String FUNCTION_GLUEMASTER_ADMIN = "3020";
	public static final String FUNCTION_GLUEMASTER_WRITE = "3011";
	public static final String FUNCTION_GLUEMASTER_WRITE_NOTICE = "3012";
	public static final String FUNCTION_GLUEMASTER_WRITE_QNA = "3013";
	public static final String FUNCTION_GLUEMASTER_REPLY_BOARD_QNA = "3014";
	public static final String FUNCTION_GLUEMASTER_WRITE_FAQ = "3015";	
	public static final String FUNCTION_GLUEMASTER_WRITE_TECH = "3016";	
	public static final String FUNCTION_GLUEMASTER_REPLY = "3017";
	
	public static final String MENU_GLUEMOBILE = "C010";
	public static final String FUNCTION_GLUEMOBILE_ADMIN = "C020";
	public static final String FUNCTION_GLUEMOBILE_WRITE = "C011";
	public static final String FUNCTION_GLUEMOBILE_WRITE_NOTICE = "C012";
	public static final String FUNCTION_GLUEMOBILE_WRITE_QNA = "C013";
	public static final String FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA = "C014";
	public static final String FUNCTION_GLUEMOBILE_WRITE_FAQ = "C015";	
	public static final String FUNCTION_GLUEMOBILE_WRITE_TECH = "C016";	
	public static final String FUNCTION_GLUEMOBILE_REPLY = "C017";
	
	public static final String MENU_UCUBE = "4010";
	public static final String FUNCTION_UCUBE_ADMIN = "4020";
	public static final String FUNCTION_UCUBE_WRITE = "4011";
	public static final String FUNCTION_UCUBE_WRITE_NOTICE = "4012";
	public static final String FUNCTION_UCUBE_WRITE_QNA = "4013";
	public static final String FUNCTION_UCUBE_REPLY_BOARD_QNA = "4014";
	public static final String FUNCTION_UCUBE_WRITE_FAQ = "4015";	
	public static final String FUNCTION_UCUBE_WRITE_TECH = "4016";	
	public static final String FUNCTION_UCUBE_REPLY = "4017";
	
	public static final String MENU_POSBEE = "5010";
	public static final String FUNCTION_POSBEE_ADMIN = "5020";
	public static final String FUNCTION_POSBEE_WRITE = "5011";
	public static final String FUNCTION_POSBEE_WRITE_NOTICE = "5012";
	public static final String FUNCTION_POSBEE_WRITE_QNA = "5013";
	public static final String FUNCTION_POSBEE_REPLY_BOARD_QNA = "5014";
	public static final String FUNCTION_POSBEE_WRITE_FAQ = "5015";	
	public static final String FUNCTION_POSBEE_WRITE_TECH = "5016";	
	public static final String FUNCTION_POSBEE_REPLY = "5017";
	
	public static final String MENU_SOLUTION_UPLOAD = "6010";
	public static final String FUNCTION_SOLUTION_UPLOAD_GLUE = "6011";
	public static final String FUNCTION_SOLUTION_UPLOAD_GLUEMASTER = "6012";
	public static final String FUNCTION_SOLUTION_UPLOAD_UCUBE = "6013";
	public static final String FUNCTION_SOLUTION_UPLOAD_POSBEE = "6014";
	public static final String FUNCTION_SOLUTION_UPLOAD_ETC = "6015";
	public static final String FUNCTION_SOLUTION_UPLOAD_ORDER_COMPANY = "6016";
	public static final String FUNCTION_SOLUTION_UPLOAD_CUSTOM_USER = "6017";
	public static final String FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE = "6018";
	
	public static final String MENU_PRESENTATION = "7010";
	public static final String MENU_GUEST_PACKAGE_DOWNLOAD = "8010";
	public static final String MENU_USER_PACKAGE_DOWNLOAD = "9010";
	
	public static final String MENU_MANAGEMENT = "A010";
	public static final String SUB_MENU_MANAGEMENT_COMPLETE = "A011";
	public static final String FUNCTION_MANAGEMENT_INPUT_USER = "A013";
	public static final String SUB_MENU_MANAGEMENT_PROGRESS = "A012";
	public static final String FUNCTION_PROGRESS_INPUT_USER = "A014";
	public static final String FUNCTION_PROGRESS_COMMENT = "A015";
	
	public static final String MENU_CUSTOMBOARD = "B010";
	
	
	public static final String[] POSBEE_SECRET_BOARD = {"b_20141224132738fb6f63f829ef"};
}
