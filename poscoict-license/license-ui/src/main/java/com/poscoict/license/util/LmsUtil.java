package com.poscoict.license.util;

import java.security.PrivateKey;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.Cipher;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
	
	private Logger logger = LoggerFactory.getLogger(getClass());

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
		// 17.01.11(수), 소스 추가
		// Glue Mobile 신규 솔루션으로 추가할 때, 패키지 저장하는 file path 누락하였음
		// 결론 : 새로 file path 지정 후 추가 조치
		if(folder.equals("GlueMobile")){
			path = Consts.GLUE_MOBILE_FILE_HOME;
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

		// 자료실 비공개
//		if(up.isMENU_CUSTOMBOARD()) {
//			if(userDetails.getAuthorities().toString().contains(Consts.rolePrefix+Consts.USERLV_ADMIN)){
//				List<Map<String,Object>> list = morgueDao.getUerCustomBoardList( userDetails.getUserNo() );
//				sb = getMenuCustomBoardAdmin(sb,up,list);
//			}else{
//				List<Map<String,Object>> list = morgueDao.getUerCustomBoardList( userDetails.getUserNo() );
//				sb = getMenuCustomBoard(sb,up,list);
//			}
//		}

		return sb;
	}

	public StringBuffer initializeNavMenu(StringBuffer sb, UserPermission up, CustomUserDetails userDetails) {
		sb = getNavMenuNotice(sb);
		if(up.isMENU_GLUE()) sb = getNavMenuGlue(sb,up,userDetails);
		if(up.isMENU_GLUEMASTER()) sb = getNavMenuGlueMaster(sb,up,userDetails);
		if(up.isMENU_GLUEMOBILE()) sb = getNavMenuGlueMobile(sb,up,userDetails);
		if(up.isMENU_UCUBE()) sb = getNavMenuUCube(sb,up,userDetails);
		if(up.isMENU_POSBEE()) sb = getNavMenuPosBee(sb,up,userDetails);
		if(up.isMENU_PRESENTATION()) sb = getNavMenuPresentation(sb);

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
		sb.append("<li>");
		sb.append("<div class=\"collapsible-header\" id=\"notice\" onclick=\"javascript:boardList('notice','NOTICE','notice'); return false;\"><i class=\"material-icons\" id=\"notice\">format_bold</i>공지사항</div>");
        sb.append("</li>");
		return sb;
	}

	public StringBuffer getNavMenuNotice(StringBuffer sb){
		sb.append("<div class=\"divider hide-on-med-and-up\"></div>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"Navnotice\" onclick=\"javascript:boardList('notice','NOTICE','notice'); return false;\"><i class=\"material-icons left\" id=\"Navnotice\">format_bold</i>전체 공지사항</a></li>");
		return sb;
	}

	public StringBuffer getMenuGlue(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
        sb.append("<li>");
		sb.append("<div class=\"collapsible-header\" id=\"Glue\"><i class=\"material-icons\" id=\"Glue\">menu</i>Glue</div>");
		sb.append("<div class=\"collapsible-body\">");
		sb.append("<div class=\"collection\">");
		sb.append("<a href=\"#\" id=\"GlueNotice\" onclick=\"javascript:boardList('notice','GLUE','GlueNotice')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueNotice\">announcement</i>공지사항</a>");
		sb.append("<a href=\"#\" id=\"GlueQna\" onclick=\"javascript:boardList('qna','GLUE','GlueQna')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueQna\">question_answer</i>Q&amp;A</a>");
		sb.append("<a href=\"#\" id=\"GlueFaq\" onclick=\"javascript:boardList('faq','GLUE','GlueFaq')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueFaq\">help_outline</i>FAQ</a>");
		sb.append("<a href=\"#\" id=\"GlueTech\" onclick=\"javascript:boardList('technical','GLUE','GlueTech')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueTech\">library_books</i>기술문서</a>");
		sb.append("<a href=\"#\" id=\"GlueOldTech\" onclick=\"javascript:boardList('oldtechnical','GLUE','GlueOldTech')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueOldTech\">library_books</i>기술문서(예전)</a>");
		if(up.isFUNCTION_GLUE_ADMIN()) sb.append("<a href=\"#\" id=\"GlueManager\" onclick=\"javascript:projectManagement('GLUE','GlueManager')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueManager\">supervisor_account</i>관리</a>");
		 if(up.isFUNCTION_GLUE_ADMIN()) sb.append( getProjectFolderTree(Consts.PROJECT_GLUE_ROOT_ID, userDetails) );
		sb.append("</div></div>");
        sb.append("</li>");

		return sb;
	}

	public StringBuffer getNavMenuGlue(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
		sb.append("<div class=\"divider hide-on-med-and-up\"></div>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueNavNotice\" onclick=\"javascript:boardList('notice','GLUE','GlueNotice')\"><i class=\"material-icons left\" id=\"NavGlueNavNotice\">announcement</i>Glue 공지사항</a></li>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueQna\" onclick=\"javascript:boardList('qna','GLUE','GlueQna')\"><i class=\"material-icons left\" id=\"NavGlueQna\">question_answer</i>Glue Q&amp;A</a></li>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueFaq\" onclick=\"javascript:boardList('faq','GLUE','GlueFaq')\"><i class=\"material-icons left\" id=\"NavGlueFaq\">help_outline</i>Glue FAQ</a></li>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueTech\" onclick=\"javascript:boardList('technical','GLUE','GlueTech')\"><i class=\"material-icons left\" id=\"NavGlueTech\">library_books</i>Glue 기술문서</a></li>");

		return sb;
	}


	public StringBuffer getMenuGlueMaster(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
        sb.append("<li>");
		sb.append("<div class=\"collapsible-header\" id=\"GlueMaster\"><i class=\"material-icons\" id=\"GlueMaster\">menu</i>Glue Master</div>");
		sb.append("<div class=\"collapsible-body\">");
		sb.append("<div class=\"collection\">");
		sb.append("<a href=\"#\" id=\"GlueMasterNotice\" onclick=\"javascript:boardList('notice','GLUEMASTER','GlueMasterNotice')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueMasterNotice\">announcement</i>공지사항</a>");
		sb.append("<a href=\"#\" id=\"GlueMasterQna\" onclick=\"javascript:boardList('qna','GLUEMASTER','GlueMasterQna')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueMasterQna\">question_answer</i>Q&amp;A</a>");
		sb.append("<a href=\"#\" id=\"GlueMasterFaq\" onclick=\"javascript:boardList('faq','GLUEMASTER','GlueMasterFaq')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueMasterFaq\">help_outline</i>FAQ</a>");
		sb.append("<a href=\"#\" id=\"GlueMasterTech\" onclick=\"javascript:boardList('technical','GLUEMASTER','GlueMasterTech')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueMasterTech\">library_books</i>기술문서</a>");
        if(up.isFUNCTION_GLUEMASTER_ADMIN()) sb.append("<a href=\"#\" id=\"GlueMasterManager\" onclick=\"javascript:projectManagement('GLUEMASTER','GlueMasterManager')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueMasterManager\">supervisor_account</i>관리</a>");
         if(up.isFUNCTION_GLUEMASTER_ADMIN()) sb.append( getProjectFolderTree(Consts.PROJECT_GLUEMASTER_ROOT_ID, userDetails) );
        sb.append("</div></div>");
        sb.append("</li>");

		return sb;
	}

	public StringBuffer getNavMenuGlueMaster(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
        sb.append("<div class=\"divider hide-on-med-and-up\"></div>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueMasterNotice\" onclick=\"javascript:boardList('notice','GLUEMASTER','GlueMasterNotice')\"><i class=\"material-icons left\" id=\"NavGlueMasterNotice\">announcement</i>GlueMaster 공지사항</a></li>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueMasterQna\" onclick=\"javascript:boardList('qna','GLUEMASTER','GlueMasterQna')\"><i class=\"material-icons left\" id=\"NavGlueMasterQna\">question_answer</i>GlueMaster Q&amp;A</a></li>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueMasterFaq\" onclick=\"javascript:boardList('faq','GLUEMASTER','GlueMasterFaq')\"><i class=\"material-icons left\" id=\"NavGlueMasterFaq\">help_outline</i>GlueMaster FAQ</a></li>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueMasterTech\" onclick=\"javascript:boardList('technical','GLUEMASTER','GlueMasterTech')\"><i class=\"material-icons left\" id=\"NavGlueMasterTech\">library_books</i>GlueMaster 기술문서</a></li>");

		return sb;
	}

	public StringBuffer getMenuGlueMobile(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
//        sb.append("<li id=\"GMO\">");
		sb.append("<li>");
        sb.append("<div class=\"collapsible-header\" id=\"GlueMobile\"><i class=\"material-icons\" id=\"GlueMobile\">menu</i>Glue Mobile</div>");
		sb.append("<div class=\"collapsible-body\">");
		sb.append("<div class=\"collection\">");
		sb.append("<a href=\"#\" id=\"GlueMobileNotice\" onclick=\"javascript:boardList('notice','GLUEMOBILE','GlueMobileNotice')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueMobileNotice\">announcement</i>공지사항</a>");
		sb.append("<a href=\"#\" id=\"GlueMobileQna\" onclick=\"javascript:boardList('qna','GLUEMOBILE','GlueMobileQna')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueMobileQna\">question_answer</i>Q&amp;A</a>");
		sb.append("<a href=\"#\" id=\"GlueMobileFaq\" onclick=\"javascript:boardList('faq','GLUEMOBILE','GlueMobileFaq')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueMobileFaq\">help_outline</i>FAQ</a>");
		sb.append("<a href=\"#\" id=\"GlueMobileTech\" onclick=\"javascript:boardList('technical','GLUEMOBILE','GlueMobileTech')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueMobileTech\">library_books</i>기술문서</a>");
        if(up.isFUNCTION_GLUEMOBILE_ADMIN()) sb.append("<a href=\"#\" id=\"GlueMobileManager\" onclick=\"javascript:projectManagement('GLUEMOBILE','GlueMobileManager')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"GlueMobileManager\">supervisor_account</i>관리</a>");
        if(up.isFUNCTION_GLUEMOBILE_ADMIN()) sb.append( getProjectFolderTree(Consts.PROJECT_GLUEMOBILE_ROOT_ID, userDetails) );
        sb.append("</div></div>");
        sb.append("</li>");

		return sb;
	}

	public StringBuffer getNavMenuGlueMobile(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
        sb.append("<div class=\"divider hide-on-med-and-up\"></div>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueMobileNotice\" onclick=\"javascript:boardList('notice','GLUEMOBILE','GlueMobileNotice')\"><i class=\"material-icons left\" id=\"NavGlueMobileNotice\">announcement</i>GlueMobile 공지사항</a></li>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueMobileQna\" onclick=\"javascript:boardList('qna','GLUEMOBILE','GlueMobileQna')\"><i class=\"material-icons left\" id=\"NavGlueMobileQna\">question_answer</i>GlueMobile Q&amp;A</a></li>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueMobileFaq\" onclick=\"javascript:boardList('faq','GLUEMOBILE','GlueMobileFaq')\"><i class=\"material-icons left\" id=\"NavGlueMobileFaq\">help_outline</i>GlueMobile FAQ</a></li>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavGlueMobileTech\" onclick=\"javascript:boardList('technical','GLUEMOBILE','GlueMobileTech')\"><i class=\"material-icons left\" id=\"NavGlueMobileTech\">library_books</i>GlueMobile 기술문서</a></li>");

		return sb;
	}

	public StringBuffer getMenuUCube(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
        sb.append("<li>");
        sb.append("<div class=\"collapsible-header\" id=\"uCUBE\"><i class=\"material-icons\" id=\"uCUBE\">menu</i>uCUBE</div>");
        sb.append("<div class=\"collapsible-body\">");
        sb.append("<div class=\"collection\">");
        sb.append("<a href=\"#\" id=\"uCUBENotice\" onclick=\"javascript:boardList('notice','UCUBE','uCUBENotice')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"uCUBENotice\">announcement</i>공지사항</a>");
        sb.append("<a href=\"#\" id=\"uCUBEQna\" onclick=\"javascript:boardList('qna','UCUBE','uCUBEQna')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"uCUBEQna\">question_answer</i>Q&amp;A</a>");
        sb.append("<a href=\"#\" id=\"uCUBEFaq\" onclick=\"javascript:boardList('faq','UCUBE','uCUBEFaq')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"uCUBEFaq\">help_outline</i>FAQ</a>");
        sb.append("<a href=\"#\" id=\"uCUBETech\" onclick=\"javascript:boardList('technical','UCUBE','uCUBETech')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"uCUBETech\">library_books</i>기술문서</a>");
        if(up.isFUNCTION_UCUBE_ADMIN()) sb.append("<a href=\"#\" id=\"uCUBEManager\" onclick=\"javascript:projectManagement('UCUBE','uCUBEManager')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"uCUBEManager\">supervisor_account</i>관리</a>");
         if(up.isFUNCTION_UCUBE_ADMIN()) sb.append( getProjectFolderTree(Consts.PROJECT_UCUBE_ROOT_ID, userDetails) );
        sb.append("</div></div>");
        sb.append("</li>");

		return sb;
	}

	public StringBuffer getNavMenuUCube(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
        sb.append("<div class=\"divider hide-on-med-and-up\"></div>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavuCUBENotice\" onclick=\"javascript:boardList('notice','UCUBE','uCUBENotice')\"><i class=\"material-icons left\" id=\"NavuCUBENotice\">announcement</i>uCUBE 공지사항</a></li>");
        sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavuCUBEQna\" onclick=\"javascript:boardList('qna','UCUBE','uCUBEQna')\"><i class=\"material-icons left\" id=\"NavuCUBEQna\">question_answer</i>uCUBE Q&amp;A</a></li>");
        sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavuCUBEFaq\" onclick=\"javascript:boardList('faq','UCUBE','uCUBEFaq')\"><i class=\"material-icons left\" id=\"NavuCUBEFaq\">help_outline</i>uCUBE FAQ</a></li>");
        sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavuCUBETech\" onclick=\"javascript:boardList('technical','UCUBE','uCUBETech')\"><i class=\"material-icons left\" id=\"NavuCUBETech\">library_books</i>uCUBE 기술문서</a></li>");

		return sb;
	}

	public StringBuffer getMenuPosBee(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
        sb.append("<li>");
        sb.append("<div class=\"collapsible-header\" id=\"PosBee\"><i class=\"material-icons\" id=\"PosBee\">menu</i>PosBee</div>");
        sb.append("<div class=\"collapsible-body\">");
        sb.append("<div class=\"collection\">");
        sb.append("<a href=\"#\" id=\"PosBeeNotice\" onclick=\"javascript:boardList('notice','POSBEE','PosBeeNotice')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"PosBeeNotice\">announcement</i>공지사항</a>");
        sb.append("<a href=\"#\" id=\"PosBeeQna\" onclick=\"javascript:boardList('qna','POSBEE','PosBeeQna')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"PosBeeQna\">question_answer</i>Q&amp;A</a>");
        sb.append("<a href=\"#\" id=\"PosBeeFaq\" onclick=\"javascript:boardList('faq','POSBEE','PosBeeFaq')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"PosBeeFaq\">help_outline</i>FAQ</a>");
        sb.append("<a href=\"#\" id=\"PosBeeTech\" onclick=\"javascript:boardList('technical','POSBEE','PosBeeTech')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"PosBeeTech\">library_books</i>기술문서</a>");
        if(up.isFUNCTION_POSBEE_ADMIN()) sb.append("<a href=\"#\" id=\"PosBeeManager\" onclick=\"javascript:projectManagement('POSBEE','PosBeeManager')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"PosBeeManager\">supervisor_account</i>관리</a>");
         if(up.isFUNCTION_POSBEE_ADMIN()) sb.append( getProjectFolderTree(Consts.PROJECT_POSBEE_ROOT_ID, userDetails) );
        sb.append("</div></div>");
        sb.append("</li>");

		return sb;
	}

	public StringBuffer getNavMenuPosBee(StringBuffer sb, UserPermission up,CustomUserDetails userDetails){
        sb.append("<div class=\"divider hide-on-med-and-up\"></div>");
        sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavPosBeeNotice\" onclick=\"javascript:boardList('notice','POSBEE','PosBeeNotice')\"><i class=\"material-icons left\" id=\"NavPosBeeNotice\">announcement</i>PosBee 공지사항</a></li>");
        sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavPosBeeQna\" onclick=\"javascript:boardList('qna','POSBEE','PosBeeQna')\"><i class=\"material-icons left\" id=\"NavPosBeeQna\">question_answer</i>PosBee Q&amp;A</a></li>");
        sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavPosBeeFaq\" onclick=\"javascript:boardList('faq','POSBEE','PosBeeFaq')\"><i class=\"material-icons left\" id=\"NavPosBeeFaq\">help_outline</i>PosBee FAQ</a></li>");
        sb.append("<li class=\"hide-on-med-and-up\"><a id=\"NavPosBeeTech\" onclick=\"javascript:boardList('technical','POSBEE','PosBeeTech')\"><i class=\"material-icons left\" id=\"NavPosBeeTech\">library_books</i>PosBee 기술문서</a></li>");

		return sb;
	}

	public StringBuffer getMenuEducationSolution(StringBuffer sb){
        sb.append("<li>");
		sb.append("<div class=\"collapsible-header\" id=\"sdkDownload\" onclick=\"javascript:page('sdkDownload')\"><i class=\"material-icons\" id=\"sdkDownload\">save</i>교육용 패키지</div>");
        sb.append("</li>");
		return sb;
	}

	public StringBuffer getMenuSolutionPackage(StringBuffer sb){
        sb.append("<li>");
		sb.append("<div class=\"collapsible-header\" id=\"certificateDownload\" onclick=\"javascript:page('certificateDownload')\"><i class=\"material-icons\">filter_drama</i>솔루션 패키지</div>");
        sb.append("</li>");
		return sb;
	}

	public StringBuffer getMenuPresentation(StringBuffer sb){
        sb.append("<li>");
        sb.append("<div class=\"collapsible-header\" id=\"presentation\" onclick=\"javascript:page('presentation')\"><i class=\"material-icons\" id=\"presentation\">style</i>제품소개</div>");
        sb.append("</li>");
		return sb;
	}

	public StringBuffer getNavMenuPresentation(StringBuffer sb){
        sb.append("<div class=\"divider hide-on-med-and-up\"></div>");
		sb.append("<li class=\"hide-on-med-and-up\"><a id=\"Navpresentation\" onclick=\"javascript:page('presentation')\"><i class=\"material-icons left\" id=\"Navpresentation\">style</i>제품소개</a></li>");
		return sb;
	}

	public StringBuffer getMenuSolutionUpload(StringBuffer sb, UserPermission up){
        sb.append("<li>");
        sb.append("<div class=\"collapsible-header\" id=\"Sol\"><i class=\"material-icons\" id=\"Sol\">menu</i>솔루션 패키지</div>");
        sb.append("<div class=\"collapsible-body\">");
        sb.append("<div class=\"collection\">");
        if(up.isFUNCTION_SOLUTION_UPLOAD_GLUE()) sb.append("<a href=\"#\" id=\"SolGluePackageManager\" onclick=\"javascript:packageManager('2','GluePackageManager')\" class=\"collection-item\"><i class=\"material-icons left\">filter_1</i>Glue</a>");
        if(up.isFUNCTION_SOLUTION_UPLOAD_GLUEMASTER()) sb.append("<a href=\"#\" id=\"SolGlueMasterPackageManager\" onclick=\"javascript:packageManager('1','GlueMasterPackageManager')\" class=\"collection-item\"><i class=\"material-icons left\">filter_2</i>GlueMaster</a>");
        if(up.isFUNCTION_SOLUTION_UPLOAD_GLUEMOBILE()) sb.append("<a href=\"#\" id=\"SolGlueMobilePackageManager\" onclick=\"javascript:packageManager('5','GlueMobilePackageManager')\" class=\"collection-item\"><i class=\"material-icons left\">filter_3</i>GlueMobile</a>");
        if(up.isFUNCTION_SOLUTION_UPLOAD_UCUBE()) sb.append("<a href=\"#\" id=\"SoluCUBEPackageManager\" onclick=\"javascript:packageManager('0','uCUBEPackageManager')\" class=\"collection-item\"><i class=\"material-icons left\">filter_4</i>uCUBE</a>");
        if(up.isFUNCTION_SOLUTION_UPLOAD_POSBEE()) sb.append("<a href=\"#\" id=\"SolPosBeePackageManager\" onclick=\"javascript:packageManager('3','PosBeePackageManager')\" class=\"collection-item\"><i class=\"material-icons left\">filter_5</i>PosBee</a>");
        if(up.isFUNCTION_SOLUTION_UPLOAD_ETC()) sb.append("<a href=\"#\" id=\"SolEtcPackageManager\" onclick=\"javascript:packageManager('4','EtcPackageManager')\" class=\"collection-item\"><i class=\"material-icons left\">explicit</i>기타 파일</a>");
        if(up.isFUNCTION_SOLUTION_UPLOAD_ORDER_COMPANY()) sb.append("<a href=\"#\" id=\"SolorderCompanyList\" onclick=\"javascript:page('orderCompanyList')\" class=\"collection-item\"><i class=\"material-icons left\">domain</i>수주사 관리</a>");
        if(up.isFUNCTION_SOLUTION_UPLOAD_CUSTOM_USER()) sb.append("<a href=\"#\" id=\"SolcustomUser\" onclick=\"javascript:page('customUser')\" class=\"collection-item\"><i class=\"material-icons left\">perm_identity</i>커스텀(어드민) 유져</a>");
        sb.append("</div></div>");
        sb.append("</li>");

		return sb;
	}

	public StringBuffer getMenuManagement(StringBuffer sb, UserPermission up){
		sb.append("<li>");
        sb.append("<div class=\"collapsible-header\" id=\"ClientMng\"><i class=\"material-icons\" id=\"ClientMng\">menu</i>고객관리</div>");
        sb.append("<div class=\"collapsible-body\">");
        sb.append("<div class=\"collection\">");
        if(up.isSUB_MENU_MANAGEMENT_COMPLETE()) sb.append("<a href=\"#\" id=\"ClientMngmanagement\" onclick=\"javascript:page('management')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"ClientMngmanagement\">content_paste</i>완료 계약건</a>");
        if(up.isSUB_MENU_MANAGEMENT_PROGRESS()) sb.append("<a href=\"#\" id=\"ClientMngprogress\" onclick=\"javascript:page('progress')\" class=\"collection-item\"><i class=\"material-icons left\" id=\"ClientMngprogress\">next_week</i>진행중 계약건</a>");
        sb.append("</div></div>");
        sb.append("</li>");
		return sb;
	}

	public StringBuffer getMenuCustomBoard(StringBuffer sb, UserPermission up, List<Map<String,Object>> list){
		sb.append("<li>");
        sb.append("<div class=\"collapsible-header\" id=\"CusMan\"><i class=\"material-icons\" id=\"CusMan\">menu</i>고객관리</div>");
		sb.append("<li>자료실<ul>");
		sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-asterisk\"}' id=\"morgue\" onclick=\"javascript:page('morgue')\">관리</li>");

		if(list!=null && list.size()>0 ) {
			for( Map<String,Object> map: list ){
//				sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-file\"}' id=\""+map.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+map.get("BOARD_ID")+"')\">"+map.get("BOARD_NAME")+"</li>");
				sb.append("<a href=\"#\" id=\""+map.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+map.get("BOARD_ID")+"')\" class=\"collection-item\"><i class=\"material-icons left\">details</i>"+map.get("BOARD_NAME")+"</a>");
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
//				sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-file\"}' id=\""+map.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+map.get("BOARD_ID")+"')\">"+map.get("BOARD_NAME")+"</li>");
				sb.append("<a href=\"#\" id=\""+map.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+map.get("BOARD_ID")+"')\" class=\"collection-item\"><i class=\"material-icons left\">cloud</i>"+map.get("BOARD_NAME")+"</a>");
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
//							sb.append("<li data-jstree='{\"icon\":\"glyphicon glyphicon-file\"}' id=\""+boardList2.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+boardList2.get("BOARD_ID")+"')\">"+boardList2.get("BOARD_NAME")+"</li>");
							sb.append("<a href=\"#\" id=\""+boardList2.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+boardList2.get("BOARD_ID")+"')\" class=\"collection-item\"><i class=\"material-icons left\">details</i>"+boardList2.get("BOARD_NAME")+"</a>");
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


	// Main Page 좌측 Tree 구성 메서드
	public String getProjectFolderTree( String rootId, CustomUserDetails userDetails ){
		List<Map<String, Object>> boardList = morgueDao.getProjectBoard(Consts.PROJECT_ROOT_ID);
		String temp = "";
		temp += setProjectBoard( rootId, boardList, userDetails );
		return temp;
	}

    // 게시판 관리 Page 의 폴더 구조
	public String getDefaultProjectFolderTree( String rootId, CustomUserDetails userDetails ){
		List<Map<String, Object>> boardList = morgueDao.getProjectBoard(Consts.PROJECT_ROOT_ID);
		String temp = "";

		if(boardList!=null && boardList.size() > 0){
			temp += setDefaultProjectBoard( rootId, boardList, userDetails );
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
								&& !folderId.equals(Consts.PROJECT_POSBEE_ROOT_ID)) temp+="<ul style=\"margin: 0 1.5em;\">";

						temp+="<i class=\"material-icons\" style=\"vertical-align:middle;\">view_list</i>"+map.get("BOARD_NAME")
						+"<a class=\'dropdown-button btn\' href=\'#\' data-activates=\'board_opt_"+map.get("BOARD_ID")+"\' style=\"margin: 5px 5px;\">관리</a>"
						+"<ul id=\'board_opt_"+map.get("BOARD_ID")+"\' class=\'dropdown-content\'>"
						+"<li><a href=\'#board_admin\' class=\"modal-trigger\" onclick=\"javascript:createProjectFun('EB','"+map.get("BOARD_ID")+"')\">게시판명 변경</a></li>"
						+"<li><a href=\'#board_admin\' class=\"modal-trigger\" onclick=\"javascript:createProjectFun('DB','"+map.get("BOARD_ID")+"')\">게시판 삭제</a></li>"
						+"</ul><br>";
						
						logger.info("@@ Board_id :" + map.get("BOARD_ID"));

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
//						temp+="<li data-jstree='{\"icon\":\"glyphicon glyphicon-list\"}' id=\""+map.get("BOARD_ID")+"\" onclick=\"javascript:getCustomBoardList('"+map.get("BOARD_ID")+"')\">"+map.get("BOARD_NAME")+"</li>";
						temp+="<a href=\"#\" id=\""+map.get("BOARD_ID")+map.get("FOLDER_ID")+"\" onclick=\"javascript:getCustomBoardList('"+map.get("BOARD_ID")+"')\" class=\"collection-item\"><i class=\"material-icons left\">view_list</i>"+map.get("BOARD_NAME")+"</a>";
					}
				}
			}
		}

		return temp;
	}
}
