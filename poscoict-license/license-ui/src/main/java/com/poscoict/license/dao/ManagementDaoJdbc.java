package com.poscoict.license.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.poscoict.license.consts.Consts;
import com.poscoict.license.vo.ContractPersonInfo;
import com.poscoict.license.vo.FileList;
import com.poscoict.license.vo.UserInfo;

@Repository
public class ManagementDaoJdbc implements ManagementDao {
    private JdbcTemplate jdbcTemplate;
    private MessageSourceAccessor messageSourceAccessor = null;
    private Logger logger = LoggerFactory.getLogger(getClass());
    
    public void setMessageSourceAccessor(MessageSourceAccessor messageSourceAccessor) {
    	this.messageSourceAccessor = messageSourceAccessor;
    }

    public void setJdbcTemplate( JdbcTemplate jdbcTemplate ) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<UserInfo> clientMapper = new RowMapper<UserInfo>() {
        public UserInfo mapRow( ResultSet rs, int rowNum ) throws SQLException {
        	UserInfo management = new UserInfo();
            management.setUSER_NO( rs.getString( "USER_NO" ) );
            management.setUSER_NAME( rs.getString( "USER_NAME" ) );
            management.setMANAGER_NAME( rs.getString( "MANAGER_NAME" ) );
            management.setPROJECT_NAME( rs.getString( "PROJECT_NAME" ) );
            management.setUSER_START_DATE( rs.getDate( "USER_START_DATE" ) );
            management.setPRODUCT_SETUP_DATE( rs.getDate( "PRODUCT_SETUP_DATE" ) );
            management.setR_CREATION_DATE( rs.getDate( "R_CREATION_DATE" ) );
            return management;
        }
    };

    private RowMapper<UserInfo> moreClientMapper = new RowMapper<UserInfo>() {
        public UserInfo mapRow( ResultSet rs, int rowNum ) throws SQLException {
        	UserInfo management = new UserInfo();
            management.setUSER_NO( rs.getString( "USER_NO" ) );
            management.setUSER_NAME( rs.getString( "USER_NAME" ) );
            management.setMANAGER_NAME( rs.getString( "MANAGER_NAME" ) );
            management.setMANAGER_OFFICE_PHON( rs.getString( "MANAGER_OFFICE_PHON" ) );
            management.setMANAGER_CEL_PHON( rs.getString( "MANAGER_CEL_PHON" ) );
            management.setMANAGER_EMAIL( rs.getString( "MANAGER_EMAIL" ) );
            management.setUSER_START_DATE( rs.getDate( "USER_START_DATE" ) );
            management.setPRODUCT_SETUP_DATE( rs.getDate( "PRODUCT_SETUP_DATE" ) );
            management.setUSER_ADDRESS( rs.getString( "USER_ADDRESS" ) );
            management.setPROJECT_NAME( rs.getString( "PROJECT_NAME" ) );
            management.setORDER_COMPANY_CODE( rs.getString( "ORDER_COMPANY_CODE" ) );
            return management;
        }
    };

    private RowMapper<FileList> fileListMapper = new RowMapper<FileList>() {
        public FileList mapRow( ResultSet rs, int rowNum ) throws SQLException {
            FileList list = new FileList();
            list.setPRODUCT_FILE_NAME( rs.getString( "PRODUCT_FILE_NAME" ) );
            list.setMAIN_CONTENT( rs.getString( "MAIN_CONTENT" ) );
            list.setFILE_CATEGORY( rs.getString( "FILE_CATEGORY" ) );
            list.setR_CREATION_DATE( rs.getString( "R_CREATION_DATE" ) );
            return list;
        }
    };
    
	public String getSubcontract(String userNo){
		return this.jdbcTemplate.queryForObject( getQuery("management.getSubcontract") , new Object[] {userNo}, String.class);
	}
	
	public int getCommentCount(String objectId){
		return this.jdbcTemplate.queryForObject( getQuery("management.getCommentCount") , new Object[] {objectId}, Integer.class);
	}

