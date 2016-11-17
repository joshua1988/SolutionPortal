package com.poscoict.license.web.controller;

import java.io.IOException;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;
import com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException;
import com.poscoict.license.service.UserException;

@ControllerAdvice
public class ExceptionControllerAdvice {
	private static final String DEFAULT_ERROR_VIEW = "error/error";
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	public ModelAndView errView(Exception ex){
		logger.error(ex.toString());
		ModelAndView mv = new ModelAndView(DEFAULT_ERROR_VIEW);
		mv.addObject("name", ex.getClass().getSimpleName());
		//mv.addObject("message", ex.getMessage());
		mv.addObject("message", "시스템장애발생");
		
		if(ex.getClass().getSimpleName().equals("BadSqlGrammarException")){
			mv.addObject("message", "데이터 베이스 오류. 다시 시도해 주세요.");
		}
		else if(ex.getClass().getSimpleName().equals("MySQLSyntaxErrorException")){
			mv.addObject("message", "데이터 베이스 오류. 다시 시도해 주세요.");
		}
		else if(ex.getClass().getSimpleName().equals("NullPointerException")){
			mv.addObject("message", "데이터 누락. 데이터를 확인해 주세요.");
		}
		else if(ex.getClass().getSimpleName().equals("DuplicateKeyException")){
			mv.addObject("message", "중복된 키 발생. 데이터를 확인해 주세요.");
		}
		else if(ex.getClass().getSimpleName().equals("SQLException")){
			mv.addObject("message", "데이터 베이스 오류. 다시 시도해 주세요.");
		}
		else if(ex.getClass().getSimpleName().equals("MySQLIntegrityConstraintViolationException")){
			mv.addObject("message", "중복된 키 발생. 데이터를 확인해 주세요.");
		}
		else if(ex.getClass().getSimpleName().equals("DataIntegrityViolationException")){
			mv.addObject("message", "중복된 키 발생. 데이터를 확인해 주세요. 파일 삭제시 사용자와 매핑된 파일 일 수 있습니다.");
		}
		else if(ex.getClass().getSimpleName().equals("IOException")){
			mv.addObject("message", "시스템장애발생");
		}
		else if(ex.getClass().getSimpleName().equals("Exception")){
			mv.addObject("message", "ex.시스템장애발생");
		}
		else{
			mv.addObject("message", "시스템장애발생");
		}

		return mv;
	}
	
	@ExceptionHandler(Exception.class)
	public ModelAndView handleException(Exception ex) {
		return errView(ex);
	}
	
	@ExceptionHandler(RuntimeException.class)
	public ModelAndView handleRuntimeException(RuntimeException ex) {
		return errView(ex);
	}
	
	@ExceptionHandler(IOException.class)
	public ModelAndView handleIOException(IOException ex){
		return errView(ex);
	}
	
	@ExceptionHandler(MySQLSyntaxErrorException.class)
	public ModelAndView handleMySQLSyntaxErrorException(MySQLSyntaxErrorException ex){
		logger.error(ex.toString());
		ModelAndView mv = new ModelAndView(DEFAULT_ERROR_VIEW);
		mv.addObject("name", ex.getClass().getSimpleName());
		mv.addObject("message", "DB에러");
		return mv;
	}
	
	@ExceptionHandler(NullPointerException.class)
	public ModelAndView handleNullPointerException(NullPointerException ex){
		logger.error(ex.toString());
		ModelAndView mv = new ModelAndView(DEFAULT_ERROR_VIEW);
		mv.addObject("name", ex.getClass().getSimpleName());
		mv.addObject("message", "데이터 누락. 데이터를 확인해 주세요.");
		return mv;
	}
	
	@ExceptionHandler(DuplicateKeyException.class)
	public ModelAndView handleDuplicateKeyException(DuplicateKeyException ex){
		logger.error(ex.toString());
		ModelAndView mv = new ModelAndView(DEFAULT_ERROR_VIEW);
		mv.addObject("name", ex.getClass().getSimpleName());
		mv.addObject("message", "중복된 키 발생. 데이터를 확인해 주세요.");
		return mv;
	}

	@ExceptionHandler(SQLException.class)
	public ModelAndView handleSQLException(SQLException ex){
		logger.error(ex.toString());
		ModelAndView mv = new ModelAndView(DEFAULT_ERROR_VIEW);
		mv.addObject("name", ex.getClass().getSimpleName());
		mv.addObject("message", "데이터 베이스 오류. 다시 시도해 주세요.");
		return mv;
	}
	
	@ExceptionHandler(MySQLIntegrityConstraintViolationException.class)
	public ModelAndView handleMySQLIntegrityConstraintViolationException( MySQLIntegrityConstraintViolationException ex){
		logger.error(ex.toString());
		ModelAndView mv = new ModelAndView(DEFAULT_ERROR_VIEW);
		mv.addObject("name", ex.getClass().getSimpleName());
		mv.addObject("message", "중복된 키 발생. 데이터를 확인해 주세요.");
		return mv;
	}
	
	@ExceptionHandler(DataIntegrityViolationException.class)
	public ModelAndView handleDataIntegrityViolationException( DataIntegrityViolationException ex){
		logger.error(ex.toString());
		ModelAndView mv = new ModelAndView(DEFAULT_ERROR_VIEW);
		mv.addObject("name", ex.getClass().getSimpleName());
		mv.addObject("message", "중복된 키 발생. 데이터를 확인해 주세요. 파일 삭제시 사용자와 매핑된 파일 일 수 있습니다.");
		return mv;
	}
	
	@ExceptionHandler(UserException.class)
	public ModelAndView handleUserException( UserException ex){
		logger.error(ex.getMessage());
		ModelAndView mv = new ModelAndView(DEFAULT_ERROR_VIEW);
		mv.addObject("name", ex.getClass().getSimpleName());
		mv.addObject("message", ex.getMessage());
		return mv;
	}
}
