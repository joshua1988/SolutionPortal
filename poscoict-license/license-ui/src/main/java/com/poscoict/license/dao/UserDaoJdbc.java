package com.poscoict.license.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.poscoict.license.vo.Board;
import com.poscoict.license.vo.PushMessage;
import com.poscoict.license.vo.Reply;
import com.poscoict.license.vo.UserInfo;

@Repository
public class UserDaoJdbc implements UserDao {
    private JdbcTemplate jdbcTemplate;
    private MessageSourceAccessor msAccessor = null;
    private Logger logger = LoggerFactory.getLogger(getClass());

    public void setMessageSourceAccessor(MessageSourceAccessor msAccessor) {
    	this.msAccessor = msAccessor;
    }


    public void setJdbcTemplate( JdbcTemplate jdbcTemplate ) {
        this.jdbcTemplate = jdbcTemplate;
    }

/*    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }*/

    private RowMapper<UserInfo> userMapper = new RowMapper<UserInfo>() {
        public UserInfo mapRow( ResultSet rs, int rowNum ) throws SQLException {
        	UserInfo user = new UserInfo();
            user.setUSER_NO( rs.getString( "USER_NO" ) );
            user.setUSER_NAME( rs.getString( "USER_NAME" ) );
            user.setUSER_PASSWORD( rs.getString( "USER_PASSWORD" ) );
            user.setUSER_TYPE( rs.getString( "USER_TYPE" ) );
            return user;
        }
    };

    private RowMapper<Reply> replyMapper = new RowMapper<Reply>() {
        public Reply mapRow( ResultSet rs, int rowNum ) throws SQLException {
            Reply re = new Reply();
            re.setCONTENT_NO( rs.getInt( "CONTENT_NO" ) );
            re.setORI_FOLDER_ID( rs.getString( "ORI_FOLDER_ID" ) );
            re.setR_CREATION_DATE( rs.getString( "R_CREATION_DATE" ) );
            re.setR_CREATION_USER( rs.getString( "R_CREATION_USER" ) );
            re.setRE_CONTENT_NO( rs.getInt( "RE_CONTENT_NO" ) );
            re.setRE_MAIN_CONTENT( rs.getString( "RE_MAIN_CONTENT" ) );
            re.setR_MODIFY_DATE( rs.getString( "R_MODIFY_DATE" ) );
            re.setR_MODIFY_USER( rs.getString( "R_MODIFY_USER" ) );
            re.setR_DELETED_DATE( rs.getString( "R_DELETED_DATE" ) );
            re.setR_DELETED_USER( rs.getString( "R_DELETED_USER" ) );
            return re;
        }
    };

    private RowMapper<Board> boardMapper = new RowMapper<Board>() {
        public Board mapRow( ResultSet rs, int rowNum ) throws SQLException {
            Board board = new Board();
            board.setCONTENT_NO( rs.getInt( "CONTENT_NO" ) );
            board.setFOLDER_ID( rs.getString( "FOLDER_ID" ) );
            board.setORI_FOLDER_ID( "ORI_FOLDER_ID" );
            board.setTITLE( rs.getString( "TITLE" ) );
            board.setMAIN_CONTENT( rs.getString( "MAIN_CONTENT" ) );
            board.setUSER_NO( rs.getString( "USER_NO" ) );
            board.setOPEN_FLAG( rs.getString( "OPEN_FLAG" ) );
            board.setCLICKS( rs.getInt( "CLICKS" ) );
            board.setCONTENT_GRP( rs.getInt( "CONTENT_GRP" ) );
            board.setCONTENT_SEQ( rs.getInt( "CONTENT_SEQ" ) );
            board.setR_CREATION_DATE( rs.getString( "R_CREATION_DATE" ) );
            board.setR_CREATION_USER( rs.getString( "R_CREATION_USER" ) );
            board.setR_MODIFY_DATE( rs.getString( "R_MODIFY_DATE" ) );
            board.setR_MODIFY_USER( rs.getString( "R_MODIFY_USER" ) );
            board.setR_DELETED_TYPE( rs.getString( "R_DELETED_TYPE" ) );
            board.setUSER_NAME( rs.getString( "USER_NAME" ) );
            board.setREPLY_COUNT( rs.getInt( "REPLY_COUNT" ) );
            return board;
        }
    };

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

//    private String subCategory( String category ) {
//    	String temp="";
//
//    	for(SubCategory sub: SubCategory.values()){
//    		if(sub.getCategory().equals(category))
//    			temp=" and SUBCATEGORY = '" + category + "'";
//    	}
//
//    	return temp;
//    }

