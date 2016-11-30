package com.poscoict.license.dao;

import java.util.List;
import java.util.Map;

import com.poscoict.license.vo.PushMessage;

public interface PushDao {

	int getMessageCount();
	
	void insertPushMessage(PushMessage push);
	
	List<Map<String, Object>> getUnsentPushMessages();
}
