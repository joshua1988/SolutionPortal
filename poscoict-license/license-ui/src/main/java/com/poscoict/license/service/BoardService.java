package com.poscoict.license.service;

import java.io.File;
import java.io.IOException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.multipart.MultipartFile;

import com.poscoict.license.consts.Consts;
import com.poscoict.license.dao.UserDao;
import com.poscoict.license.exception.UserException;
import com.poscoict.license.push.PushDao;
import com.poscoict.license.security.CustomUserDetails;
import com.poscoict.license.util.LmsUtil;
import com.poscoict.license.vo.Board;
import com.poscoict.license.vo.PushMessage;
import com.poscoict.license.vo.Reply;
import com.poscoict.license.vo.UserInfo;
import com.poscoict.license.vo.UserPermission;

@Service
public class BoardService extends LmsUtil {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private PushDao pushDao;

	@Autowired
	private PlatformTransactionManager transactionManager;

	private Logger logger = LoggerFactory.getLogger(getClass());

	public String checkLogin(String text, String password, HttpSession session, HttpServletRequest request){
		logger.info("_______checkLogin: " + text);
		String url="redirect:/board";
		int check = 0;

    	session.invalidate();
    	session = request.getSession();

        if ( ( text.trim() != "" ) && ( password.trim() != "" ) ) {
            check = userDao.loginCheck( text.trim(), password.trim() );
            if(check == 1){
            	UserInfo user = userDao.get(text.trim());
                session.setAttribute( "USER_NO", user.getUSER_NO() );
                session.setAttribute( "USER_NAME", user.getUSER_NAME() );
                session.setAttribute( "USER_PASSWORD", user.getUSER_PASSWORD() );
                session.setAttribute( "USER_TYPE", user.getUSER_TYPE() );
                if ( user.getUSER_TYPE().equals( "D" ) ) {
                    session.setAttribute( "SUPER_USER", true );
                } else if ( user.getUSER_TYPE().equals( "S" ) ) {
                    session.setAttribute( "SUBCONTRACT", true );
                } else if ( user.getUSER_TYPE().equals( "U" ) ) {
                    session.setAttribute( "PUBLIC_USER", true );
                } else {
                     // guest 인 경우
                    session.setAttribute( "GUEST_USER", true );
                }

                if(!user.getUSER_TYPE().equals("G") && user.getUSER_NO().equals(user.getUSER_PASSWORD())){
                	session.setAttribute("changePassword", true);
                }
                logger.info("checkLogin: " + text + " USER_TYPE " + user.getUSER_TYPE());
            }else{
            	url="redirect:/popup/error.jsp";

            	//
            	UserInfo user = userDao.get(text.trim());
            	logger.info("@@ failed USER_NAME : "+ session.getAttribute("USER_NAME"));
            	logger.info("@@ failed getUSER_NAME : "+ user.getUSER_NAME());

            	session.setAttribute("msg", "사용자 정보가 없거나 비밀번호가 틀립니다.");
            	session.setAttribute("send", "/index.jsp");
            	logger.info("checkLogin: "+ text + " 사용자 정보가 없거나 비밀번호가 틀립니다.");
            }
        } else{
        	url="redirect:/popup/error.jsp";
        	session.setAttribute("msg", "잘못된 접근 입니다.");
        	session.setAttribute("send", "/index.jsp");
        }
        logger.info("checkLogin: success " + text);
        return url;
	}

