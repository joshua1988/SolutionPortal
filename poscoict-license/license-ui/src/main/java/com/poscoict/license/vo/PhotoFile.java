package com.poscoict.license.vo;

import org.springframework.web.multipart.MultipartFile;

public class PhotoFile {
	private MultipartFile Filedata;

	public MultipartFile getFiledata() {
		return Filedata;
	}

	public void setFiledata(MultipartFile filedata) {
		Filedata = filedata;
	}	
}
