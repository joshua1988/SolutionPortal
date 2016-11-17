package com.poscoict.license.util;

import java.security.PrivateKey;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.Cipher;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Service;

import com.poscoict.license.consts.Consts;
import com.poscoict.license.consts.Consts.SubCategory;
import com.poscoict.license.dao.MorgueDao;
import com.poscoict.license.security.CustomUserDetails;
import com.poscoict.license.vo.UserPermission;

@Service
public class LmsUtil {
	@Autowired
	private MorgueDao morgueDao;
	
	public String dateFormat() {
        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy/MM/dd HH:mm:ss" );
        Date date = new Date();
        String modifyDate = sdf.format( date );
        return modifyDate;
    }
    
    public String attachDateFormat() {
        SimpleDateFormat sdf = new SimpleDateFormat( "yyyyMMdd" );
        Date date = new Date();
        String modifyDate = sdf.format( date );
        return modifyDate;
    }
    
    public String attachFileDateFormat() {
        SimpleDateFormat sdf = new SimpleDateFormat( "yyyyMMddHHmmss" );
        Date date = new Date();
        String modifyDate = sdf.format( date );
        return modifyDate;
    }
    
    public ArrayList<Map<String,Object>> getBoardTypes(){
    	ArrayList<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
    	
    	for(SubCategory category: Consts.SubCategory.values()){
    		Map<String, Object> map = new HashMap<String, Object>();
    		map.put("categoryType", category.getCategory());
    		map.put("categoryTypeToString", category.getCategoryToString());
    		list.add(map);
    	}
    	return list;
    }
    