    public List<UserInfo> getClientInfo(boolean mode, String orderCompanyCode) {
        return this.jdbcTemplate.query( getQuery("management.getClientInfo") + modeClientInfo(mode, orderCompanyCode), this.clientMapper );
    }
    
    public List<Map<String, Object>> getProgressInfo(String subCategory, boolean mode, String orderCompanyCode) {
        return this.jdbcTemplate.queryForList( getQuery("management.getProgressInfo")+progressSubCategoryQuery(subCategory) + modeProgressInfo(mode, orderCompanyCode) );
    }
    
    public List<Map<String, Object>> getCustomUserList() {
        return this.jdbcTemplate.queryForList( getQuery("management.getCustomUserList") );
    }
    
    public void insert_user_permission(String codes, String codeTypes, String userNo, int size) {
        this.jdbcTemplate.update( getQuery("management.insert_user_permission"), codes, codeTypes, userNo, size );
    }
    
    private String progressSubCategoryQuery( String subCategory ) {
        switch ( Integer.parseInt( subCategory ) ) {
            case 0:
                return " where co.ORDER_STATUS IN ('P','C','R','G','F') ";
            case 1:
                return " where co.ORDER_STATUS = 'P' ";
            case 2:
                return " where co.ORDER_STATUS = 'C' ";
            case 3:
                return " where co.ORDER_STATUS = 'R' ";
            case 4:
                return " where co.ORDER_STATUS IN ('G','F') ";
            default:
                return "";
        }
    }
    
    private String modeProgressInfo( boolean mode, String orderCompanyCode ) {
    	if(mode)
    		return " and co.ORDER_COMPANY_CODE = '"+orderCompanyCode+"' order by co.R_CREATION_DATE DESC";
    	else
    		return " order by co.R_CREATION_DATE DESC";
    }
    
    private String modeClientInfo( boolean mode, String orderCompanyCode ) {
    	if(mode)
    		return " and ORDER_COMPANY_CODE = '"+orderCompanyCode+"' order by R_CREATION_DATE DESC";
    	else
    		return " order by R_CREATION_DATE DESC";
    }

    public UserInfo getClientInfoMore( String USER_NO ) {
        return this.jdbcTemplate.queryForObject( getQuery("management.getClientInfoMore"), new Object[] { USER_NO }, this.moreClientMapper );
    }
    
    public Map<String, Object> getProgressInfoMore( String objectId ) {
        return this.jdbcTemplate.queryForMap( getQuery("management.getProgressInfoMore"), objectId );
    }

    // 폴더별 다운로드 파일 리스트
    public List<Map<String, Object>> getFileList( String category ) {
        return this.jdbcTemplate.queryForList( getQuery("management.getFileList"), new Object[] { category });
    }

    public List<FileList> getFileList() {
        return this.jdbcTemplate.query( getQuery("management.getFileList2"), this.fileListMapper );
    }

    // 패키지 패스
    public String getFilePath( String objectId ) {
    	try{
    		return this.jdbcTemplate.queryForObject( getQuery("management.getFilePath"), new Object[] { objectId }, String.class );    		
    	}catch(EmptyResultDataAccessException e){
    		return null;
    	}
    }
    
    // 라이센스 패스
    public String getLicensePath( String fileName, String userNo ) {
    		return this.jdbcTemplate.queryForObject( getQuery("management.getLicensePath"), new Object[] { fileName, userNo }, String.class );    		
    }
    
    // 라이센스 패스
    public String getLicensePath2( String licenseKey, String userNo ) {
    	try{
    		return this.jdbcTemplate.queryForObject( getQuery("management.getLicensePath2"), new Object[] { licenseKey, userNo }, String.class );    		
    	}catch(EmptyResultDataAccessException e){
    		return null;
    	}
    }
    
    // 인스톨가이드 패스
    public String getInstallGuidePath( String fileName ) {
    	try{
    		return this.jdbcTemplate.queryForObject( getQuery("management.getInstallGuidePath"), new Object[] { fileName }, String.class );    		
    	}catch(EmptyResultDataAccessException e){
    		return null;
    	}
    }
    
