package com.poscoict.license.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.poscoict.license.vo.Board;
import com.poscoict.license.vo.Reply;

@Repository
public class MorgueDaoJdbc implements MorgueDao {
    private JdbcTemplate jdbcTemplate;
    private MessageSourceAccessor msAccessor = null;
    private Logger logger = LoggerFactory.getLogger(getClass());
    
    public void setMessageSourceAccessor(MessageSourceAccessor msAccessor) {
     this.msAccessor = msAccessor;
    }

    public void setJdbcTemplate( JdbcTemplate jdbcTemplate ) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    public String getQuery(String queryKey){
    	String query = this.msAccessor.getMessage(queryKey);
    	logger.debug(queryKey);
    	return query;
    }
    
    private String searchQuery( String search, String select ) {
        switch ( Integer.parseInt( select ) ) {
            case 0:
                return " and TITLE LIKE '%" + search + "%'";
            case 1:
                return " and USER_NAME LIKE '%" + search + "%'";
            case 2:
                return " and (TITLE LIKE '%" + search + "%' or MAIN_CONTENT LIKE '%" + search + "%')";
            default:
                return "";
        }
    }
    
    
    
    public void createCustomBoard( String userNo, String boardId, String boardName ) {
    	this.jdbcTemplate.update( getQuery("morgue.createCustomBoard"), userNo, boardId, boardName, userNo, userNo );
    }
    
    public void createCustomBoard( String rootId, String boardId, String boardName, String createUser ) {
    	this.jdbcTemplate.update( getQuery("morgue.createProjectCustomBoard"), rootId, boardId, boardName, createUser, createUser );
    }
    
    public void deleteCustomBoard( String boardId, String userNo ) {
    	this.jdbcTemplate.update( getQuery("morgue.deleteCustomBoard"), userNo, userNo, boardId );
    }
    
    public void renameCustomBoard( String boardId, String boardName, String userNo ) {
    	this.jdbcTemplate.update( getQuery("morgue.renameCustomBoard"), boardName, userNo, boardId );
    }
    
    public List<Map<String, Object>> getUerCustomBoardList( String userNo ) {
        return this.jdbcTemplate.queryForList( getQuery("morgue.getUerCustomBoardList"), userNo );
    }
    
    public int getBoardCount( String boardId ) {
        return this.jdbcTemplate.queryForObject( getQuery("morgue.getBoardCount"), new Object[] { boardId }, Integer.class );
    }
    
    public List<Map<String, Object>> getCustomBoardList( String boardId, int start, int end ) {
        return this.jdbcTemplate.queryForList( getQuery("morgue.customBoardList"), boardId, start, end );
    }
    
    public int getSearchCount( String boardId, String search, String select ) {
        return this.jdbcTemplate.queryForObject( "select count(*) from glms_custom_board cus, glms_user user where cus.USER_NO = user.USER_NO"
                + " and cus.BOARD_ID=?"+ searchQuery( search, select ), new Object[] { boardId }, Integer.class );
    }
    
    public List<Map<String, Object>> getBoardSearch( String boardId, String search, String select, int start, int end ) {
        return this.jdbcTemplate
                .queryForList(
                		"select cus.CONTENT_NO, cus.BOARD_ID, cus.ORI_BOARD_ID, cus.TITLE, "
                		+"cus.R_CREATION_DATE, cus.R_CREATION_USER, cus.USER_NO, user.USER_NAME "
                		+"from glms_custom_board cus, glms_user user where cus.USER_NO = user.USER_NO "
                		+ searchQuery( search, select )
                		+"and cus.ORI_BOARD_ID=? and R_DELETED_DATE is null order by cus.CONTENT_NO DESC LIMIT ?,?"
                		, boardId, start, end);
    }
    
    public String getCustomBoardName( String boardId ) {
        return this.jdbcTemplate.queryForObject( getQuery("morgue.getCustomBoardName"), new Object[] { boardId }, String.class );
    }
    
    public int getBoardTotalCount( String boardId ) {
        return this.jdbcTemplate.queryForObject( getQuery("morgue.getBoardTotalCount"), new Object[]{ boardId }, Integer.class );
    }
    
    public void setAttachFileInfo(int contentNo, String folderId, String objectId, String fileName, String filePath, int fileSize, String userNo){
    	this.jdbcTemplate.update( getQuery("board.setAttachFileInfo"), objectId, contentNo, folderId, fileName, filePath, fileSize, userNo);
    }
    
