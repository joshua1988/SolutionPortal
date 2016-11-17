package com.poscoict.license.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ContractProductInfo {
    private List LICENSE_KEY;
    private List PRODUCT_FILE_ID;
    private List file;
    private List LICENSE_QUANTITY;
    private List CHECKBOX;
//    private List INSTALL_FILE_NAME;
	
    public ContractProductInfo(){
    	LICENSE_KEY = new ArrayList<String>();
    	PRODUCT_FILE_ID = new ArrayList<String>();
    	file = new ArrayList<MultipartFile>();
    	LICENSE_QUANTITY = new ArrayList<String>();
    	CHECKBOX = new ArrayList<String>();
//    	INSTALL_FILE_NAME = new ArrayList<String>();
    }
    
    public List getCHECKBOX() {
		return CHECKBOX;
	}

	public void setCHECKBOX(List CHECKBOX) {
		this.CHECKBOX = CHECKBOX;
	}

	//    public List getINSTALL_FILE_NAME() {
//		return INSTALL_FILE_NAME;
//	}
//
//	public void setINSTALL_FILE_NAME(List iNSTALL_FILE_NAME) {
//		INSTALL_FILE_NAME = iNSTALL_FILE_NAME;
//	}
	public List getLICENSE_KEY() {
		return LICENSE_KEY;
	}

	public void setLICENSE_KEY(List lICENSE_KEY) {
		LICENSE_KEY = lICENSE_KEY;
	}

	public List getPRODUCT_FILE_ID() {
		return PRODUCT_FILE_ID;
	}

	public void setPRODUCT_FILE_ID(List pRODUCT_FILE_ID) {
		PRODUCT_FILE_ID = pRODUCT_FILE_ID;
	}

	public List getFile() {
		return file;
	}

	public void setFile(List file) {
		this.file = file;
	}

	public List getLICENSE_QUANTITY() {
		return LICENSE_QUANTITY;
	}

	public void setLICENSE_QUANTITY(List lICENSE_QUANTITY) {
		LICENSE_QUANTITY = lICENSE_QUANTITY;
	}
    
}
