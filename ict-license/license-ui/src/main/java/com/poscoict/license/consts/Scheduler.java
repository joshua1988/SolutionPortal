package com.poscoict.license.consts;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class Scheduler {
	private Logger logger = LoggerFactory.getLogger(getClass());
    @Scheduled(cron="0 0 2 * * *") // 매일 오전 2시  @Scheduled(fixedDelay=100000)
    public void deleteCertificate() {
	    logger.info("___Scheduler__deleteCertificate START "+new SimpleDateFormat( "yyyy/MM/dd HH:mm:ss" ).format(new Date()));
	   
	    try{
		    // pdf 파일삭제
		    deleteFile("Scheduler PDF 파일삭제: ", new File(Consts.PDF_PATH).listFiles());
		   
		    // image 파일삭제
		    deleteFile("Scheduler IMG 파일삭제: ", new File(Consts.IMG_PATH).listFiles());
		   
		    // 서버임시폴더 image 파일삭제
		    String serverTempFolderPath = this.getClass().getResource("/").getPath();
		    serverTempFolderPath = serverTempFolderPath.substring(0, serverTempFolderPath.indexOf("WEB-INF")-1)+Consts.IMG_TEMP_FOLDER;
		    deleteFile("Scheduler serverIMG 파일삭제: ", new File(serverTempFolderPath).listFiles()); 
		   
	    }catch(Exception e){
		    logger.error("___Scheduler__deleteCertificate", e);
	    }
	   
	    logger.info("___Scheduler__deleteCertificate END "+new SimpleDateFormat( "yyyy/MM/dd HH:mm:ss" ).format(new Date()));
    }
   
    public void deleteFile(String message, File[] fileList){
	    for(int i=0; i<fileList.length; i++){
		    File file = fileList[i];
		    if(file.isFile()){
			    String format = file.getName().substring(file.getName().lastIndexOf(".")+1);
			    if(format.equals("pdf") || format.equals(Consts.IMG_FORMAT)){
				    logger.info(message+file.getName());
				    file.delete();
			    }
		    }
	    }
    }

}
