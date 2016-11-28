package com.poscoict.license.push;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.poscoict.license.dao.PushDao;
import com.poscoict.license.vo.PushMessage;
import com.poscoict.license.vo.PushSubscription;

@RestController
public class PushController {
	
	@Autowired
	private PushDao pushDao;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
    private static final String post_type = "게시글";
    private static final String board_type = "Q&A";
    private static final String solution_type = "Glue Mobile";
    private static final String post_title = "푸쉬 메시지 설치 가이드";

    @RequestMapping("/push/message")
    public PushMessage getMessage(@RequestParam(value="pushID", defaultValue="10") String name) {
    	pushDao.insertPushMessage(new PushMessage(1, 11, true, post_type, board_type, solution_type, post_title, name, name, name));
    	return new PushMessage(1, 11, true, post_type, board_type, solution_type, post_title, name, name, name);
    }
    
    @RequestMapping(value="/push/subscription", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public PushSubscription updateSubscription(@RequestBody PushSubscription endpoint) {
    	
    	logger.info("post received : " + endpoint);
    	logger.info("post received : " + endpoint.getENDPOINT());
//    	return new PushSubscription("null", true);
    	return endpoint;
    }
    
    
}