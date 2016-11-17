package com.poscoict.license.vo;

public class FileList {
    private String PRODUCT_FILE_NAME;
    private String MAIN_CONTENT;
    private String FILE_CATEGORY;
    private String R_CREATION_DATE;

    public String getR_CREATION_DATE() {
        return R_CREATION_DATE;
    }

    public void setR_CREATION_DATE( String r_CREATION_DATE ) {
        R_CREATION_DATE = r_CREATION_DATE;
    }

    public String getFILE_CATEGORY() {
        return FILE_CATEGORY;
    }

    public void setFILE_CATEGORY( String fILE_CATEGORY ) {
        FILE_CATEGORY = fILE_CATEGORY;
    }

    public String getPRODUCT_FILE_NAME() {
        return PRODUCT_FILE_NAME;
    }

    public void setPRODUCT_FILE_NAME( String pRODUCT_FILE_NAME ) {
        PRODUCT_FILE_NAME = pRODUCT_FILE_NAME;
    }

    public String getMAIN_CONTENT() {
        return MAIN_CONTENT;
    }

    public void setMAIN_CONTENT( String mAIN_CONTENT ) {
        MAIN_CONTENT = mAIN_CONTENT;
    }
}
