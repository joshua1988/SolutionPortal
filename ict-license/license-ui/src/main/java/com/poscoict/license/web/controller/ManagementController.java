package com.poscoict.license.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import com.poscoict.license.consts.Consts;
import com.poscoict.license.service.ManagementService;
import com.poscoict.license.service.UserException;
import com.poscoict.license.vo.ContractPersonInfo;
import com.poscoict.license.vo.ContractProductInfo;
import com.poscoict.license.vo.UserInfo;
import com.poscoict.license.vo.UserPermission;

@Controller
public class ManagementController extends ExceptionControllerAdvice {    
    private ManagementService getManagementService() {
        ApplicationContext context = new GenericXmlApplicationContext( "applicationContext.xml" );
        return context.getBean( "managementService", ManagementService.class );
    }

    // 고객관리 리스트
    @RequestMapping( value = { "management" }, method = RequestMethod.POST )
    public ModelAndView getClientList( @RequestParam( value="search", required=false ) String search,
    		@RequestParam( value="select", required=false ) String select, HttpSession session) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "page", "licenseManagement/licenseManagement" );
        mv.addObject( "category", "management" );
        mv.addObject( "list", getManagementService().getClientList(search, select, session) );
        return mv;
    }
    
    // 고객관리 리스트(진행중)
    @RequestMapping( value = { "progress" }, method = RequestMethod.POST )
    public ModelAndView getProgressList( @RequestParam( value="subCategory", required=false ) String subCategory,
    		@RequestParam( value="search", required=false ) String search,
    		@RequestParam( value="select", required=false ) String select, HttpSession session) {
    	if(subCategory==null) subCategory="0";
    	
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "page", "licenseManagement/progress" );
        mv.addObject( "category", "progress" );
        mv.addObject( "subCategory", subCategory );
        mv.addObject( "list", getManagementService().getProgressList(subCategory, search, select, session) );
        mv.addObject( "counting", getManagementService().getProgressCategoryCounting(session) );

        return mv;
    }

    // 패키지 다운로드 뷰(guest용)
    @RequestMapping( value = { "sdkDownload" }, method = RequestMethod.POST )
    public ModelAndView getFileList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "page", "packageDownload/packageDownload" );
        mv.addObject( "category", "sdkDownload" );
        mv.addObject( "map", getManagementService().getFileList() );
        return mv;
    }
    
    // 라이센스, 패키지 다운로드 뷰(고객용)
    @RequestMapping( value = { "certificateDownload" }, method = RequestMethod.POST )
    public ModelAndView getLicenseList( HttpSession session ) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "page", "certificateDownload/certificateDownload" );
        mv.addObject( "category", "certificateDownload" );
        mv.addObject( "list", getManagementService().getLicenseList(session) );
        return mv;
    }

    // 상세 고객 정보 수정
    @RequestMapping( value = { "userInfom" }, method = RequestMethod.POST )
    public ModelAndView getUserInfo( String userNo ) {
    	Map<String, Object> map = getManagementService().getUserInfo(userNo);
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "page", "licenseManagement/userInfom" );
        mv.addObject( "user", map.get("user") );
        mv.addObject( "company", map.get("company") );
        mv.addObject( "product" , map.get("product") );
        mv.addObject("file", map.get("file"));
        mv.addObject("etcUserFile", map.get("etcUserFile"));
        mv.addObject( "category", "management" );
        
        return mv;
    }
    
    // 	상세 고객 정보 수정폼(진행중)
    @RequestMapping( value = { "progressUserInfom" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView getProgressUserInfom( @RequestParam( value="objectId", required=false ) String objectId, HttpServletRequest request ) {    	
    	Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);  
        if(flashMap !=null) objectId = (String)flashMap.get("objectId");
    	
    	Map<String, Object> map = getManagementService().getProgressUserInfo(objectId);
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "page", "licenseManagement/progressUserInfom" );
        mv.addObject( "user", map.get("user") );
        mv.addObject("file", map.get("file"));
        mv.addObject("comment", map.get("comment"));
        mv.addObject("log", map.get("log"));
        mv.addObject( "category", "progress" );
        
        return mv;
    }

    // 파일 업로드 폼 리턴
    @RequestMapping( value = { "licenseManager" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView fileUploadForm(HttpSession session, String mode) {
    	Map<String, Object> map = getManagementService().fileUploadForm( (String) session.getAttribute("USER_NO"), mode );
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "list", map.get("list") );
        mv.addObject( "folder", map.get("folder") );
        mv.addObject( "page", "packageManagement/packageManagement" );
        mv.addObject("mode", mode);
        mv.addObject( "category", "licenseManager" );
        
        return mv;
    }

    // 신규유저 작성 폼
    @RequestMapping( value = { "newContract" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView newContractForm() {
    	Map<String, Object> map = getManagementService().newContractForm();
    	ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "file", map.get("file") );
        mv.addObject( "company", map.get("company") );
//        mv.addObject( "etcFile", map.get("etcFile") );
        mv.addObject( "page", "licenseManagement/newContract" );
        mv.addObject( "category", "management" );

        return mv;
    }
    
    // 진행중 계약건 폼
    @RequestMapping( value = { "progressContract" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView progressContractForm() {
    	ModelAndView mv = new ModelAndView();
        mv.setViewName( "mainPage" );
        mv.addObject( "file", getManagementService().progressContractForm() );
        mv.addObject( "page", "licenseManagement/progressContract" );
        mv.addObject( "category", "progress" );

        return mv;
    }
    
    // 신규유저 입력
	@RequestMapping( value = { "addContract" }, method = RequestMethod.POST )
    public ModelAndView newContract( ContractPersonInfo per, @RequestParam( value = "etcFile", required=false ) String[] etcFile,
    		@ModelAttribute ContractProductInfo pro, HttpSession session ) throws UserException {
		getManagementService().newContract(per, pro, etcFile, session);
        return getClientList(null,null,session);
    }
	
    // 임시고객 -> 신규유저 전환 계약완료
	@RequestMapping( value = { "convertUser" }, method = RequestMethod.POST )
    public String convertUser( ContractPersonInfo per, @RequestParam( value = "etcFile", required=false ) String[] etcFile,
    		@ModelAttribute ContractProductInfo pro, String objectId, HttpSession session ) throws UserException {
		getManagementService().convertUser(per, etcFile, pro, objectId, session);
		
        return "redirect:/progress";
    }
	
	// 진행중 계약건 입력
	@RequestMapping( value = { "addProgressContract" }, method = RequestMethod.POST )
    public ModelAndView addProgressContract( @RequestParam( value="USER_NAME" ) String userName,
    		@RequestParam( value="PROJECT_NAME" ) String projectName,
    		@RequestParam( value="USER_ADDRESS", required=false ) String userAddress,
    		@RequestParam( value="MANAGER_NAME", required=false ) String managerName,
    		@RequestParam( value="MANAGER_OFFICE_PHON", required=false ) String officePhon,
    		@RequestParam( value="MANAGER_CEL_PHON", required=false ) String celPhon,
    		@RequestParam( value="MANAGER_EMAIL", required=false ) String email,
    		@RequestParam( value="USER_START_DATE", required=false ) String startDate,
    		@RequestParam( value="PRODUCT_FILE_ID", required=false ) String product,
    		@RequestParam( value="COMMENT", required=false ) String comment,
    		HttpSession session
    		 ) throws UserException {
		getManagementService().addProgressContract(userName, projectName, userAddress, managerName, officePhon, celPhon,
				email, startDate ,product, comment, session);
		
        return getProgressList(null,null,null,session);
    }
	
	// 진행중 계약건 수정
	@RequestMapping( value = { "modifyProgressInfo" }, method = RequestMethod.POST )
    public String modifyProgressInfo( 
    		@RequestParam( value="objectId" ) String objectId,
    		@RequestParam( value="P_USER_NAME" ) String userName,
    		@RequestParam( value="P_PROJECT_NAME" ) String projectName,
    		@RequestParam( value="P_USER_ADDRESS", required=false ) String userAddress,
    		@RequestParam( value="P_MANAGER_NAME", required=false ) String managerName,
    		@RequestParam( value="P_MANAGER_OFFICE_PHON", required=false ) String officePhon,
    		@RequestParam( value="P_MANAGER_CEL_PHON", required=false ) String celPhon,
    		@RequestParam( value="P_MANAGER_EMAIL", required=false ) String email,
    		@RequestParam( value="P_USER_START_DATE", required=false ) String startDate,
    		@RequestParam( value="P_PRODUCT_FILE_ID", required=false ) String product,
    		HttpServletRequest request,
    		HttpSession session){
		getManagementService().modifyProgressInfo(objectId, userName, projectName, userAddress, managerName, officePhon, celPhon,
				email, startDate ,product, (String)session.getAttribute("USER_NO"));
		FlashMap map = RequestContextUtils.getOutputFlashMap(request);
		map.put("objectId", objectId);
		return "redirect:/progressUserInfom";
    }
	
	// 코멘트 입력
	@RequestMapping( value = { "insertComment" }, method = RequestMethod.POST )
    public String insertComment( String objectId, String comment, HttpSession session, HttpServletRequest request ) throws UserException {
		System.out.println("___________comment "+objectId);
		getManagementService().insertComment(objectId, comment, (String)session.getAttribute("USER_NO"));
		FlashMap map = RequestContextUtils.getOutputFlashMap(request);
		map.put("objectId", objectId);
		return "redirect:/progressUserInfom";
    }
	
	// 코멘트 삭제
	@RequestMapping( value = { "deleteComment" }, method = RequestMethod.POST )
    public String deleteComment( String objectId, String commentNo, HttpSession session, HttpServletRequest request ) throws UserException {
		getManagementService().deleteComment(objectId, commentNo, (String)session.getAttribute("USER_NO"));
		FlashMap map = RequestContextUtils.getOutputFlashMap(request);
		map.put("objectId", objectId);
		return "redirect:/progressUserInfom";
    }
	
	// 코멘트 수정
	@RequestMapping( value = { "modifyComment" }, method = RequestMethod.POST )
    public String modifyComment( String objectId, String commentNo, String comment, HttpSession session, HttpServletRequest request ) throws UserException {
		getManagementService().modifyComment(objectId, commentNo, comment, (String)session.getAttribute("USER_NO"));
		FlashMap map = RequestContextUtils.getOutputFlashMap(request);
		map.put("objectId", objectId);
		return "redirect:/progressUserInfom";
    }
	
	// 예비 고객 정식 등록 폼
	@RequestMapping( value = { "userContractForm" }, method = RequestMethod.POST )
    public ModelAndView userContractForm( String objectId ) throws UserException {
//    	Map<String, Object> map = getManagementService().newContractForm();
    	Map<String, Object> user = getManagementService().getProgressUserInfo(objectId);
    	
    	ModelAndView mv = new ModelAndView();
        mv.setViewName( "licenseManagement/newContract2" );
        mv.addObject( "category", "management" );
        
        mv.addObject( "userInfo", user.get("user"));
        mv.addObject( "file", user.get("file") );
        mv.addObject( "company", getManagementService().getOrderCompanyList() );
        mv.addObject( "objectId", objectId );
        return mv;
    }
	
	// 예비 고객 상태 변경
	@RequestMapping( value = { "changeUserStatus" }, method = RequestMethod.POST )
    public String changeUserStatus( String objectId, String uStatus, HttpSession session, HttpServletRequest request ) throws UserException {
		getManagementService().changeUserStatus(objectId, uStatus, (String)session.getAttribute("USER_NO"));
		FlashMap map = RequestContextUtils.getOutputFlashMap(request);
		map.put("objectId", objectId);
		return "redirect:/progressUserInfom";
    }

    // 고객관리 제품정보 수정 폼 리턴
    @RequestMapping( value = { "productModifyForm" }, method = RequestMethod.POST)
    public void getproductModifyForm(String userNo, String licenseKey, HttpServletResponse resp) throws IOException{
    	System.out.println("userNO: "+userNo+" licenseKey: "+licenseKey);
    	Map<String, Object> map = getManagementService().getproductModifyForm(userNo, licenseKey);
    	JSONObject js = new JSONObject();
    	js.put("product", map.get("product"));
    	js.put("file", map.get("file"));
    	js.put("userNo", userNo);
    	js.put("licenseKey", licenseKey);
    	
    	resp.setContentType("text/html;charset=utf-8");
    	PrintWriter out = resp.getWriter();
    	out.print(js.toString());
    }
    
    //고객관리 제품 삭제
    @RequestMapping( value = { "destroyProduct" }, method = RequestMethod.POST )
    public ModelAndView destroyProduct(String userNo, String licenseKey) throws IOException{
    	getManagementService().destroyProduct(userNo, licenseKey);
    	return getUserInfo(userNo);
    }

    // 제품정보수정 
    @RequestMapping( value = { "modifyProduct" }, method = RequestMethod.POST )
    public ModelAndView modifyProduct(@RequestParam( value = "userNo") String userNo,
    						  @RequestParam( value = "licenseKey") String licenseKey,
    						  @RequestParam( value = "PRODUCT_FILE_ID") String productFileId,
    						  @RequestParam( value = "LICENSE_KEY") String newLicenseKey,
    						  @RequestParam( value = "LICENSE_QUANTITY") String licenseQuantity,
    						  @RequestParam( value = "selectFile") String selectFile, // fixed: 기존파일, change: 파일변경
    						  @RequestParam( value = "CHECKBOX", required=false) String checkBox, // 체크시 파일없음
    						  @RequestParam( value = "file", required=false ) MultipartFile file,
    						  HttpSession session) throws UserException {
    	getManagementService().modifyProduct(userNo, licenseKey, productFileId, newLicenseKey, licenseQuantity, selectFile, checkBox, file, session);
    	return getUserInfo( userNo );
    }
    
    @RequestMapping(value = { "deletePackage" }, method = RequestMethod.POST )
    public void deletePackage(String category, String objectId, Writer writer, HttpSession session) throws IOException{
    	writer.write(getManagementService().deletePackage(category, objectId, session));
    }
    
    @RequestMapping(value = { "openPackage" }, method = RequestMethod.POST )
    public ModelAndView openPakage( String objectId, String flag, String mode, HttpSession session ) throws UserException{
    	getManagementService().openPackage(objectId, flag, session);
    	return fileUploadForm( session, mode );
    }
    
    // 고객정보 수정
    @RequestMapping(value = { "modifyProfile" }, method = RequestMethod.POST )
    public ModelAndView modifyProfile(ContractPersonInfo info, String oldUserNo, 
    		@RequestParam( value="etcFile", required=false ) String[] etcFile,
    		HttpSession session){
    	
    	System.out.println("____________oldUserNo: "+oldUserNo+"  etcFIle: "+etcFile);
    	return getUserInfo( getManagementService().modifyProfile(info, oldUserNo, etcFile, session) );
    }
	
	@RequestMapping(value={"plusProduct"}, method = RequestMethod.POST )
    public ModelAndView plusProduct(ContractProductInfo info, String userNo, HttpSession session) throws UserException {
    	return getUserInfo( getManagementService().plusProduct(info, userNo, session) );
    }
	
	@RequestMapping(value={"patchList"}, method = RequestMethod.POST )
    public ModelAndView getPatchList(String menu) {
		Map<String, Object> map = getManagementService().getPackageList(menu);
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("packageManagement/packageList");
    	mv.addObject("solutionMode", "package");
    	mv.addObject("mode", menu);
    	mv.addObject("packageList", map.get("packageList"));
    	mv.addObject("patchList", map.get("patchList"));
    	return mv;
    }
	
	@RequestMapping(value={"versionList"}, method = RequestMethod.POST )
    public void getVersionList(String menu, Writer writer) throws IOException {
		String temp = getManagementService().getVersionList(menu);
		if(temp=="")
			writer.write("null");
		else
			writer.write(temp);
    }
	
	@RequestMapping(value={"addOrderCompany"}, method = RequestMethod.POST )
    public String addOrderCompany(ContractPersonInfo per, HttpSession session, Writer write) throws Exception {
		String msg = getManagementService().addOrderCompany(per, (String)session.getAttribute("USER_NO"));
    	return "redirect:/orderCompanyList";
    }
	
	public String popupManager(String comment){
		String temp="<script>alert("+comment+");</script>";
		return temp;
	}
	
	@RequestMapping(value={"orderCompanyList"}, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView getOrderCompanyList() {
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("mainPage");
    	mv.addObject("page","packageManagement/orderCompany");
    	mv.addObject("orderCompanyList", getManagementService().getOrderCompanyList());
    	return mv;
    }
	
	@RequestMapping(value={"orderCompanyInfo"}, method = RequestMethod.POST )
    public void getOrderCompanyInfo(String companyId, HttpServletResponse resp) throws IOException {
    	JSONObject js = new JSONObject();
    	js.put("map", getManagementService().getOrderCompanyInfo(companyId));
    	
    	resp.setContentType("text/html;charset=utf-8");
    	PrintWriter out = resp.getWriter();
    	out.print(js.toString());
    }
	
	@RequestMapping(value={"modifyCompanyInfo"}, method = RequestMethod.POST )
    public String modifyCompanyInfo(
//    		Writer writer,
			  @RequestParam( value = "USER_NO" ) String userNo,
			  @RequestParam( value = "USER_NAME" ) String userName,
			  @RequestParam( value = "MANAGER_NAME") String managerName,
			  @RequestParam( value = "USER_ADDRESS", required=false) String userAddress,
			  @RequestParam( value = "MANAGER_OFFICE_PHON", required=false ) String managerOfficePhon,
			  @RequestParam( value = "MANAGER_CEL_PHON", required=false ) String managerCelPhon,
			  @RequestParam( value = "MANAGER_EMAIL", required=false ) String managerEmail,
			  @RequestParam( value = "oriCompanyId" ) String oriUserNo
    		) throws IOException, UserException {
		getManagementService().modifyCompanyInfo(userNo,userName,managerName,userAddress,managerOfficePhon,managerCelPhon,managerEmail,oriUserNo);
//		writer.write("success");
		return "redirect:/orderCompanyList";
    }
	
	@RequestMapping(value={"expireOrderCompany"}, method = RequestMethod.POST )
    public String expireOrderCompany(HttpSession session, String companyId) throws IOException {
		getManagementService().expireOrderCompany(session, companyId);
		return "redirect:/orderCompanyList";
    }
	
    @RequestMapping( value = {"packageUpload","patchUpload"}, method = RequestMethod.POST)
    public ModelAndView upload( @RequestParam( "folderCategory" ) String folder, 
    					  @RequestParam( value="packageVersion",required=false ) String packageVersion,
    					  @RequestParam( "file" ) MultipartFile file,
    					  @RequestParam( "comment" ) String comment, 
    					  @RequestParam( "mode" ) String mode,
    					  @RequestParam( "solutionMode" ) String solutionMode,
    					  HttpSession session ) throws Exception {
    	getManagementService().upload(folder, packageVersion, file, comment, solutionMode, session);
    	ModelAndView mv = fileUploadForm( session, mode );
    	return mv; 
    }
    
    //고객삭제
    @RequestMapping( value = {"userExpire"}, method = RequestMethod.POST )
    public ModelAndView userExpire( @RequestParam( "userNo" ) String userNo, HttpSession session ) throws Exception {
    	getManagementService().expireOrderCompany(session, userNo);
    	
    	return getClientList(null,null,session); 
    }
    
    //고객삭제 (진행중)
    @RequestMapping( value = {"progressUserExpire"}, method = RequestMethod.POST )
    public ModelAndView progressUserExpire( @RequestParam( "objectId" ) String objectId, HttpSession session ) throws Exception {
    	getManagementService().progressUserExpire( (String)session.getAttribute("USER_NO"), objectId);
    	return getProgressList(null,null,null,session);
    }
    
    //비번 초기화
    @RequestMapping( value = {"initializationPassword"}, method = RequestMethod.POST )
    public void initializationPassword( @RequestParam( "userNo" ) String userNo, HttpSession session, 
    		Writer writer ) throws Exception {
    	getManagementService().initializationPassword(userNo, session);
    	writer.write("success");
    }
    
    // 커스텀 유저 리스트
    @RequestMapping( value = {"customUser"}, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView customUser() throws Exception {
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName( "mainPage" );
        mv.addObject( "page", "packageManagement/customUser" );
        mv.addObject("list", getManagementService().getCustomUserList());
    	return mv;
    }
    
    // 커스텀 유저 생성 폼
    @RequestMapping( value = {"addCustomUserForm"}, method = RequestMethod.POST )
    public ModelAndView addCustomUserForm() throws Exception {
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName( "mainPage" );
        mv.addObject( "page", "packageManagement/newCustomUser" );
    	return mv;
    }
    
    // 커스텀 유저 생성
    @RequestMapping( value = { "addCustomUser" }, method = RequestMethod.POST )
    public String addCustomUser( HttpSession session, ContractPersonInfo userInfo, UserPermission userPermission ) throws UserException {
    	getManagementService().addCustomUser(session, userInfo, userPermission);
        return "redirect:/customUser";
    }
    
    @RequestMapping( value = { "customUserInfo" }, method = { RequestMethod.GET, RequestMethod.POST } )
    public ModelAndView customUserInfo( String userNo ) throws UserException {
    	ModelAndView mv = new ModelAndView();
    	Map<String, Object> map = getManagementService().customUserInfo(userNo);
    	
    	mv.setViewName( "mainPage" );
        mv.addObject( "page", "packageManagement/customUserInfo" );
        mv.addObject("userInfo", map.get("userInfo"));
        mv.addObject("userPermission", map.get("userPermission"));
        
    	return mv;
    }
    
    @RequestMapping( value = { "modifyCustomUser" }, method = RequestMethod.POST )
    public String modifyCustomUser( HttpSession session,
    		UserInfo userInfo,
    		UserPermission userPermission,
    		String userNo, String mode ) throws UserException {
    	String targetUser = getManagementService().modifyCustomUser((String)session.getAttribute("USER_NO"), userNo, mode, userInfo, userPermission);
    	return "redirect:/customUserInfo?userNo="+targetUser;
    }
    
//    @RequestMapping( value = {"encodePassword"}, method = { RequestMethod.GET, RequestMethod.POST } )
//    public void encodePassword( HttpSession session, Writer writer ) throws Exception {
//    	getManagementService().encodePassword(session);
//    	writer.write("success");
//    }
}
