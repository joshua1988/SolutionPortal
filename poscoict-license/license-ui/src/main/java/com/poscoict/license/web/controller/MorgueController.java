package com.poscoict.license.web.controller;

import java.io.IOException;
import java.io.Writer;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.poscoict.license.exception.UserException;
import com.poscoict.license.security.CustomUserDetails;
import com.poscoict.license.service.MorgueService;
import com.poscoict.license.vo.UserPermission;

@Controller
public class MorgueController {

	@Autowired MorgueService getMorgueService;

    @RequestMapping( value = {"morgue"}, method = { RequestMethod.GET,RequestMethod.POST })
    public ModelAndView morgue( HttpSession session ) throws Exception{
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("mainPage");
    	mv.addObject( "page", "morgue/morgue" );
    	mv.addObject("customBoardList", getMorgueService.getUerCustomBoardList( (String) session.getAttribute("USER_NO") ));
    	return mv;
    }

    @RequestMapping( value = {"createCustomBoard"}, method = { RequestMethod.POST })
    public ModelAndView createBoard(HttpSession session, String boardName) throws Exception{
    	getMorgueService.createCustomBoard(session, boardName.trim());
    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	session.setAttribute("userMenu", getMorgueService.getUserMenu( (UserPermission)session.getAttribute("userPermission"), userDetails ));

    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("mainPage");
    	mv.addObject( "page", "morgue/morgue" );
    	mv.addObject("customBoardList", getMorgueService.getUerCustomBoardList( (String) session.getAttribute("USER_NO") ));
    	return mv;
    }

    @RequestMapping( value = {"deleteCustomBoard"}, method = { RequestMethod.POST })
    public ModelAndView deleteCustomBoard(HttpSession session, String boardId) throws Exception{
    	getMorgueService.deleteCustomBoard( boardId, (String)session.getAttribute("USER_NO") );
    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	session.setAttribute("userMenu", getMorgueService.getUserMenu( (UserPermission)session.getAttribute("userPermission"), userDetails ));

    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("mainPage");
    	mv.addObject( "page", "morgue/morgue" );
    	mv.addObject("customBoardList", getMorgueService.getUerCustomBoardList( (String) session.getAttribute("USER_NO") ));
    	return mv;
    }

    @RequestMapping( value = {"renameCustomBoard"}, method = { RequestMethod.POST })
    public ModelAndView renameCustomBoard(HttpSession session, String boardId, String boardName) throws Exception{
    	getMorgueService.renameCustomBoard( boardId, boardName, (String)session.getAttribute("USER_NO") );
    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	session.setAttribute("userMenu", getMorgueService.getUserMenu( (UserPermission)session.getAttribute("userPermission"), userDetails ));

    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("mainPage");
    	mv.addObject( "page", "morgue/morgue" );
    	mv.addObject("customBoardList", getMorgueService.getUerCustomBoardList( (String) session.getAttribute("USER_NO") ));
    	return mv;
    }

    @RequestMapping( value = {"customBoard"}, method = { RequestMethod.GET,RequestMethod.POST })
    public ModelAndView customBoard( HttpSession session,
    		@RequestParam( value = "boardId" ) String boardId,
    		@RequestParam( value = "chartNum", defaultValue = "1" ) String chartNum,
            @RequestParam( value = "search", required = false ) String search,
            @RequestParam( value = "select", required = false ) String select
    		) throws Exception{
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("mainPage");
    	mv.addObject( "page", "morgue/customBoardList" );

    	Map<String, Object> map = getMorgueService.getBoardList(boardId, chartNum, search, select);
        if ( ( search != null ) || ( search != "" ) ) {
        	mv.addObject( "search", search );
        	mv.addObject( "select", select );
        }

        mv.addObject( "boardList", map.get("list") );
        mv.addObject( "boardId", boardId );
        mv.addObject( "totalPage", map.get("totalPage") );
        mv.addObject( "chartNum", chartNum );
        mv.addObject( "boardName", map.get("boardName") );

    	return mv;
    }

    //customWriting
    @RequestMapping( value = {"customWriting"}, method = { RequestMethod.GET,RequestMethod.POST })
    public ModelAndView customWritingForm( HttpSession session,
    		@RequestParam( value = "boardId" ) String boardId ) throws Exception{
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("mainPage");
    	mv.addObject( "page", "morgue/write" );
    	mv.addObject("boardId", boardId);
    	mv.addObject("boardName", getMorgueService.getCustomBoardName(boardId));

    	return mv;
    }

