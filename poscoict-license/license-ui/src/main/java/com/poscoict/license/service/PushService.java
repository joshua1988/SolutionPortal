package com.poscoict.license.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.PlatformTransactionManager;

import com.poscoict.license.dao.PushDao;

public class PushService {
	
	@Autowired
	private PushDao pushDao;
	
	@Autowired
	private PlatformTransactionManager transactionManager;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	
}
