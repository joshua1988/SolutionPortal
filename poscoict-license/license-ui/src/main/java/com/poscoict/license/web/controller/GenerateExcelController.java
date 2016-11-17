package com.poscoict.license.web.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.poscoict.license.service.GenerateExcelService;

@Controller
public class GenerateExcelController {
	
	@Autowired GenerateExcelService getGenerateExcelService;
    
    @RequestMapping( value = "generateExcel", method = RequestMethod.POST )
    public ModelAndView makeExcelFileClientInfo() throws IOException{
    	String filePath = getGenerateExcelService.makeExcelFileClientInfo();
    	
    	File file = new File( filePath );
    	return new ModelAndView( "down", "downloadFile", file );
    }
}