    @RequestMapping( value = { "customWrite" }, method = RequestMethod.POST )
    public String insertBoard(
    		@RequestParam( "WRITE_TITLE" ) String title,
            @RequestParam( "WRITE_MAIN_CONTENT" ) String mainContent,
            @RequestParam( "boardId" ) String boardId,
            @RequestParam(value="boardAttach", required=false) MultipartFile[] boardAttach,
            HttpSession session ) throws Exception {
        getMorgueService.insertBoard(title, boardId, mainContent, boardAttach, session);

        return "redirect:/customBoard?boardId="+boardId;
    }

    @RequestMapping( value = { "cViewPost" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView viewPost(
    		@RequestParam( value = "boardId" ) String boardId,
    		@RequestParam( "contentNo" ) String contentNo,
            @RequestParam( value = "chartNum", defaultValue = "1" ) String chartNum,
            @RequestParam( value = "search", required = false ) String search,
            @RequestParam( value = "select", required = false ) String select,
            HttpSession session) throws UserException {
    	Map<String, Object> map = getMorgueService.viewPost(boardId, chartNum, contentNo, search, select, session);
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "search", search );
        mv.addObject( "select", select );
        mv.addObject( "page", "morgue/viewPost" );
        mv.addObject( "board", map.get("boardInfo") );
        mv.addObject( "attachInfo", map.get("attachInfo") );
        mv.addObject("boardId", boardId);
        mv.addObject( "contentNo", contentNo );
        mv.addObject( "chartNum", chartNum );

        return mv;
    }

    // 리플 리스트
    @RequestMapping( value = { "cReplyList" }, method = RequestMethod.POST )
    public ModelAndView replyList( String boardId, String contentNo, HttpSession session ) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "morgue/replyList" );
        ArrayList<Map<String, Object>> list = getMorgueService.replyList(boardId, contentNo, session);
        mv.addObject( "list", list );
        mv.addObject( "size", list.size() );
        mv.addObject( "replyBoardId", boardId );
        mv.addObject( "contentNo", contentNo );
        return mv;
    }

    // 리플 등록
    @RequestMapping( value = "cInsertReply", method = RequestMethod.POST )
    public void insertReply( String boardId, String contentNo, String mainContent, HttpSession session, Writer writer ) throws IOException, UserException {
        writer.write( getMorgueService.insertReply(boardId, contentNo, URLDecoder.decode(mainContent, "UTF-8"), session) );
    }

    // 리플 삭제
    @RequestMapping( value = { "cDeleteReply" }, method = RequestMethod.POST )
    public void deleteReply( String boardId, String reContentNo, String contentNo, HttpSession session, Writer writer ) throws IOException {
        writer.write( getMorgueService.deleteReply(boardId, reContentNo, contentNo, session) );
    }

    // 답글 폼
    @RequestMapping( value = { "replyCustomBoardForm" }, method = RequestMethod.POST )
    public ModelAndView replyBoardForm( String boardId, String contentNo, String search, String select, String chartNum ) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "morgue/replyBoard" );
        mv.addObject( "replyBoardForm", getMorgueService.replyBoardForm(boardId, contentNo) );
        mv.addObject("boardId", boardId);
        mv.addObject("search", search);
        mv.addObject("select", select);
        mv.addObject("chartNum", chartNum);
        return mv;
    }

    // 게시물 답글
    @RequestMapping( value = "replyCustomBoard", method = RequestMethod.POST )
    public String replyBoard( HttpSession session,
    		@RequestParam( "boardId" ) String boardId,
            @RequestParam( value = "reply_openFlag", defaultValue = "Y" ) String openFlag,
            @RequestParam( "reply_title" ) String title,
            @RequestParam( "reply_content" ) String content,
            @RequestParam( "content_no" ) String contentNo,
            @RequestParam( "chartNum" ) String chartNum,
            @RequestParam( value="search", required = false ) String search,
            @RequestParam( value="select", required = false ) String select,
            @RequestParam( value="boardAttach", required = false ) MultipartFile[] boardAttach) throws UserException {
    	ModelAndView mv = new ModelAndView();

    	int no = getMorgueService.replyBoard(session, boardId, title, content, contentNo, boardAttach);

    	mv.setViewName( "board/replyBoard" );
        mv.addObject("success", "success");
        mv.addObject("boardId", boardId);
        mv.addObject("chartNum", chartNum);
        mv.addObject("search", search);
        mv.addObject("select", select);

        return "redirect:/cViewPost?boardId="+boardId+"&contentNo="+no+"&chartNum="+chartNum;
    }

    // 게시판 수정 폼
    @RequestMapping( value = { "cModifyBoardForm" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView modifyBoardForm(
    		@RequestParam( "boardId" ) String boardId,
    		@RequestParam( "contentNo" ) String contentNo,
            @RequestParam( value = "chartNum", defaultValue = "1" ) String chartNum,
            @RequestParam( value = "search", required = false ) String search,
            @RequestParam( value = "select", required = false ) String select,
            @RequestParam( value = "subCategory", required = false ) String subCategory,
            HttpSession session) throws UserException{
    	ModelAndView mv = new ModelAndView();
    	Map<String, Object> map = getMorgueService.modifyBoardForm(session, boardId, contentNo);

    	mv.setViewName( "mainPage" );
    	mv.addObject( "page", "morgue/modify" );
        mv.addObject( "board", map.get("boardInfo") );
        mv.addObject( "attachInfo", map.get("attachInfo") );
        mv.addObject("chartNum", chartNum);
        mv.addObject("search", search);
        mv.addObject("select", select);

    	return mv;
    }

    // 게시물 수정하기
    @RequestMapping( value = "cModifyBoard", method = { RequestMethod.GET, RequestMethod.POST } )
    public String modifyBoard( HttpSession session,
    		@RequestParam( "boardId" ) String boardId,
            @RequestParam( "modify_title" ) String title,
            @RequestParam( "modify_content" ) String content,
            @RequestParam( "content_no" ) String contentNo,
            @RequestParam(value="boardAttach", required=false) MultipartFile[] boardAttach,
            @RequestParam(value="deleteFile", required=false) String[] deleteFile,
            @RequestParam( value = "chartNum", defaultValue = "1" ) String chartNum,
            @RequestParam( value = "search", required = false ) String search,
            @RequestParam( value = "select", required = false ) String select
    		) throws UserException {
    	//attachFileMode default:0, 삭제:1

    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("board/modify");
    	getMorgueService.modifyBoard(session, boardId, title, content, contentNo, boardAttach, deleteFile);
        mv.addObject("success", "success");

//        return viewPost(category, chartNum, contentNo, search, select, oldSubCategory, session);
        return "redirect:/customBoard?boardId="+boardId+"&contentNo="+contentNo+"&chartNum="+chartNum;
    }

    // 게시물 삭제하기
    @RequestMapping( value = { "cDeleteBoard" }, method = RequestMethod.POST )
    public String deleteBoard( HttpSession session,
    		@RequestParam( "boardId" ) String boardId,
    		@RequestParam( "contentNo" ) String contentNo,
            @RequestParam( "chartNum" ) String chartNum,
            @RequestParam( value = "search", required = false ) String search,
            @RequestParam( value = "select", required = false ) String select) throws UserException {

    	getMorgueService.deleteBoard(session, boardId, contentNo);
        return "redirect:/customBoard?boardId="+boardId;
    }

    @RequestMapping( value = { "boardManagement" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView boardManagement( HttpSession session, String solution ) throws UserException{
    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName( "mainPage" );
    	mv.addObject( "page", "boardManagement/boardManagement" );
        mv.addObject( "projectFolders", getMorgueService.defaultprojectFolderTree(solution, userDetails) );
        mv.addObject("solution", solution);

    	return mv;
    }

    @RequestMapping( value = { "projectFolders" }, method = { RequestMethod.POST } )
    public ModelAndView projectFolders( HttpSession session,
    		@RequestParam( "solution" ) String solution,
    		@RequestParam( "mode" ) String mode,
    		@RequestParam( value = "upperId" ) String upperId,
    		@RequestParam( value = "projectName", required = false ) String projectName ) throws UserException{
    	getMorgueService.projectFolders(session, solution, mode, upperId, projectName);

    	CustomUserDetails userDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	UserPermission userPermission = (UserPermission)session.getAttribute("userPermission");

    	session.setAttribute("userMenu", getMorgueService.getUserMenu(userPermission, userDetails));
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName( "mainPage" );
    	mv.addObject( "page", "boardManagement/boardManagement" );
      mv.addObject( "projectFolders", getMorgueService.defaultprojectFolderTree(solution, userDetails) );
      mv.addObject( "solution", solution);

    	return mv;
    }
}
