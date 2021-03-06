package com.poscoict.license.push;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.poscoict.license.vo.PushSubscription;

@RestController
public class PushController {

	@Autowired
	private PushDao pushDao;
	
	@Autowired
	private PushService pushService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
    @RequestMapping(value="/push/subscription", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public void updateSubscription(@RequestBody Map<String,String> data) throws IOException {
    	
    	logger.info("endpoint received : " + data.get("endpoint"));
    	logger.info("key received : " + data.get("key"));
    	logger.info("status received : " + data.get("subscription_status"));
    	
    	String endpoint = data.get("endpoint");
    	String key = data.get("key");
    	String subscription_status = data.get("subscription_status");
    	
    	pushDao.insertPushSubscription(new PushSubscription(endpoint, key, subscription_status));
    }
    
    // Send a push message to the each browser (users)
    @RequestMapping("/push/fetch/message")
    public List<Map<String, Object>> fetchPushMessage() throws IOException {
    	List<Map<String, Object>> list = pushService.getMostRecentMessage();
    	
    	return list;
    }
    
    // if you want to forward all the unsent messages to users,
    // implement it here
//    public List<Map<String, Object>> fetchPushMessages() {}
    
    // Send messages to google server
    @RequestMapping("/push/send")
    public void sendMessages() throws IOException {
    	pushService.sendPushMessage();
    }
    
    @RequestMapping("/push/update/messages")
    public void updateSentMessages() throws IOException {
    	pushService.updateSentMessages();
    }
    
    
    
    
}