    // 패치 파일 패스
    public String getPatchPath( String objectId ) {
    	try{
    		return this.jdbcTemplate.queryForObject( getQuery("management.getPatchPath"), new Object[] { objectId }, String.class );    		
    	}catch(EmptyResultDataAccessException e){
    		return null;
    	}
    }
    
    // 패치 파일 패스 (전체 삭제용)
    public List<Map<String, Object>> getDeletePatchPath( String objectId ) {
    	try{
    		return this.jdbcTemplate.queryForList( getQuery("management.getDeletePatchPath"), objectId );    		
    	}catch(EmptyResultDataAccessException e){
    		return null;
    	}
    }
    
    // 패치 파일 패스 (삭제용)
    public String getDeletePatchPath2( String objectId ) {
    	try{
    		return this.jdbcTemplate.queryForObject( getQuery("management.getDeletePatchPath2"), new Object[] { objectId }, String.class );    		
    	}catch(EmptyResultDataAccessException e){
    		return null;
    	}
    }
    
    // 다운로드 카운팅
    public void setDownloadCnt(String userNo, String fileName){
    	this.jdbcTemplate.update( getQuery("management.setDownloadCnt"), userNo, fileName);
    }
    
    // 
    public void addUserEtcFileInfo(String userNo, String etcId, String admin){
    	this.jdbcTemplate.update( getQuery("management.addUserEtcFileInfo"), userNo, etcId, admin);
    }
    
    // 파일 다운로드 카운팅
    public void insertFileDownload(String userNo, String fileName){
    	this.jdbcTemplate.update( getQuery("management.insertFileDownload"), userNo, fileName);
    }
    
    // 라이센스 카운팅
    public void setLiscenseDownloadCnt(String userNo, String fileName){
    	this.jdbcTemplate.update( getQuery("management.setLiscenseDownloadCnt"), userNo, fileName );
    }
    
    // 업로드폴더 패스
    public String getFolderPath( String folderName ) {
        return this.jdbcTemplate.queryForObject( getQuery("management.getFolderPath"), new Object[] { folderName }, String.class );
    }

    // 신규 파일정보 입력
    public void addFileInfo( String objectId, String folder, String packageVersion, String fileName, String comment, String filePath, String userNo ) {
        this.jdbcTemplate.update( getQuery("management.addFileInfo"),
        		objectId, folder, packageVersion, fileName, comment, filePath, userNo, userNo );
    }
    
    // 신규 패치파일정보 입력
    public void addPatchFileInfo( String objectId, String pObjectId, String folder, String packageVersion, String fileName, String comment, String filePath, String userNo ) {
        this.jdbcTemplate.update( getQuery("management.addPatchFileInfo"),
        		objectId, pObjectId, folder, packageVersion, fileName, comment, filePath, userNo, userNo );
    }
    
    public List<Map<String, Object>> getFolderCategory(String userNo) {
        return this.jdbcTemplate.queryForList( getQuery("management.getFolderCategory"), userNo );
    }
    
    public List<Map<String, Object>> getPackageVersionList() {
        return this.jdbcTemplate.queryForList( getQuery("management.getPackageVersionList") );
    }

    public List<Map<String, Object>> getFileAllList() {
        return this.jdbcTemplate.queryForList( getQuery("management.getFileAllList") );
    }

    public List<Map<String, Object>> getCompanyList() {
        return this.jdbcTemplate.queryForList( getQuery("management.getCompanyList") );
    }
    
    public List<Map<String, Object>> getProductInfo(String userNo) {
        return this.jdbcTemplate.queryForList( getQuery("management.getProductInfo"), userNo);
    }
    
    public Map<String, Object> getProductInfo2(String userNo, String licenseKey) {
        return this.jdbcTemplate.queryForMap( getQuery("management.getProductInfo2") , userNo,licenseKey);
    }
    
