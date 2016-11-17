package com.poscoict.license.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poscoict.license.dao.ManagementDao;
import com.poscoict.license.util.LmsUtil;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

@Service
public class GenerateExcelService extends LmsUtil {
	
	@Autowired
	private ManagementDao managementDao;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	WritableWorkbook workbook = null;
	WritableSheet sheet = null;
    
    public String setNullString(String str){
    	return str==null?" ":str;	
    }
    
    public void setDefaultCell(int row, WritableCellFormat textFormat2, Map<String, Object> map){
    	try{
    		Label label = new jxl.write.Label(0, row, setNullString((String)map.get("USER_NO")), textFormat2);
    		this.sheet.addCell(label);
    		label = new jxl.write.Label(1, row, setNullString((String)map.get("USER_NAME")), textFormat2);
    		this.sheet.addCell(label);
    		label = new jxl.write.Label(2, row, setNullString((String)map.get("PROJECT_NAME")), textFormat2);
    		this.sheet.addCell(label);
    		label = new jxl.write.Label(3, row, setNullString((String)map.get("USER_ADDRESS")), textFormat2);
    		this.sheet.addCell(label);
    		label = new jxl.write.Label(4, row, setNullString((String)map.get("MANAGER_NAME")), textFormat2);
    		this.sheet.addCell(label);
    		label = new jxl.write.Label(5, row, setNullString((String)map.get("MANAGER_OFFICE_PHON")), textFormat2);
    		this.sheet.addCell(label);
    		label = new jxl.write.Label(6, row, setNullString((String)map.get("MANAGER_CEL_PHON")), textFormat2);
    		this.sheet.addCell(label);
    		label = new jxl.write.Label(7, row, setNullString((String)map.get("MANAGER_EMAIL")), textFormat2);
    		this.sheet.addCell(label);
    		label = new jxl.write.Label(8, row, setNullString((String)map.get("ORDER_COMPANY")), textFormat2);
    		this.sheet.addCell(label);
//    		label = new jxl.write.Label(9, row, setNullString((String)map.get("PRODUCT")), textFormat2);
//    		this.sheet.addCell(label);
    		label = new jxl.write.Label(10, row, setNullString((String)map.get("USER_START_DATE")), textFormat2);
    		this.sheet.addCell(label);
    		label = new jxl.write.Label(11, row, setNullString((String)map.get("PRODUCT_SETUP_DATE")), textFormat2);
    		this.sheet.addCell(label);
    		label = new jxl.write.Label(12, row, setNullString((String)map.get("R_CREATION_DATE")), textFormat2);
    		this.sheet.addCell(label);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    }

	public String makeExcelFileClientInfo(){
		logger.info("________________makeExcelFileClientInfo_______________");
        String baseDir = "D:"+File.separator+"files"+File.separator+"generateExcel";
        String filePath = baseDir+File.separator+attachFileDateFormat()+"_고객정보.xls";
        List<Map<String, Object>> list = managementDao.makeExcelFileClientInfo();
        
        try{
        	File file = new File(baseDir);
        	if(!file.exists()) file.mkdirs();
        	// 저장할 파일 객체 생성
        	file = new File(filePath);
        	// 엑셀파일 객체 생성
        	this.workbook = Workbook.createWorkbook(file);
        	
        	// 시트 객체 생성
        	this.sheet = workbook.createSheet("고객정보(완료)", 0);
        	
        	// 셀형식
    		WritableCellFormat headerFormat = new WritableCellFormat();
    		headerFormat.setAlignment(Alignment.CENTRE);
    		headerFormat.setBackground(Colour.GRAY_25);
    		headerFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
    		
    		WritableCellFormat textFormat = new WritableCellFormat();
    		textFormat.setAlignment(Alignment.LEFT);
    		textFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
    		
    		WritableCellFormat mergeFormat = new WritableCellFormat();
    		mergeFormat.setAlignment(Alignment.LEFT);
    		mergeFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
    		mergeFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
    		
        	// 열넓이 설정 (열 위치, 넓이)
    		for(int i=0; i<13; i++){
    			this.sheet.setColumnView(i, 20);
    		}
        	
        	int row = 0;
        	// 헤더
        	Label label = new jxl.write.Label(0, row, "계약번호", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(1, row, "회사명", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(2, row, "프로젝트명", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(3, row, "주소", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(4, row, "담당자", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(5, row, "전화번호", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(6, row, "휴대번호", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(7, row, "이메일", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(8, row, "수주사", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(9, row, "계약제품", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(10, row, "계약일자", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(11, row, "설치일자", headerFormat);
        	this.sheet.addCell(label);
        	label = new jxl.write.Label(12, row, "포탈 등록일자", headerFormat);
        	this.sheet.addCell(label);
        	
        	if(list.size()>0 && list != null){
        		for(Map<String, Object> map: list){
        			row++;
        			
        			if(map.get("PRODUCT")!=null){
        				String temp = (String)map.get("PRODUCT");
        				String[] arr = temp.split("\\|");
        				int arrLe = arr.length;
        				if(arrLe>1){
        					for(int i=0; i<arrLe; i++){
        						label = new jxl.write.Label(9, row+i, arr[i].replaceAll(":", " "), textFormat);
        			    		this.sheet.addCell(label);
        					}
        					for(int i=0; i<13; i++){
        						if(i!=9) this.sheet.mergeCells(i, row, i, row+arrLe-1);
        						
        					}
        					setDefaultCell(row, mergeFormat, map);
        					row+=arrLe-1;
        				}else{
        					setDefaultCell(row, textFormat, map);	
        					label = new jxl.write.Label(9, row, setNullString(((String) map.get("PRODUCT")).replaceAll(":", " ")), textFormat);
        		    		this.sheet.addCell(label);
        				}
        			}else{
        				setDefaultCell(row, textFormat, map);
        				label = new jxl.write.Label(9, row, setNullString((String)map.get("PRODUCT")), textFormat);
        	    		this.sheet.addCell(label);
        			}
        			
        		}
        	}
        	
        	this.workbook.write();
        	this.workbook.close();
 
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return filePath;
	}
}