	public String checkLogin2(String text, String securedPassword, HttpSession session, HttpServletRequest request) throws UserException{
		logger.info("checkLogin: " + text);
		String url="redirect:/board";
		int check = 0;

    	PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
    	session.invalidate();
    	session = request.getSession();

        if ( ( text.trim() != "" ) && ( securedPassword.trim() != "" ) ) {
        	if(privateKey == null){
        		throw new UserException("암호화 비밀키 정보를 찾을 수 없습니다.");
        	}
            try {
				check = userDao.loginCheck( text.trim(), decryptRsa(privateKey, securedPassword) );
			} catch (Exception e) {
				e.printStackTrace();
			}

            if(check == 1){
            	UserInfo user = userDao.get(text.trim());
                session.setAttribute( "USER_NO", user.getUSER_NO() );
                session.setAttribute( "USER_NAME", user.getUSER_NAME() );
                session.setAttribute( "USER_PASSWORD", user.getUSER_PASSWORD() );
                session.setAttribute( "USER_TYPE", user.getUSER_TYPE() );
                if ( user.getUSER_TYPE().equals( "D" ) ) {
                    session.setAttribute( "SUPER_USER", true );
                } else if ( user.getUSER_TYPE().equals( "S" ) ) {
                    session.setAttribute( "SUBCONTRACT", true );
                } else if ( user.getUSER_TYPE().equals( "U" ) ) {
                    session.setAttribute( "PUBLIC_USER", true );
                } else {
                    session.setAttribute( "GUEST_USER", true );
                }

                if(!user.getUSER_TYPE().equals("G") && user.getUSER_NO().equals(user.getUSER_PASSWORD())){
                	session.setAttribute("changePassword", true);
                }
                logger.info("checkLogin: " + text + " USER_TYPE " + user.getUSER_TYPE());
            }else{
            	url="redirect:/popup/error.jsp";
            	session.setAttribute("msg", "사용자 정보가 없거나 비밀번호가 틀립니다.");
            	session.setAttribute("send", "/index.jsp");
            	logger.info("checkLogin: "+ text + " 사용자 정보가 없거나 비밀번호가 틀립니다.");
            }
        } else{
        	url="redirect:/popup/error.jsp";
        	session.setAttribute("msg", "잘못된 접근 입니다.");
        	session.setAttribute("send", "/index.jsp");
        }
        logger.info("checkLogin: success " + text);
        return url;
	}

	public String getUserMenu(UserPermission userPermission, CustomUserDetails userDetails){
		return initializeMenu(new StringBuffer(), userPermission, userDetails).toString();
	}

	public String getUserNavMenu(UserPermission userPermission, CustomUserDetails userDetails){
		return initializeNavMenu(new StringBuffer(), userPermission, userDetails).toString();
	}

	public List<Map<String, Object>> getUerCustomBoardList( String userNo ) {
		return userDao.getUerCustomBoardList( userNo );
	}

	public UserPermission getMenuList( String userNo ) {
		List<Map<String, Object>> list = userDao.getMenuList( userNo );
		UserPermission userPermission = setUserPermission(list);
		return userPermission;
	}

    public Map<String, Object> passwordPop(HttpSession session) throws Exception{
    	logger.info("get passwordPopForm");
    	Map<String, Object> map = new HashMap<String, Object>();

    	KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
    	generator.initialize(2048);

    	KeyPair keyPair = generator.genKeyPair();
    	KeyFactory keyFactory = KeyFactory.getInstance("RSA");

    	PublicKey publicKey = keyPair.getPublic();
    	PrivateKey privateKey = keyPair.getPrivate();

    	// 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
    	session.setAttribute("__rsaPrivateKey__", privateKey);

    	// 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
    	RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);

