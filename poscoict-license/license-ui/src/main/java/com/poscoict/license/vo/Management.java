package com.poscoict.license.vo;

import org.springframework.web.multipart.MultipartFile;

public class Management {
    private String USER_NO;
    private String USER_NAME;
    private String MANAGER_NAME;
    private String MANAGER_OFFICE_PHON;
    private String MANAGER_CEL_PHON;
    private String MANAGER_EMAIL;
    private String USER_START_DATE;
    private String USER_END_DATE;
    private String LICENSE_KEY;
    private String PRODUCT_FILE_NAME;
    private MultipartFile file;
    private String PROJECT_NAME;
    private String USER_ADDRESS;
    private String LICENSE_QUANTITY;
    private String ORDER_COMPANY_CODE;

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

    public MultipartFile getFile() {
        return file;
    }

    public void setFile( MultipartFile file ) {
        this.file = file;
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

    public String getUSER_START_DATE() {
        return USER_START_DATE;
    }

    public void setUSER_START_DATE( String uSER_START_DATE ) {
        USER_START_DATE = uSER_START_DATE;
    }

    public String getUSER_END_DATE() {
        return USER_END_DATE;
    }

    public void setUSER_END_DATE( String uSER_END_DATE ) {
        USER_END_DATE = uSER_END_DATE;
    }

    public String getLICENSE_KEY() {
        return LICENSE_KEY;
    }

    public void setLICENSE_KEY( String lICENSE_KEY ) {
        LICENSE_KEY = lICENSE_KEY;
    }

    public String getPRODUCT_FILE_NAME() {
        return PRODUCT_FILE_NAME;
    }

    public void setPRODUCT_FILE_NAME( String pRODUCT_FILE_NAME ) {
        PRODUCT_FILE_NAME = pRODUCT_FILE_NAME;
    }
}
