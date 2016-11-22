package com.poscoict.license.push;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.poscoict.license.dao.PushDao;
import com.poscoict.license.vo.PushMessage;

@RestController
public class PushController {
	
	@Autowired
	private PushDao pushDao;
	
//  private static final String template = "Hello, %s!";
//  private final AtomicLong counter = new AtomicLong();
    private static final String post_type = "게시글";
    private static final String board_type = "Q&A";
    private static final String solution_type = "Glue Mobile";
    private static final String post_title = "푸쉬 메시지 설치 가이드";

//    @RequestMapping("/greeting")
//    public Greeting greeting(@RequestParam(value="name", defaultValue="World") String name) {
//        return new Greeting(counter.incrementAndGet(),
//                            String.format(template, name));
//    }
    
    @RequestMapping("/push/message")
    public PushMessage getMessage(@RequestParam(value="pushID", defaultValue="10") String name) {
    	pushDao.insertPushMessage(new PushMessage(1, 11, post_type, board_type, solution_type, post_title, name, name, name));
    	return new PushMessage(1, 11, post_type, board_type, solution_type, post_title, name, name, name);
    }
    
}