    public int loginCheck( String id, String pw ) {
        return this.jdbcTemplate.queryForObject( getQuery("board.loginCheck"), new Object[] {
                id, pw }, Integer.class );
    }

    public List<Map<String, Object>> getUerCustomBoardList( String userNo ) {
        return this.jdbcTemplate.queryForList( getQuery("morgue.getUerCustomBoardList"), userNo );
    }

    public UserInfo get( String id ) {
        return this.jdbcTemplate.queryForObject( getQuery("board.get"), new Object[] { id }, this.userMapper );
    }

    public List<Map<String, Object>> getMenuList(String userNo) {
    	return this.jdbcTemplate.queryForList( getQuery("board.getMenuList"), userNo);
    }

    // 중요 공지 등록/해지
    public void noticeMode(String folderId, String contentNo){
    	this.jdbcTemplate.update( getQuery("board.noticeMode"), folderId, contentNo );
    }

    // 폴더별 게시물 토탈
    public int getBoardCount( String folderId ) {
        return this.jdbcTemplate.queryForObject( getQuery("board.getBoardCount"), new Object[] { folderId },
                Integer.class );
    }

    // 폴더별 게시물 토탈
    public int getBoardCount2( String folderId, String category ) {
        return this.jdbcTemplate.queryForObject( getQuery("board.getBoardCount2")+" and SUBCATEGORY = '" + category + "'"
        		, new Object[] { folderId }, Integer.class );
    }

    // 폴더별 검색 게시물 토탈
    public int getSearchCount2( String folderId, String category, String search, String select ) {
        return this.jdbcTemplate.queryForObject( "select count(*) from glms_qna qna, glms_user user where qna.USER_NO = user.USER_NO"
                + " and FOLDER_ID=?"+" and SUBCATEGORY = '" + category + "'" + searchQuery( search, select ), new Object[] { folderId }, Integer.class );
    }

    // 게시물 리스트
    public List<Map<String, Object>> getBoard2( String page, String category, int start, int end ) {
        return this.jdbcTemplate.queryForList( getQuery("board.getBoard")+" and SUBCATEGORY = '" + category + "'"+" order by CONTENT_GRP DESC, CONTENT_SEQ ASC LIMIT ?,?) order by OD ASC, CONTENT_GRP DESC, CONTENT_SEQ ASC"
        		, page, start, end );
    }

    // 게시물 검색 리스트
    public List<Map<String, Object>> getBoardSearch2( String page, String search, String select, String category, int start, int end ) {
        return this.jdbcTemplate
                .queryForList(
                		"(select 'A' as OD, qna.CONTENT_NO, qna.FOLDER_ID, qna.ORI_FOLDER_ID, qna.SUBCATEGORY, qna.TITLE, qna.OPEN_FLAG, "
                		+"qna.R_CREATION_DATE, qna.R_CREATION_USER, qna.R_MODIFY_DATE, qna.R_MODIFY_USER, "
                		+"qna.CLICKS, qna.USER_NO, qna.R_DELETED_TYPE, qna.CONTENT_GRP, qna.CONTENT_SEQ, user.USER_NAME, "
                		+"(select count(*) from glms_qna_reply where ORI_FOLDER_ID=qna.ORI_FOLDER_ID and CONTENT_NO=qna.CONTENT_NO and R_DELETED_USER is null) as REPLY_COUNT "
                		+"from glms_qna qna, glms_user user where qna.USER_NO = user.USER_NO and qna.ORI_FOLDER_ID='notice' and qna.SUBCATEGORY='important' "
                		+"and qna.R_DELETED_DATE is null) UNION ALL "
                		+"(select 'B' as OD, qna.CONTENT_NO, qna.FOLDER_ID, qna.ORI_FOLDER_ID, qna.SUBCATEGORY, qna.TITLE, qna.OPEN_FLAG, "
                        +"qna.R_CREATION_DATE, qna.R_CREATION_USER, qna.R_MODIFY_DATE, qna.R_MODIFY_USER, "
                        +"qna.CLICKS, qna.USER_NO, qna.R_DELETED_TYPE, qna.CONTENT_GRP, qna.CONTENT_SEQ, user.USER_NAME, "
                        +"(select count(*) from glms_qna_reply where ORI_FOLDER_ID=qna.ORI_FOLDER_ID and CONTENT_NO=qna.CONTENT_NO and R_DELETED_USER is null) as REPLY_COUNT "
                        +"from glms_qna qna, glms_user user" + " where qna.USER_NO = user.USER_NO" + " and qna.FOLDER_ID in (?,'important') "
                        + searchQuery( search, select ) + " and SUBCATEGORY = '" + category + "'"
                        + " order by CONTENT_GRP DESC, CONTENT_SEQ ASC LIMIT ?,?) order by OD ASC, CONTENT_GRP DESC, CONTENT_SEQ ASC"
                        , page, start, end );
    }



