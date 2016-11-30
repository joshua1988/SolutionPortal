package com.poscoict.license.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.jdbc.core.JdbcTemplate;

import com.poscoict.license.vo.PushMessage;

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
    
    // Push Message
//    private RowMapper<PushMessage> pushMapper = new RowMapper<PushMessage>() {
//		@Override
//		public PushMessage mapRow(ResultSet rs, int rowNum) throws SQLException {
//			// TODO Auto-generated method stub
//			PushMessage push = new PushMessage();
//			push.setOBJECT_ID(rs.getInt("OBJECT_ID"));
//			push.setCONTENT_NO(rs.getInt("CONTENT_NO"));
//			push.setPOST_TYPE(rs.getString("POST_TYPE"));
//			push.setBOARD_TYPE(rs.getString("BOARD_TYPE"));
//			push.setSOLUTION_TYPE(rs.getString("SOLUTION_TYPE"));
//			push.setPOST_TITLE(rs.getString("POST_TITLE"));
//			push.setCONTENT(rs.getString("CONTENT"));
//			push.setUSER(rs.getString("USER"));
//			push.setCREATED_DATE(rs.getString("CREATED_DATE"));
//			return push;
//		}
//    };

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
	
    public String getQuery(String queryKey){
    	String query = this.msAccessor.getMessage(queryKey);
    	logger.debug(queryKey);
    	return query;
    }
}
