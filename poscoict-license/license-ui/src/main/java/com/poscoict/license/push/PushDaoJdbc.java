package com.poscoict.license.push;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.jdbc.core.JdbcTemplate;

import com.poscoict.license.vo.PushMessage;
import com.poscoict.license.vo.PushSubscription;

public class PushDaoJdbc implements PushDao{

	private JdbcTemplate jdbcTemplate;
    private MessageSourceAccessor msAccessor = null;
    private Logger logger = LoggerFactory.getLogger(getClass());
    

    public void setMessageSourceAccessor(MessageSourceAccessor msAccessor) {
    	this.msAccessor = msAccessor;
    }

    public void setJdbcTemplate( JdbcTemplate jdbcTemplate ) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
	@Override
    // 푸쉬 메시지 개수 카운트
	public int getMessageCount() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.queryForObject(getQuery("push.getMessageCount"), Integer.class);
	}

	@Override
    // 푸쉬 메시지 생성
	public void insertPushMessage(PushMessage push) {
		// TODO Auto-generated method stub
		this.jdbcTemplate.update(getQuery("push.insertMessage"), push.getOBJECT_ID(), push.getCONTENT_NO(), push.getSENT_FLAG(), 
				push.getPOST_TYPE(), push.getBOARD_TYPE(), push.getSOLUTION_TYPE(), push.getPOST_TITLE(), 
				push.getCONTENT(), push.getUSER(), push.getCREATED_DATE());
	}
	
    @Override
	public List<Map<String, Object>> getUnsentPushMessages() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.queryForList(getQuery(("push.getUnsentMessages")));
	}
    
    
    @Override
	public List<Map<String, Object>> getTheMostRecentPushMessages() {
		// TODO Auto-generated method stub
    	return this.jdbcTemplate.queryForList(getQuery(("push.getTheMostRecentMessage")));
	}

	@Override
	public void updateSentMessages() {
		// TODO Auto-generated method stub
		this.jdbcTemplate.update(getQuery("push.updateSentMessages"));
	}

	@Override
	public void insertPushSubscription(PushSubscription pushSubscription) {
		// TODO Auto-generated method stub
		this.jdbcTemplate.update(getQuery("push.insertSubscription"), pushSubscription.getEND_POINT(), pushSubscription.getP256DH_KEY(), 
				pushSubscription.getSUBSCRIPTION_STATUS());
	}
    
	@Override
	public List<Map<String, Object>> getSubscriptionUserList() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.queryForList(getQuery("push.getSubscriptionUserList"));
	}

	//
    public String getQuery(String queryKey){
    	String query = this.msAccessor.getMessage(queryKey);
    	logger.debug(queryKey);
    	return query;
    }
}
