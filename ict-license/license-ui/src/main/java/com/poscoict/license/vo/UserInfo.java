package com.poscoict.license.vo;

import java.sql.Date;

public class UserInfo {
    private String USER_NO;
    private String USER_NAME;
    private String USER_PASSWORD;
    private String USER_TYPE;
    private String MANAGER_NAME;
    private String MANAGER_OFFICE_PHON;
    private String MANAGER_CEL_PHON;
    private String MANAGER_EMAIL;
    private Date USER_START_DATE;
    private Date USER_END_DATE;
    private Date PRODUCT_SETUP_DATE;
    private Date R_CREATION_DATE;
    private String R_CREATION_USER;
    private Date R_MODIFY_DATE;
    private String R_MODIFY_USER;
    private String PROJECT_NAME;
    private String USER_ADDRESS;
    private String LICENSE_QUANTITY;
    private String ORDER_COMPANY_CODE;

    public Date getPRODUCT_SETUP_DATE() {
		return PRODUCT_SETUP_DATE;
	}

	public void setPRODUCT_SETUP_DATE(Date pRODUCT_SETUP_DATE) {
		PRODUCT_SETUP_DATE = pRODUCT_SETUP_DATE;
	}

	public String getPROJECT_NAME() {
        return PROJECT_NAME;
    }

    public void setPROJECT_NAME( String pROJECT_NAME ) {
        PROJECT_NAME = pROJECT_NAME;
    }

    public String getUSER_ADDRESS() {
        return USER_ADDRESS;
    }

    public void setUSER_ADDRESS( String uSER_ADDRESS ) {
        USER_ADDRESS = uSER_ADDRESS;
    }

    public String getLICENSE_QUANTITY() {
        return LICENSE_QUANTITY;
    }

    public void setLICENSE_QUANTITY( String lICENSE_QUANTITY ) {
        LICENSE_QUANTITY = lICENSE_QUANTITY;
    }

    public String getORDER_COMPANY_CODE() {
        return ORDER_COMPANY_CODE;
    }

    public void setORDER_COMPANY_CODE( String oRDER_COMPANY_CODE ) {
        ORDER_COMPANY_CODE = oRDER_COMPANY_CODE;
    }

    public String getMANAGER_NAME() {
        return MANAGER_NAME;
    }

    public void setMANAGER_NAME( String mANAGER_NAME ) {
        MANAGER_NAME = mANAGER_NAME;
    }

    public String getMANAGER_OFFICE_PHON() {
        return MANAGER_OFFICE_PHON;
    }

    public void setMANAGER_OFFICE_PHON( String mANAGER_OFFICE_PHON ) {
        MANAGER_OFFICE_PHON = mANAGER_OFFICE_PHON;
    }

    public String getMANAGER_CEL_PHON() {
        return MANAGER_CEL_PHON;
    }

    public void setMANAGER_CEL_PHON( String mANAGER_CEL_PHON ) {
        MANAGER_CEL_PHON = mANAGER_CEL_PHON;
    }

    public String getMANAGER_EMAIL() {
        return MANAGER_EMAIL;
    }

    public void setMANAGER_EMAIL( String mANAGER_EMAIL ) {
        MANAGER_EMAIL = mANAGER_EMAIL;
    }

    public Date getUSER_START_DATE() {
        return USER_START_DATE;
    }

    public void setUSER_START_DATE( Date uSER_START_DATE ) {
        USER_START_DATE = uSER_START_DATE;
    }

    public Date getUSER_END_DATE() {
        return USER_END_DATE;
    }

    public void setUSER_END_DATE( Date uSER_END_DATE ) {
        USER_END_DATE = uSER_END_DATE;
    }

    public Date getR_CREATION_DATE() {
        return R_CREATION_DATE;
    }

    public void setR_CREATION_DATE( Date r_CREATION_DATE ) {
        R_CREATION_DATE = r_CREATION_DATE;
    }

    public String getR_CREATION_USER() {
        return R_CREATION_USER;
    }

    public void setR_CREATION_USER( String r_CREATION_USER ) {
        R_CREATION_USER = r_CREATION_USER;
    }

    public Date getR_MODIFY_DATE() {
        return R_MODIFY_DATE;
    }

    public void setR_MODIFY_DATE( Date r_MODIFY_DATE ) {
        R_MODIFY_DATE = r_MODIFY_DATE;
    }

    public String getR_MODIFY_USER() {
        return R_MODIFY_USER;
    }

    public void setR_MODIFY_USER( String r_MODIFY_USER ) {
        R_MODIFY_USER = r_MODIFY_USER;
    }

    public String getUSER_NO() {
        return USER_NO;
    }

    public void setUSER_NO( String uSER_NO ) {
        USER_NO = uSER_NO;
    }

    public String getUSER_NAME() {
        return USER_NAME;
    }

    public void setUSER_NAME( String uSER_NAME ) {
        USER_NAME = uSER_NAME;
    }

    public String getUSER_PASSWORD() {
        return USER_PASSWORD;
    }

    public void setUSER_PASSWORD( String uSER_PASSWORD ) {
        USER_PASSWORD = uSER_PASSWORD;
    }

    public String getUSER_TYPE() {
        return USER_TYPE;
    }

    public void setUSER_TYPE( String uSER_TYPE ) {
        USER_TYPE = uSER_TYPE;
    }

    public UserInfo( String USER_NO, String USER_NAME, String USER_PASSWORD, String USER_TYPE ) {
        this.USER_NO = USER_NO;
        this.USER_NAME = USER_NAME;
        this.USER_PASSWORD = USER_PASSWORD;
        this.USER_TYPE = USER_TYPE;
    }

    public UserInfo() {
    }
}
