package com.poscoict.license.push;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;

public class PushSender {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	InputStream inputStream;
	Properties prop;
	String propFileName, serverKey;
	
	/*
	 * property 파일을 MessageSourceAccessor 로 처리할 수 있는지 확인
	 * http://whybk.tistory.com/33
	*/
	public void getServerKey() throws IOException {
		try {
			prop = new Properties();
			propFileName = "key.properties";
			inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
			
			if (inputStream != null) {
				prop.load(inputStream);
			} else {
				throw new FileNotFoundException("property file " + propFileName + " is not found in the classpath");
			}
			
			serverKey = prop.getProperty("key");
		} catch (Exception e) {
			// TODO: handle exception
			logger.info("Exception: " + e);
		} finally {
			inputStream.close();
		}
	}
	
	public void sendPush(String endpoint) throws IOException {
		getServerKey();
		logger.info("@@ got serverKey : " + serverKey);
		
		try {
            Sender sender = new FCMSender(serverKey);
            logger.info("Obtained SeverKey is : "+ serverKey);
            Message message = new Message.Builder()
                              .collapseKey("message")
                              .timeToLive(3)
                              .delayWhileIdle(true)
                              .addData("message", "Notification from Java application")
                              .build();

            // Use the same token(or registration id) that was earlier
            // used to send the message to the client directly from
            // Firebase Console's Notification tab.
            Result result = sender.send(message, endpoint, 1);
            logger.info("Result: " + result.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
}
