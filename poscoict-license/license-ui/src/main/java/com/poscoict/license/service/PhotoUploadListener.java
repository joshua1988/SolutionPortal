package com.poscoict.license.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PhotoUploadListener implements ServletContextListener {
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		logger.info("____contextInitialized contextDestroyed(Photo Copy)____");
	}

	/*
	 * (non-Javadoc)
	 * @see javax.servlet.ServletContextListener#contextInitialized(javax.servlet.ServletContextEvent)
	 * 	톰캣 기동시 .metadata 사진 폴더 확인. 없으면 로컬 백업 폴더에서 복사
	 */
	@Override
	public void contextInitialized(ServletContextEvent event) {
		logger.info("____contextInitialized START(Photo Copy)____");
		String serverPath = event.getServletContext().getRealPath("/");
		String backupFolder = "D:"+File.separator+"files"+File.separator+"photoUpload";
		File temp = new File(serverPath+File.separator+"editor");
		
		logger.info("@@@@@@@@@@@ serverPath : " + serverPath);
		if(!temp.exists()){
			File backup = new File(backupFolder);
			File server = new File(serverPath);
			if(backup.exists()) copy(backup, server, serverPath);			
		}else{
			logger.info("____contextInitialized (Photo Directory)____"+temp.exists());
		}
		logger.info("____contextInitialized END(Photo Copy)____");
	}

	public void copy(File sourceF, File targetF, String serverPath){
		File[] ff = sourceF.listFiles();
		for (File file : ff) {
			File temp = new File( serverPath + File.separator + file.getName());
			if(file.isDirectory()){
				logger.info("Photo copy(Directory): "+file.getName());
				temp.mkdir();
				
				copy(file, temp, serverPath + File.separator + file.getName());
//				copy(file, temp, serverPath + file.getName());
			} else {
				logger.info("Photo copy(File): "+file.getName());
				FileInputStream fis = null;
				FileOutputStream fos = null;
				try {
					fis = new FileInputStream(file);
					fos = new FileOutputStream(temp) ;
					byte[] b = new byte[(int) file.length()];
					int cnt = 0;
					while((cnt=fis.read(b)) != -1){
						fos.write(b, 0, cnt);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally{
					try {
						fis.close();
						fos.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						logger.error("____contextInitialized (Photo Copy): ", e);
						e.printStackTrace();
					}
				}
			}
		}
		
	}
}
