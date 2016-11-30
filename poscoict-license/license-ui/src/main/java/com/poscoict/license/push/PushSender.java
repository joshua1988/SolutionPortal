package com.poscoict.license.push;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import nl.martijndwars.webpush.GcmNotification;
import nl.martijndwars.webpush.Notification;
import nl.martijndwars.webpush.PushService;

public class PushSender {

	private static final String USER_AGENT = "Chrome/54.0.2840.99";
	private static final String POST_URL = "https://android.googleapis.com/gcm/send/ddcoH3mRabE:APA91bGvBh2TIvd3CN0GJPOjePE5HnPv_RjygiVgbly3E--EDWpmcNktjyi-tLeBn5XG4ihCoXQPQNQGk4tRI4rUgFSJbfi2MEQgtsqCWPFogfYkJHYfoUa5-6OdfdFSQ9lvZDea6lnj";
	
	public static void main(String[] args) throws Exception {

		PushSender http = new PushSender();
		
		String endpoint = "ddcoH3mRabE:APA91bGvBh2TIvd3CN0GJPOjePE5HnPv_RjygiVgbly3E--EDWpmcNktjyi-tLeBn5XG4ihCoXQPQNQGk4tRI4rUgFSJbfi2MEQgtsqCWPFogfYkJHYfoUa5-6OdfdFSQ9lvZDea6lnj";
//		PublicKey userPublicKey = "";
//		String userAuth = "";
//		String payload = "";
		
		// Or create a GcmNotification, in case of Google Cloud Messaging
		Notification notification = new GcmNotification(endpoint, null, null, null);

		// Instantiate the push service with a GCM API key
		PushService pushService = new PushService("AIzaSyBLu1iuV3vP0Z5W2NKBUjadlO9oJQYha64");

		// Send the notification
		pushService.send(notification);

//		System.out.println("\nTesting 2 - Send Http POST request");
//		http.sendPOST();
	}
	
	public static void sendPOST() throws IOException {
		URL obj = new URL(POST_URL);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestProperty("Authorization", "key=AIzaSyBLu1iuV3vP0Z5W2NKBUjadlO9oJQYha64");
		con.setRequestProperty("Content-Type", "application/json");
		con.setRequestMethod("POST");
		con.setDoOutput(true);
		
		// For POST only - START
//		OutputStream os = con.getOutputStream();
//		os.write(POST_PARAMS.getBytes());
//		os.flush();
//		os.close();
		// For POST only - END
		
		
		// JSON object
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("현대", "몽구");
		jsonObj.put("기아", "주영");
		
		OutputStreamWriter streamWriter = new OutputStreamWriter(con.getOutputStream());
		streamWriter.write(jsonObj.toString());
		streamWriter.flush();
		streamWriter.close();
		//

		int responseCode = con.getResponseCode();
		System.out.println("POST Response Code :: " + responseCode);

		if (responseCode == HttpURLConnection.HTTP_OK) { //success
			BufferedReader in = new BufferedReader(new InputStreamReader(
					con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			// print result
			System.out.println(response.toString());
		} else {
			System.out.println("POST request not worked");
		}
	}
}