    	map.put("publicKeyModulus", publicSpec.getModulus().toString(16));
    	map.put("publicKeyExponent", publicSpec.getPublicExponent().toString(16));
    	logger.info("return passwordPopForm");
    	return map;
    }

    public String passCheck(CustomUserDetails userDetails){
    	String temp="success";
    	if(userDetails.changePassword() && !userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_GUEST))
    		temp="fail";

    	return temp;
    }

    public void noticeMode(String mode, String contentNo){
    	String folderId = "";
    	if(mode.equals("important")) folderId = "notice";
    	else folderId = "important";

    	userDao.noticeMode(folderId, contentNo);
    	logger.info("noticeMode: "+folderId+" contentNo:"+contentNo);
    }

	public String changePassword(String oriPass, String newPass, HttpSession session) throws Exception{
		StandardPasswordEncoder encoder = new StandardPasswordEncoder();
		PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");

		CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
		String userNo = userDetails.getUserNo();
		String userPassword = userDetails.getPassword();
		logger.info("changePassword: " + userNo);

    	String result = "";

    	if(encoder.matches(decryptRsa(privateKey, oriPass), userPassword)){
    		result = "success";

    		String newPassword = encoder.encode(decryptRsa(privateKey, newPass));
			userDao.modifyPassword(userNo, newPassword);

			session.removeAttribute("__rsaPrivateKey__");
			session.removeAttribute("changePassword");
			userDetails.setPassword(newPassword);
			userDetails.setChangePassword(false);
			session.setAttribute("userDetails", userDetails);

    		logger.info("changePassword-success " + userNo);
    	}else{
    		result = "fail";
    		logger.info("changePassword-fail " + userNo);
    	}

    	return result;
	}

    public Map<String, Object> getNoticeList( String menu, String chartNum, String search, String select ){
    	logger.info("getNoticeList: " + " menu= " +menu + " chartNum= " + chartNum + " search= " + search);
    	Map<String, Object> map = new HashMap<String, Object>();

        int pageList = 14; // 페이지당 14개 게시물
        int totalCount = 0;
        int totalPage = 0;

        int start = ( Integer.parseInt( chartNum ) == 1 ) ? 0 : ( Integer.parseInt( chartNum ) - 1 ) * pageList;
        List<Map<String, Object>> list = null;
        if ( ( search == null ) || ( search == "" ) ) { // 전체목록
            totalCount = userDao.getBoardCount( menu ); // 분류별 게시물 갯수
            totalPage = (int) Math.ceil( (double) totalCount / pageList ); // 총 페이지 갯수
            list =  userDao.getBoard( menu, start, pageList );
        } else { // 검색어 목록
            logger.info("getNoticeList-search: " + " menu= " +menu + " search= " + search + " select= " + select );
            totalCount = userDao.getSearchCount( menu, search, select );
            totalPage = (int) Math.ceil( (double) totalCount / pageList ); // 총 페이지 갯수
            list =  userDao.getBoardSearch( menu, search, select, start, pageList );
        }

        map.put("list", list);
        map.put("totalPage", totalPage);

    	return map;
    }

    public Map<String, Object> getBoardList( String category, String chartNum, String search, String select, String subCategory ){
    	logger.info("getNoticeList: " + " category= " +category + " chartNum= " + chartNum + " search= " + search);
    	Map<String, Object> map = new HashMap<String, Object>();

        int pageList = 14; // 페이지당 14개 게시물
        int totalCount = 0;
        int totalPage = 0;

        int start = ( Integer.parseInt( chartNum ) == 1 ) ? 0 : ( Integer.parseInt( chartNum ) - 1 ) * pageList;
        List<Map<String, Object>> list = null;

        if ( ( search == null ) || ( search == "" ) ) { // 전체목록
            totalCount = userDao.getBoardCount2( category, subCategory ); // 분류별 게시물 갯수
            totalPage = (int) Math.ceil( (double) totalCount / pageList ); // 총 페이지 갯수
            list =  userDao.getBoard2( category, subCategory, start, pageList );
        } else { // 검색어 목록
            logger.info("getNoticeList-search: " + " category= " +category + " search= " + search + " select= " + select );
            totalCount = userDao.getSearchCount2( category, subCategory, search, select );
            totalPage = (int) Math.ceil( (double) totalCount / pageList ); // 총 페이지 갯수
            list =  userDao.getBoardSearch2( category, search, select, subCategory, start, pageList );
        }

        map.put("list", list);
        map.put("totalPage", totalPage);
        map.put("subCategoryList", getBoardTypes());

    	return map; 
    }

	public void insertBoard( String title, String openFlag, String folder, String subCategory, String mainContent,
    		String menubar, MultipartFile[] boardAttach, String guestID, String guestPW, HttpSession session ) throws Exception {
    	logger.info("boardList: folder= " + folder);
    	TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());

        CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
        String userNo = userDetails.getUserNo();
        boolean extraAccount = userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_GUEST);

        if(extraAccount){
        	guestID = guestID.trim();
        	guestPW = guestPW.trim();
        	if(guestID.isEmpty() || guestPW.isEmpty())
        		throw new UserException("guest 유저는 임시ID 및 PW를 입력해 주세요.");
        	if(guestID.length()>50 || guestPW.length()>50)
        		throw new UserException("임시ID 및 PW 최대 글자수는 50자 입니다.");
        }

        Board board = new Board();

        int no = userDao.getBoardCount( folder ) + 1;
        board.setCONTENT_NO( no );
        board.setFOLDER_ID( folder );
        board.setORI_FOLDER_ID( folder );
        board.setSUBCATEGORY(subCategory);
        board.setTITLE( title );
        board.setOPEN_FLAG( openFlag );
        board.setMAIN_CONTENT( mainContent.replaceAll("'", "&apos;") );
        board.setUSER_NO( userNo );
        board.setR_CREATION_USER( userNo );
        board.setR_CREATION_DATE( dateFormat() );

        logger.info("@@@@ dateFormat() : " + dateFormat());

        board.setCONTENT_GRP( no );
        board.setCONTENT_SEQ( 1 );
        
        ArrayList<Map<String, Object>> attachList = new ArrayList<Map<String,Object>>();
        if(boardAttach.length>0){
            for ( int i=0; i<boardAttach.length; i++ ) {

            	Map<String, Object> attach = new HashMap<String, Object>();
            	String attachPath = Consts.BOARD_ATTACH_FILE_HOME;
            	attachPath+= folder + File.separator + attachDateFormat() + File.separator + attachFileDateFormat();
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
        			userDao.setAttachFileInfo(no, folder, attachList.get(i).get("objectId").toString(), attachList.get(i).get("fileName").toString(),
        					attachList.get(i).get("filePath").toString(), Integer.parseInt(attachList.get(i).get("fileSize").toString()), userNo);
        		}
        	}
        	userDao.insertBoard( board );
        	
        	if(extraAccount) userDao.insertExtraAccounts(guestID, guestPW, no, folder);

        	this.transactionManager.commit(status);
        }catch(Exception e){
        	this.transactionManager.rollback(status);
        	logger.error("userDao.insertBoard: ", e);
        	throw new UserException("게시물 등록 실패");
        }
        