    // 글쓰기
    public void insertBoard( Board board ) {
        this.jdbcTemplate.update( getQuery("board.insertBoard"),
        		board.getCONTENT_NO(), board.getFOLDER_ID(), board.getFOLDER_ID(), board.getSUBCATEGORY(),
                board.getTITLE(), board.getMAIN_CONTENT(), board.getUSER_NO(), board.getOPEN_FLAG(), board.getR_CREATION_DATE(),
                board.getR_CREATION_USER(), board.getCONTENT_GRP(), board.getCONTENT_SEQ(), board.getATTACH_FILE_NAME(),
                board.getATTACH_FILE_PATH(), board.getATTACH_FILE_SIZE() );
    }

    // 게시판 guest 임시 ID,PW 입력
    public void insertExtraAccounts(String guestID, String guestPW, int contentNo, String folderID){
    	this.jdbcTemplate.update( getQuery("board.insertExtraAccounts"), guestID, guestPW, contentNo, folderID);
    }

    // 게시판 guest 임시 ID,PW 확인
    public int getExtraAccounts( String guestID, String guestPW, int contentNo, String folderID ) {
        return this.jdbcTemplate.queryForObject( getQuery("board.getExtraAccounts"), new Object[]{guestID, guestPW, contentNo, folderID}, Integer.class );
    }

    // folder 패스 가져오기
    public String getFolderPath( String folderId ) {
        return this.jdbcTemplate.queryForObject( getQuery("board.getFolderPath"), new Object[] { folderId }, String.class );
    }

    // 게시물 리스트
    public List<Map<String, Object>> getBoard( String page, int start, int end ) {
        return this.jdbcTemplate.queryForList( getQuery("board.getBoard"), page, start, end );
    }

    // 게시물 검색 리스트
    public List<Map<String, Object>> getBoardSearch( String page, String search, String select, int start, int end ) {
        return this.jdbcTemplate
                .queryForList( "select qna.CONTENT_NO, qna.FOLDER_ID, qna.ORI_FOLDER_ID, qna.SUBCATEGORY, qna.TITLE, qna.MAIN_CONTENT, qna.OPEN_FLAG,"
                        + " qna.R_CREATION_DATE, qna.R_CREATION_USER, qna.R_MODIFY_DATE, qna.R_MODIFY_USER,"
                        + " qna.CLICKS, qna.USER_NO, qna.R_DELETED_TYPE, qna.CONTENT_GRP, qna.CONTENT_SEQ, user.USER_NAME,"
                        + " (select count(*) from glms_qna_reply where ORI_FOLDER_ID=qna.ORI_FOLDER_ID and CONTENT_NO=qna.CONTENT_NO ) as REPLY_COUNT"
                        + " from glms_qna qna, glms_user user" + " where qna.USER_NO = user.USER_NO" + " and qna.ORI_FOLDER_ID=?"
                        + searchQuery( search, select ) + " order by CONTENT_GRP DESC, CONTENT_SEQ ASC LIMIT ?,?", new Object[] { page,
                        start, end });
    }

    // 폴더별 검색 게시물 토탈
    public int getSearchCount( String FOLDER_ID, String search, String select ) {
        return this.jdbcTemplate.queryForObject( "select count(*) from glms_qna qna, glms_user user" + " where qna.USER_NO = user.USER_NO"
                + " and ORI_FOLDER_ID=?" + searchQuery( search, select ), new Object[] { FOLDER_ID }, Integer.class );
    }

    // 게시물 조회수 증가
    public void mountClicks( String menu, int contentNo ) {
        this.jdbcTemplate.update( getQuery("board.mountClicks"), new Object[] { menu, contentNo } );
    }

    // 게시물 보기
    public Map<String, Object> getViewPost( String menu, int contentNo ) {
        return this.jdbcTemplate.queryForMap(getQuery("board.getViewPost"), new Object[] { menu, contentNo } );
    }