    //Guest용 제품 다운로드 리스트(GlueFramework 만)
    public List<Map<String, Object>> getGuestPackageInfo() {
        return this.jdbcTemplate.queryForList( getQuery("management.getGuestPackageInfo"));		
    }
    
    public List<Map<String, Object>> getGuestEtcFile() {
        return this.jdbcTemplate.queryForList( getQuery("management.getGuestEtcFile"));		
    }
    
    public List<Map<String, Object>> getUserEtcFile(String userNo) {
        return this.jdbcTemplate.queryForList( getQuery("management.getUserEtcFile"), userNo);		
    }
    
    public List<Map<String, Object>> getAllEtcFile() {
        return this.jdbcTemplate.queryForList( getQuery("management.getAllEtcFile"));		
    }
    
    public Map<String, Object> getUserEtcFile2(String objectId) {
        return this.jdbcTemplate.queryForMap( getQuery("management.getUserEtcFile2"), objectId );		
    }
    
    public List<Map<String, Object>> getUserEtcFile3(String userNo) {
        return this.jdbcTemplate.queryForList( getQuery("management.getUserEtcFile3"), userNo);		
    }
    //deleteUserEtcFileInfo
    public void deleteUserEtcFileInfo(String userNo) {
        this.jdbcTemplate.update( getQuery("management.deleteUserEtcFileInfo"), userNo);		
    }
    //유저별 라이센스,제품 다운로드 리스트
    public List<Map<String, Object>> getLicenseInfo(String userNo) {
        return this.jdbcTemplate.queryForList( getQuery("management.getLicenseInfo"),userNo);		
    }
    
    //유저별 패치 다운로드 리스트
    public List<Map<String, Object>> getPatchInfo(String fileId) {
        return this.jdbcTemplate.queryForList( getQuery("management.getPatchInfo"), fileId );		
    }
    
    // 신규 유저 
    public void addUser( ContractPersonInfo ma, String userNo, String pass, String type ) {
        this.jdbcTemplate.update( getQuery("management.addUser"), 
        		ma.getUSER_NO(), ma.getUSER_NAME(), pass, ma.getMANAGER_NAME(),
                ma.getMANAGER_OFFICE_PHON(), ma.getMANAGER_CEL_PHON(), ma.getMANAGER_EMAIL(), type, ma.getUSER_START_DATE(),
                userNo, userNo, ma.getUSER_ADDRESS(), ma.getPROJECT_NAME(), ma.getORDER_COMPANY_CODE() );
    }
    
    public void addProgressContract( String objectId, String userName, String projectName, String managerName, String officePhon,
    		String celPhon, String email, String startDate, String address, String product, String companyCode, String status, String userNo) {
        this.jdbcTemplate.update( getQuery("management.addProgressContract"), objectId, userName, projectName, managerName, officePhon
        		,celPhon, email, startDate, address, product, companyCode, status, userNo);
    }
    
    public void modifyProgressInfo( String objectId, String userName, String projectName, String managerName, String officePhon,
    		String celPhon, String email, String startDate, String address, String product, String userNo) {
        this.jdbcTemplate.update( getQuery("management.modifyProgressInfo"), userName, projectName, managerName, officePhon
        		,celPhon, email, startDate, address, product, userNo, objectId);
    }
    
    public void insertProgressComment( String objectId, int commentNo, String comment, String userNo ) {
        this.jdbcTemplate.update( getQuery("management.insertProgressComment"), objectId, commentNo, comment, userNo );
    }
    
    public void deleteComment( String objectId, int commentNo, String userNo ) {
        this.jdbcTemplate.update( getQuery("management.deleteComment"), userNo, objectId, commentNo );
    }
    
    public void modifyComment( String objectId, int commentNo, String comment, String userNo ) {
        this.jdbcTemplate.update( getQuery("management.modifyComment"), comment, userNo, objectId, commentNo );
    }
    
    public List<Map<String, Object>> getProgressCategoryCounting(boolean mode, String companyCode){
    	return this.jdbcTemplate.queryForList( getQuery("management.getProgressCategoryCounting")+getCountingSubQuery(mode, companyCode) );
    }
    
