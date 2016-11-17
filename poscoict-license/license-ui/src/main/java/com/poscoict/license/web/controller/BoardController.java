package com.poscoict.license.web.controller;

import java.io.IOException;
import java.io.Writer;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.poscoict.license.consts.Consts;
import com.poscoict.license.security.CustomUserDetails;
import com.poscoict.license.service.BoardService;
import com.poscoict.license.service.UserException;
import com.poscoict.license.vo.UserPermission;

@Controller
public class BoardController extends ExceptionControllerAdvice {

    private BoardService getBoardService() {
        ApplicationContext context = new GenericXmlApplicationContext( "applicationContext.xml" );
        return context.getBean( "boardService", BoardService.class );
    }
    
    @RequestMapping( value = {"index"}, method = {RequestMethod.GET})
    public ModelAndView loginForm() throws Exception{
    	System.out.println("_____________________________________________index");
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("login/login");
    	return mv;
    }
    
    // 로그인처리 
    @RequestMapping( value = {"login"}, method = {RequestMethod.POST, RequestMethod.GET})
    public String checkLogin(HttpSession session){
    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	UserPermission userPermission = getBoardService().getMenuList(userDetails.getUserNo());
    	session.setAttribute("userDetails", userDetails);
    	session.setAttribute("USER_NO", userDetails.getUserNo());
    	session.setAttribute("USER_NAME", userDetails.getUsername());
    	session.setAttribute("userPermission", userPermission);
    	if(userDetails.changePassword() && !userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_GUEST)) 
    		session.setAttribute("changePassword", true);
    	
    	session.setAttribute("jstree", "initialize");
    	session.setAttribute("userMenu", getBoardService().getUserMenu(userPermission, userDetails));
    	
