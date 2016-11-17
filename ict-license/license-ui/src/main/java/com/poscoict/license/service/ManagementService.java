package com.poscoict.license.service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.multipart.MultipartFile;

import com.poscoict.license.consts.Consts;
import com.poscoict.license.dao.ManagementDao;
import com.poscoict.license.security.CustomUserDetails;
import com.poscoict.license.util.LmsUtil;
import com.poscoict.license.vo.ContractPersonInfo;
import com.poscoict.license.vo.ContractProductInfo;
import com.poscoict.license.vo.FileList;
import com.poscoict.license.vo.UserInfo;
import com.poscoict.license.vo.UserPermission;

@Service
public class ManagementService extends LmsUtil {
	@Autowired
	private ManagementDao managementDao;
	
	@Autowired
	private PlatformTransactionManager transactionManager;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
    public ArrayList<UserInfo> getClientList( String search, String select, HttpSession session) {
    	logger.info("getClientList: search= " + search + " select= " + select);
    	CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
    	boolean mode = false;
    	String companyCode = "";
    	
    	if(userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ORDER_COMPANY)){
    		mode = true;
    		companyCode = managementDao.getSubcontract((String)session.getAttribute("USER_NO"));
    		System.out.println("USER_TYPE-ORDER_COMPANY " + companyCode);
    	}
    	
        ArrayList<UserInfo> list = null;
        if(search!=null && select!=null){
        	list = (ArrayList<UserInfo>) managementDao.getClientSearch(search, select, mode, companyCode);
        }else{
        	list = (ArrayList<UserInfo>) managementDao.getClientInfo(mode, companyCode);
        }
        