    public String getCountingSubQuery(boolean mode, String companyCode){
    	if(mode)
    		return " where ORDER_COMPANY_CODE="+companyCode+" group by ORDER_STATUS";
    	else
    		return " group by ORDER_STATUS";
    }

    public List<Map<String, Object>> getCommentList( String objectId ){
    	return this.jdbcTemplate.queryForList( getQuery("management.getCommentList"), objectId );
    }
    
    public void updateProductSetupDate( String userNo, String setupDate ) {
        this.jdbcTemplate.update( getQuery("management.updateProductSetupDate"), setupDate, userNo);
    }
    
    public void updateProgressUserNo( String newUserNo, String admin, String objectId ) {
        this.jdbcTemplate.update( getQuery("management.updateProgressUserNo"), newUserNo, admin, objectId);
    }
    
    // 신규 라이센스
    public void addLicenseInfo( String userNo, String licenseKey, String objectId, String admin, String path, String licenseName, String quantity ) {
        this.jdbcTemplate.update( getQuery("management.addLicenseInfo"), userNo, licenseKey, objectId, path, licenseName, quantity, admin, admin );
    }
    
    // 라이센스 인증서 다운로드 정보
    public Map<String, Object> getLicenseCertification(String userNo, String licenseFileName) {
        return this.jdbcTemplate.queryForMap(getQuery("management.getLicenseCertification"), licenseFileName, userNo);
    }
    
    // 라이센스 인증서 다운로드 정보
    public Map<String, Object> getTechSupportCertificationInfo(String userNo, String productFileId) {
        return this.jdbcTemplate.queryForMap(getQuery("management.getTechSupportCertificationInfo"),productFileId, userNo);
    }
    
    // 제품정보 수정
    public void updateProductInfo( String userNo, String licenseKey, String proId, String quantity, String admin, String oldLicenseKey ) {
        this.jdbcTemplate.update( getQuery("management.updateProductInfo"), licenseKey, proId, quantity, admin, userNo, oldLicenseKey);
    }
    
    // 라이센스 정보 수정
    public void updateLicenseInfo( String userNo, String oldLicenseKey, String licenseName, String licensePath, String admin ) {
        this.jdbcTemplate.update( getQuery("management.updateLicenseInfo"), licenseName, licensePath, admin, userNo, oldLicenseKey);
    }
    
    // 고객정보 수정
    public void updateProfileInfo(ContractPersonInfo info, String oldUserNo, String admin){
    	this.jdbcTemplate.update(getQuery("management.updateProfileInfo"),
    			info.getUSER_NO(), info.getUSER_NAME(), info.getMANAGER_NAME(), info.getMANAGER_OFFICE_PHON(), info.getMANAGER_CEL_PHON(),
    			info.getMANAGER_EMAIL(), info.getUSER_START_DATE(), info.getUSER_ADDRESS(), info.getPROJECT_NAME(), 
    			info.getORDER_COMPANY_CODE(), admin, oldUserNo
    			);
    }
    
    public void updateLicenseUserNo(String userNo, String oldUserNo, String admin){
    	this.jdbcTemplate.update(getQuery("management.updateLicenseUserNo"), userNo, admin, oldUserNo);
    }
    
    public void updateInstallFilName(String admin, String userNo, String licenseKey){
    	this.jdbcTemplate.update(getQuery("management.updateInstallFilName"), admin, userNo, licenseKey);
    }
    
    // 패키지 삭제전 사용자 매핑 정보 확인
    public Map<String, Object> getUseProduct(String objectId){
        return this.jdbcTemplate.queryForMap( getQuery("management.getUseProduct"), objectId, objectId, objectId );
    }
    
    // 패키지 삭제 (인스톨가이드 포함)
    public void deleteProduct(String objectId){
    	this.jdbcTemplate.update(getQuery("management.deleteProduct"), new Object[] { objectId });
    }
    
    // 패치 삭제
    public void deletePatchFile( String objectId ){
    	this.jdbcTemplate.update(getQuery("management.deletePatchFile"), new Object[] { objectId });
    }
    