    public String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8");
        return decryptedValue;
    }
    
    public byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[]{};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
    
    public String getFolderPath(String folder){
    	String path="";
    	
    	if(folder.equals("uCUBE")){
    		path = Consts.UCUBE_FILE_HOME;
    	}
    	if(folder.equals("GlueFramework")){
    		path = Consts.GLUE_FRAMEWORK_FILE_HOME;
    	}
		if(folder.equals("license")){
			path = Consts.LICENSE_FILE_HOME;
		}
		if(folder.equals("GlueMaster")){
			path = Consts.GLUE_MASTER_FILE_HOME;
		}
		if(folder.equals("etc")){
			path = Consts.ETC_FILE_HOME;
		}
		if(folder.equals("PosBee")){
			path = Consts.POSBEE_FILE_HOME;
		}
		if(folder.equals("BoardAttach")){
			path = Consts.BOARD_ATTACH_FILE_HOME;
		}    	
    	return path;
    }
	
	public String sortOrder(int sortCount) {
		if (sortCount < 10) {
			return "000" + sortCount;
		} else if (sortCount < 100) {
			return "00" + sortCount;
		} else if (sortCount < 1000) {
			return "0" + sortCount;
		} else {
			return "" + sortCount;
		}
	}
	
	public String passwordEncoder(String password){
		StandardPasswordEncoder encoder = new StandardPasswordEncoder();
		return encoder.encode(password);
	}
	
	public UserPermission setUserPermission(List<Map<String, Object>> list){
		UserPermission userPermission = new UserPermission();
		for(Map<String, Object> map: list){
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
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_GLUEMOBILE)) userPermission.setFUNCTION_SOLUTION_UPLOAD_GLUEMOBILE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_UCUBE)) userPermission.setFUNCTION_SOLUTION_UPLOAD_UCUBE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_POSBEE)) userPermission.setFUNCTION_SOLUTION_UPLOAD_POSBEE(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_ETC)) userPermission.setFUNCTION_SOLUTION_UPLOAD_ETC(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_ORDER_COMPANY)) userPermission.setFUNCTION_SOLUTION_UPLOAD_ORDER_COMPANY(true);
			if(map.get("CODE").equals(Consts.FUNCTION_SOLUTION_UPLOAD_CUSTOM_USER)) userPermission.setFUNCTION_SOLUTION_UPLOAD_CUSTOM_USER(true);
			
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
	
	public StringBuffer initializeMenu(StringBuffer sb, UserPermission up, CustomUserDetails userDetails){
		sb.append("<ul>");
		sb = getMenuNotice(sb);
		if(up.isMENU_GLUE()) sb = getMenuGlue(sb,up,userDetails);
		if(up.isMENU_GLUEMASTER()) sb = getMenuGlueMaster(sb,up,userDetails);
		if(up.isMENU_GLUEMOBILE()) sb = getMenuGlueMobile(sb,up,userDetails);
		if(up.isMENU_UCUBE()) sb = getMenuUCube(sb,up,userDetails);
		if(up.isMENU_POSBEE()) sb = getMenuPosBee(sb,up,userDetails);
		if(up.isMENU_GUEST_PACKAGE_DOWNLOAD()) sb = getMenuEducationSolution(sb);
		if(up.isMENU_USER_PACKAGE_DOWNLOAD()) sb = getMenuSolutionPackage(sb);
		if(up.isMENU_PRESENTATION()) sb = getMenuPresentation(sb);
		if(up.isMENU_SOLUTION_UPLOAD()) sb = getMenuSolutionUpload(sb,up);
		if(up.isMENU_MANAGEMENT()) sb = getMenuManagement(sb,up);
		if(up.isMENU_CUSTOMBOARD()) {
			if(userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)){
				List<Map<String,Object>> list = morgueDao.getUerCustomBoardList( userDetails.getUserNo() );
				sb = getMenuCustomBoardAdmin(sb,up,list);
			}else{
				List<Map<String,Object>> list = morgueDao.getUerCustomBoardList( userDetails.getUserNo() );
				sb = getMenuCustomBoard(sb,up,list);				
			}
		}
		sb.append("</ul>");
		
		return sb;
	}
	
	public boolean confirmKey( ArrayList<String> list, String key ){
		boolean flag = true;
		if( list!=null ) {
			for(String temp: list){
				if(temp.equals(key)) flag = false;
			}			
		}
		return flag;
	}

	public StringBuffer getMenuNotice(StringBuffer sb){
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-bullhorn\"}' id=\"notice\" onclick=\"javascript:boardList('notice','NOTICE','notice'); return false;\">공지사항</li>");
		return sb;
	}
	
	public StringBuffer getMenuGlue(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
		sb.append("<li>Glue<ul id=\"GLUE\">");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueNotice\" onclick=\"javascript:boardList('notice','GLUE','GlueNotice')\">공지사항</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueQna\" onclick=\"javascript:boardList('qna','GLUE','GlueQna')\">Q&amp;A</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueFaq\" onclick=\"javascript:boardList('faq','GLUE','GlueFaq')\">FAQ</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueTech\" onclick=\"javascript:boardList('technical','GLUE','GlueTech')\">기술문서</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueOldTech\" onclick=\"javascript:boardList('oldtechnical','GLUE','GlueOldTech')\">기술문서(예전)</li>");
		if(up.isFUNCTION_GLUE_ADMIN()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-asterisk\"}' id=\"GlueManager\" onclick=\"javascript:projectManagement('GLUE','GlueManager')\">관리</li>");
		if(up.isFUNCTION_GLUE_ADMIN()) sb.append( getProjectFolderTree(Consts.PROJECT_GLUE_ROOT_ID, userDetails) );
		sb.append("</ul></li>");
		
		return sb;
	}
	
	public StringBuffer getMenuGlueMaster(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
		sb.append("<li>GlueMaster<ul id=\"GLUEMASTER\">");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueMasterNotice\" onclick=\"javascript:boardList('notice','GLUEMASTER','GlueMasterNotice')\">공지사항</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueMasterQna\" onclick=\"javascript:boardList('qna','GLUEMASTER','GlueMasterQna')\">Q&amp;A</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueMasterFaq\" onclick=\"javascript:boardList('faq','GLUEMASTER','GlueMasterFaq')\">FAQ</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueMasterTech\" onclick=\"javascript:boardList('technical','GLUEMASTER','GlueMasterTech')\">기술문서</li>");
		if(up.isFUNCTION_GLUEMASTER_ADMIN()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-asterisk\"}' id=\"GlueMasterManager\" onclick=\"javascript:projectManagement('GLUEMASTER','GlueMasterManager')\">관리</li>");
		if(up.isFUNCTION_GLUEMASTER_ADMIN()) sb.append( getProjectFolderTree(Consts.PROJECT_GLUEMASTER_ROOT_ID, userDetails) );
		sb.append("</ul></li>");
		
		return sb;
	}
	
	public StringBuffer getMenuGlueMobile(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
		sb.append("<li>GlueMobile<ul id=\"GLUEMOBILE\">");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueMobileNotice\" onclick=\"javascript:boardList('notice','GLUEMOBILE','GlueMobileNotice')\">공지사항</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueMobileQna\" onclick=\"javascript:boardList('qna','GLUEMOBILE','GlueMobileQna')\">Q&amp;A</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueMobileFaq\" onclick=\"javascript:boardList('faq','GLUEMOBILE','GlueMobileFaq')\">FAQ</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"GlueMobileTech\" onclick=\"javascript:boardList('technical','GLUEMOBILE','GlueMobileTech')\">기술문서</li>");
		if(up.isFUNCTION_GLUEMOBILE_ADMIN()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-asterisk\"}' id=\"GlueMobileManager\" onclick=\"javascript:projectManagement('GLUEMOBILE','GlueMobileManager')\">관리</li>");
		if(up.isFUNCTION_GLUEMOBILE_ADMIN()) sb.append( getProjectFolderTree(Consts.PROJECT_GLUEMOBILE_ROOT_ID, userDetails) );
		sb.append("</ul></li>");
		
		return sb;
	}
	
	public StringBuffer getMenuUCube(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
		sb.append("<li>uCUBE<ul id=\"UCUBE\">");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"uCUBENotice\" onclick=\"javascript:boardList('notice','UCUBE','uCUBENotice')\">공지사항</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"uCUBEQna\" onclick=\"javascript:boardList('qna','UCUBE','uCUBEQna')\">Q&amp;A</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"uCUBEFaq\" onclick=\"javascript:boardList('faq','UCUBE','uCUBEFaq')\">FAQ</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"uCUBETech\" onclick=\"javascript:boardList('technical','UCUBE','uCUBETech')\">기술문서</li>");
		if(up.isFUNCTION_UCUBE_ADMIN()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-asterisk\"}' id=\"uCUBEManager\" onclick=\"javascript:projectManagement('UCUBE','uCUBEManager')\">관리</li>");
		if(up.isFUNCTION_UCUBE_ADMIN()) sb.append( getProjectFolderTree(Consts.PROJECT_UCUBE_ROOT_ID, userDetails) );
		sb.append("</ul></li>");
		
		return sb;
	}
	
	public StringBuffer getMenuPosBee(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
		sb.append("<li>PosBee<ul id=\"POSBEE\">");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"PosBeeNotice\" onclick=\"javascript:boardList('notice','POSBEE','PosBeeNotice')\">공지사항</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"PosBeeQna\" onclick=\"javascript:boardList('qna','POSBEE','PosBeeQna')\">Q&amp;A</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"PosBeeFaq\" onclick=\"javascript:boardList('faq','POSBEE','PosBeeFaq')\">FAQ</li>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\"PosBeeTech\" onclick=\"javascript:boardList('technical','POSBEE','PosBeeTech')\">기술문서</li>");
		if(up.isFUNCTION_POSBEE_ADMIN()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-asterisk\"}' id=\"PosBeeManager\" onclick=\"javascript:projectManagement('POSBEE','PosBeeManager')\">관리</li>");
		if(up.isFUNCTION_POSBEE_ADMIN()) sb.append( getProjectFolderTree(Consts.PROJECT_POSBEE_ROOT_ID, userDetails) );
		sb.append("</ul></li>");
		
		return sb;
	}
	
	public StringBuffer getMenuEducationSolution(StringBuffer sb){
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-download-alt\"}' id=\"sdkDownload\" onclick=\"javascript:page('sdkDownload')\">교육용 솔루션 패키지</li>");
		return sb;
	}
	
	public StringBuffer getMenuSolutionPackage(StringBuffer sb){
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-download-alt\"}' id=\"certificateDownload\" onclick=\"javascript:page('certificateDownload')\">솔루션 패키지</li>");
		return sb;
	}
	
	public StringBuffer getMenuPresentation(StringBuffer sb){
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-thumbs-up\"}' id=\"presentation\" onclick=\"javascript:page('presentation')\">제품소개</li>");
		return sb;
	}
	
	public StringBuffer getMenuSolutionUpload(StringBuffer sb, UserPermission up){
		sb.append("<li>솔루션 패키지 관리<ul>");
		if(up.isFUNCTION_SOLUTION_UPLOAD_GLUE()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-leaf\"}' id=\"GluePackageManager\" onclick=\"javascript:packageManager('2','GluePackageManager')\">Glue</li>");
		if(up.isFUNCTION_SOLUTION_UPLOAD_GLUEMASTER()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-leaf\"}' id=\"GlueMasterPackageManager\" onclick=\"javascript:packageManager('1','GlueMasterPackageManager')\">GlueMaster</li>");
		if(up.isFUNCTION_SOLUTION_UPLOAD_GLUEMOBILE()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-leaf\"}' id=\"GlueMobilePackageManager\" onclick=\"javascript:packageManager('5','GlueMobilePackageManager')\">GlueMobile</li>");
		if(up.isFUNCTION_SOLUTION_UPLOAD_UCUBE()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-leaf\"}' id=\"uCUBEPackageManager\" onclick=\"javascript:packageManager('0','uCUBEPackageManager')\">uCUBE</li>");
		if(up.isFUNCTION_SOLUTION_UPLOAD_POSBEE()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-leaf\"}' id=\"PosBeePackageManager\" onclick=\"javascript:packageManager('3','PosBeePackageManager')\">PosBee</li>");
		if(up.isFUNCTION_SOLUTION_UPLOAD_ETC()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-leaf\"}' id=\"EtcPackageManager\" onclick=\"javascript:packageManager('4','EtcPackageManager')\">기타 파일</li>");
		if(up.isFUNCTION_SOLUTION_UPLOAD_ORDER_COMPANY()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-leaf\"}' id=\"orderCompanyList\" onclick=\"javascript:page('orderCompanyList')\">수주사 관리</li>");
		if(up.isFUNCTION_SOLUTION_UPLOAD_CUSTOM_USER()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-user\"}' id=\"customUser\" onclick=\"javascript:page('customUser')\">커스텀(어드민) 유져</li>");
		sb.append("</ul></li>");
		return sb;
	}
	
	public StringBuffer getMenuManagement(StringBuffer sb, UserPermission up){
		sb.append("<li>고객관리<ul>");
		if(up.isSUB_MENU_MANAGEMENT_COMPLETE()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-user\"}' id=\"management\" onclick=\"javascript:page('management')\">완료 계약건</li>");
		if(up.isSUB_MENU_MANAGEMENT_PROGRESS()) sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-user\"}' id=\"progress\" onclick=\"javascript:page('progress')\">진행중 계약건</li>");
		sb.append("</ul></li>");
		return sb;
	}

	public StringBuffer getMenuCustomBoard(StringBuffer sb, UserPermission up, List<Map<String,Object>> list){
		sb.append("<li>자료실<ul>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-asterisk\"}' id=\"morgue\" onclick=\"javascript:page('morgue')\">관리</li>");
		
		if(list!=null && list.size()>0 ) {
			for( Map<String,Object> map: list ){
				sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-file\"}' id=\""+map.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+map.get("BOARD_ID")+"')\">"+map.get("BOARD_NAME")+"</li>");				
			}
		}
		sb.append("</ul></li>");
		return sb;
	}
	
	public StringBuffer getMenuCustomBoardAdmin(StringBuffer sb, UserPermission up, List<Map<String,Object>> list){
		sb.append("<li>자료실<ul>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-asterisk\"}' id=\"morgue\" onclick=\"javascript:page('morgue')\">관리</li>");
		
		if(list!=null && list.size()>0 ) {
			for( Map<String,Object> map: list ){
				sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-file\"}' id=\""+map.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+map.get("BOARD_ID")+"')\">"+map.get("BOARD_NAME")+"</li>");				
			}
		}
		
		list = morgueDao.getAllAdminUserCustomBoardList();
		if(list!=null && list.size()>0 ) {
			ArrayList<String> user = new ArrayList<String>();
			sb.append("<li>솔루션 어드민<ul>");
			for( Map<String,Object> boardList1: list ){
				if( confirmKey(user,(String)boardList1.get("USER_NO")) ){
					user.add((String)boardList1.get("USER_NO"));
					sb.append("<li>"+boardList1.get("USER_NO")+"<ul>");
					for( Map<String,Object> boardList2: list ){
						if(boardList1.get("USER_NO").equals(boardList2.get("USER_NO"))){
							sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-file\"}' id=\""+boardList2.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+boardList2.get("BOARD_ID")+"')\">"+boardList2.get("BOARD_NAME")+"</li>");
						}
					}
					sb.append("</ul></li>");
				}
			}
			sb.append("</ul></li>");			
		}
		
		
		sb.append("</ul></li>");
		return sb;
	}
	
	
	public String getProjectFolderTree( String rootId, CustomUserDetails userDetails ){
		List<Map<String, Object>> list = morgueDao.getProjectFolders(rootId);
		List<Map<String, Object>> boardList = morgueDao.getProjectBoard(Consts.PROJECT_ROOT_ID);
		String temp = "";
		
		ArrayList<String> lev1 = new ArrayList<String>();
		ArrayList<String> lev2 = new ArrayList<String>();
		
		if( list!=null && list.size()>0 ){
			for( Map<String, Object> ma: list ){
				if(ma.get("lev1_up").equals(rootId)) {
					if(confirmKey(lev1,(String)ma.get("lev1"))  && ma.get("lev1_DELETED_DATE")==null){
						lev1.add((String)ma.get("lev1"));
						temp+="<li>"+ma.get("lev1Name");
						
							for( Map<String, Object> ma2: list ){
								if( ma2.get("lev2_up")!=null && ma2.get("lev1").equals(ma.get("lev2_up")) ){
									// temp+="<ul>"; 
									if(confirmKey(lev2,(String)ma2.get("lev2"))  && ma2.get("lev2_DELETED_DATE")==null){
										temp+="<ul>"; // 수정
										lev2.add((String)ma2.get("lev2"));
										if(ma2.get("lev2Name")!=null) {
											temp+="<li>"+ma2.get("lev2Name");
											
											if(  ma2.get("lev3_up")!=null && ma2.get("lev2").equals(ma2.get("lev3_up")) ){
												temp+="<ul>";
												for( Map<String, Object> ma3: list ){
													if(ma3.get("lev3Name")!=null && ma3.get("lev3_up").equals(ma2.get("lev2")) && ma3.get("lev3_DELETED_DATE")==null) {
														temp+="<li>"+ma3.get("lev3Name")
															+setProjectBoard( (String)ma3.get("lev3"), boardList, userDetails )
															+"</li>";
													}
												}
												temp+="</ul>";
											}
											temp+=setProjectBoard( (String)ma2.get("lev2"), boardList, userDetails );
											temp+="</li>";
										}
										temp+="</ul>"; // 수정
									}
									//temp+="</ul>";
								}	
							}
							temp+=setProjectBoard( (String)ma.get("lev1"), boardList, userDetails );
						temp+="</li>";
					}						
				}
			}
		}
		temp+=setProjectBoard( rootId, boardList, userDetails );
		return temp;
	}
	
	public String getDefaultProjectFolderTree( String rootId, CustomUserDetails userDetails ){
		List<Map<String, Object>> list = morgueDao.getProjectFolders(rootId);
		List<Map<String, Object>> boardList = morgueDao.getProjectBoard(Consts.PROJECT_ROOT_ID);
		String temp = "";
		
		ArrayList<String> lev1 = new ArrayList<String>();
		ArrayList<String> lev2 = new ArrayList<String>();
		
		if( (list!=null && list.size()>0) || (boardList!=null && boardList.size()>0) ){
			temp+="<ul>";
			for( Map<String, Object> ma: list ){
				if(ma.get("lev1_up").equals(rootId)) {
					if(confirmKey(lev1,(String)ma.get("lev1")) && ma.get("lev1_DELETED_DATE")==null){
						lev1.add((String)ma.get("lev1"));
						temp+="<li><span class=\"glyphicon glyphicon-folder-open\"></span>&nbsp;&nbsp;"+ma.get("lev1Name")
								+"&nbsp;&nbsp;"
								+"<div class=\"btn-group btn-group-xs\">"
								+"<button type=\"button\" class=\"btn btn-warning dropdown-toggle\" data-toggle=\"dropdown\">"
								+"관리<span class=\"caret\"></span></button>"
								+"<ul class=\"dropdown-menu\">"
								+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('F','"+ma.get("lev1")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">이안에 폴더 생성</a></li>"
								+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('B','"+ma.get("lev1")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">이안에 게시판 생성</a></li>"
								+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('EF','"+ma.get("lev1")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">폴더명 변경</a></li>"
								+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('DF','"+ma.get("lev1")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">폴더 삭제</a></li>"
								+"</ul></div>";
						
							for( Map<String, Object> ma2: list ) {
								if( ma2.get("lev2_up")!=null && ma2.get("lev1").equals(ma.get("lev2_up")) ){
									temp+="<ul>";
									if(confirmKey(lev2,(String)ma2.get("lev2")) && ma2.get("lev2_DELETED_DATE")==null) {
										lev2.add((String)ma2.get("lev2"));
										if(ma2.get("lev2Name")!=null) {
											temp+="<li><span class=\"glyphicon glyphicon-folder-open\" style=\"color: gray;\"></span>&nbsp;&nbsp;"+ma2.get("lev2Name")
													+"&nbsp;&nbsp;"
													+"<div class=\"btn-group btn-group-xs\">"
													+"<button type=\"button\" class=\"btn btn-warning dropdown-toggle\" data-toggle=\"dropdown\">"
													+"관리<span class=\"caret\"></span></button>"
													+"<ul class=\"dropdown-menu\">"
													+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('F','"+ma2.get("lev2")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">이안에 폴더 생성</a></li>"
													+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('B','"+ma2.get("lev2")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">이안에 게시판 생성</a></li>"
													+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('EF','"+ma2.get("lev2")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">폴더명 변경</a></li>"
													+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('DF','"+ma2.get("lev2")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">폴더 삭제</a></li>"
													+"</ul></div>";
											
											if(  ma2.get("lev3_up")!=null && ma2.get("lev2").equals(ma2.get("lev3_up"))){
												temp+="<ul>";
												for( Map<String, Object> ma3: list ){
													if(ma3.get("lev3Name")!=null && ma3.get("lev3_up").equals(ma2.get("lev2")) && ma3.get("lev3_DELETED_DATE")==null) {
														temp+="<li><span class=\"glyphicon glyphicon-folder-open\" style=\"color: silver;\"></span>&nbsp;&nbsp;"+ma3.get("lev3Name")
																+"&nbsp;&nbsp;"
																+"<div class=\"btn-group btn-group-xs\">"
																+"<button type=\"button\" class=\"btn btn-warning dropdown-toggle\" data-toggle=\"dropdown\">"
																+"관리<span class=\"caret\"></span></button>"
																+"<ul class=\"dropdown-menu\">"
																+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('B','"+ma3.get("lev3")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">이안에 게시판 생성</a></li>"
																+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('EF','"+ma3.get("lev3")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">폴더명 변경</a></li>"
																+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('DF','"+ma3.get("lev3")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">폴더 삭제</a></li>"
																+"</ul></div>"
																+setDefaultProjectBoard( (String)ma3.get("lev3"), boardList, userDetails )
																+"</li>";
													}
												}
												temp+="</ul>";
											}
											
											temp+=setDefaultProjectBoard( (String)ma2.get("lev2"), boardList, userDetails );
											temp+="</li>";
										}
									}
									temp+="</ul>";
								}	
							}
							temp+=setDefaultProjectBoard( (String)ma.get("lev1"), boardList, userDetails );
						temp+="</li>";
					}						
				}
			}
			temp+=setDefaultProjectBoard( rootId, boardList, userDetails );
			temp+="</ul>";
		}
		return temp;
	}
	
	public String setDefaultProjectBoard( String folderId, List<Map<String, Object>> boardList, CustomUserDetails userDetails ){
		String temp="";
		boolean secretmode = true;
		if(boardList!=null && boardList.size()>0){
			for( Map<String, Object> map: boardList ){
				if( map.get("FOLDER_ID").equals(folderId) ){
					secretmode = true;
					for(String secretBoard: Consts.POSBEE_SECRET_BOARD){
						if(map.get("BOARD_ID").equals(secretBoard) && !userDetails.getUserNo().equals("posbee")
								&& !userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)){
							secretmode=false;
						}
					}
					
					if(secretmode){
						if(!folderId.equals(Consts.PROJECT_GLUE_ROOT_ID) && !folderId.equals(Consts.PROJECT_GLUEMASTER_ROOT_ID)
								&& !folderId.equals(Consts.PROJECT_GLUEMOBILE_ROOT_ID)
								&& !folderId.equals(Consts.PROJECT_UCUBE_ROOT_ID)
								&& !folderId.equals(Consts.PROJECT_POSBEE_ROOT_ID)) temp+="<ul>";
						temp+="<li><span class=\"glyphicon glyphicon-list\"></span>&nbsp;&nbsp;"+map.get("BOARD_NAME")
								+"&nbsp;&nbsp;"
								+"<div class=\"btn-group btn-group-xs\">"
								+"<button type=\"button\" class=\"btn btn-warning dropdown-toggle\" data-toggle=\"dropdown\">"
								+"관리<span class=\"caret\"></span></button>"
								+"<ul class=\"dropdown-menu\">"
								+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('EB','"+map.get("BOARD_ID")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">게시판명 변경</a></li>"
								+"<li><a href=\"#\" onclick=\"javascript:createProjectFun('DB','"+map.get("BOARD_ID")+"')\" data-toggle=\"modal\" data-target=\"#projectFolderModal\">게시판 삭제</a></li>"
								+"</ul></div>";
						if(!folderId.equals(Consts.PROJECT_GLUE_ROOT_ID) && !folderId.equals(Consts.PROJECT_GLUEMASTER_ROOT_ID)
								&& !folderId.equals(Consts.PROJECT_GLUEMOBILE_ROOT_ID)
								&& !folderId.equals(Consts.PROJECT_UCUBE_ROOT_ID)
								&& !folderId.equals(Consts.PROJECT_POSBEE_ROOT_ID)) temp+="</ul>";
					}
				}
				
			}
		}
		
		return temp;
	}
	
	public String setProjectBoard( String folderId, List<Map<String, Object>> boardList ){
		String temp="";
		if(boardList!=null && boardList.size()>0){
			for( Map<String, Object> map: boardList ){
				if( map.get("FOLDER_ID").equals(folderId) ){
					if(!folderId.equals(Consts.PROJECT_GLUE_ROOT_ID) && !folderId.equals(Consts.PROJECT_GLUEMASTER_ROOT_ID)
							&& !folderId.equals(Consts.PROJECT_GLUEMOBILE_ROOT_ID)
							&& !folderId.equals(Consts.PROJECT_UCUBE_ROOT_ID)
							&& !folderId.equals(Consts.PROJECT_POSBEE_ROOT_ID)) temp+="<ul>";
					temp+="<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\""+map.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+map.get("BOARD_ID")+"')\">"+map.get("BOARD_NAME")+"</li>";
					if(!folderId.equals(Consts.PROJECT_GLUE_ROOT_ID) && !folderId.equals(Consts.PROJECT_GLUEMASTER_ROOT_ID)
							&& !folderId.equals(Consts.PROJECT_GLUEMOBILE_ROOT_ID)
							&& !folderId.equals(Consts.PROJECT_UCUBE_ROOT_ID)
							&& !folderId.equals(Consts.PROJECT_POSBEE_ROOT_ID)) temp+="</ul>";
				}
			}
		}
		
		return temp;
	}
	
	public String setProjectBoard( String folderId, List<Map<String, Object>> boardList, CustomUserDetails userDetails ){
		String temp="";
		boolean secretmode = true;
		if(boardList!=null && boardList.size()>0){
			for( Map<String, Object> map: boardList ){
				secretmode = true;
				for(String secretBoard: Consts.POSBEE_SECRET_BOARD){
					if(map.get("BOARD_ID").equals(secretBoard) && !userDetails.getUserNo().equals("posbee")
							&& !userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)){
						secretmode=false;
					}
				}
				
				if(secretmode){
					if( map.get("FOLDER_ID").equals(folderId) ){
						temp+="<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\""+map.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+map.get("BOARD_ID")+"')\">"+map.get("BOARD_NAME")+"</li>";
					}
				}
			}
		}
		
		if(!folderId.equals(Consts.PROJECT_GLUE_ROOT_ID) && !folderId.equals(Consts.PROJECT_GLUEMASTER_ROOT_ID)
				&& !folderId.equals(Consts.PROJECT_GLUEMOBILE_ROOT_ID)
				&& !folderId.equals(Consts.PROJECT_UCUBE_ROOT_ID)
				&& !folderId.equals(Consts.PROJECT_POSBEE_ROOT_ID)
				&& temp!="") temp = "<ul>"+temp+"</ul>";
		
		return temp;
	}
}
