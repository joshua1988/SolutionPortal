package com.poscoict.license.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.multipart.MultipartFile;

import com.poscoict.license.consts.Consts;
import com.poscoict.license.dao.MorgueDao;
import com.poscoict.license.security.CustomUserDetails;
import com.poscoict.license.util.LmsUtil;
import com.poscoict.license.vo.Reply;
import com.poscoict.license.vo.UserPermission;

@Service
public class MorgueService extends LmsUtil {
	@Autowired
	private MorgueDao morgueDao;
	
	@Autowired
	private PlatformTransactionManager transactionManager;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	public List<Map<String, Object>> getUerCustomBoardList( String userNo ) {		
		return morgueDao.getUerCustomBoardList( userNo );
	}
	
	public void createCustomBoard(HttpSession session, String boardName) {
		String boardId = "cb_"+attachFileDateFormat()+UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12);
		String userNo = (String) session.getAttribute("USER_NO");
		morgueDao.createCustomBoard( userNo, boardId, boardName);
		logger.info("create Custom Board - userNo: "+userNo+" boardId: "+boardId);
	}
	
	public void deleteCustomBoard( String boardId, String userNo ) {
		morgueDao.deleteCustomBoard( boardId, userNo );
		logger.info("deleteCustomBoard "+boardId);
	}
	
	public void renameCustomBoard( String boardId, String boardName, String userNo ) {
		morgueDao.renameCustomBoard( boardId, boardName, userNo);
		logger.info("renameCustomBoard "+boardId);
	}
	
	public Map<String, Object> getBoardList( String boardId, String chartNum, String search, String select ){
		Map<String, Object> map = new HashMap<String, Object>();
		
        int pageList = 14; // 페이지당 14개 게시물
        int totalCount = 0;
        int totalPage = 0;
        
        int start = ( Integer.parseInt( chartNum ) == 1 ) ? 0 : ( Integer.parseInt( chartNum ) - 1 ) * pageList;
        List<Map<String, Object>> list = null;
        
        if ( ( search == null ) || ( search == "" ) ) { // 전체목록
        	totalCount = morgueDao.getBoardCount(boardId);
        	totalPage = (int) Math.ceil( (double) totalCount / pageList ); // 총 페이지 갯수
        	list = morgueDao.getCustomBoardList(boardId, start, pageList);
        } else {
        	totalCount = morgueDao.getSearchCount(boardId, search, select);
        	totalPage = (int) Math.ceil( (double) totalCount / pageList ); // 총 페이지 갯수
        	list = morgueDao.getBoardSearch(boardId, search, select, start, pageList);
        }
        
        map.put("list", list);
        map.put("totalPage", totalPage);
        map.put("boardName", morgueDao.getCustomBoardName(boardId));
        
		return map;
	}
	
	public String getCustomBoardName ( String boardId ) {
		return morgueDao.getCustomBoardName( boardId );
	}
	
	public void insertBoard( String title, String boardId, String mainContent, MultipartFile[] boardAttach, HttpSession session) throws UserException {
		TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		int no = morgueDao.getBoardTotalCount(boardId)+1;
		String userNo = (String) session.getAttribute("USER_NO");
		
		ArrayList<Map<String, Object>> attachList = new ArrayList<Map<String,Object>>();
        if(boardAttach.length>0){
            for ( int i=0; i<boardAttach.length; i++ ) {
            	
            	Map<String, Object> attach = new HashMap<String, Object>();
            	String attachPath = Consts.BOARD_ATTACH_FILE_HOME;
            	attachPath+= File.separator+"custom"+File.separator+boardId + File.separator + attachDateFormat() + File.separator + attachFileDateFormat();
                attach.put("fileName", boardAttach[i].getOriginalFilename());
                
                int attachSize = (int) boardAttach[i].getSize();
                if(attachSize==0) continue;
                
                if(attachSize>100*1024*1000)
                	throw new UserException("첨부파일 크기가 100MB를 초과 하였습니다.");

                attachPath+="("+(i+1)+")_"+UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12);
                
                if(boardAttach[i].getOriginalFilename().lastIndexOf(".") != -1){
                	attachPath+=boardAttach[i].getOriginalFilename().substring(boardAttach[i].getOriginalFilename().lastIndexOf("."));
                }
                String objectId = "at_"+attachFileDateFormat()+i;
                objectId += UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12);
                
                attach.put("filePath", attachPath);
                attach.put("fileSize", attachSize);
                attach.put("objectId", objectId);
                attachList.add(attach);
                
                try {
                    File ufile = new File( attachPath );
                    if ( !ufile.exists() ) {
                    	ufile.mkdirs();
                    }
                    boardAttach[i].transferTo( ufile );
                } catch ( IOException e ) {
                    e.printStackTrace();
                    try {
						throw new IOException("첨부파일 등록 실패");
					} catch (IOException e1) {
						e1.printStackTrace();
					}
                }
            }
        }
        
        try{
        	if(attachList.size()>0){
        		for(int i=0; i<attachList.size(); i++){
        			morgueDao.setAttachFileInfo(no, boardId, attachList.get(i).get("objectId").toString(), attachList.get(i).get("fileName").toString(), 
        					attachList.get(i).get("filePath").toString(), Integer.parseInt(attachList.get(i).get("fileSize").toString()), userNo);
        		}        		
        	}
        	morgueDao.insertBoard(no, boardId, title, mainContent.replaceAll("'", "&apos;"), userNo, no, 1);
        	this.transactionManager.commit(status);
        }catch(Exception e){
        	this.transactionManager.rollback(status);
        	logger.error("userDao.insertBoard: ", e);
        	throw new UserException("게시물 등록 실패");
        }
		
	}
	
    public Map<String, Object> viewPost( String boardId, String chartNum, String contentNo, String search,  String select, HttpSession session ) throws UserException {
        logger.info("cViewPost: boardId= " + boardId + " contentNo= " + contentNo);
        // 게시물 내용 가져오기
        Map<String, Object> temp = morgueDao.getViewPost( boardId, Integer.parseInt( contentNo ) );
        List<Map<String, Object>> attachList= morgueDao.getBoardAttachInfo(boardId, Integer.parseInt( contentNo ));
        
        Map<String, Object> map = new HashMap<String, Object>();	
        map.put("boardInfo", temp);
        map.put("attachInfo", attachList);
        return map;
    }
    
    public Map<String, Object> replyBoardForm( String boardId, String contentNo ) {
    	Map<String, Object> map = morgueDao.getViewPost( boardId, Integer.parseInt( contentNo ) );
        return map;
    }
    
    public ArrayList<Map<String, Object>> replyList( String boardId, String contentNo, HttpSession session ) {
        logger.info("customBoardReplyList: contentNo= " + contentNo + " boardId= " + boardId);
        ArrayList<Map<String, Object>> list = (ArrayList<Map<String, Object>>) morgueDao.getReplyList( boardId, Integer.parseInt( contentNo ) );
        return list;
    }
    
    public String insertReply( String boardId, String contentNo, String mainContent, HttpSession session ) throws UserException {
        logger.info("insertCustomBoardReply: contentNo= " + contentNo + " boardId= " + boardId);
        int no = morgueDao.getReplyCount( boardId, Integer.parseInt( contentNo ) );        
        try{
        	morgueDao.insertReply( Integer.parseInt(contentNo), boardId, no+1, mainContent.trim(), (String) session.getAttribute( "USER_NO" ) );
        }catch(Exception e){
        	logger.error("morgueDao.insertReply", e);
        	throw new UserException("리플 등록 실패");
        }
        
        return "end";
    }
    
    public String deleteReply( String boardId, String reContentNo, String contentNo, HttpSession session ) {
        morgueDao.deleteReply((String) session.getAttribute( "USER_NO" ), Integer.parseInt(contentNo), boardId, Integer.parseInt(reContentNo));
        return "end";
    }
    
    public int replyBoard( HttpSession session, String boardId, String title, String content, String contentNo,
            MultipartFile[] boardAttach ) throws UserException {
    	logger.info("replyCustomBoard: boardId= " + boardId + " contentNo= " + contentNo);
    	TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
    	
        CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
        String userNo = userDetails.getUserNo();
    	
        // 상위글 GRP, SEQ 얻어오기
        HashMap<String, Object> map = (HashMap<String, Object>) morgueDao.replyCheck( boardId, Integer.parseInt( contentNo ) );
        // 답글 입력
        int no = morgueDao.getBoardTotalCount(boardId)+1;
        
        ArrayList<Map<String, Object>> attachList = new ArrayList<Map<String,Object>>();
        if(boardAttach.length>0){
            for ( int i=0; i<boardAttach.length; i++ ) {
            	
            	Map<String, Object> attach = new HashMap<String, Object>();
            	String attachPath = Consts.BOARD_ATTACH_FILE_HOME;
            	attachPath+= boardId + File.separator + attachDateFormat() + File.separator + attachFileDateFormat();
                attach.put("fileName", boardAttach[i].getOriginalFilename());
                
                int attachSize = (int) boardAttach[i].getSize();
                if(attachSize==0) continue;
                
                if(attachSize>100*1024*1000)
                	throw new UserException("첨부파일 크기가 100MB를 초과 하였습니다.");

                attachPath+="("+(i+1)+")_"+UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12);
                
                if(boardAttach[i].getOriginalFilename().lastIndexOf(".") != -1){
                	attachPath+=boardAttach[i].getOriginalFilename().substring(boardAttach[i].getOriginalFilename().lastIndexOf("."));
                }
                String objectId = "at_"+attachFileDateFormat()+i;
                objectId += UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12);
                
                attach.put("filePath", attachPath);
                attach.put("fileSize", attachSize);
                attach.put("objectId", objectId);
                attachList.add(attach);
                
                System.out.println( "up: fileName: " + boardAttach[i].getOriginalFilename() + " attachPath: " + attachPath );
                try {
                    File ufile = new File( attachPath );
                    if ( !ufile.exists() ) {
                    	ufile.mkdirs();
                    }
                    boardAttach[i].transferTo( ufile );
                } catch ( IOException e ) {
                    e.printStackTrace();
                    try {
						throw new IOException("첨부파일 등록 실패");
					} catch (IOException e1) {
						e1.printStackTrace();
					}
                }
            }
        }
        
        try{
        	if(attachList.size()>0){
        		for(int i=0; i<attachList.size(); i++){
        			morgueDao.setAttachFileInfo(no, boardId, attachList.get(i).get("objectId").toString(), attachList.get(i).get("fileName").toString(), 
        					attachList.get(i).get("filePath").toString(), Integer.parseInt(attachList.get(i).get("fileSize").toString()), userNo);
        		}        		
        	}
        	morgueDao.insertBoard(no, boardId, title, content.replaceAll("'", "&apos;"), 
        			userNo, (Integer) map.get( "CONTENT_GRP" ), (Integer) map.get( "CONTENT_SEQ" ) + 1);
        	
        	this.transactionManager.commit(status);
        }catch(Exception e){
        	this.transactionManager.rollback(status);
        	logger.error("userDao.insertBoard: ", e);
        	throw new UserException("게시물 등록 실패");
        }
        
        logger.info("replyBoard: success ");
        return no;
    }
    
    public Map<String, Object> modifyBoardForm(HttpSession session, String boardId, String contentNo) throws UserException{
    	logger.info("cModifyBoardForm: boardId= " + boardId + " contentNo= " + contentNo);
    	Map<String, Object> boardInfo = morgueDao.getViewPost( boardId, Integer.parseInt( contentNo ) );
    	boardInfo.put("MAIN_CONTENT", ((String) boardInfo.get("MAIN_CONTENT")).replaceAll( "\r\n", "</br>" ));
    	List<Map<String, Object>> attachList= morgueDao.getBoardAttachInfo(boardId, Integer.parseInt( contentNo ));
    	
    	Map<String, Object> temp = new HashMap<String, Object>();
    	temp.put("boardInfo", boardInfo);
    	temp.put("attachInfo", attachList);
    	
    	return temp;
    }
    
    public void modifyBoard( HttpSession session, String boardId, String title, String content, String contentNo,
            MultipartFile[] boardAttach, String[] deleteFile ) throws UserException {
    	logger.info("cModifyBoard: boardId= " + boardId + " contentNo= " + contentNo);
    	TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
        
        ArrayList<Map<String, Object>> attachList = new ArrayList<Map<String,Object>>();
        
        try{
        	morgueDao.modifyBoard( title, content.replaceAll("'", "&apos;"), dateFormat(), 
        			(String) session.getAttribute( "USER_NO" ), boardId, contentNo ); 
        	
            if(boardAttach.length>0){
                for ( int i=0; i<boardAttach.length; i++ ) {
                	Map<String, Object> attach = new HashMap<String, Object>();
                	String attachPath = Consts.BOARD_ATTACH_FILE_HOME;
                	attachPath+= File.separator+"custom"+File.separator+boardId + File.separator + attachDateFormat() + File.separator + attachFileDateFormat();
                    attach.put("fileName", boardAttach[i].getOriginalFilename());
                    
                    int attachSize = (int) boardAttach[i].getSize();
                    if(attachSize==0) continue;
                    if(attachSize>100*1024*1000)
                    	throw new UserException("첨부파일 크기가 100MB를 초과 하였습니다.");

                    attachPath+="("+(i+1)+")";
                    if(boardAttach[i].getOriginalFilename().lastIndexOf(".") != -1){
                    	attachPath+=boardAttach[i].getOriginalFilename().substring(boardAttach[i].getOriginalFilename().lastIndexOf("."));
                    }
                    String objectId = "at_"+attachFileDateFormat()+i;
                    objectId += UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12);
                    
                    attach.put("filePath", attachPath);
                    attach.put("fileSize", attachSize);
                    attach.put("objectId", objectId);
                    attachList.add(attach);
                    
                    try {
                        File ufile = new File( attachPath );
                        if ( !ufile.exists() ) {
                        	ufile.mkdirs();
                        }
                        boardAttach[i].transferTo( ufile );
                        morgueDao.setAttachFileInfo(Integer.parseInt(contentNo), boardId, attachList.get(i).get("objectId").toString(), attachList.get(i).get("fileName").toString(), 
            					attachList.get(i).get("filePath").toString(), Integer.parseInt(attachList.get(i).get("fileSize").toString()), (String) session.getAttribute( "USER_NO" ));
                    } catch ( IOException e ) {
                        e.printStackTrace();
                        try {
    						throw new IOException("첨부파일 등록 실패");
    					} catch (IOException e1) {
    						e1.printStackTrace();
    					}
                    }
                }
            }
            
        	// 첨부파일 삭제
        	if(deleteFile!=null){
        		for(int i=0; i<deleteFile.length; i++){
        			String deleteAttachFilePath = morgueDao.getAttachFilePath(deleteFile[i]);
        			logger.info("deleteAttachFilePath: " + deleteAttachFilePath);
        			File file = new File(deleteAttachFilePath);
        			if(file.exists()==true)
        				file.delete();        			
        			morgueDao.deleteAttachFile(deleteFile[i]);
        		}
        	}
        		
        	transactionManager.commit(status);
        }catch(Exception e){
        	logger.error("userDao.modifyBoard: ", e);
        	transactionManager.rollback(status);
        	throw new UserException("게시물 수정 실패");
        }
        logger.info("modifyBoard-success");
    }
    
    public void deleteBoard( HttpSession session, String boardId, String contentNo ) throws UserException {
    	logger.info("deleteBoard: boardId= " + boardId + " contentNo= " + contentNo);

    	morgueDao.deleteBoard( dateFormat(), (String) session.getAttribute("USER_NO"), boardId, Integer.parseInt( contentNo ) );
    }
    
    
	public String getUserMenu(UserPermission userPermission, CustomUserDetails userDetails){
		return initializeMenu(new StringBuffer(), userPermission, userDetails).toString();
	}
	
	public String defaultprojectFolderTree(String solution,CustomUserDetails userDetails){
		if(Consts.SubCategory.GLUE.getCategory().equals(solution)) solution=Consts.PROJECT_GLUE_ROOT_ID;
		if(Consts.SubCategory.GLUEMASTER.getCategory().equals(solution)) solution=Consts.PROJECT_GLUEMASTER_ROOT_ID;
		if(Consts.SubCategory.GLUEMOBILE.getCategory().equals(solution)) solution=Consts.PROJECT_GLUEMOBILE_ROOT_ID;
		if(Consts.SubCategory.UCUBE.getCategory().equals(solution)) solution=Consts.PROJECT_UCUBE_ROOT_ID;
		if(Consts.SubCategory.POSBEE.getCategory().equals(solution)) solution=Consts.PROJECT_POSBEE_ROOT_ID;
		
		return getDefaultProjectFolderTree( solution, userDetails );
	}
	
	public void projectFolders( HttpSession session, String solution, String mode, String upperId, String projectName ) throws UserException {
		if(upperId.equals("root")) {
			if(Consts.SubCategory.GLUE.getCategory().equals(solution)) upperId=Consts.PROJECT_GLUE_ROOT_ID;
			if(Consts.SubCategory.GLUEMASTER.getCategory().equals(solution)) upperId=Consts.PROJECT_GLUEMASTER_ROOT_ID;
			if(Consts.SubCategory.GLUEMOBILE.getCategory().equals(solution)) upperId=Consts.PROJECT_GLUEMOBILE_ROOT_ID;
			if(Consts.SubCategory.UCUBE.getCategory().equals(solution)) upperId=Consts.PROJECT_UCUBE_ROOT_ID;
			if(Consts.SubCategory.POSBEE.getCategory().equals(solution)) upperId=Consts.PROJECT_POSBEE_ROOT_ID;
		}
		
		if(mode.equals("F")) {
			morgueDao.createProjectFolder( upperId, getRandomId(mode), projectName.trim(), (String)session.getAttribute("USER_NO") );
		}
		if(mode.equals("B")) {
			String boardId = getRandomId(mode);
			TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
			try{
				morgueDao.createProjectBoard( upperId, boardId, (String)session.getAttribute("USER_NO") );
				morgueDao.createCustomBoard( Consts.PROJECT_ROOT_ID, boardId, projectName.trim(), (String)session.getAttribute("USER_NO") );	
				this.transactionManager.commit(status);
			}catch(Exception e){
				this.transactionManager.rollback(status);
	        	logger.error("createProjectBoard FAIL: ", e);
	        	throw new UserException("게시판 생성 실패");
			}
		}
		if(mode.equals("EF")) {
			morgueDao.renameProjectFolder( upperId, projectName.trim(), (String)session.getAttribute("USER_NO") );
		}
		if(mode.equals("DF")) {
			morgueDao.deleteProjectFolder( upperId, (String)session.getAttribute("USER_NO") );
		}
		if(mode.equals("EB")) {
			morgueDao.renameCustomBoard( upperId, projectName.trim(), (String)session.getAttribute("USER_NO") );
		}
		if(mode.equals("DB")) {
			morgueDao.deleteCustomBoard( upperId, (String)session.getAttribute("USER_NO") );
		}
	}
	
	public String getRandomId(String mode){
		return mode.toLowerCase()+"_"+attachFileDateFormat()+UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12);
	}
}