//      Insert this new board data into push message table 
//      DATE : 16.11.22
        try {
	      	int pushObjectId = pushDao.getMessageCount() + 1;
	      	String postType = new String("board");
	      	insertPush(pushObjectId, no, false, postType, folder, subCategory, title, mainContent.replaceAll("'", "&apos;"), userNo, dateFormat());
		} catch (Exception e) {
			// TODO: handle exception
			this.transactionManager.rollback(status);
	      	logger.error("pushDao.insertPushMessage : ", e);
	      	throw new UserException("Push 메시지 등록 실패");
		}
        
    }

    public Map<String, Object> viewPost( String folder, String subCategory, String chartNum, String contentNo, String search,  String select, HttpSession session ) throws UserException {
        logger.info("viewPost: folder= " + folder + " contentNo= " + contentNo);
        Map<String, Object> permission = userDao.getBoardPermissionCheck(folder, contentNo);
        CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
        String userNo = userDetails.getUserNo();

        UserPermission userPermission = (UserPermission)session.getAttribute("userPermission");
        if( (userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)
        		|| userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_CUSTOM_USER))
        		&& permission.get("OPEN_FLAG").equals("N")
        		&&(!permission.get("USER_NO").equals(userNo) && !permission.get("ORI_USER").equals(userNo))){
        	boolean permissionCheck = false;
        	if(subCategory.equals("GLUE") && userPermission.isFUNCTION_GLUE_ADMIN()) permissionCheck=true;
        	if(subCategory.equals("GLUEMASTER") && userPermission.isFUNCTION_GLUEMASTER_ADMIN()) permissionCheck=true;
        	if(subCategory.equals("UCUBE") && userPermission.isFUNCTION_UCUBE_ADMIN()) permissionCheck=true;
        	if(subCategory.equals("POSBEE") && userPermission.isFUNCTION_POSBEE_ADMIN()) permissionCheck=true;

        	if(!permissionCheck) throw new UserException("권한이 없는 게시물입니다.");
        }

        if( !userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)
        		&& !userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_CUSTOM_USER)
        		&& permission.get("OPEN_FLAG").equals("N")
        		&& (!permission.get("USER_NO").equals(userNo) && !permission.get("ORI_USER").equals(userNo)) )
        	throw new UserException("비밀글로 설정된 게시물입니다.");

        // 조회수 증가
        userDao.mountClicks( folder, Integer.parseInt( contentNo ) );
        // 게시물 내용 가져오기
        Map<String, Object> temp = userDao.getViewPost( folder, Integer.parseInt( contentNo ) );
        List<Map<String, Object>> attachList= userDao.getBoardAttachInfo(folder, Integer.parseInt( contentNo ));
        temp.put("SUBCATEGORY", temp.get("FOLDER_ID").equals("notice")?null:Consts.SubCategory.valueOf((String)temp.get("SUBCATEGORY")).getCategoryToString());