    // 패치 삭제 (패키지 삭제시)
    public void deletePatchFile2(String objectId){
    	this.jdbcTemplate.update(getQuery("management.deletePatchFile2"), new Object[] { objectId });
    }
    
    // 유저 정보 검색 리스트
    public List<UserInfo> getClientSearch(String search, String select, boolean mode, String orderCompanyCode) {
        return this.jdbcTemplate.query( getQuery("management.getClientSearch") + searchQuery( search, select )
        		+ modeClientInfo(mode, orderCompanyCode), this.clientMapper);
    }
    
    public List<Map<String, Object>> getProgressSearch(String search, String select, boolean mode, String orderCompanyCode) {
        return this.jdbcTemplate.queryForList( getQuery("management.getProgressUserSearch") + progressSearchQuery( search, select )
        		+ modeClientInfo(mode, orderCompanyCode));
    }
    
    public List<Map<String, Object>> getProgressContractLog(String objectId) {
        return this.jdbcTemplate.queryForList( getQuery("management.getProgressContractLog"), objectId );
    }
    
    public void destroyProduct(String userNo, String licenseKey){
    	this.jdbcTemplate.update(getQuery("management.destroyProduct"), new Object[] { userNo,  licenseKey});
    }
    
    private String searchQuery( String search, String select ) {
        switch ( Integer.parseInt( select ) ) {
            case 0:
                return " and u.USER_NAME LIKE '%" + search + "%'";
            case 1:
                return " and u.USER_NO LIKE '%" + search + "%'";
            case 2:
                return " and c.COMPANY_NAME LIKE '%" + search + "%'";
            default:
                return "";
        }
    }
    
    private String progressSearchQuery( String search, String select ) {
        switch ( Integer.parseInt( select ) ) {
            case 0:
                return " and co.USER_NAME LIKE '%" + search + "%'";
            case 1:
                return " and co.PROJECT_NAME LIKE '%" + search + "%'";
            case 2:
                return " and c.COMPANY_NAME LIKE '%" + search + "%'";
            default:
                return "";
        }
    }
    
    public List<Map<String, Object>> getPackageList(String menu) {
        return this.jdbcTemplate.queryForList( getQuery("management.getPackageList"), menu);
    }
    
    public List<Map<String, Object>> getPatchList(String menu) {
        return this.jdbcTemplate.queryForList( getQuery("management.getPatchList"), menu);
    }
    
    public List<Map<String,Object>> getVersionList(String packageName){
    	return this.jdbcTemplate.queryForList( getQuery("management.getVersionList"), packageName);
    }
    
    public List<Map<String,Object>> getOrderCompanyList(){
    	return this.jdbcTemplate.queryForList( getQuery("management.getOrderCompanyList"));
    }
    
    public void updateOpenPackage(String objectId, String flag){
    	this.jdbcTemplate.update( getQuery("management.updateOpenPackage"), flag, objectId);
    }
    
    // 게시판 첨부파일 패스
    public String getAttachFilePath( String category, String contentNo ) {
        return this.jdbcTemplate.queryForObject( getQuery("management.getAttachFilePath"), new Object[] { category,contentNo }, String.class );
    }
    
    public String getQuery(String queryKey){
    	String query = this.messageSourceAccessor.getMessage(queryKey);
    	logger.debug(queryKey);
    	return query;
    }
    
    public int orderCompanyCount() {
        return this.jdbcTemplate.queryForObject( getQuery("management.orderCompanyCount"), Integer.class);
    }
    
    public void addOrderCompany(String sortString, String userName, String userNo, String admin){
    	this.jdbcTemplate.update(getQuery("management.addOrderCompany"), sortString, userName, userNo, admin);
    }
    
