package com.poscoict.license.push;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.android.gcm.server.Sender;

class FCMSender extends Sender {

    public FCMSender(String key) {
        super(key);
    }

    @Override
    protected HttpURLConnection getConnection(String url) throws IOException {
        String fcmUrl = "https://android.googleapis.com/gcm/send";
        return (HttpURLConnection) new URL(fcmUrl).openConnection();
    }
}