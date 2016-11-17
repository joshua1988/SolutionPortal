package com.poscoict.license.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView {

    public void Download() {
        setContentType( "application/download; utf-8" );
        System.out.println( "Download" );
    }
    
    private String getBrowser(HttpServletRequest request) {

        String header =request.getHeader("User-Agent");

        if (header.contains("MSIE")) {

               return "MSIE";

        } else if(header.contains("Chrome")) {

               return "Chrome";

        } else if(header.contains("Opera")) {

               return "Opera";

        }

        return "Firefox";

    }

    @Override
    protected void renderMergedOutputModel( Map<String, Object> model, HttpServletRequest request, HttpServletResponse response )
            throws Exception {
    	@SuppressWarnings("unchecked")
		Map<String, Object> map = (Map<String, Object>) model.get( "downloadFile" );
    	
        File file = (File) map.get( "file" );
        String fileName = "";
        if(map.get( "fileName" ) != null) fileName = (String) map.get("fileName");
        else fileName = file.getName();
        
        response.setContentType( getContentType() );
        response.setContentLength( (int) file.length() );
        
        String header = getBrowser(request);

        if (header.contains("MSIE")) {

               String docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");

               response.setHeader("Content-Disposition", "attachment;filename=" + docName + ";");

        } else if (header.contains("Firefox")) {

               String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 

               response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "\"");

        } else if (header.contains("Opera")) {

               String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 

               response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "\"");

        } else if (header.contains("Chrome")) {

               String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 

               response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "\"");

        }

        response.setHeader("Content-Type", "application/octet-stream");

        response.setHeader("Content-Transfer-Encoding", "binary;");

        response.setHeader("Pragma", "no-cache;");

        response.setHeader("Expires", "-1;");

        OutputStream out = response.getOutputStream();
        FileInputStream fis = null;

        try {
            fis = new FileInputStream( file );
            FileCopyUtils.copy( fis, out );
        } catch ( Exception e ) {
            e.printStackTrace();
        } finally {
            if ( fis != null ) {
                try {
                    fis.close();
                } catch ( Exception e ) {
                }
            }
            if ( out != null ) {
                try {
                    out.close();
                } catch ( Exception e ) {
                }
            }
        }
        out.flush();
    }
    
    

}
