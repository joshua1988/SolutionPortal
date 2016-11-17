package com.poscoict.license.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.poscoict.license.vo.PhotoFile;

@Controller
public class PhotoUploadController {
	final String backupFolder = "D:"+File.separator+"files"+File.separator+"photoUpload"+File.separator+"editor"+File.separator+"upload"+File.separator;
	final String backupFolderHTML5 = "D:"+File.separator+"files"+File.separator+"photoUpload"+File.separator+"editor"+File.separator+"multiupload"+File.separator;
	
	@RequestMapping(value="photoUploadCallback", method=RequestMethod.GET)
	public ModelAndView photoUploadCallback(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("board/callback");
		return mv;
	}
	
    @RequestMapping( value = {"PhotoUpload"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String PhotoUpload(HttpServletRequest request, HttpServletResponse response, PhotoFile upFile) throws Exception{
    	String return1 = request.getParameter("callback"); 
    	String return2 = "?callback_func="+request.getParameter("callback_func");
    	String return3 = "";
    	String name = "";
    	String serverPath = request.getContextPath();
    	System.out.println("_________________________IMG Controller");
    	try{
    		if(upFile.getFiledata() != null && upFile.getFiledata().getOriginalFilename() != null && !upFile.getFiledata().getOriginalFilename().equals("")){
    			name = upFile.getFiledata().getOriginalFilename().substring(upFile.getFiledata().getOriginalFilename().lastIndexOf(File.separator)+1);
    			String filename_ext = name.substring(name.lastIndexOf(".")+1);
    			filename_ext = filename_ext.toLowerCase();
    			String[] allow_file = {"jpg","png","bmp","gif"};
				int cnt=0;
				for(int i=0; i<allow_file.length; i++){
					if(filename_ext.equals(allow_file[i])){
						cnt++;
					}
				}
				if(cnt == 0){
					return3 = "&errstr="+name;
				}else{
					String dftFilePath = request.getSession().getServletContext().getRealPath("/");
					String folderPath = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
					String filePath = dftFilePath+"editor"+File.separator+"upload"+File.separator+folderPath+File.separator;
					File file = new File(filePath);
					if(!file.exists()){
						file.mkdirs();
					}
					
					String realFileNm = "";
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
					String today = formatter.format(new java.util.Date());
					realFileNm = today+UUID.randomUUID().toString()+name.substring(name.lastIndexOf("."));
					String rlFileNm = filePath + realFileNm;
					
					upFile.getFiledata().transferTo(new File(rlFileNm));
					
					//backup
					file = new File(backupFolder+folderPath+File.separator);
					if(!file.exists()){
						file.mkdirs();
					}
					fileCopy(rlFileNm, backupFolder+folderPath+File.separator+realFileNm);
					
					return3 += "&bNewLine=true";
					return3 += "&sFileName="+name;
					return3 += "&sFileURL="+serverPath+"/editor/upload/"+folderPath+"/"+realFileNm;
				}
    		}else{
    			return3 += "&errstr=error";
    		}
    	}catch(Exception e){
    		e.getStackTrace();
    	}
    	
    	System.out.println("______________return1+return2+return3: "+return1+return2+return3);
    	return "redirect:/photoUploadCallback"+return2+return3;
    }
    
    @RequestMapping( value = {"PhotoUploadHTML5"}, method = {RequestMethod.POST})
    public void PhotoUploadHTML5(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	try{
    		System.out.println("________PhotoUploadHTML5");
        	//파일정보
        	String sFileInfo = "";
        	String filename = request.getHeader("file-name");
        	String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
        	filename_ext = filename_ext.toLowerCase();
        	
        	String[] allow_file = {"jpg","png","bmp","gif"};
        	
        	int cnt=0;
        	for(int i=0; i<allow_file.length; i++){
        		if(filename_ext.equals(allow_file[i])){
        			cnt++;
        		}
        	}
        	
        	if(cnt==0){
        		PrintWriter print = response.getWriter();
        		print.print("NOTALLOW_"+filename);
        		print.flush();
        		print.close();
        	}else{
        		String dftFilePath = request.getSession().getServletContext().getRealPath("/");
        		String folderPath = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        		String filePath = dftFilePath+"editor"+File.separator+"multiupload"+File.separator+folderPath+File.separator;
        		File file = new File(filePath);
        		if(!file.exists()){
        			file.mkdirs();
        		}
				
        		String realFileNm = "";
        		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        		String today = formatter.format(new java.util.Date());
        		realFileNm = today+UUID.randomUUID().toString()+filename.substring(filename.lastIndexOf("."));
        		String rlFileNm = filePath + realFileNm;
        		
        		InputStream is = request.getInputStream();
        		OutputStream os = new FileOutputStream(rlFileNm);
        		int numRead;
        		byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
        		while((numRead = is.read(b, 0, b.length)) != -1){
        			os.write(b, 0, numRead);
        		}
        		if(is != null){
        			is.close();
        		}
        		os.flush();
        		os.close();
        		
        		//backup
				file = new File(backupFolderHTML5+folderPath+File.separator);
				if(!file.exists()){
					file.mkdirs();
				}
				fileCopy(rlFileNm, backupFolderHTML5+folderPath+File.separator+realFileNm);
        		System.out.println("___________rlFileNm: "+rlFileNm);
        		System.out.println("____________backupFolderHTML5: "+backupFolderHTML5+folderPath+File.separator+realFileNm);
        		
        		String serverPath = request.getContextPath();
        		sFileInfo += "&bNewLine=true";
        		sFileInfo += "&sFileName="+ filename;
        		sFileInfo += "&sFileURL="+serverPath+"/editor/multiupload/"+folderPath+"/"+realFileNm;
        		PrintWriter print = response.getWriter();
        		print.print(sFileInfo);
        		print.flush();
        		print.close();
        	}	
    	}catch(Exception e){
    		e.getStackTrace();
    	}
    }
    
	 public void fileCopy(String inFileName, String outFileName) {
		try {
			FileInputStream fis = new FileInputStream(inFileName);
			FileOutputStream fos = new FileOutputStream(outFileName);
			
			int data = 0;
			while((data=fis.read())!=-1) {
				fos.write(data);
			}
			fis.close();
			fos.close();
		} catch (IOException e) {
//			logger.error("파일복사 실패: "+inFileName, e);
			e.printStackTrace();
		}
	}
}
