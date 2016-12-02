package com.poscoict.license.push;

import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;

public class PushSender {

//	private static final String USER_AGENT = "Chrome/54.0.2840.99";
//	private static final String POST_URL = "https://android.googleapis.com/gcm/send/";
	
	public static void main(String[] args) throws Exception {

		String serverKey = "AIzaSyBLu1iuV3vP0Z5W2NKBUjadlO9oJQYha64";
		try {
            Sender sender = new FCMSender(serverKey);
            Message message = new Message.Builder()
                              .collapseKey("message")
                              .timeToLive(3)
                              .delayWhileIdle(true)
                              .addData("message", "Notification from Java application")
                              .build();  

            // Use the same token(or registration id) that was earlier
            // used to send the message to the client directly from
            // Firebase Console's Notification tab.
            Result result = sender.send(message,
        "ddcoH3mRabE:APA91bGvBh2TIvd3CN0GJPOjePE5HnPv_RjygiVgbly3E--EDWpmcNktjyi-tLeBn5XG4ihCoXQPQNQGk4tRI4rUgFSJbfi2MEQgtsqCWPFogfYkJHYfoUa5-6OdfdFSQ9lvZDea6lnj",
                1);
            System.out.println("Result: " + result.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
		
	}
	
}
