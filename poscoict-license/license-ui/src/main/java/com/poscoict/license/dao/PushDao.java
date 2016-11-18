package com.poscoict.license.dao;

import com.poscoict.license.vo.PushMessage;

public interface PushDao {

	int getMessageCount( String FOLDER_ID );
	
	void insertPushMessage( PushMessage push );
}