    // 게시판 첨부파일 정보
    public List<Map<String, Object>> getBoardAttachInfo( String category, int contentNo ) {
        return this.jdbcTemplate.queryForList( getQuery("board.getBoardAttachInfo"), category, contentNo );
    }

    // 게시물 수정 업데이트
    public void modifyBoard( Board board ) {
        this.jdbcTemplate.update( getQuery("board.modifyBoard"),
        		board.getSUBCATEGORY(), board.getOPEN_FLAG(), board.getTITLE(), board.getMAIN_CONTENT(),
                board.getR_MODIFY_DATE(), board.getR_MODIFY_USER(), board.getORI_FOLDER_ID(), board.getCONTENT_NO() );
    }

    // 게시물 삭제
    public void deleteBoard( String date, String USER_NO, String USER_TYPE, String ORI_FOLDER_ID, int CONTENT_NO ) {
        this.jdbcTemplate.update( getQuery("board.deleteBoard"), date, USER_NO, USER_TYPE, ORI_FOLDER_ID, CONTENT_NO );
    }

    // 답글
    public Map<String, Object> replyCheck( String folder, int groupNo ) {
        return this.jdbcTemplate.queryForMap( getQuery("board.replyCheck"), new Object[] { folder, groupNo } );
    }

    // 리플 리스트
    public List<Map<String, Object>> getReplyList( String ORI_FOLDER_ID, int CONTENT_NO ) {
        return this.jdbcTemplate.queryForList( getQuery("board.getReplyList"), new Object[] { ORI_FOLDER_ID, CONTENT_NO });
    }

    // 리플 등록
    public void insertReply( Reply reply ) {
        this.jdbcTemplate.update( getQuery("board.insertReply"), reply.getCONTENT_NO(),
                reply.getORI_FOLDER_ID(), reply.getRE_CONTENT_NO(), reply.getRE_MAIN_CONTENT(), reply.getR_CREATION_DATE(),
                reply.getR_CREATION_USER() );
    }

    // 리플 MAX(CONTENT_NO)
    public int getReplyCount( String ORI_FOLDER_ID, int CONTENT_NO ) {
        return this.jdbcTemplate.queryForObject( getQuery("board.getReplyCount"), new Object[] { ORI_FOLDER_ID, CONTENT_NO },
        		Integer.class );
    }

    // 리플 삭제
    public void deleteReply( String userNo, int contentNo, String folder, int reContentNo ) {
        this.jdbcTemplate.update( getQuery("board.deleteReply"), userNo, contentNo, folder, reContentNo, userNo);
    }

    // 비밀번호 확인
    public int passwordConfirmation(String userNo, String oriPassword){
    	return this.jdbcTemplate.queryForObject(getQuery("board.passwordConfirmation"),
    			new Object[] {userNo, oriPassword}
    			, Integer.class);
    }

    // 비밀번호 수정
    public void modifyPassword(String userNo, String newPassword){
    	this.jdbcTemplate.update(getQuery("board.modifyPassword"), newPassword, userNo);
    }

    // 첨부파일 패스
    public String getAttachFilePath(String objectId){
    	return this.jdbcTemplate.queryForObject(getQuery("board.getAttachFilePath"),
    			new Object[] {objectId}, String.class);
    }

    // 첨부파일 정보 삭제
    public void deleteAttachFile( String objectId ) {
        this.jdbcTemplate.update( getQuery("board.deleteAttachFile"), objectId );
    }

    // 첨부파일 정보 삭제
    public void updateAttachFileInfo( String folderId, String contentNo, String fileName, String filePath, int fileSize ) {
        this.jdbcTemplate.update( getQuery("board.updateAttachFileInfo"), fileName, filePath, fileSize, folderId, contentNo );
    }

    // 게시판 읽기 권한 확인
    public Map<String, Object> getBoardPermissionCheck(String folderId, String contentNo) {
        return this.jdbcTemplate.queryForMap(getQuery("board.getBoardPermissionCheck"), folderId, folderId, folderId, folderId, folderId, contentNo);
    }

    public void setAttachFileInfo(int contentNo, String folderId, String objectId, String fileName, String filePath, int fileSize, String userNo){
    	this.jdbcTemplate.update( getQuery("board.setAttachFileInfo"), objectId, contentNo, folderId, fileName, filePath, fileSize, userNo);
    }

    public String getQuery(String queryKey){
    	String query = this.msAccessor.getMessage(queryKey);
    	logger.debug(queryKey);
    	return query;
    }
}