        return list;
    }
    
    public ArrayList<Map<String, Object>> getProgressList( String subCategory, String search, String select, HttpSession session) {
    	logger.info("getClientList: search= " + search + " select= " + select);
    	CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
    	boolean mode = false;
    	String companyCode = "";
    	
    	if(userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ORDER_COMPANY)){
    		mode = true;
    		companyCode = managementDao.getSubcontract((String)session.getAttribute("USER_NO"));
    		System.out.println("USER_TYPE-ORDER_COMPANY " + companyCode);
    	}
    	
    	ArrayList<Map<String, Object>> list = null;
        if(search!=null && select!=null){
        	list = (ArrayList<Map<String, Object>>) managementDao.getProgressSearch(search, select, mode, companyCode);
        }else{
        	list = (ArrayList<Map<String, Object>>) managementDao.getProgressInfo(subCategory, mode, companyCode);
        }
        
        return list;
    }
    
    public ArrayList<Map<String, Object>> getProgressCategoryCounting(HttpSession session) {
    	logger.info("getProgressCategoryCounting");
    	
    	CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
    	boolean mode = false;
    	String companyCode = "";
    	
    	if(userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)){ 
    		companyCode=Consts.POSCO_ICT_CODE;    		
    	}
    	else {
    		companyCode = managementDao.getCompanyCode( (String)session.getAttribute("USER_NO") );
    		mode=true;
    	}
    	
    	ArrayList<Map<String, Object>> list = (ArrayList<Map<String, Object>>) managementDao.getProgressCategoryCounting(mode, companyCode);
        return list;
    }
    
    public Map<String, Object> getFileList() {
    	logger.info("getFileList");
    	Map<String, Object> productList = new HashMap<String, Object>();
    	
        // 패키지 리스트
        List<Map<String, Object>> list =  managementDao.getGuestPackageInfo();
        productList.put("product", list);
        
        //패치 리스트
        if(list.size()>0){
        	for(Map<String, Object> map: list){
        		if(!map.get("FILE_CATEGORY").equals("etc"))
        		{
        			List<Map<String, Object>> patchList = managementDao.getPatchInfo((String)map.get("OBJECT_ID"));
        			productList.put((String)map.get("OBJECT_ID"), patchList);
        		}
        	}
        }
        //기타 파일
//        List<Map<String, Object>> etcList = managementDao.getGuestEtcFile();
//        productList.put("etcList", etcList);
        return productList;
    }
    
    public Map<String, Object> getLicenseList( HttpSession session ) {
    	logger.info("getLicenseList");
        String USER_NO = (String) session.getAttribute( "USER_NO" );
        Map<String, Object> productList = new HashMap<String, Object>();
        
        // 패키지 리스트
        List<Map<String, Object>> list =  managementDao.getLicenseInfo(USER_NO);
        productList.put("product", list);
        
        //패치 리스트
        if(list.size()>0){
        	for(Map<String, Object> map: list){
        		String fileId = (String) map.get("PRODUCT_FILE_ID");
        		
        		List<Map<String, Object>> patchList = managementDao.getPatchInfo(fileId);
        		productList.put(fileId, patchList);
        	}
        }
        //기타 파일
        List<Map<String, Object>> etcList = managementDao.getUserEtcFile(USER_NO);
        productList.put("etcList", etcList);
        
        System.out.println("getLicenseList success");
        return productList;
    }
    
    public Map<String, Object> getUserInfo( String userNo ) {
        logger.info("getUserInfo: userNo= " + userNo);
        UserInfo user = managementDao.getClientInfoMore( userNo );
        ArrayList<Map<String, Object>> company = (ArrayList<Map<String, Object>>) managementDao.getCompanyList();
        ArrayList<Map<String, Object>> product = (ArrayList<Map<String, Object>>) managementDao.getProductInfo( userNo );
        ArrayList<Map<String, Object>> file = (ArrayList<Map<String, Object>>) managementDao.getFileAllList();
        ArrayList<Map<String, Object>> etcUserFile = (ArrayList<Map<String, Object>>) managementDao.getUserEtcFile3(userNo);
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("user", user);
        map.put("company", company);
        map.put("product", product);
        map.put("file", file);
        map.put("etcUserFile", etcUserFile);
        return map;
    }
    
    public Map<String, Object> getProgressUserInfo( String objectId ) {
        logger.info("getProgressUserInfo: objectId= " + objectId);
        
        Map<String, Object> user = managementDao.getProgressInfoMore( objectId );
        user.put("ORDER_STATUS_TEXT", Consts.ProgressStatus.valueOf((String)user.get("ORDER_STATUS")).getProgressStatusToString());
        ArrayList<Map<String, Object>> file = (ArrayList<Map<String, Object>>) managementDao.getFileAllList();
        ArrayList<Map<String, Object>> comment = (ArrayList<Map<String, Object>>) managementDao.getCommentList(objectId);
        ArrayList<Map<String, Object>> log = (ArrayList<Map<String, Object>>) managementDao.getProgressContractLog(objectId);
        
        if(log.size()>0){
        	for(int i=0; i<log.size(); i++){
        		log.get(i).put("ORDER_STATUS_TEXT", Consts.ProgressStatus.valueOf((String)log.get(i).get("ORDER_STATUS")).getProgressStatusToString());
    		}
        }
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("user", user);
        map.put("file", file);
        map.put("comment", comment);
        map.put("log", log);
        return map;
    }
    
    public Map<String, Object> fileUploadForm( String userNo, String mode ) {
    	logger.info("fileUploadForm");
        // 파일 리스트
        ArrayList<FileList> list = (ArrayList<FileList>) managementDao.getFileList();
        // 파일 카테고리 종류
//        ArrayList<Map<String, Object>> folders = (ArrayList<Map<String, Object>>) managementDao.getFolderCategory(userNo);
        // 0: uCUBE, 1: GlueMaster, 2: GlueFramework, 3: PosBee, 4: etc
        String folder = "";
        if(mode.equals("0")) folder = "uCUBE";
        else if (mode.equals("1")) folder = "GlueMaster";
        else if (mode.equals("2")) folder = "GlueFramework";
        else if (mode.equals("3")) folder = "PosBee";
        else if (mode.equals("4")) folder = "etc";
        else if (mode.equals("5")) folder = "GlueMobile";
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list);
        map.put("folder", folder);
        
        return map;
    }
    
    public Map<String, Object> newContractForm() {
    	logger.info("newContractForm");
        // 파일 카테고리 종류 getOrderCompanyList
        ArrayList<Map<String, Object>> file = (ArrayList<Map<String, Object>>) managementDao.getFileAllList();
        ArrayList<Map<String, Object>> company = (ArrayList<Map<String, Object>>) managementDao.getOrderCompanyList();
       
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("file", file);
        map.put("company", company);

        return map;
    }
    
    public ArrayList<Map<String, Object>> progressContractForm() {
    	logger.info("newContractForm");
        // 패키지 종류
        return (ArrayList<Map<String, Object>>) managementDao.getFileAllList();
    }
    
    public void addProgressContract(String userName, String projectName, String userAddress, String managerName,
    		String officePhon, String celPhon, String email, String startDate, String product, String comment, HttpSession session){
    	CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
    	String companyCode = "";
    	
    	if(userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)) companyCode=Consts.POSCO_ICT_CODE;
    	else companyCode = managementDao.getCompanyCode( (String)session.getAttribute("USER_NO") );
    	
    	
    	String objectId = "pc_"+attachFileDateFormat();
    	objectId += UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12);
    	
    	TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	
    	try{
    		//유저정보
    		managementDao.addProgressContract( objectId, userName, projectName, managerName, officePhon,
    	    	 celPhon, email, startDate.isEmpty()?null:startDate, userAddress, product, companyCode, Consts.ProgressStatus.valueOf("P").getProgressStatus(), (String)session.getAttribute("USER_NO"));
    		//유저정보 로그
    		managementDao.insertProgressUserLog(objectId, null, Consts.ProgressStatus.valueOf("P").getProgressStatus(), (String)session.getAttribute("USER_NO"));
    		if(!comment.isEmpty()) {
    			managementDao.insertProgressComment(objectId, 1, comment.trim().replaceAll("\n", "<br>"), (String)session.getAttribute("USER_NO"));
    		}
    			
    		this.transactionManager.commit(status);
    	}catch(DuplicateKeyException e){
    		this.transactionManager.rollback(status);
    		logger.error("addProgressContract: ", e);
    		throw new DuplicateKeyException("중복키가 발생하였습니다. 데이터를 확인해 주세요.");
    	}catch(RuntimeException e){
    		this.transactionManager.rollback(status);
    		logger.error("addProgressContract: ", e);
    	}
    }
    
    public void modifyProgressInfo(String objectId, String userName, String projectName, String userAddress, String managerName,
    		String officePhon, String celPhon, String email, String startDate, String product, String userNo){
    	TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	try{
        	managementDao.modifyProgressInfo( objectId, userName, projectName, managerName, officePhon,
               	 celPhon, email, startDate.isEmpty()?null:startDate, userAddress, product, userNo);
           	managementDao.insertProgressUserLog(objectId, null, Consts.ProgressStatus.valueOf("M").getProgressStatus(), userNo);
           	this.transactionManager.commit(status);
    	}catch(DuplicateKeyException e){
    		this.transactionManager.rollback(status);
    		logger.error("addProgressContract: ", e);
    		throw new DuplicateKeyException("중복키가 발생하였습니다. 데이터를 확인해 주세요.");
    	}catch(RuntimeException e){
    		this.transactionManager.rollback(status);
    		logger.error("addProgressContract: ", e);
    	}
    }
    
    public void insertComment(String objectId, String comment, String userNo){
    	int no = managementDao.getCommentCount(objectId);
    	managementDao.insertProgressComment(objectId, no+1, comment.trim().replaceAll("\n", "<br>"), userNo);
    }
    
    public void deleteComment(String objectId, String commentNo, String userNo){
    	managementDao.deleteComment(objectId, Integer.parseInt(commentNo), userNo);
    }
    // 
    public void modifyComment(String objectId, String commentNo, String comment, String userNo){
    	managementDao.modifyComment(objectId, Integer.parseInt(commentNo), comment.trim().replaceAll("\n", "<br>"), userNo);
    }
    
    public void changeUserStatus(String objectId, String uStatus, String userNo){
    	TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	try{
    		managementDao.changeUserStatus(objectId, Consts.ProgressStatus.valueOf(uStatus).getProgressStatus(), userNo);
        	managementDao.insertProgressUserLog(objectId, null, Consts.ProgressStatus.valueOf(uStatus).getProgressStatus(), userNo);
        	this.transactionManager.commit(status);
    	}catch(Exception e){
    		this.transactionManager.rollback(status);
    		logger.error("changeUserStatus: ", e);
    	}
    }
    
    @SuppressWarnings("unchecked")
	public void newContract( ContractPersonInfo per, ContractProductInfo pro, String[] etcFile, HttpSession session ) throws UserException {
    	logger.info("newContract");
    	TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	try{
    		System.out.println("company: " + per.getORDER_COMPANY_CODE());
            String licenseUpPath = Consts.LICENSE_FILE_HOME;

            String userNo = per.getUSER_NO();

            if ( pro != null ) {
            	ArrayList<MultipartFile> upFileList = (ArrayList<MultipartFile>) pro.getFile();
            	ArrayList<String> productList = (ArrayList<String>) pro.getPRODUCT_FILE_ID();
            	ArrayList<String> licenseKeyList = (ArrayList<String>) pro.getLICENSE_KEY();
            	ArrayList<String> quantityList = (ArrayList<String>) pro.getLICENSE_QUANTITY();
            	ArrayList<String> fileCheckList = (ArrayList<String>) pro.getCHECKBOX();
            	
            	for(int i=0; i<productList.size(); i++){
            		String licensePath = "";
            		
            		String licenseName = "";
            		String objectId = productList.get(i);
            		String licenseKey = licenseKeyList.get(i);
            		String quantity = quantityList.get(i);
            		String fileCheck = fileCheckList.get(i);
            		if(fileCheck.equals("false")){
            			MultipartFile upFile = upFileList.get(i);
            			licenseName = upFile.getOriginalFilename(); // 라이센스파일명
                		logger.info("newContract: fileName= " + licenseName);
                		try {
                			File upfile = new File( licenseUpPath + userNo + File.separator + licenseName );
                			
                			if(upfile.isFile()) throw new UserException("동일파일명이 존재합니다. 파일명을 변경해 주세요.");
                			
                			if ( !upfile.exists() ) upfile.mkdirs();

                			upFile.transferTo( upfile );
                			licensePath = upfile.getAbsolutePath();
                			logger.info("newContract: licensePath= " + licensePath);
                		} catch ( IOException e ) {
                			logger.error("newContract(File Upload Error): ", e);
                		} 
                		// 라이센스 정보
            		}
            		managementDao.addLicenseInfo( userNo, licenseKey, objectId, (String) session.getAttribute( "USER_NO" ), licensePath, licenseName, quantity );	
            	}
            }
            if(etcFile != null){
            	for(int i=0;i<etcFile.length;i++){
            		String etcId = etcFile[i];
            		managementDao.addUserEtcFileInfo(userNo, etcId, (String) session.getAttribute( "USER_NO" ));
            	}
            }
            
            // 유저 정보
            managementDao.addUser( per, (String) session.getAttribute( "USER_NO" ), passwordEncoder(userNo), Consts.USERLV_PUBLIC );
            // 권한 정보 입력
    		Map<String, Object> map = getClientPermission();
    		String codes = (String) map.get("codes");
			String codeTypes = (String) map.get("codeTypes");
			int size = (Integer) map.get("size");
			managementDao.insert_user_permission(codes, codeTypes, userNo, size);
            
            // 설치일자 따로 업데이트
            if(!per.getPRODUCT_SETUP_DATE().isEmpty()){
            	managementDao.updateProductSetupDate(userNo, per.getPRODUCT_SETUP_DATE());
            }
    		this.transactionManager.commit(status);
    	}catch(DuplicateKeyException e){
    		this.transactionManager.rollback(status);
    		logger.error("plusProduct: ", e);
    		throw new DuplicateKeyException("중복키가 발생하였습니다. 데이터를 확인해 주세요.");
    	}catch(RuntimeException e){
    		this.transactionManager.rollback(status);
    		logger.error("plusProduct: ", e);
    	}

//        return "redirect:/management";
    }
    
    public Map<String, Object> getLicenseCertification(String userNo, String licenseFileName) {
    	logger.info("getLicenseCertification: userNo= " + userNo + " licenseFileName= " + licenseFileName);
        return (Map<String, Object>) managementDao.getLicenseCertification(userNo, licenseFileName);
    }
    
    public Map<String, Object> getTechSupportCertificationInfo(String userNo, String productFileName) throws UserException {
    	logger.info("getTechSupportCertificationInfo: " + productFileName);
    	Map<String, Object> map = managementDao.getTechSupportCertificationInfo(userNo, productFileName);
    	if(map.get("TECH_SUPPORT_DATE").equals("0")){
    		throw new UserException("제품이 설치되지 않았습니다. 설치후 관리자에 문의하세요.");
    	}
        return map;
    }
    
    public Map<String, Object> getproductModifyForm(String userNo, String licenseKey){
    	logger.info("getproductModifyForm: userNo= " + userNo + " licenseKey= " + licenseKey);
    	Map<String, Object> product = managementDao.getProductInfo2(userNo, licenseKey);
    	ArrayList<Map<String, Object>> file = (ArrayList<Map<String, Object>>) managementDao.getFileAllList();
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("product", product);
    	map.put("file", file);
    	return map;
    }
    
    public void modifyProduct(String userNo, String licenseKey, String productFileId,
			  String newLicenseKey, String licenseQuantity, String selectFile, String checkBox,
			  MultipartFile file, HttpSession session) throws UserException {
  	logger.info("modifyProduct: userNo= " + userNo + " PRODUCT_FILE_ID= " + productFileId);
  	TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
  	String licenseUpPath = Consts.LICENSE_FILE_HOME;
  	
	  	try{
	  		String oldLiscensePath = managementDao.getLicensePath2(licenseKey, userNo);
	  		managementDao.updateInstallFilName((String)session.getAttribute("USER_NO"), userNo, licenseKey);
	  		managementDao.updateProductInfo(userNo, newLicenseKey, productFileId, licenseQuantity, (String)session.getAttribute("USER_NO"), licenseKey);
	  		if(selectFile.equals("change")){
	  			String path = "";
	  			String licenseName = "";
	  			
	  			if( checkBox==null ){
	  				MultipartFile upFile = file;
	  				licenseName = upFile.getOriginalFilename(); // 라이센스파일명
	  				try {
	  					
	  					File upfile = new File( licenseUpPath + userNo + File.separator + licenseName );
	  					if(upfile.isFile()) throw new UserException("동일파일명이 존재합니다. 파일명을 변경해 주세요.");
	  					
	  					if ( !upfile.exists() ) upfile.mkdirs();
	  					
	  					upFile.transferTo( upfile );
	  					path = upfile.getAbsolutePath();
	  					logger.info("modifyProduct: upFileName= " + licenseName + " path= " + path);
	  				} catch ( IOException e ) {
	  					logger.error("modifyProduct(File Upload Error): ", e);
	  				}	  				
	  			}
	  			managementDao.updateLicenseInfo(userNo, licenseKey, licenseName, path, (String)session.getAttribute("USER_NO"));
	  			
	  			//기존 라이센스 파일 삭제
				File oldLicenseFile = new File(oldLiscensePath);
				if(oldLicenseFile.exists())
					oldLicenseFile.delete();
	  		}
	  		this.transactionManager.commit(status);
	  	}catch(DuplicateKeyException e){
	  		this.transactionManager.rollback(status);
	  		logger.error("plusProduct: ", e);
	  		throw new DuplicateKeyException("중복키가 발생하였습니다. 데이터를 확인해 주세요.");
	  	}catch(RuntimeException e){
	  		this.transactionManager.rollback(status);
	  		logger.error("plusProduct: ", e);
	  	}
	}
    
    public String deletePackage(String category, String objectId, HttpSession session){
    	logger.info("deletePakage: category= " + category + " objectId=" + objectId);
    	String result = "";
    	
    	// 패키지, 인스톨가이드 삭제, 패키지 삭제시 패치 및 인스톨 가이드 삭제
    	if(category.equals("package")){ 
    		Map<String, Object> fileInfo = managementDao.getUseProduct(objectId);
    		if( Integer.parseInt(fileInfo.get("CNT").toString()) > 0 ){
    			result="N"; // 매핑된 사용자가 있을시 삭제 안함
        	}else{
        		CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
        		if( !userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)
        				&& !userDetails.getUserNo().equals(fileInfo.get("R_CREATION_USER"))
        				&& fileInfo.get("FILE_CATEGORY").equals("etc") ){
        			// 공통으로 사용하는 기타파일 삭제시 관리자가 아니고 등록자가 아닐시 권한 없음
        			result="P";	
        		} else {
        			result="Y";
        			
        			ArrayList<String> filePath = new ArrayList<String>();
        			// 패키지 패스
        			filePath.add(managementDao.getFilePath(objectId));
        			// 패치 패스
        			ArrayList<Map<String, Object>> patchPathList = 
        					(ArrayList<Map<String, Object>>) managementDao.getDeletePatchPath(objectId);
        			if(patchPathList.size()>0){
        				for(Map<String, Object> map: patchPathList){
        					filePath.add((String)map.get("PACKAGE_FILE_PATH"));
        				}
        			}
        			
        			// 패키지 정보 삭제
        			managementDao.deleteProduct(objectId);
        			// 패치 정보 삭제
        			managementDao.deletePatchFile2(objectId);
        			
        			if(filePath.size()>0){
        				for(String path: filePath){
        					logger.info("delete file path: " + path);
        					File file = new File(path);
        					if(file.exists()==true)
        						file.delete();
        				}
        			}
        		}
        		
        	}
    	}else{ // 패치 삭제
    		result="Y";
    		
    		// 패치 패스
    		String patchPath = managementDao.getDeletePatchPath2(objectId);
    		
    		managementDao.deletePatchFile(objectId);
    		if(patchPath!=null){
				logger.info("delete file path: " + patchPath);
				System.out.println("delete file path " + patchPath);
				File file = new File(patchPath);
				if(file.exists()==true)
					file.delete();
    		}
    	}

    	return result;
    }
    
    public void openPackage(String objectId, String flag, HttpSession session) throws UserException{
    	Map<String, Object> fileInfo = managementDao.getUseProduct(objectId);
    	CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userDetails");
		if( !userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)
				&& !userDetails.getUserNo().equals(fileInfo.get("R_CREATION_USER"))
				&& fileInfo.get("FILE_CATEGORY").equals("etc") ){
			throw new UserException("변경 권한이 없습니다.");
		}
    	
    	managementDao.updateOpenPackage(objectId, flag.equals("Y")?"N":"Y");
    	logger.info("openPackage- objectId: "+objectId+" flag: "+(flag.equals("Y")?"N":"Y"));
    }
    
    public String modifyProfile(ContractPersonInfo info, String oldUserNo, String[] etcFile, HttpSession session){
    	logger.info("modifyProfile: oldUserNo= " + oldUserNo);
    	logger.info("modifyProfile: etcFile= " + etcFile);
    	TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	try{
    		managementDao.updateProductSetupDate(oldUserNo, info.getPRODUCT_SETUP_DATE().isEmpty()?null:info.getPRODUCT_SETUP_DATE());
        	managementDao.updateProfileInfo(info, oldUserNo, (String)session.getAttribute("USER_NO"));
        	
        	if(!info.getUSER_NO().equals(oldUserNo)){
        		System.out.println("update USER_NO");
        		managementDao.updateLicenseUserNo(info.getUSER_NO(), oldUserNo, (String)session.getAttribute("USER_NO"));
        	}
        	
        	managementDao.deleteUserEtcFileInfo(oldUserNo);
            if(etcFile!=null){
            	for(int i=0;i<etcFile.length;i++){
            		String objectId = etcFile[i];
            		managementDao.addUserEtcFileInfo(info.getUSER_NO(), objectId, (String) session.getAttribute( "USER_NO" ));
            	}
            }
            
    		this.transactionManager.commit(status);
    	}catch(DuplicateKeyException e){
    		this.transactionManager.rollback(status);
    		logger.error("plusProduct: ", e);
    		throw new DuplicateKeyException("중복키가 발생하였습니다. 데이터를 확인해 주세요.");
    	}catch(RuntimeException e){
    		this.transactionManager.rollback(status);
    		logger.error("plusProduct: ", e);
    	}
    	return info.getUSER_NO();
    }
    
    @SuppressWarnings("unchecked")
	public String plusProduct(ContractProductInfo info, String userNo, HttpSession session) throws UserException {
    	logger.info("plusProduct: userNo= " + userNo);
    	TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	try{
    		String licenseUpPath = Consts.LICENSE_FILE_HOME;
            if ( info != null ) {
            	ArrayList<MultipartFile> upFileList = (ArrayList<MultipartFile>) info.getFile();
            	ArrayList<String> proIdList = (ArrayList<String>) info.getPRODUCT_FILE_ID();
            	ArrayList<String> licenseKeyList = (ArrayList<String>) info.getLICENSE_KEY();
            	ArrayList<String> quantityList = (ArrayList<String>) info.getLICENSE_QUANTITY();
            	ArrayList<String> fileCheckList = (ArrayList<String>) info.getCHECKBOX();
            	for(int i=0; i<proIdList.size(); i++){
            		String path = "";
            		String licenseName = ""; // 라이센스파일명
            		
            		String objectId = proIdList.get(i);
            		String licenseKey = licenseKeyList.get(i);
            		String quantity = quantityList.get(i);
            		String fileCheck = fileCheckList.get(i);
            		
            		if(fileCheck.equals("false")){
            			try {
            				MultipartFile upFile = upFileList.get(i);
            				licenseName = upFile.getOriginalFilename(); // 라이센스파일명
            				
            				File upfile = new File( licenseUpPath + userNo + File.separator + licenseName );            				
            				if(upfile.isFile()) throw new UserException("동일파일명이 존재합니다. 파일명을 변경해 주세요.");
            				
            				if ( !upfile.exists() ) upfile.mkdirs();
            				
            				upFile.transferTo( upfile );
            				path = upfile.getAbsolutePath();
            				logger.info("plusProduct: upFileName= " + licenseName + " path= " + path);
            			} catch ( IOException e ) {
            				logger.error("plusProduct(File Upload Error): ", e);
            			}            			
            		}
            		
            		// 라이센스 정보
            		managementDao.addLicenseInfo( userNo, licenseKey, objectId, (String) session.getAttribute( "USER_NO" ), path, licenseName, quantity );
            	}
            }
    		this.transactionManager.commit(status);
    	}catch(DuplicateKeyException e){
    		this.transactionManager.rollback(status);
    		logger.error("plusProduct: ", e);
    		throw new DuplicateKeyException("중복키가 발생하였습니다. 데이터를 확인해 주세요.");
    	}catch(RuntimeException e){
    		this.transactionManager.rollback(status);
    		logger.error("plusProduct: ", e);
    	}
    	
    	return userNo;
    }
    
    public void destroyProduct(String userNo, String licenseKey){
    	logger.info("destroyProduct userNo: "+userNo+" licenseKey: "+licenseKey);
    	String licensePath = managementDao.getLicensePath2(licenseKey, userNo);
    	managementDao.destroyProduct(userNo, licenseKey);
    	if(licensePath!=null){
    		File file = new File(licensePath);
    		if(file.exists()) file.delete();
    	}
    }
    
	public Map<String, Object> getPackageList(String menu){
    	// 0: uCUBE, 1: GlueMaster, 2: GlueFramework, 3: PosBee, 4: etc 
		Map<String, Object> map = new HashMap<String, Object>();
    	switch ( Integer.parseInt( menu ) ) {
        case 0:
        	map.put("packageList", managementDao.getPackageList("uCUBE"));
        	map.put("patchList", managementDao.getPatchList("uCUBE"));
        	break;
        case 1:
        	map.put("packageList", managementDao.getPackageList("GlueMaster"));
        	map.put("patchList", managementDao.getPatchList("GlueMaster"));
        	break;
        case 2:
        	map.put("packageList", managementDao.getPackageList("GlueFramework"));
        	map.put("patchList", managementDao.getPatchList("GlueFramework"));
        	break;
        case 3:
        	map.put("packageList", managementDao.getPackageList("PosBee"));
        	map.put("patchList", managementDao.getPatchList("PosBee"));
        	break;
        case 4:
        	map.put("packageList", managementDao.getPackageList("etc"));
        	break;
        case 5:
        	map.put("packageList", managementDao.getPackageList("GlueMobile"));
        	map.put("patchList", managementDao.getPatchList("GlueMobile"));
        	break;
        }
    	
    	return map;
    }
	
	public List<Map<String, Object>> getOrderCompanyList() {
		return managementDao.getOrderCompanyList();
	}
	
	public String getVersionList(String packageName){
		logger.debug("getVersionList- packageName: " + packageName);
		List<Map<String, Object>> temp = managementDao.getVersionList(packageName);
		String temp2 = "";
		if(temp.size()>0){
			for(int i=0; i<temp.size(); i++){
				if(i<temp.size()-1)
					temp2 += (String) temp.get(i).get("PACKAGE_VERSION") + ":";
				else
					temp2 += (String) temp.get(i).get("PACKAGE_VERSION");
			}
		}
		
		return temp2;
	}
	
	public String addOrderCompany(ContractPersonInfo info, String admin) throws Exception{
		logger.debug("getVersionList- addCompany: " + info.getUSER_NO());
    	TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	info.setPROJECT_NAME("수주사");
    	
    	try{
    		int cnt = managementDao.orderCompanyCount();
    		String sortString = sortOrder(cnt+1);
    		managementDao.addOrderCompany(sortString, info.getUSER_NAME(), info.getUSER_NO(), admin);
    		managementDao.addOrderCompanyInfo(info, passwordEncoder(info.getUSER_NO()), Consts.USERLV_ORDER_COMPANY, admin);
    		
    		Map<String, Object> map = getOrderCompanyPermission();
    		String codes = (String) map.get("codes");
			String codeTypes = (String) map.get("codeTypes");
			int size = (Integer) map.get("size");
			managementDao.insert_user_permission(codes, codeTypes, info.getUSER_NO(), size);
			
    		this.transactionManager.commit(status);
    	}catch(NullPointerException e){
    		this.transactionManager.rollback(status);
    		logger.error("addCompany: ", e);
    		throw new NullPointerException("등록 실패 - NullPointerException");
    	}catch(DuplicateKeyException e){
    		this.transactionManager.rollback(status);
    		logger.error("plusProduct: ", e);
    		throw new DuplicateKeyException("중복키가 발생하였습니다. 데이터를 확인해 주세요.");
    	}catch(Exception e){
    		this.transactionManager.rollback(status);
    		logger.error("addCompany: ", e);
    		throw new UserException("등록 실패");
    	}
    	
    	String msg = "수주사("+info.getUSER_NAME()+") 등록완료";
    	return msg;
	}
	
	public Map<String, Object> getOrderCompanyInfo(String companyId) throws UnsupportedEncodingException{
		logger.debug("getOrderCompanyInfo: " + companyId);
		return managementDao.getOrderCompanyInfo(companyId);
	}

	public void modifyCompanyInfo(String userNo, String userName, String managerName, String userAddress,
			String managerOfficePhon, String managerCelPhon, String managerEmail, String oriUserNo) throws UserException {
		logger.debug("modifyCompanyInfo: " + oriUserNo);
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		try{
			managementDao.updateUserInfo(userNo, userName, managerName, userAddress, managerOfficePhon, managerCelPhon, managerEmail, oriUserNo);
			managementDao.updateOrderCompanyInfo(userNo, userName, oriUserNo);
			this.transactionManager.commit(status);
		}catch(Exception e){
			this.transactionManager.rollback(status);
			logger.error("modifyCompanyInfo", e);
			throw new UserException("수주사 정보 수정 실패");
		}
	}
	
	public void expireOrderCompany(HttpSession session, String companyId) {
		logger.debug("expire OrderCompany or user: " + companyId);
		managementDao.expireOrderCompany((String)session.getAttribute("USER_NO"), companyId);
	}
	
	public void progressUserExpire(String userNo, String objectId) {
		logger.debug("expire progressUser: " + objectId);
		managementDao.progressUserExpire(userNo, objectId);
		managementDao.insertProgressUserLog(objectId, null, Consts.ProgressStatus.valueOf("G").getProgressStatus(), userNo);
	}
	
	public void convertUser(ContractPersonInfo per, String[] etcFile, ContractProductInfo pro, String objectId, HttpSession session) throws UserException{
		newContract(per, pro, etcFile, session);
		changeUserStatus(objectId, Consts.ProgressStatus.F.getProgressStatus(), (String)session.getAttribute("USER_NO"));
		
		String newUserNo = per.getUSER_NO();
		managementDao.updateProgressUserNo(newUserNo, (String)session.getAttribute("USER_NO"), objectId);
	}
	
	public void upload(String folder, String packageVersion, MultipartFile file, String comment, String mode, HttpSession session) throws Exception{
    	TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
    	try{
    		String folderPath = getFolderPath(folder);
    		String objectId = "";
            if(mode.equals("package")){
            	if(packageVersion!=null&&packageVersion!=""){
            		folderPath += packageVersion+File.separator;
            		objectId = "pk_"+attachFileDateFormat()+UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12);
            	}
            }else{
            	folderPath += packageVersion+File.separator+"patch"+File.separator;
            	objectId = "pt_"+attachFileDateFormat()+UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12);;
            }
            
            MultipartFile upFile = file;
            String fileName = null;
            if ( upFile != null ) {
                fileName = upFile.getOriginalFilename();
                System.out.println( "up: fileName: " + fileName + " " + folderPath );
                if(mode.equals("package")){
                	managementDao.addFileInfo( objectId, folder, folder.equals("etc")?fileName:packageVersion, fileName, comment.replaceAll("\n", "<br>"), folderPath + fileName, (String) session.getAttribute( "USER_NO" ) );        	
                }else{
                	String pObjectId = managementDao.getProductKey(folder, packageVersion);
                	managementDao.addPatchFileInfo(objectId, pObjectId, folder, packageVersion, fileName, comment.replaceAll("\n", "<br>"), folderPath + fileName, (String) session.getAttribute( "USER_NO" ));
                }
                try {
                    File ufile = new File( folderPath + fileName );
                    
                    if(ufile.isFile()){
                    	logger.error("upload- Duplicate FileName: "+folderPath+fileName);
                    	throw new UserException("동일파일명이 존재합니다. 파일명을 변경해 주세요.");
                    }
                    
                    if ( !ufile.exists() ) {
                    	ufile.mkdirs();
                    }
                    upFile.transferTo( ufile );
                } catch ( IOException e ) {
                    e.printStackTrace();
                    logger.error("packageUpload/patchUpload(File Upload Error): ", e);
                    throw new IOException();
                }
            }
            this.transactionManager.commit(status);
    	}catch(DuplicateKeyException e){
    		this.transactionManager.rollback(status);
    		logger.error("packageUpload/patchUpload(File Upload Error): ", e);
    		throw new DuplicateKeyException("중복키가 발생하였습니다. 데이터를 확인해 주세요.");
    	}catch(Exception e){
    		this.transactionManager.rollback(status);
    		logger.error("packageUpload/patchUpload(File Upload Error): ", e);
    		throw new Exception(e);
    	}
	}
	
	public void initializationPassword(String userNo, HttpSession session) {
		logger.debug("initializationPassword user: " + userNo);
		managementDao.initializationPassword(passwordEncoder(userNo), (String)session.getAttribute("USER_NO"), userNo);
	}
	
