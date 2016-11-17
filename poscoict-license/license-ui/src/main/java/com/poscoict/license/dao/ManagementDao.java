package com.poscoict.license.dao;

import java.util.List;
import java.util.Map;

import com.poscoict.license.vo.ContractPersonInfo;
import com.poscoict.license.vo.FileList;
import com.poscoict.license.vo.UserInfo;

public interface ManagementDao {
	String getSubcontract(String userNo);
	
    List<UserInfo> getClientInfo(boolean mode, String orderCompanyCode);

    List<Map<String, Object>> getFileList( String category );

    List<FileList> getFileList();

    String getFilePath( String objectId );
    
    String getInstallGuidePath( String fileName );
    
    String getPatchPath( String objectId );
    
    List<Map<String, Object>> getDeletePatchPath( String objectId );
    
    String getDeletePatchPath2( String objectId );
    
    String getFolderPath( String folderName );

    UserInfo getClientInfoMore( String USER_NO );

    void addFileInfo( String objectId, String folder, String packageVersion, String fileName, String comment, String filePath, String userNo );
    
    void addPatchFileInfo( String objectId, String pObjectId, String folder, String packageVersion, String fileName, String comment, String filePath, String userNo );
    
    void setDownloadCnt(String userNo, String fileName);
    
    void insertFileDownload(String userNo, String fileName);

    List<Map<String, Object>> getFolderCategory(String userNo);
    
    List<Map<String, Object>> getPackageVersionList();

    List<Map<String, Object>> getFileAllList();
    
    List<Map<String, Object>> getUserEtcFile(String userNo);
    
    List<Map<String, Object>> getAllEtcFile();
    
    void addUserEtcFileInfo(String userNo, String etcId, String admin);
    
    Map<String, Object> getUserEtcFile2(String objectId);
    
    List<Map<String, Object>> getUserEtcFile3(String userNo);
    
    void deleteUserEtcFileInfo(String userNo);
    
    void addUser( ContractPersonInfo ma, String userNo, String pass, String type );
    
    void addLicenseInfo( String userNo, String licenseKey, String objectId, String admin, String path, String licenseName, String quantity );

    List<Map<String, Object>> getCompanyList();
    
    List<Map<String, Object>> getProductInfo(String userNo);
    
    List<Map<String, Object>> getGuestPackageInfo();
    
    List<Map<String, Object>> getLicenseInfo(String userNo);
    
    List<Map<String, Object>> getPatchInfo(String fileId);
    
    Map<String, Object> getProductInfo2(String userNo, String licenseKey);
    
    String getLicensePath( String fileName, String userNo );
    
    String getLicensePath2( String licenseKey, String userNo );
    
    void setLiscenseDownloadCnt(String userNo, String fileName);
    
    Map<String, Object> getLicenseCertification(String userNo, String licenseFileName);
    
    Map<String, Object> getTechSupportCertificationInfo(String userNo, String productFileId);

    void updateProductInfo( String userNo, String licenseKey, String proId, String quantity, String admin, String oldLicenseKey );
    
    void updateLicenseInfo( String userNo, String oldLicenseKey, String licenseName, String licensePath, String admin );
    
    void updateProfileInfo(ContractPersonInfo info, String oldUserNo, String admin);
    
    void updateLicenseUserNo(String userNo, String oldUserNo, String admin);
    
    void updateInstallFilName(String admin, String userNo, String licenseKey);
    
    List<Map<String, Object>> getGuestEtcFile();
    
    Map<String,Object> getUseProduct(String objectId);
    
    void deleteProduct(String objectId);
    
    void deletePatchFile(String objectId);
    
    void deletePatchFile2(String objectId);
    
    List<UserInfo> getClientSearch(String search, String select, boolean mode, String orderCompanyCode);
    
    void destroyProduct(String userNo, String licenseKey);
    
    List<Map<String, Object>> getPackageList(String menu);
    
    List<Map<String, Object>> getPatchList(String menu);
    
    List<Map<String,Object>> getOrderCompanyList();
    
    void updateOpenPackage(String objectId, String flag);
    
    List<Map<String,Object>> getVersionList(String packageName);
    
    String getAttachFilePath( String category, String contentNo );
    
    int orderCompanyCount();
    
    void addOrderCompany(String sortString, String userName, String userNo, String admin);
    
    void addOrderCompanyInfo(ContractPersonInfo info, String newPassword, String userType, String admin);
    
    Map<String, Object> getOrderCompanyInfo(String companyId);
    
    void updateUserInfo(String userNo, String userName, String managerName, String userAddress, String managerOfficePhon,
    		String managerCelPhon, String managerEmail, String oriUserNo);
    
    void updateOrderCompanyInfo(String userNo, String userName, String oriUserNo);
    
    void expireOrderCompany(String companyId, String admin);
    
    public void updateProductSetupDate( String userNo, String setupDate );
    
    void initializationPassword(String initializationPassword, String admin, String userNo);
    
    List<Map<String, Object>> getUserList();
    
    Map<String, Object> getDownloadAttachInfo( String objectId );
    
    String getCompanyCode( String userNo );
    
    void addProgressContract( String objectId, String userName, String projectName, String managerName, String officePhon,
    		String celPhon, String email, String startDate, String address, String product, String companyCode, String status, String userNo);
    
    void insertProgressComment( String objectId, int commentNo, String comment, String userNo);
    
    List<Map<String, Object>> getProgressInfo(String subCategory, boolean mode, String orderCompanyCode);
    
    List<Map<String, Object>> getProgressSearch(String search, String select, boolean mode, String orderCompanyCode);
    
    Map<String, Object> getProgressInfoMore( String objectId );
    
    int getCommentCount(String objectId);
    
    List<Map<String, Object>> getCommentList( String objectId );
    
    void modifyProgressInfo( String objectId, String userName, String projectName, String managerName, String officePhon,
    		String celPhon, String email, String startDate, String address, String product, String userNo);
    
    void progressUserExpire(String userNo, String objectId);
    
    void changeUserStatus(String objectId, String userNo, String uStatus);
    
    void insertProgressUserLog(String objectId, String newUserNo, String uStatus, String userNo);
    
    List<Map<String, Object>> getProgressContractLog(String objectId);
    
    void deleteComment( String objectId, int commentNo, String userNo );
    
    void modifyComment( String objectId, int commentNo, String comment, String userNo );
    
    List<Map<String, Object>> getProgressCategoryCounting(boolean mode, String companyCode);
    
    void updateProgressUserNo( String newUserNo, String admin, String objectId );
    
    List<Map<String, Object>> makeExcelFileClientInfo();
    
    String getProductKey( String category, String version );
    
    List<Map<String, Object>> getCustomUserList();
    
    void insert_user_permission(String codes, String codeTypes, String userNo, int size);
    
    List<Map<String, Object>> getUserPermission( String userNo );
    
    void updateCustomUserInfo( UserInfo userInfo, String adminUser, String customUserNo );
    
    void deleteCustomUserPermission( String userNo );
}