//        logger.info("@@@@@@@@@@ 시간 데이터 :", temp.get("r_CREATION_DATE"));

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("boardInfo", temp);
        map.put("attachInfo", attachList);
        return map;
    }

    public void modifyBoard( HttpSession session, String category, String openFlag, String title, String content, String contentNo,
            String subCategory, MultipartFile[] boardAttach, String[] deleteFile ) throws UserException {
    	logger.info("modifyBoard: category= " + category + " contentNo= " + contentNo);

    	TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
        Board board = new Board();
        board.setORI_FOLDER_ID( category );
        board.setUSER_NO( (String) session.getAttribute( "USER_NO" ) );
        board.setOPEN_FLAG( openFlag );
        board.setTITLE( title );
        board.setMAIN_CONTENT( content.replaceAll("'", "&apos;") );
        board.setCONTENT_NO( Integer.parseInt( contentNo ) );
        board.setR_MODIFY_DATE( dateFormat() );
        board.setR_MODIFY_USER( (String) session.getAttribute( "USER_NO" ) );
        board.setSUBCATEGORY(subCategory);

        ArrayList<Map<String, Object>> attachList = new ArrayList<Map<String,Object>>();

        try{
        	// 게시물 정보 수정
        	userDao.modifyBoard( board );

        	// 첨부파일 등록
            if(boardAttach.length>0){
                for ( int i=0; i<boardAttach.length; i++ ) {
                	Map<String, Object> attach = new HashMap<String, Object>();
                	String attachPath = Consts.BOARD_ATTACH_FILE_HOME;
                	attachPath+= category + File.separator + attachDateFormat() + File.separator + attachFileDateFormat();
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

                    System.out.println( "up: fileName: " + boardAttach[i].getOriginalFilename() + " attachPath: " + attachPath );
                    try {
                        File ufile = new File( attachPath );
                        if ( !ufile.exists() ) {
                        	ufile.mkdirs();
                        }
                        boardAttach[i].transferTo( ufile );
            			userDao.setAttachFileInfo(Integer.parseInt(contentNo), category, attachList.get(i).get("objectId").toString(), attachList.get(i).get("fileName").toString(),
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
        			String deleteAttachFilePath = userDao.getAttachFilePath(deleteFile[i]);
        			logger.info("deleteAttachFilePath: " + deleteAttachFilePath);
        			File file = new File(deleteAttachFilePath);
        			if(file.exists()==true)
        				file.delete();
        			userDao.deleteAttachFile(deleteFile[i]);
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

    public Map<String, Object> modifyBoardForm(HttpSession session, String category, String contentNo) throws UserException{
    	logger.info("modifyBoardForm: category= " + category + " contentNo= " + contentNo);

//        CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
//        boolean extraAccount = userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_GUEST);
//
//        if(extraAccount){
//        	guestID = guestID.trim();
//        	guestPW = guestPW.trim();
//        	if(guestID.isEmpty() || guestPW.isEmpty())
//        		throw new UserException("guest 유저는 임시ID 및 PW를 입력해 주세요.");
//        	if(userDao.getExtraAccounts(guestID, guestPW, Integer.parseInt(contentNo), category)<1)
//        		throw new UserException("임시 아이디 및 패스워드가 맞지 않습니다.");
//        }

    	Map<String, Object> boardInfo = userDao.getViewPost( category, Integer.parseInt( contentNo ) );
    	boardInfo.put("MAIN_CONTENT", ((String) boardInfo.get("MAIN_CONTENT")).replaceAll( "\r\n", "</br>" ));
    	List<Map<String, Object>> attachList= userDao.getBoardAttachInfo(category, Integer.parseInt( contentNo ));

    	Map<String, Object> temp = new HashMap<String, Object>();
    	temp.put("boardInfo", boardInfo);
    	temp.put("attachInfo", attachList);

    	return temp;
    }

    public void checkAuthentication(String menu, CustomUserDetails userDetails) throws UserException{
    	if(!userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN) && !menu.equals("qna")){
    		throw new UserException("글 쓰기 권한이 없습니다.");
    	}
    }

    public void deleteBoard( HttpSession session, String category, String contentNo ) throws UserException {
    	logger.info("deleteBoard: @ category= " + category + " @ contentNo= " + contentNo);
        CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
        String userNo = userDetails.getUserNo();
        System.out.println("deleteBoard________userNo: "+userNo);

//        boolean extraAccount = userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_GUEST);
//        if(extraAccount){
//        	guestID = guestID.trim();
//        	guestPW = guestPW.trim();
//        	if(guestID.isEmpty() || guestPW.isEmpty())
//        		throw new UserException("guest 유저는 임시ID 및 PW를 입력해 주세요.");
//        	if(userDao.getExtraAccounts(guestID, guestPW, Integer.parseInt(contentNo), category)<1)
//        		throw new UserException("임시 아이디 및 패스워드가 맞지 않습니다.");
//        }

        String userType = "";
        if (userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)) {
        	userType = Consts.USERLV_ADMIN;
        } else if(userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_PUBLIC)){
        	userType = Consts.USERLV_PUBLIC;
        }else{
        	userType = Consts.USERLV_GUEST;
        }

        Map<String, Object> map = userDao.getViewPost(category, Integer.parseInt( contentNo ));

        if(!userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)
        		&& !map.get("R_CREATION_USER").equals(userNo))
        	throw new UserException("이 게시물을 삭제할 권한이 없습니다.");

        userDao.deleteBoard( dateFormat(), userNo, userType, category, Integer.parseInt( contentNo ) );
    }

    public int replyBoard( HttpSession session, String folder, String openFlag, String title, String content, String contentNo,
            String subCategory, MultipartFile[] boardAttach, String guestID, String guestPW ) throws UserException {
    	logger.info("replyBoard: folder= " + folder + " contentNo= " + contentNo);
    	TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());

        CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
        String userNo = userDetails.getUserNo();
        boolean extraAccount = userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_GUEST);

        if(extraAccount){
        	guestID = guestID.trim();
        	guestPW = guestPW.trim();
        	if(guestID.isEmpty() || guestPW.isEmpty())
        		throw new UserException("guest 유저는 임시ID 및 PW를 입력해 주세요.");
        	if(guestID.length()>50 || guestPW.length()>50)
        		throw new UserException("임시ID 및 PW 최대 글자수는 50자 입니다.");
        }

        Board board = new Board();
        // 상위글 GRP, SEQ, LVL 얻어오기
        HashMap<String, Object> map = (HashMap<String, Object>) userDao.replyCheck( folder, Integer.parseInt( contentNo ) );
        // 답글 입력
        int no = userDao.getBoardCount( folder ) + 1;
        board.setCONTENT_NO( no );
        board.setFOLDER_ID( folder );
        board.setUSER_NO( userNo );
        board.setOPEN_FLAG( openFlag );
        board.setTITLE( title );
        board.setMAIN_CONTENT( content );
        board.setR_CREATION_USER( userNo );
        board.setR_CREATION_DATE( dateFormat() );

        board.setCONTENT_GRP( (Integer) map.get( "CONTENT_GRP" ) );
        board.setCONTENT_SEQ( (Integer) map.get( "CONTENT_SEQ" ) + 1 );
        board.setSUBCATEGORY(subCategory);

        ArrayList<Map<String, Object>> attachList = new ArrayList<Map<String,Object>>();
        if(boardAttach.length>0){
            for ( int i=0; i<boardAttach.length; i++ ) {

            	Map<String, Object> attach = new HashMap<String, Object>();
            	String attachPath = Consts.BOARD_ATTACH_FILE_HOME;
            	attachPath+= folder + File.separator + attachDateFormat() + File.separator + attachFileDateFormat();
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
        			userDao.setAttachFileInfo(no, folder, attachList.get(i).get("objectId").toString(), attachList.get(i).get("fileName").toString(),
        					attachList.get(i).get("filePath").toString(), Integer.parseInt(attachList.get(i).get("fileSize").toString()), userNo);
        		}
        	}
        	userDao.insertBoard( board );
        	if(extraAccount) userDao.insertExtraAccounts(guestID, guestPW, no, folder);
        	logger.info("replyBoard: extraAccount guestID : "+guestID);
        	logger.info("replyBoard: extraAccount guestPW : "+guestPW);
        	logger.info("replyBoard: extraAccount no : "+no);

        	this.transactionManager.commit(status);
        }catch(Exception e){
        	this.transactionManager.rollback(status);
        	logger.error("userDao.insertBoard: ", e);
        	throw new UserException("게시물 등록 실패");
        }

        logger.info("replyBoard: success ");
        return no;
    }

    public Map<String, Object> replyBoardForm( String menu, String contentNo ) {
    	logger.info("replyBoardForm");
    	Map<String, Object> map = userDao.getViewPost( menu, Integer.parseInt( contentNo ) );
        return map;
    }

    public ArrayList<Map<String, Object>> replyList( String folder, String contentNo, HttpSession session ) {
        logger.info("replyList: contentNo= " + contentNo + " folder= " + folder);
        ArrayList<Map<String, Object>> list = (ArrayList<Map<String, Object>>) userDao.getReplyList( folder, Integer.parseInt( contentNo ) );
        session.setAttribute( "replyMenu", folder );
        return list;
    }

    public String insertReply( String folder, String contentNo, String subCategory, String mainContent, String guestReplyId, HttpSession session ) throws UserException {
        logger.info("insertReply: contentNo= " + contentNo + " category= " + folder);
        int no = userDao.getReplyCount( folder, Integer.parseInt( contentNo ) );
        Reply re = new Reply();
        re.setCONTENT_NO( Integer.parseInt( contentNo ) );
        re.setORI_FOLDER_ID( folder );
        re.setRE_CONTENT_NO( no + 1 );
        re.setRE_MAIN_CONTENT( mainContent.replaceAll("\n", "<br>") );
        re.setR_CREATION_DATE( dateFormat() );
        re.setR_CREATION_USER( (String) session.getAttribute( "USER_NO" ) );

		// guest 일 때 댓글 달 이름 가져오기
//        if (session.getAttribute( "USER_NO").equals("guest")) {
//			re.setR_CREATION_USER( guestReplyId );
//		} else {
//			re.setR_CREATION_USER( (String) session.getAttribute( "USER_NO" ) );
//		}
//        logger.info(" @@ session USER_NO : "+session.getAttribute( "USER_NO"));

        try{
        	userDao.insertReply( re );
        }catch(Exception e){
        	logger.error("userDao.insertReply", e);
        	throw new UserException("리플 등록 실패");
        }
        
//      Insert this new reply data into push message table 
//      DATE : 16.11.22
        try {
	      	int pushObjectId = pushDao.getMessageCount() + 1;
	      	String postType = new String("comment");
	      	logger.info("subCategory : "+subCategory);
	      	insertPush(pushObjectId, Integer.parseInt( contentNo ), false, postType, folder, subCategory, 
	      			"-", mainContent.replaceAll("\n", "<br>"), (String) session.getAttribute( "USER_NO" ), dateFormat());
		} catch (Exception e) {
			// TODO: handle exception
//			this.transactionManager.rollback(status);
	      	logger.error("pushDao.insertPushMessage : ", e);
	      	throw new UserException("리플 등록 실패");
		}

        return "end";
    }

    public String deleteReply( String folder, String reContentNo, String contentNo, HttpSession session ) {
        logger.info("deleteReply: contentNo= " + reContentNo);
        logger.info("deleteReply: USER_NO =============== " + (String) session.getAttribute( "USER_NO" ));
        userDao.deleteReply((String) session.getAttribute( "USER_NO" ), Integer.parseInt(contentNo), folder, Integer.parseInt(reContentNo));
        return "end";
    }

    public String permissionCheck( HttpSession session, String contentNo, String category ) throws UserException {
        logger.info("permissionCheck: contentNo= " + contentNo+" category: "+category);
        CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");

        String temp = "success";

        Map<String, Object> permission = userDao.getBoardPermissionCheck(category, contentNo);
        if(userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_GUEST)){
        	Map<String, Object> map = userDao.getViewPost(category, Integer.parseInt(contentNo));
        	if(map.get("OPEN_FLAG").equals("N") && permission.get("ORI_USER").equals(Consts.GUEST_USER))
        		temp="fail";
        	else if(map.get("OPEN_FLAG").equals("N") && map.get("USER_NO").equals(Consts.GUEST_USER))
        		temp="fail";
        	else if(map.get("OPEN_FLAG").equals("N"))
        		temp="secret";
        }

        return temp;
    }

    public String guestPermissionCheck( HttpSession session, String contentNo, String category, String guestID, String guestPW ) {
        logger.info("permissionCheck: contentNo= " + contentNo);
        String temp = "Y";

    	logger.info("guestPermissionCheck: guestID : "+guestID);
    	logger.info("guestPermissionCheck: guestPW : "+guestPW);
    	logger.info("guestPermissionCheck: no : "+contentNo);

        Map<String, Object> permission = userDao.getBoardPermissionCheck(category, contentNo);
        if(userDao.getExtraAccounts(guestID, guestPW, Integer.parseInt(contentNo), category)<1) temp="N";

        logger.info("guestPermissionCheck: temp1 : "+temp);

//        if(userDao.getExtraAccounts(guestID, guestPW, Integer.parseInt(permission.get("UP_CONTENT_NO").toString()),
//        		(String)permission.get("UP_ORI_FOLDER_ID"))<1) {
//        	temp="N";
//        }
//        else{
//        	temp="Y";
//        }
//        logger.info("guestPermissionCheck: temp2 : "+temp);

        return temp;
    }

    public boolean boardPermissionCheck(HttpSession session, String folder, String subCategory){
    	boolean flag = false;
    	UserPermission userPermission = (UserPermission)session.getAttribute("userPermission");
    	System.out.println("folder: " +folder + " subCategory: "+subCategory);

    	if(subCategory.equals("NOTICE") && userPermission.isFUNCTION_NOTICE_WRITE()) flag=true;

    	if(subCategory.equals("GLUE") && userPermission.isFUNCTION_GLUE_WRITE()) {
    		if(folder.equals("notice") && userPermission.isFUNCTION_GLUE_WRITE_NOTICE()) flag=true;
    		if(folder.equals("qna") && userPermission.isFUNCTION_GLUE_WRITE_QNA()) flag=true;
    		if(folder.equals("faq") && userPermission.isFUNCTION_GLUE_WRITE_FAQ()) flag=true;
    		if(folder.equals("technical") && userPermission.isFUNCTION_GLUE_WRITE_TECH()) flag=true;
    		if(folder.equals("oldtechnical") && userPermission.isFUNCTION_GLUE_WRITE_OLDTECH()) flag=true;
    	}
    	if(subCategory.equals("GLUEMASTER") && userPermission.isFUNCTION_GLUEMASTER_WRITE()) {
    		if(folder.equals("notice") && userPermission.isFUNCTION_GLUEMASTER_WRITE_NOTICE()) flag=true;
    		if(folder.equals("qna") && userPermission.isFUNCTION_GLUEMASTER_WRITE_QNA()) flag=true;
    		if(folder.equals("faq") && userPermission.isFUNCTION_GLUEMASTER_WRITE_FAQ()) flag=true;
    		if(folder.equals("technical") && userPermission.isFUNCTION_GLUEMASTER_WRITE_TECH()) flag=true;
    	}
    	if(subCategory.equals("GLUEMOBILE") && userPermission.isFUNCTION_GLUEMOBILE_WRITE()) {
    		if(folder.equals("notice") && userPermission.isFUNCTION_GLUEMOBILE_WRITE_NOTICE()) flag=true;
    		if(folder.equals("qna") && userPermission.isFUNCTION_GLUEMOBILE_WRITE_QNA()) flag=true;
    		if(folder.equals("faq") && userPermission.isFUNCTION_GLUEMOBILE_WRITE_FAQ()) flag=true;
    		if(folder.equals("technical") && userPermission.isFUNCTION_GLUEMOBILE_WRITE_TECH()) flag=true;
    	}
    	if(subCategory.equals("UCUBE") && userPermission.isFUNCTION_UCUBE_WRITE()) {
    		if(folder.equals("notice") && userPermission.isFUNCTION_UCUBE_WRITE_NOTICE()) flag=true;
    		if(folder.equals("qna") && userPermission.isFUNCTION_UCUBE_WRITE_QNA()) flag=true;
    		if(folder.equals("faq") && userPermission.isFUNCTION_UCUBE_WRITE_FAQ()) flag=true;
    		if(folder.equals("technical") && userPermission.isFUNCTION_UCUBE_WRITE_TECH()) flag=true;
    	}
    	if(subCategory.equals("POSBEE") && userPermission.isFUNCTION_POSBEE_WRITE()) {
    		if(folder.equals("notice") && userPermission.isFUNCTION_POSBEE_WRITE_NOTICE()) flag=true;
    		if(folder.equals("qna") && userPermission.isFUNCTION_POSBEE_WRITE_QNA()) flag=true;
    		if(folder.equals("faq") && userPermission.isFUNCTION_POSBEE_WRITE_FAQ()) flag=true;
    		if(folder.equals("technical") && userPermission.isFUNCTION_POSBEE_WRITE_TECH()) flag=true;
    	}

    	return flag;
    }
    
    public void insertPush(int object_id, int content_no, boolean sent_flag, String post_type, 
			String board_type, String solution_type, String post_title, String content, String user, String created_date) {
//      Insert this new board data into push message table 
//      DATE : 16.11.22
    	PushMessage pushMsg = new PushMessage(object_id, content_no, false, post_type, board_type, solution_type, post_title, content, user, created_date);
      	pushDao.insertPushMessage(pushMsg);
    }
}
