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
	
	/*public static void sendPOST() throws IOException, JSONException{
		try {
			URL obj = new URL(POST_URL);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			con.setRequestProperty("Authorization", "key=AIzaSyBLu1iuV3vP0Z5W2NKBUjadlO9oJQYha64");
//			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
			con.setRequestProperty("User-Agent", USER_AGENT);
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
			JSONObject data = new JSONObject();
			jsonObj.put("to", "ddcoH3mRabE:APA91bGvBh2TIvd3CN0GJPOjePE5HnPv_RjygiVgbly3E--EDWpmcNktjyi-tLeBn5XG4ihCoXQPQNQGk4tRI4rUgFSJbfi2MEQgtsqCWPFogfYkJHYfoUa5-6OdfdFSQ9lvZDea6lnj");
			data.put("title", "Push Sender");
			data.put("text", "nice");
			jsonObj.put("notification", data);
			
			System.out.println("jsonObj.toString() : "+jsonObj.toString());
			
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
			
			con.disconnect();
		} catch (MalformedURLException e){
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
	    }
	}*/
}
