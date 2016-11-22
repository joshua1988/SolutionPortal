package com.poscoict.license.dao;

import com.poscoict.license.vo.PushMessage;

public interface PushDao {

	int getMessageCount();
	
	void insertPushMessage( PushMessage push );
}