    public void insertBoard( int contentNo, String boardId, String title, String mainContent, String userNo, int conentGrp, int contentSeq ) {
        this.jdbcTemplate.update( getQuery("morgue.insertBoard"), contentNo, boardId, boardId, title, mainContent, userNo, conentGrp, contentSeq, userNo);
    }
    
    public Map<String, Object> getViewPost( String boardId, int contentNo ) {
        return this.jdbcTemplate.queryForMap(getQuery("morgue.getViewPost"), new Object[] { boardId, contentNo } );
    }
    
    public Map<String, Object> replyCheck( String boardId, int groupNo ) {
        return this.jdbcTemplate.queryForMap( getQuery("morgue.replyCheck"), new Object[] { boardId, groupNo } );
    }
    
    public List<Map<String, Object>> getBoardAttachInfo( String boardId, int contentNo ) {
        return this.jdbcTemplate.queryForList( getQuery("board.getBoardAttachInfo"), boardId, contentNo );
    }
    
    public void modifyBoard( String title, String mainContent, String modifyDate, String userNo, String boardId, String contentNo ) {
    	this.jdbcTemplate.update( getQuery("morgue.modifyBoard"), title, mainContent, modifyDate, userNo, boardId, contentNo);
    }
    
    public String getAttachFilePath(String objectId){
    	return this.jdbcTemplate.queryForObject(getQuery("board.getAttachFilePath"), new Object[] {objectId}, String.class);
    }
    
    public void deleteAttachFile( String objectId ) {
        this.jdbcTemplate.update( getQuery("board.deleteAttachFile"), objectId );
    }
    
    public void deleteBoard( String date, String userNo, String boardId, int contentNo ) {
        this.jdbcTemplate.update( getQuery("morgue.deleteBoard"), date, userNo, boardId, contentNo );
    }
    
    public List<Map<String, Object>> getProjectFolders( String rootId ) {
        return this.jdbcTemplate.queryForList( getQuery("morgue.getProjectFolders"), rootId );
    }
    
    public void createProjectFolder ( String upperId, String id, String name, String userNo ) {
        this.jdbcTemplate.update( getQuery("morgue.createProjectFolder"), upperId, id, name, userNo, userNo );
    }
    
    public void createProjectBoard ( String folderId, String boardId, String userNo ) {
        this.jdbcTemplate.update( getQuery("morgue.createProjectBoard"), folderId, boardId, userNo, userNo );
    }
    
    public void renameProjectFolder ( String folderId, String folderName, String userNo ) {
        this.jdbcTemplate.update( getQuery("morgue.renameProjectFolder"), folderName, userNo, folderId );
    }
    
    public void renameProjectBoard ( String boardId, String boardName, String userNo ) {
        this.jdbcTemplate.update( getQuery("morgue.renameProjectBoard"), boardName, userNo, boardId );
    }
    
    public void deleteProjectFolder ( String folderId, String userNo ) {
        this.jdbcTemplate.update( getQuery("morgue.deleteProjectFolder"), userNo, userNo, folderId );
    }
    
    public List<Map<String, Object>> getProjectBoard( String rootId ) {
        return this.jdbcTemplate.queryForList( getQuery("morgue.getProjectBoard"), rootId );
    }
    
    public List<Map<String, Object>> getAllAdminUserCustomBoardList () {
        return this.jdbcTemplate.queryForList( getQuery("morgue.getAllAdminUserCustomBoardList") );
    }
    
    public List<Map<String, Object>> getReplyList( String boardId, int contentNo ) {
        return this.jdbcTemplate.queryForList( getQuery("morgue.getReplyList"), boardId, contentNo );
    }
    
    // 리플 MAX(CONTENT_NO)
    public int getReplyCount( String boardId, int contentNo ) {
        return this.jdbcTemplate.queryForObject( getQuery("morgue.getReplyCount"), new Object[] { boardId, contentNo }, 
        		Integer.class );
    }
    
    // 리플 등록
    public void insertReply( int contentNo, String boardId, int reContentNo, String mainContent, String userNo ) {
        this.jdbcTemplate.update( getQuery("morgue.insertReply"), contentNo, boardId, reContentNo, mainContent, userNo );
    }
    
 // 리플 삭제
    public void deleteReply( String userNo, int contentNo, String boardId, int reContentNo ) {
        this.jdbcTemplate.update( getQuery("morgue.deleteReply"), userNo, contentNo, boardId, reContentNo, userNo);
    }
}
