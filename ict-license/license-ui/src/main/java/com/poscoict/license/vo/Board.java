package com.poscoict.license.vo;

public class Board {
    private int CONTENT_NO;
    private String FOLDER_ID;
    private String ORI_FOLDER_ID;
    private String SUBCATEGORY;
    private String TITLE;
    private String MAIN_CONTENT;
    private String USER_NO;
    private String OPEN_FLAG;
    private String R_CREATION_DATE;
    private String R_CREATION_USER;
    private String R_MODIFY_DATE;
    private String R_MODIFY_USER;
    private String R_DELETED_TYPE;
    private int CLICKS;
    private int CONTENT_GRP;
    private int CONTENT_SEQ;
    private int REPLY_COUNT;
    private String ATTACH_FILE_NAME;
    private String ATTACH_FILE_PATH;
    private int ATTACH_FILE_SIZE;

    public String getSUBCATEGORY() {
		return SUBCATEGORY;
	}

	public void setSUBCATEGORY(String sUBCATEGORY) {
		SUBCATEGORY = sUBCATEGORY;
	}

	public int getATTACH_FILE_SIZE() {
		return ATTACH_FILE_SIZE;
	}

	public void setATTACH_FILE_SIZE(int aTTACH_FILE_SIZE) {
		ATTACH_FILE_SIZE = aTTACH_FILE_SIZE;
	}

	public String getATTACH_FILE_NAME() {
		return ATTACH_FILE_NAME;
	}

	public void setATTACH_FILE_NAME(String aTTACH_FILE_NAME) {
		ATTACH_FILE_NAME = aTTACH_FILE_NAME;
	}

	public String getATTACH_FILE_PATH() {
		return ATTACH_FILE_PATH;
	}

	public void setATTACH_FILE_PATH(String aTTACH_FILE_PATH) {
		ATTACH_FILE_PATH = aTTACH_FILE_PATH;
	}

	public int getREPLY_COUNT() {
        return REPLY_COUNT;
    }

    public void setREPLY_COUNT( int rEPLY_COUNT ) {
        this.REPLY_COUNT = rEPLY_COUNT;
    }

    public int getCONTENT_GRP() {
        return CONTENT_GRP;
    }

    public void setCONTENT_GRP( int cONTENT_GRP ) {
        this.CONTENT_GRP = cONTENT_GRP;
    }

    public int getCONTENT_SEQ() {
        return CONTENT_SEQ;
    }

    public void setCONTENT_SEQ( int cONTENT_SEQ ) {
        this.CONTENT_SEQ = cONTENT_SEQ;
    }

    public String getR_DELETED_TYPE() {
        return R_DELETED_TYPE;
    }

    public void setR_DELETED_TYPE( String r_DELETED_TYPE ) {
        this.R_DELETED_TYPE = r_DELETED_TYPE;
    }

    private String USER_NAME;

    public String getORI_FOLDER_ID() {
        return ORI_FOLDER_ID;
    }

    public void setORI_FOLDER_ID( String oRI_FOLDER_ID ) {
        this.ORI_FOLDER_ID = oRI_FOLDER_ID;
    }

    public String getUSER_NAME() {
        return USER_NAME;
    }

    public void setUSER_NAME( String uSER_NAME ) {
        this.USER_NAME = uSER_NAME;
    }

    public int getCLICKS() {
        return CLICKS;
    }

    public void setCLICKS( int cLICKS ) {
        this.CLICKS = cLICKS;
    }

    public String getUSER_NO() {
        return USER_NO;
    }

    public void setUSER_NO( String uSER_NO ) {
        this.USER_NO = uSER_NO;
    }

    public int getCONTENT_NO() {
        return CONTENT_NO;
    }

    public void setCONTENT_NO( int cONTENT_NO ) {
        this.CONTENT_NO = cONTENT_NO;
    }

    public String getFOLDER_ID() {
        return FOLDER_ID;
    }

    public void setFOLDER_ID( String fOLDER_ID ) {
        this.FOLDER_ID = fOLDER_ID;
    }

    public String getTITLE() {
        return TITLE;
    }

    public void setTITLE( String tITLE ) {
        this.TITLE = tITLE;
    }

    public String getMAIN_CONTENT() {
        return MAIN_CONTENT;
    }

    public void setMAIN_CONTENT( String mAIN_CONTENT ) {
        this.MAIN_CONTENT = mAIN_CONTENT;
    }

    public String getOPEN_FLAG() {
        return OPEN_FLAG;
    }

    public void setOPEN_FLAG( String oPEN_FLAG ) {
        this.OPEN_FLAG = oPEN_FLAG;
    }

    public String getR_CREATION_DATE() {
        return R_CREATION_DATE;
    }

    public void setR_CREATION_DATE( String r_CREATION_DATE ) {
        this.R_CREATION_DATE = r_CREATION_DATE;
    }

    public String getR_CREATION_USER() {
        return R_CREATION_USER;
    }

    public void setR_CREATION_USER( String r_CREATION_USER ) {
        this.R_CREATION_USER = r_CREATION_USER;
    }

    public String getR_MODIFY_DATE() {
        return R_MODIFY_DATE;
    }

    public void setR_MODIFY_DATE( String r_MODIFY_DATE ) {
        this.R_MODIFY_DATE = r_MODIFY_DATE;
    }

    public String getR_MODIFY_USER() {
        return R_MODIFY_USER;
    }

    public void setR_MODIFY_USER( String r_MODIFY_USER ) {
        this.R_MODIFY_USER = r_MODIFY_USER;
    }
}
