package com.poscoict.license.dao;

import java.util.List;
import java.util.Map;

import com.poscoict.license.vo.Board;
import com.poscoict.license.vo.Reply;
import com.poscoict.license.vo.UserInfo;

public interface UserDao {
    int loginCheck( String id, String pw );
    
    List<Map<String, Object>> getUerCustomBoardList( String userNo );
    
    List<Map<String, Object>> getMenuList(String userNo);

    UserInfo get( String id );

    int getBoardCount( String FOLDER_ID );

    void insertBoard( Board board );
    
    void insertExtraAccounts(String guestID, String guestPW, int contentNo, String folderID);
    
    int getExtraAccounts( String guestID, String guestPW, int contentNo, String folderID );
    
    String getFolderPath( String folderId );

    List<Map<String, Object>> getBoard( String page, int start, int end );

    List<Map<String, Object>> getBoardSearch( String page, String search, String select, int start, int end );

    int getSearchCount( String FOLDER_ID, String search, String select );

    void mountClicks( String menu, int contentNo );

    Map<String, Object> getViewPost( String menu, int contentNo );

    void modifyBoard( Board board );

    void deleteBoard( String date, String USER_NO, String USER_TYPE, String ORI_FOLDER_ID, int CONTENT_NO );

    Map<String, Object> replyCheck( String ORI_FOLDER_ID, int CONTENT_NO );

    List<Map<String, Object>> getReplyList( String ORI_FOLDER_ID, int CONTENT_NO );

    void insertReply( Reply reply );

    int getReplyCount( String ORI_FOLDER_ID, int CONTENT_NO );

    void deleteReply( String userNo, int contentNo, String boardId, int reContentNo );
    
    int passwordConfirmation(String userNo, String oriPassword);
    
    void modifyPassword(String userNo, String newPassword);
    
    int getBoardCount2( String folderId, String category );
    
    int getSearchCount2( String FOLDER_ID, String category, String search, String select );
    
    List<Map<String, Object>> getBoard2( String page, String category, int start, int end );
    
    List<Map<String, Object>> getBoardSearch2( String page, String search, String select, String category, int start, int end );
    
    String getAttachFilePath(String objectId);
    
    void deleteAttachFile( String objectId );
    
    void updateAttachFileInfo( String folderId, String contentNo, String fileName, String filePath, int fileSize );
    
    Map<String, Object> getBoardPermissionCheck(String folderId, String contentNo);
    
    void setAttachFileInfo(int contentNo, String folderId, String objectId, String fileName, String filePath, int fileSize, String userNo);
    
    List<Map<String, Object>> getBoardAttachInfo( String category, int contentNo );
    
    void noticeMode(String folderId, String contentNo);
}