    public void addOrderCompanyInfo(ContractPersonInfo info, String newPassword, String userType, String admin){
    	this.jdbcTemplate.update(getQuery("management.addOrderCompanyInfo"), info.getUSER_NO(), info.getUSER_NAME(), newPassword, info.getMANAGER_NAME(),
    			info.getMANAGER_OFFICE_PHON(), info.getMANAGER_CEL_PHON(), info.getMANAGER_EMAIL(), userType, info.getUSER_ADDRESS(),
    			info.getPROJECT_NAME(), Consts.POSCO_ICT_CODE, admin, admin);
    }
    
    public Map<String, Object> getOrderCompanyInfo(String companyId) {
        return this.jdbcTemplate.queryForMap(getQuery("management.getOrderCompanyInfo"), companyId);
    }
    
    public void updateUserInfo(String userNo, String userName, String managerName, String userAddress, String managerOfficePhon,
    		String managerCelPhon, String managerEmail, String oriUserNo){
    	this.jdbcTemplate.update(getQuery("management.updateUserInfo"), userNo, userName, managerName, userAddress, managerOfficePhon,
    			managerCelPhon, managerEmail, oriUserNo);
    }
    
    public void updateOrderCompanyInfo(String userNo, String userName, String oriUserNo){
    	this.jdbcTemplate.update(getQuery("management.updateOrderCompanyInfo"), userNo, userName, oriUserNo);
    }
    
    public void expireOrderCompany(String admin, String companyId){
    	this.jdbcTemplate.update(getQuery("management.expireOrderCompany"), admin, companyId);
    }
    
    public void progressUserExpire(String userNo, String objectId){
    	this.jdbcTemplate.update(getQuery("management.progressUserExpire"), userNo, objectId);
    }

    public void changeUserStatus(String objectId, String uStatus, String userNo){
    	this.jdbcTemplate.update(getQuery("management.changeUserStatus"), uStatus, userNo, objectId);
    }
    
    public void insertProgressUserLog(String objectId, String newUserNo, String uStatus, String userNo){
    	this.jdbcTemplate.update(getQuery("management.insertProgressUserLog"), objectId, newUserNo, uStatus, userNo);
    }
    
    public void initializationPassword(String initializationPassword, String admin, String userNo){
    	this.jdbcTemplate.update(getQuery("management.initializationPassword"), initializationPassword, admin, userNo);
    }
    
    public List<Map<String, Object>> getUserList() {
        return this.jdbcTemplate.queryForList(getQuery("management.getUserList"));
    }
    
    public Map<String, Object> getDownloadAttachInfo( String objectId ) {
        return this.jdbcTemplate.queryForMap( getQuery("management.getDownloadAttachInfo"), objectId );
    }
    
    public String getCompanyCode( String userNo ) {
    		return this.jdbcTemplate.queryForObject( getQuery("management.getCompanyCode"), new Object[] { userNo }, String.class );    		
    }

    public List<Map<String, Object>> makeExcelFileClientInfo() {
        return this.jdbcTemplate.queryForList(getQuery("management.makeExcelFileClientInfo"));
    }
    
    public String getProductKey( String category, String version ) {
		return this.jdbcTemplate.queryForObject( getQuery("management.getProductKey"), new Object[] { category, version }, String.class );    		
    }
    
    public List<Map<String, Object>> getUserPermission( String userNo ) {
		return this.jdbcTemplate.queryForList( getQuery("management.getUserPermission"), userNo );    		
    }
    
    public void updateCustomUserInfo( UserInfo userInfo, String adminUser, String customUserNo ) {
    	this.jdbcTemplate.update( getQuery("management.updateCustomUserInfo"), userInfo.getUSER_NO().trim(), userInfo.getUSER_NAME().trim(),
    			userInfo.getMANAGER_NAME().trim(), userInfo.getMANAGER_OFFICE_PHON().trim(), userInfo.getMANAGER_CEL_PHON().trim(), adminUser,
    			userInfo.getMANAGER_EMAIL().trim(), userInfo.getUSER_ADDRESS().trim(), customUserNo);
    }
    
    public void deleteCustomUserPermission( String userNo ) {
    	this.jdbcTemplate.update( getQuery("management.deleteCustomUserPermission"), userNo );
    }
}
