package com.poscoict.license.push;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.PlatformTransactionManager;

public class PushService {
	
	@Autowired
	private PushDao pushDao;
	private Logger logger = LoggerFactory.getLogger(getClass());
	PushSender push = new PushSender();
	
	/* Steps to send push messages (When posting boards, comments)
	 * 1. Get subscription user lists
	 * 2. Get the push message data to send
	 * 3. Send a push message
	 * 
	 * Steps to send unsent push messages (When users come back to the site in a long time)
	 * 1. Get subscription users list
	 * 2. Get the push message data to send
	 * 3. send unsent push messages
	 */
	
	// subscription users = the number of endpoints
	public List<Map<String, Object>> getSubscriptionUsers() {
		List<Map<String, Object>> list = pushDao.getSubscriptionUserList();
		
//		Object[] endpoint_list = list.toArray();
//		logger.info("endpoint_list array : " + endpoint_list.toString());
//		int numberOfSubscription = list.size();
//		logger.info("subscription number : " + numberOfSubscription);
		
		return list;
	}
	
	public void sendPushMessage() throws IOException {
		List<Map<String, Object>> list = getSubscriptionUsers();
		
		for (Map<String, Object> map : list) {
		    for (Map.Entry<String, Object> entry : map.entrySet()) {
		        String endpoint = entry.getValue().toString();
		        push.sendPush(endpoint);
		        
		        logger.info("each endpoint : " + endpoint.toString());
		    }
		}
	}
	
	public List<Map<String, Object>> getUnsentPushMessages() {
		List<Map<String, Object>> list = pushDao.getUnsentPushMessages();
		
		return list;
	}
	
	
}
