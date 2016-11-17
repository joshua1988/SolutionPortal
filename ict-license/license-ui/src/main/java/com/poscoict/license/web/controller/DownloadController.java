package com.poscoict.license.web.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.poscoict.license.consts.Consts;
import com.poscoict.license.dao.ManagementDao;
import com.poscoict.license.dao.ManagementDaoJdbc;

@Controller
public class DownloadController extends ExceptionControllerAdvice{
    private ManagementDao dao = null;
	private Logger logger = LoggerFactory.getLogger(getClass());

    private ManagementDao getManagementDao() {
        ApplicationContext context = new GenericXmlApplicationContext( "applicationContext.xml" );
        return this.dao = context.getBean( "managementDao", ManagementDaoJdbc.class );
    }
    
    @RequestMapping( value={"attachFileDown"}, method=RequestMethod.POST )
    public ModelAndView attachFileDown(@RequestParam( "objectId" ) String objectId){
    	dao = getManagementDao();
    	System.out.println("________objectId: "+objectId);
    	Map<String, Object> fileInfo = dao.getDownloadAttachInfo(objectId);
    	File file = new File( (String)fileInfo.get("ATTACH_FILE_PATH") );
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("file", file);
    	map.put("fileName", fileInfo.get("ATTACH_FILE_NAME"));
    	
    	return new ModelAndView( "attachDown", "downloadFile", map );
    }

    @RequestMapping( value={"sdkFileDown","licenseFileDown"} )
    public ModelAndView download( @RequestParam( "category" ) String category, @RequestParam( "objectId" ) String objectId,
    		 HttpServletRequest request ) {
        dao = getManagementDao();
        String userNo = (String)request.getSession().getAttribute("USER_NO");
        String filePath = "";
        
        if(category.equals("pakage")){
        	filePath = dao.getFilePath( objectId );
        	dao.insertFileDownload(userNo, objectId);
        }
        else if(category.equals("license")){
        	filePath = dao.getLicensePath( objectId, userNo );    
        	dao.setLiscenseDownloadCnt(userNo, objectId);
        }else if(category.equals("installGuide")){
//        	filePath = dao.getFilePath( category, fileName );
        }else if(category.equals("patch")){
        	filePath = dao.getPatchPath( objectId );
        	dao.insertFileDownload(userNo, objectId);
        }
        
        File file = new File( filePath );
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("file", file);
        return new ModelAndView( "attachDown", "downloadFile", map );
    }
    
    @RequestMapping( value={"pdfDownload"}, method=RequestMethod.POST )
    public ModelAndView pdfDownload(@RequestParam( "fileName" ) String fileName){
    	String filePath = Consts.PDF_PATH+fileName;
    	File file = new File( filePath );
    	Map<String, Object> map = new HashMap<String, Object>();
        map.put("file", file);
    	return new ModelAndView( "attachDown", "downloadFile", map );
    }
}