//	public void encodePassword(HttpSession session){
//		logger.debug("initializationPassword Start");
//		StandardPasswordEncoder encoder = new StandardPasswordEncoder();
//		
//		List<Map<String, Object>> userList = managementDao.getUserList();
//		for(Map<String, Object> user: userList){
//			managementDao.initializationPassword( encoder.encode((String)user.get("USER_PASSWORD")), (String)session.getAttribute("USER_NO"), (String)user.get("USER_NO"));
//		}
//	}
	
	public List<Map<String, Object>> getCustomUserList(){	
		List<Map<String, Object>> userList = managementDao.getCustomUserList();
		return userList;
	}
	
	public void addCustomUser( HttpSession session, ContractPersonInfo userInfo, UserPermission userPermission ) throws UserException {
		TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
		try{
			userInfo.setPROJECT_NAME("CUSTOM USER");
			managementDao.addOrderCompanyInfo(userInfo, passwordEncoder(userInfo.getUSER_NO()), 
					Consts.USERLV_CUSTOM_USER, (String) session.getAttribute("USER_NO") );
			
			Map<String, Object> map = setPermissionCode(userPermission);
			String codes = (String) map.get("codes");
			String codeTypes = (String) map.get("codeTypes");
			int size = (Integer) map.get("size");
			managementDao.insert_user_permission(codes, codeTypes, userInfo.getUSER_NO(), size);
			
			this.transactionManager.commit(status);
		}catch(NullPointerException e){
			this.transactionManager.rollback(status);
    		logger.error("addCustomUser: ", e);
			throw new UserException("커스텀 유저 생성 실패");
		}catch(Exception e){
			this.transactionManager.rollback(status);
    		logger.error("addCustomUser: ", e);
    		throw new UserException("커스텀 유저 생성 실패");
		}
	}
	
	public Map<String, Object> customUserInfo(String userNo) {
		UserInfo userInfo = managementDao.getClientInfoMore(userNo);
		UserPermission userPermission = getUserPermission(managementDao.getUserPermission(userNo));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userInfo", userInfo);
		map.put("userPermission", userPermission);
		
		return map;
	}
	
	public String modifyCustomUser(String adminUser, String customUserNo, String mode, UserInfo userInfo, UserPermission userPermission) throws UserException{
		String userNo = "";
		if(mode.equals("info")){
			userNo=userInfo.getUSER_NO().trim();
			managementDao.updateCustomUserInfo(userInfo, adminUser, customUserNo);
		}else if(mode.equals("permission")){
			userNo=customUserNo;
			TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
			try{
				managementDao.deleteCustomUserPermission( customUserNo );
				
				Map<String, Object> map = setPermissionCode(userPermission);
				String codes = (String) map.get("codes");
				String codeTypes = (String) map.get("codeTypes");
				int size = (Integer) map.get("size");
				managementDao.insert_user_permission(codes, codeTypes, customUserNo, size);
				
				this.transactionManager.commit(status);
			}catch(Exception e){
				this.transactionManager.rollback(status);
	    		logger.error("CustomUser Modify Permission FAIL: "+customUserNo, e);
	    		throw new UserException("커스텀 유저 권한수정 실패");
			}
		}
		
		return userNo;
	}
	
	public UserPermission getUserPermission(List<Map<String, Object>> permissionList){
		UserPermission userPermission = new UserPermission();
		
		for( Map<String, Object> map: permissionList){
			if(map.get("CODE").equals(Consts.MENU_NOTICE)) userPermission.setMENU_NOTICE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_NOTICE_WRITE)) userPermission.setFUNCTION_NOTICE_WRITE(true);
			
			if(map.get("CODE").equals(Consts.MENU_GLUE)) userPermission.setMENU_GLUE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUE_ADMIN)) userPermission.setFUNCTION_GLUE_ADMIN(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUE_WRITE)) userPermission.setFUNCTION_GLUE_WRITE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUE_WRITE_NOTICE)) userPermission.setFUNCTION_GLUE_WRITE_NOTICE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUE_WRITE_QNA)) userPermission.setFUNCTION_GLUE_WRITE_QNA(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUE_REPLY_BOARD_QNA)) userPermission.setFUNCTION_GLUE_REPLY_BOARD_QNA(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUE_WRITE_FAQ)) userPermission.setFUNCTION_GLUE_WRITE_FAQ(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUE_WRITE_TECH)) userPermission.setFUNCTION_GLUE_WRITE_TECH(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUE_WRITE_OLDTECH)) userPermission.setFUNCTION_GLUE_WRITE_OLDTECH(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUE_REPLY)) userPermission.setFUNCTION_GLUE_REPLY(true);
			
			if(map.get("CODE").equals(Consts.MENU_GLUEMASTER)) userPermission.setMENU_GLUEMASTER(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMASTER_ADMIN)) userPermission.setFUNCTION_GLUEMASTER_ADMIN(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMASTER_WRITE)) userPermission.setFUNCTION_GLUEMASTER_WRITE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMASTER_WRITE_NOTICE)) userPermission.setFUNCTION_GLUEMASTER_WRITE_NOTICE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMASTER_WRITE_QNA)) userPermission.setFUNCTION_GLUEMASTER_WRITE_QNA(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMASTER_REPLY_BOARD_QNA)) userPermission.setFUNCTION_GLUEMASTER_REPLY_BOARD_QNA(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMASTER_WRITE_FAQ)) userPermission.setFUNCTION_GLUEMASTER_WRITE_FAQ(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMASTER_WRITE_TECH)) userPermission.setFUNCTION_GLUEMASTER_WRITE_TECH(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMASTER_REPLY)) userPermission.setFUNCTION_GLUEMASTER_REPLY(true);
			
			if(map.get("CODE").equals(Consts.MENU_GLUEMOBILE)) userPermission.setMENU_GLUEMOBILE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMOBILE_ADMIN)) userPermission.setFUNCTION_GLUEMOBILE_ADMIN(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMOBILE_WRITE)) userPermission.setFUNCTION_GLUEMOBILE_WRITE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMOBILE_WRITE_NOTICE)) userPermission.setFUNCTION_GLUEMOBILE_WRITE_NOTICE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMOBILE_WRITE_QNA)) userPermission.setFUNCTION_GLUEMOBILE_WRITE_QNA(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA)) userPermission.setFUNCTION_GLUEMOBILE_REPLY_BOARD_QNA(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMOBILE_WRITE_FAQ)) userPermission.setFUNCTION_GLUEMOBILE_WRITE_FAQ(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMOBILE_WRITE_TECH)) userPermission.setFUNCTION_GLUEMOBILE_WRITE_TECH(true);
			if(map.get("CODE").equals(Consts.FUNCTION_GLUEMOBILE_REPLY)) userPermission.setFUNCTION_GLUEMOBILE_REPLY(true);
			
			if(map.get("CODE").equals(Consts.MENU_UCUBE)) userPermission.setMENU_UCUBE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_UCUBE_ADMIN)) userPermission.setFUNCTION_UCUBE_ADMIN(true);
			if(map.get("CODE").equals(Consts.FUNCTION_UCUBE_WRITE)) userPermission.setFUNCTION_UCUBE_WRITE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_UCUBE_WRITE_NOTICE)) userPermission.setFUNCTION_UCUBE_WRITE_NOTICE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_UCUBE_WRITE_QNA)) userPermission.setFUNCTION_UCUBE_WRITE_QNA(true);
			if(map.get("CODE").equals(Consts.FUNCTION_UCUBE_REPLY_BOARD_QNA)) userPermission.setFUNCTION_UCUBE_REPLY_BOARD_QNA(true);
			if(map.get("CODE").equals(Consts.FUNCTION_UCUBE_WRITE_FAQ)) userPermission.setFUNCTION_UCUBE_WRITE_FAQ(true);
			if(map.get("CODE").equals(Consts.FUNCTION_UCUBE_WRITE_TECH)) userPermission.setFUNCTION_UCUBE_WRITE_TECH(true);
			if(map.get("CODE").equals(Consts.FUNCTION_UCUBE_REPLY)) userPermission.setFUNCTION_UCUBE_REPLY(true);
			
			if(map.get("CODE").equals(Consts.MENU_POSBEE)) userPermission.setMENU_POSBEE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_POSBEE_ADMIN)) userPermission.setFUNCTION_POSBEE_ADMIN(true);
			if(map.get("CODE").equals(Consts.FUNCTION_POSBEE_WRITE)) userPermission.setFUNCTION_POSBEE_WRITE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_POSBEE_WRITE_NOTICE)) userPermission.setFUNCTION_POSBEE_WRITE_NOTICE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_POSBEE_WRITE_QNA)) userPermission.setFUNCTION_POSBEE_WRITE_QNA(true);
			if(map.get("CODE").equals(Consts.FUNCTION_POSBEE_REPLY_BOARD_QNA)) userPermission.setFUNCTION_POSBEE_REPLY_BOARD_QNA(true);
			if(map.get("CODE").equals(Consts.FUNCTION_POSBEE_WRITE_FAQ)) userPermission.setFUNCTION_POSBEE_WRITE_FAQ(true);
			if(map.get("CODE").equals(Consts.FUNCTION_POSBEE_WRITE_TECH)) userPermission.setFUNCTION_POSBEE_WRITE_TECH(true);
			if(map.get("CODE").equals(Consts.FUNCTION_POSBEE_REPLY)) userPermission.setFUNCTION_POSBEE_REPLY(true);
			
			if(map.get("CODE").equals(Consts.MENU_SOLUTION_UPLOAD)) userPermission.setMENU_SOLUTION_UPLOAD(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_GLUE)) userPermission.setFUNCTION_SOLUTION_UPLOAD_GLUE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_GLUEMASTER)) userPermission.setFUNCTION_SOLUTION_UPLOAD_GLUEMASTER(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_UCUBE)) userPermission.setFUNCTION_SOLUTION_UPLOAD_UCUBE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_POSBEE)) userPermission.setFUNCTION_SOLUTION_UPLOAD_POSBEE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_ETC)) userPermission.setFUNCTION_SOLUTION_UPLOAD_ETC(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_ORDER_COMPANY)) userPermission.setFUNCTION_SOLUTION_UPLOAD_ORDER_COMPANY(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_CUSTOM_USER)) userPermission.setFUNCTION_SOLUTION_UPLOAD_CUSTOM_USER(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE)) userPermission.setFUNCTION_SOLUTION_UPLOAD_GLUEMOBILE(true);
			
			if(map.get("CODE").equals(Consts.MENU_PRESENTATION)) userPermission.setMENU_PRESENTATION(true);
			if(map.get("CODE").equals(Consts.MENU_GUEST_PACKAGE_DOWNLOAD)) userPermission.setMENU_GUEST_PACKAGE_DOWNLOAD(true);
			if(map.get("CODE").equals(Consts.MENU_USER_PACKAGE_DOWNLOAD)) userPermission.setMENU_USER_PACKAGE_DOWNLOAD(true);
			
			if(map.get("CODE").equals(Consts.MENU_MANAGEMENT)) userPermission.setMENU_MANAGEMENT(true);
			if(map.get("CODE").equals(Consts.SUB_MENU_MANAGEMENT_COMPLETE)) userPermission.setSUB_MENU_MANAGEMENT_COMPLETE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_MANAGEMENT_INPUT_USER)) userPermission.setFUNCTION_MANAGEMENT_INPUT_USER(true);
			if(map.get("CODE").equals(Consts.SUB_MENU_MANAGEMENT_PROGRESS)) userPermission.setSUB_MENU_MANAGEMENT_PROGRESS(true);
			if(map.get("CODE").equals(Consts.FUNCTION_PROGRESS_INPUT_USER)) userPermission.setFUNCTION_PROGRESS_INPUT_USER(true);
			if(map.get("CODE").equals(Consts.FUNCTION_PROGRESS_COMMENT)) userPermission.setFUNCTION_PROGRESS_COMMENT(true);
			
			if(map.get("CODE").equals(Consts.MENU_CUSTOMBOARD)) userPermission.setMENU_CUSTOMBOARD(true);
			
		}
		
		
		return userPermission;
	}
	
	public Map<String, Object> setPermissionCode ( UserPermission userPermission ){
		ArrayList<String> codes = new ArrayList<String>();
		ArrayList<String> codeTypes = new ArrayList<String>();
		
		if(userPermission.isMENU_NOTICE()) {
			codes.add(Consts.MENU_NOTICE);
			codeTypes.add("menu");
		}
		if(userPermission.isFUNCTION_NOTICE_WRITE()) {
			codes.add(Consts.FUNCTION_NOTICE_WRITE);
			codeTypes.add("function");
		}
		
		if(userPermission.isMENU_GLUE()) {
			codes.add(Consts.MENU_GLUE);
			codeTypes.add("menu");
		}
		if(userPermission.isFUNCTION_GLUE_ADMIN()) {
			codes.add(Consts.FUNCTION_GLUE_ADMIN);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUE_WRITE()) {
			codes.add(Consts.FUNCTION_GLUE_WRITE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUE_WRITE_NOTICE()) {
			codes.add(Consts.FUNCTION_GLUE_WRITE_NOTICE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUE_WRITE_QNA()) {
			codes.add(Consts.FUNCTION_GLUE_WRITE_QNA);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUE_REPLY_BOARD_QNA()) {
			codes.add(Consts.FUNCTION_GLUE_REPLY_BOARD_QNA);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUE_WRITE_FAQ()) {
			codes.add(Consts.FUNCTION_GLUE_WRITE_FAQ);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUE_WRITE_TECH()) {
			codes.add(Consts.FUNCTION_GLUE_WRITE_TECH);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUE_WRITE_OLDTECH()) {
            codes.add(Consts.FUNCTION_GLUE_WRITE_OLDTECH);
            codeTypes.add("function");
        }
		if(userPermission.isFUNCTION_GLUE_REPLY()) {
			codes.add(Consts.FUNCTION_GLUE_REPLY);
			codeTypes.add("function");
		}
		
		if(userPermission.isMENU_GLUEMASTER()) {
			codes.add(Consts.MENU_GLUEMASTER);
			codeTypes.add("menu");
		}
		if(userPermission.isFUNCTION_GLUEMASTER_ADMIN()) {
			codes.add(Consts.FUNCTION_GLUEMASTER_ADMIN);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMASTER_WRITE()) {
			codes.add(Consts.FUNCTION_GLUEMASTER_WRITE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMASTER_WRITE_NOTICE()) {
			codes.add(Consts.FUNCTION_GLUEMASTER_WRITE_NOTICE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMASTER_WRITE_QNA()) {
			codes.add(Consts.FUNCTION_GLUEMASTER_WRITE_QNA);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMASTER_REPLY_BOARD_QNA()) {
			codes.add(Consts.FUNCTION_GLUEMASTER_REPLY_BOARD_QNA);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMASTER_WRITE_FAQ()) {
			codes.add(Consts.FUNCTION_GLUEMASTER_WRITE_FAQ);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMASTER_WRITE_TECH()) {
			codes.add(Consts.FUNCTION_GLUEMASTER_WRITE_TECH);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMASTER_REPLY()) {
			codes.add(Consts.FUNCTION_GLUEMASTER_REPLY);
			codeTypes.add("function");
		}
		
		if(userPermission.isMENU_GLUEMOBILE()) {
			codes.add(Consts.MENU_GLUEMOBILE);
			codeTypes.add("menu");
		}
		if(userPermission.isFUNCTION_GLUEMOBILE_ADMIN()) {
			codes.add(Consts.FUNCTION_GLUEMOBILE_ADMIN);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMOBILE_WRITE()) {
			codes.add(Consts.FUNCTION_GLUEMOBILE_WRITE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMOBILE_WRITE_NOTICE()) {
			codes.add(Consts.FUNCTION_GLUEMOBILE_WRITE_NOTICE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMOBILE_WRITE_QNA()) {
			codes.add(Consts.FUNCTION_GLUEMOBILE_WRITE_QNA);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMOBILE_REPLY_BOARD_QNA()) {
			codes.add(Consts.FUNCTION_GLUEMOBILE_REPLY_BOARD_QNA);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMOBILE_WRITE_FAQ()) {
			codes.add(Consts.FUNCTION_GLUEMOBILE_WRITE_FAQ);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMOBILE_WRITE_TECH()) {
			codes.add(Consts.FUNCTION_GLUEMOBILE_WRITE_TECH);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_GLUEMOBILE_REPLY()) {
			codes.add(Consts.FUNCTION_GLUEMOBILE_REPLY);
			codeTypes.add("function");
		}
		
		if(userPermission.isMENU_UCUBE()) {
			codes.add(Consts.MENU_UCUBE);
			codeTypes.add("menu");
		}
		if(userPermission.isFUNCTION_UCUBE_ADMIN()) {
			codes.add(Consts.FUNCTION_UCUBE_ADMIN);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_UCUBE_WRITE()) {
			codes.add(Consts.FUNCTION_UCUBE_WRITE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_UCUBE_WRITE_NOTICE()) {
			codes.add(Consts.FUNCTION_UCUBE_WRITE_NOTICE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_UCUBE_WRITE_QNA()) {
			codes.add(Consts.FUNCTION_UCUBE_WRITE_QNA);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_UCUBE_REPLY_BOARD_QNA()) {
			codes.add(Consts.FUNCTION_UCUBE_REPLY_BOARD_QNA);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_UCUBE_WRITE_FAQ()) {
			codes.add(Consts.FUNCTION_UCUBE_WRITE_FAQ);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_UCUBE_WRITE_TECH()) {
			codes.add(Consts.FUNCTION_UCUBE_WRITE_TECH);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_UCUBE_REPLY()) {
			codes.add(Consts.FUNCTION_UCUBE_REPLY);
			codeTypes.add("function");
		}
		
		if(userPermission.isMENU_POSBEE()) {
			codes.add(Consts.MENU_POSBEE);
			codeTypes.add("menu");
		}
		if(userPermission.isFUNCTION_POSBEE_ADMIN()) {
			codes.add(Consts.FUNCTION_POSBEE_ADMIN);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_POSBEE_WRITE()) {
			codes.add(Consts.FUNCTION_POSBEE_WRITE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_POSBEE_WRITE_NOTICE()) {
			codes.add(Consts.FUNCTION_POSBEE_WRITE_NOTICE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_POSBEE_WRITE_QNA()) {
			codes.add(Consts.FUNCTION_POSBEE_WRITE_QNA);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_POSBEE_REPLY_BOARD_QNA()) {
			codes.add(Consts.FUNCTION_POSBEE_REPLY_BOARD_QNA);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_POSBEE_WRITE_FAQ()) {
			codes.add(Consts.FUNCTION_POSBEE_WRITE_FAQ);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_POSBEE_WRITE_TECH()) {
			codes.add(Consts.FUNCTION_POSBEE_WRITE_TECH);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_POSBEE_REPLY()) {
			codes.add(Consts.FUNCTION_POSBEE_REPLY);
			codeTypes.add("function");
		}
		
		if(userPermission.isMENU_SOLUTION_UPLOAD()) {
			codes.add(Consts.MENU_SOLUTION_UPLOAD);
			codeTypes.add("menu");
		}
		if(userPermission.isFUNCTION_SOLUTION_UPLOAD_GLUE()) {
			codes.add(Consts.FUNCTION_SOLUTION_UPLOAD_GLUE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_SOLUTION_UPLOAD_GLUEMASTER()) {
			codes.add(Consts.FUNCTION_SOLUTION_UPLOAD_GLUEMASTER);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_SOLUTION_UPLOAD_UCUBE()) {
			codes.add(Consts.FUNCTION_SOLUTION_UPLOAD_UCUBE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_SOLUTION_UPLOAD_POSBEE()) {
			codes.add(Consts.FUNCTION_SOLUTION_UPLOAD_POSBEE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_SOLUTION_UPLOAD_ETC()) {
			codes.add(Consts.FUNCTION_SOLUTION_UPLOAD_ETC);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_SOLUTION_UPLOAD_ORDER_COMPANY()) {
			codes.add(Consts.FUNCTION_SOLUTION_UPLOAD_ORDER_COMPANY);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_SOLUTION_UPLOAD_CUSTOM_USER()) {
			codes.add(Consts.FUNCTION_SOLUTION_UPLOAD_CUSTOM_USER);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_SOLUTION_UPLOAD_GLUEMOBILE()) {
			codes.add(Consts.FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE);
			codeTypes.add("function");
		}
		
		if(userPermission.isMENU_PRESENTATION()) {
			codes.add(Consts.MENU_PRESENTATION);
			codeTypes.add("menu");
		}
		if(userPermission.isMENU_GUEST_PACKAGE_DOWNLOAD()) {
			codes.add(Consts.MENU_GUEST_PACKAGE_DOWNLOAD);
			codeTypes.add("menu");
		}
		if(userPermission.isMENU_USER_PACKAGE_DOWNLOAD()) {
			codes.add(Consts.MENU_USER_PACKAGE_DOWNLOAD);
			codeTypes.add("menu");
		}
		
		if(userPermission.isMENU_MANAGEMENT()) {
			codes.add(Consts.MENU_MANAGEMENT);
			codeTypes.add("menu");
		}
		if(userPermission.isSUB_MENU_MANAGEMENT_COMPLETE()) {
			codes.add(Consts.SUB_MENU_MANAGEMENT_COMPLETE);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_MANAGEMENT_INPUT_USER()) {
			codes.add(Consts.FUNCTION_MANAGEMENT_INPUT_USER);
			codeTypes.add("function");
		}
		if(userPermission.isSUB_MENU_MANAGEMENT_PROGRESS()) {
			codes.add(Consts.SUB_MENU_MANAGEMENT_PROGRESS);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_PROGRESS_INPUT_USER()) {
			codes.add(Consts.FUNCTION_PROGRESS_INPUT_USER);
			codeTypes.add("function");
		}
		if(userPermission.isFUNCTION_PROGRESS_COMMENT()) {
			codes.add(Consts.FUNCTION_PROGRESS_COMMENT);
			codeTypes.add("function");
		}
		
		if(userPermission.isMENU_CUSTOMBOARD()) {
			codes.add(Consts.MENU_CUSTOMBOARD);
			codeTypes.add("menu");
		}
		
		StringBuffer codesToString = new StringBuffer();
		StringBuffer typesToString = new StringBuffer();
		int size = codes.size();
		
		if( size>0 ) {
			for( int i=0; i<size; i++ ){
				codesToString.append("<code>"+codes.get(i)+"</code>");
				typesToString.append("<type>"+codeTypes.get(i)+"</type>");				
			}
		}else{
			throw new NullPointerException();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("codes", codesToString.toString());
		map.put("codeTypes", typesToString.toString());
		map.put("size", size);
		
		return map;
	}
    
	public Map<String, Object> getOrderCompanyPermission(){
		UserPermission per = new UserPermission();
		per.setMENU_NOTICE(true);
		
		per.setMENU_GLUE(true);
		per.setFUNCTION_GLUE_WRITE(true);
		per.setFUNCTION_GLUE_WRITE_QNA(true);
		per.setFUNCTION_GLUE_REPLY_BOARD_QNA(true);
		per.setFUNCTION_GLUE_REPLY(true);
		
		per.setMENU_GLUEMASTER(true);
		per.setFUNCTION_GLUEMASTER_WRITE(true);
		per.setFUNCTION_GLUEMASTER_WRITE_QNA(true);
		per.setFUNCTION_GLUEMASTER_REPLY_BOARD_QNA(true);
		per.setFUNCTION_GLUEMASTER_REPLY(true);
		
		per.setMENU_GLUEMOBILE(true);
		per.setFUNCTION_GLUEMOBILE_WRITE(true);
		per.setFUNCTION_GLUEMOBILE_WRITE_QNA(true);
		per.setFUNCTION_GLUEMOBILE_REPLY_BOARD_QNA(true);
		per.setFUNCTION_GLUEMOBILE_REPLY(true);

		per.setMENU_UCUBE(true);
		per.setFUNCTION_UCUBE_WRITE(true);
		per.setFUNCTION_UCUBE_WRITE_QNA(true);
		per.setFUNCTION_UCUBE_REPLY_BOARD_QNA(true);
		per.setFUNCTION_UCUBE_REPLY(true);
		
		per.setMENU_POSBEE(true);
		per.setFUNCTION_POSBEE_WRITE(true);
		per.setFUNCTION_POSBEE_WRITE_QNA(true);
		per.setFUNCTION_POSBEE_REPLY_BOARD_QNA(true);
		per.setFUNCTION_POSBEE_REPLY(true);
		
		per.setMENU_PRESENTATION(true);
		per.setMENU_GUEST_PACKAGE_DOWNLOAD(true);
		
		per.setMENU_MANAGEMENT(true);
		per.setSUB_MENU_MANAGEMENT_COMPLETE(true);
		per.setFUNCTION_MANAGEMENT_INPUT_USER(true);
		per.setSUB_MENU_MANAGEMENT_PROGRESS(true);
		per.setFUNCTION_PROGRESS_INPUT_USER(true);
		per.setFUNCTION_PROGRESS_COMMENT(true);
		
		return setPermissionCode(per);
	}
	
	public Map<String, Object> getClientPermission(){
		UserPermission per = new UserPermission();
		per.setMENU_NOTICE(true);
		
		per.setMENU_GLUE(true);
		per.setFUNCTION_GLUE_WRITE(true);
		per.setFUNCTION_GLUE_WRITE_QNA(true);
		per.setFUNCTION_GLUE_REPLY_BOARD_QNA(true);
		per.setFUNCTION_GLUE_REPLY(true);
		
		per.setMENU_GLUEMASTER(true);
		per.setFUNCTION_GLUEMASTER_WRITE(true);
		per.setFUNCTION_GLUEMASTER_WRITE_QNA(true);
		per.setFUNCTION_GLUEMASTER_REPLY_BOARD_QNA(true);
		per.setFUNCTION_GLUEMASTER_REPLY(true);
		
		per.setMENU_GLUEMOBILE(true);
		per.setFUNCTION_GLUEMOBILE_WRITE(true);
		per.setFUNCTION_GLUEMOBILE_WRITE_QNA(true);
		per.setFUNCTION_GLUEMOBILE_REPLY_BOARD_QNA(true);
		per.setFUNCTION_GLUEMOBILE_REPLY(true);

		per.setMENU_UCUBE(true);
		per.setFUNCTION_UCUBE_WRITE(true);
		per.setFUNCTION_UCUBE_WRITE_QNA(true);
		per.setFUNCTION_UCUBE_REPLY_BOARD_QNA(true);
		per.setFUNCTION_UCUBE_REPLY(true);
		
		per.setMENU_POSBEE(true);
		per.setFUNCTION_POSBEE_WRITE(true);
		per.setFUNCTION_POSBEE_WRITE_QNA(true);
		per.setFUNCTION_POSBEE_REPLY_BOARD_QNA(true);
		per.setFUNCTION_POSBEE_REPLY(true);
		
		per.setMENU_PRESENTATION(true);
		per.setMENU_USER_PACKAGE_DOWNLOAD(true);
		
		return setPermissionCode(per);
	}
}
