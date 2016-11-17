package com.poscoict.license.dao;

import java.util.List;
import java.util.Map;

public interface MorgueDao {
	void createCustomBoard( String userNo, String boardId, String boardName );
	
	void createCustomBoard( String rootId, String boardId, String boardName, String createUser );
	
	void deleteCustomBoard( String boardId, String userNo );
	
	void renameCustomBoard( String boardId, String boardName, String userNo );
	
	List<Map<String, Object>> getUerCustomBoardList( String userNo );
	
	int getBoardCount( String boardId );
	
	List<Map<String, Object>> getCustomBoardList( String boardId, int start, int end );
	
	int getSearchCount( String boardId, String search, String select );
	
	List<Map<String, Object>> getBoardSearch( String boardId, String search, String select, int start, int end );
	
	String getCustomBoardName( String boardId );
	
	int getBoardTotalCount( String boardId );
	
	void setAttachFileInfo(int contentNo, String folderId, String objectId, String fileName, String filePath, int fileSize, String userNo);
	
	void insertBoard( int contentNo, String boardId, String title, String mainContent, String userNo, int conentGrp, int contentSeq );
	
	Map<String, Object> getViewPost( String boardId, int contentNo );
	
	List<Map<String, Object>> getBoardAttachInfo( String boardId, int contentNo );
	
	Map<String, Object> replyCheck( String boardId, int groupNo );
	
	void modifyBoard( String title, String mainContent, String modifyDate, String userNo, String boardId, String contentNo );
	
	String getAttachFilePath(String objectId);
	
	void deleteAttachFile( String objectId );
	
	void deleteBoard( String date, String userNo, String boardId, int contentNo );
	
	List<Map<String, Object>> getProjectFolders( String rootId );
	
	void createProjectFolder ( String upperId, String id, String name, String userNo );
	
	void createProjectBoard ( String folderId, String boardId, String userNo );
	
	void renameProjectFolder ( String folderId, String folderName, String userNo );
	
	void renameProjectBoard ( String boardId, String boardName, String userNo );
	
	void deleteProjectFolder ( String folderId, String userNo );
	
	List<Map<String, Object>> getProjectBoard( String rootId );
	
	List<Map<String, Object>> getAllAdminUserCustomBoardList ();
	
	List<Map<String, Object>> getReplyList( String boardId, int contentNo );
	
	int getReplyCount( String boardId, int contentNo );
	
	void insertReply( int contentNo, String boardId, int reContentNo, String mainContent, String userNo );
	
	void deleteReply( String userNo, int contentNo, String boardId, int reContentNo );
}