    	return "redirect:/board";
    }
    
    @RequestMapping(value={"logout"}, method={RequestMethod.POST, RequestMethod.GET})
    public String logout(HttpSession session){
    	System.out.println("logout_____________________________________________index");
    	session.invalidate();
    	return "redirect:/index";
    }
    
    @RequestMapping(value={"passCheck"}, method={RequestMethod.POST, RequestMethod.GET})
    public void passCheck(HttpSession session, Writer writer) throws IOException{
    	writer.write(getBoardService().passCheck((CustomUserDetails) session.getAttribute("userDetails")));
    }
    
    // 패스워드 변경폼
    @RequestMapping(value={"passwordPop"}, method={RequestMethod.POST})
    public ModelAndView passwordPop(@RequestParam(value = "mode", defaultValue = "0") String mode, HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView();
    	
    	Map<String, Object> map = getBoardService().passwordPop(session);
    	mv.addObject("publicKeyModulus", map.get("publicKeyModulus"));
    	mv.addObject("publicKeyExponent", map.get("publicKeyExponent"));
    	mv.setViewName("login/changePassword");
    	mv.addObject("mode", mode);

    	return mv;
    }
    
    // 중요 공지 등록/해제
    @RequestMapping(value={"noticeMode"}, method={RequestMethod.POST})
    public String noticeMode(String mode, String contentNo) {
    	getBoardService().noticeMode(mode, contentNo);
    	return "redirect:/board";
    }
    
    // 패스워드 변경
    @RequestMapping(value={"changePassword"}, method={RequestMethod.POST})
    public void changePassword(String oriPass, String newPass, HttpSession session, Writer writer) throws Exception {
    	writer.write(getBoardService().changePassword(oriPass, newPass, session));
    }

    // 게시판 리스트
    @RequestMapping( value = { "board" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView getNoticeList( @RequestParam( value = "folder", defaultValue = "notice" ) String folder,
            @RequestParam( value = "chartNum", defaultValue = "1" ) String chartNum,
            @RequestParam( value = "search", required = false ) String search,
            @RequestParam( value = "select", required = false ) String select,
            @RequestParam( value = "subCategory", defaultValue = "NOTICE" ) String subCategory){
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName( "mainPage" );
    	Map<String, Object> map = getBoardService().getBoardList(folder, chartNum, search, select, subCategory);
    	
        if ( ( search != null ) || ( search != "" ) ) {
        	mv.addObject( "search", search );
        	mv.addObject( "select", select );
        }
        
        mv.addObject( "subCategory", subCategory );
        mv.addObject( "boardList", map.get("list") );
        mv.addObject("subCategoryList", map.get("subCategoryList"));
        mv.addObject( "folder", folder );
        mv.addObject( "totalPage", map.get("totalPage") );
        mv.addObject( "chartNum", chartNum );
        
    	return mv;
    }
    
    // 게시판 글쓰기 폼
    @RequestMapping(value={"writing"}, method=RequestMethod.POST)
    public ModelAndView getWritingForm(HttpSession session, String folder, String subCategory) throws UserException{
//    	getBoardService().checkAuthentication(folder, (CustomUserDetails)session.getAttribute("userDetails"));
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("mainPage");
    	mv.addObject("page", "board/write");
    	mv.addObject("folder", folder);
    	mv.addObject("subCategory", subCategory);
    	
    	return mv;
    }

    // 게시판 글쓰기 인서트
    @RequestMapping( value = { "write" }, method = RequestMethod.POST )
    public String insertBoard( @RequestParam( "WRITE_TITLE" ) String title,
            @RequestParam( value = "OPEN_FLAG", defaultValue = "Y" ) String openFlag, 
            @RequestParam( "folder" ) String folder,
            @RequestParam( "subCategory" ) String subCategory,
            @RequestParam( "WRITE_MAIN_CONTENT" ) String mainContent, 
            @RequestParam(value="menubar", required=false) String menubar,
            @RequestParam(value="boardAttach", required=false) MultipartFile[] boardAttach,
            @RequestParam(value="guestID", required=false) String guestID,
            @RequestParam(value="guestPW", required=false) String guestPW,
            HttpSession session ) throws Exception {
        getBoardService().insertBoard(title, openFlag, folder, subCategory, mainContent, menubar, boardAttach, guestID, guestPW, session);
//        return getNoticeList(category,"1",null,null,"all");
        return "redirect:/board?folder="+folder+"&subCategory="+subCategory;
    }

    // 게시물 보기
    @RequestMapping( value = { "viewPost" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView viewPost( 
//    		@RequestParam( value = "oriFolderId" ) String oriFolderId,
    		@RequestParam( value = "folder" ) String folder,
            @RequestParam( value = "chartNum", defaultValue = "1" ) String chartNum, 
            @RequestParam( "contentNo" ) String contentNo,
            @RequestParam( value = "search", required = false ) String search,
            @RequestParam( value = "select", required = false ) String select,
            @RequestParam( value = "subCategory", required = false ) String subCategory,
            HttpSession session) throws UserException {
    	Map<String, Object> map = getBoardService().viewPost(folder, subCategory, chartNum, contentNo, search, select, session);
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "search", search );
        mv.addObject( "select", select );
        mv.addObject( "page", "board/viewPost" );
        mv.addObject( "board", map.get("boardInfo") );
        mv.addObject( "attachInfo", map.get("attachInfo") );
        mv.addObject("folder", folder);
        mv.addObject("subCategory", subCategory);
    	
        mv.addObject( "contentNo", contentNo );
        mv.addObject( "chartNum", chartNum );

        return mv;
    }

    // 게시물 수정하기
    @RequestMapping( value = "modifyBoard", method = { RequestMethod.GET, RequestMethod.POST } )
    public String modifyBoard( HttpSession session, 
//    		@RequestParam( "oriFolderId" ) String oriFolderId,
    		@RequestParam( "folder" ) String folder,
            @RequestParam( value = "modify_openFlag", defaultValue = "Y" ) String openFlag, 
            @RequestParam( "modify_title" ) String title,
            @RequestParam( "modify_content" ) String content, 
            @RequestParam( "content_no" ) String contentNo,
            @RequestParam( value="subCategory", defaultValue = "NOTICE" ) String subCategory,
            @RequestParam(value="boardAttach", required=false) MultipartFile[] boardAttach,
            @RequestParam(value="deleteFile", required=false) String[] deleteFile,
            @RequestParam( value = "chartNum", defaultValue = "1" ) String chartNum,
            @RequestParam( value = "search", required = false ) String search,
            @RequestParam( value = "select", required = false ) String select
    		) throws UserException {
    	//attachFileMode default:0, 삭제:1
    	
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("board/modify");
    	getBoardService().modifyBoard(session, folder, openFlag, title, content, contentNo, subCategory, boardAttach, deleteFile);
        mv.addObject("success", "success");

//        return viewPost(category, chartNum, contentNo, search, select, oldSubCategory, session);
        return "redirect:/viewPost?folder="+folder+"&subCategory="+subCategory+"&contentNo="+contentNo+"&chartNum="+chartNum;
    }
    
    
    // 게시판 수정 폼
    @RequestMapping( value = { "modifyBoardForm" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView modifyBoardForm(
//    		@RequestParam( "oriFolderId" ) String oriFolderId,
    		@RequestParam( "folder" ) String folder, 
    		@RequestParam( "contentNo" ) String contentNo,
//            @RequestParam(value="guestID", required=false) String guestID,
//            @RequestParam(value="guestPW", required=false) String guestPW,
            @RequestParam( value = "chartNum", defaultValue = "1" ) String chartNum,
            @RequestParam( value = "search", required = false ) String search,
            @RequestParam( value = "select", required = false ) String select,
            @RequestParam( value = "subCategory", required = false ) String subCategory,
            HttpSession session) throws UserException{
    	ModelAndView mv = new ModelAndView();
    	Map<String, Object> map = getBoardService().modifyBoardForm(session, folder, contentNo);
    	
    	mv.setViewName( "mainPage" );
    	mv.addObject( "page", "board/modify" );
        mv.addObject( "board", map.get("boardInfo") );
        mv.addObject( "attachInfo", map.get("attachInfo") );
//        mv.addObject("subCategoryList", getBoardService().getBoardTypes());
        mv.addObject("folder", folder);
        mv.addObject("chartNum", chartNum);
        mv.addObject("search", search);
        mv.addObject("select", select);
        mv.addObject("subCategory", subCategory);
        
    	return mv;
    }

    // 게시물 삭제하기
    @RequestMapping( value = { "deleteBoard" }, method = RequestMethod.POST )
    public String deleteBoard( HttpSession session, 
    		@RequestParam( "subCategory" ) String subCategory,
    		@RequestParam( "folder" ) String folder, 
    		@RequestParam( "contentNo" ) String contentNo,
            @RequestParam( "chartNum" ) String chartNum, 
            @RequestParam( value = "search", required = false ) String search,
            @RequestParam( value = "select", required = false ) String select) throws UserException {
        getBoardService().deleteBoard(session, folder, contentNo);
//        return getNoticeList(category,chartNum,search,select,"all");
        return "redirect:/board?folder="+folder+"&subCategory="+subCategory;
    }

    // 게시물 답글
    @RequestMapping( value = "replyBoard", method = RequestMethod.POST )
    public String replyBoard( HttpSession session, @RequestParam( "folder" ) String folder,
            @RequestParam( value = "reply_openFlag", defaultValue = "Y" ) String openFlag, @RequestParam( "reply_title" ) String title,
            @RequestParam( "reply_content" ) String content, @RequestParam( "content_no" ) String contentNo,
            @RequestParam( "subCategory" ) String subCategory,
            @RequestParam( "chartNum" ) String chartNum,
            @RequestParam( value="search", required = false ) String search,
            @RequestParam( value="select", required = false ) String select,
            @RequestParam(value="guestID", required=false) String guestID,
            @RequestParam(value="guestPW", required=false) String guestPW,
            @RequestParam( value="boardAttach", required = false ) MultipartFile[] boardAttach) throws UserException {
    	ModelAndView mv = new ModelAndView();
    	
    	int no = getBoardService().replyBoard(session, folder, openFlag, title, content, contentNo, subCategory, boardAttach, guestID, guestPW);
    	
    	mv.setViewName( "board/replyBoard" );      
        mv.addObject("success", "success");
        mv.addObject("folder", folder);
        mv.addObject("chartNum", chartNum);
        mv.addObject("search", search);
        mv.addObject("select", select);
        mv.addObject("subCategory", subCategory);
        
//        return viewPost(category, chartNum, Integer.toString(no), search, select, subCategory, session);
        return "redirect:/viewPost?folder="+folder+"&subCategory="+subCategory+"&contentNo="+no+"&chartNum="+chartNum;
    }
    
    // 답글 폼    
    @RequestMapping( value = { "replyBoardForm" }, method = RequestMethod.POST )
    public ModelAndView replyBoardForm( String folder, String contentNo, String search, String select, String chartNum ) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "board/replyBoard" );
        mv.addObject( "replyBoardForm", getBoardService().replyBoardForm(folder, contentNo) );
        mv.addObject("folder", folder);
        mv.addObject("search", search);
        mv.addObject("select", select);
        mv.addObject("chartNum", chartNum);
        return mv;
    }

    // 리플 리스트
    @RequestMapping( value = { "replyList" }, method = RequestMethod.POST )
    public ModelAndView replyList( String folder, String contentNo, HttpSession session ) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "board/replyList" );
        ArrayList<Map<String, Object>> list = getBoardService().replyList(folder, contentNo, session);
        mv.addObject( "list", list );
        mv.addObject( "size", list.size() );
        mv.addObject( "replyFolder", folder );
        mv.addObject( "contentNo", contentNo );
        return mv;
    }
    
    //presentation
    @RequestMapping( value = { "presentation" }, method = RequestMethod.POST )
    public ModelAndView presentation() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject("page", "presentation/presentation");
        mv.addObject("category", "presentation");
        return mv;
    }

    // 리플 등록
    @RequestMapping( value = "insertReply", method = RequestMethod.POST )
    public void insertReply( String folder, String contentNo, String mainContent, HttpSession session, Writer writer ) throws IOException, UserException {
        writer.write( getBoardService().insertReply(folder, contentNo, URLDecoder.decode(mainContent, "UTF-8"), session) );
    }

    // 리플 삭제
    @RequestMapping( value = { "deleteReply" }, method = RequestMethod.POST )
    public void deleteReply( String folder, String reContentNo, String contentNo, HttpSession session, Writer writer ) throws IOException {
        writer.write( getBoardService().deleteReply(folder, reContentNo, contentNo, session) );
    }
    
    // 비밀게시물 여부 확인
    @RequestMapping( value = { "permissionCheck" }, method = RequestMethod.POST )
    public void permissionCheck( HttpSession session, Writer writer, String contentNo, String category ) throws IOException, UserException {
        writer.write(getBoardService().permissionCheck(session, contentNo, category));
    }
    
    // 비밀게시물 guest 유져 패스워드 확인
    @RequestMapping( value = { "guestPermissionCheck" }, method = RequestMethod.POST )
    public void guestPermissionCheck( HttpSession session, Writer writer, String contentNo, String category 
    		, String guestID, String guestPW) throws IOException {
        writer.write(getBoardService().guestPermissionCheck(session, contentNo, category, guestID, guestPW));
    }
    
    // boardPermissionCheck
    @RequestMapping( value = { "boardPermissionCheck" }, method = RequestMethod.POST )
    public void boardPermissionCheck( HttpSession session, Writer writer, String folder, String subCategory) throws IOException, UserException {
    	String temp="success";
    	if(!getBoardService().boardPermissionCheck(session, folder, subCategory)) temp="fail";
//    	CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
//    	if(!userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN) && !category.equals("qna")){
//    		temp="fail";
//    	}
    	writer.write(temp);
    }
}
