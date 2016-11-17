package com.poscoict.license.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.util.PDFImageWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.List;
import com.itextpdf.text.ListItem;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.poscoict.license.consts.Consts;
import com.poscoict.license.dao.ManagementDao;

import javax.servlet.http.HttpServletRequest;

@Service
public class CertificateService {
	@Autowired
	private ManagementDao managementDao;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	private Font FONT = null;

	private static enum Fonts{
		FONT12NOAML, FONT12BOLD, FONT18NOAML, FONT20BOLD
	}
	
	private Font getFont(Fonts name){
		try {
			BaseFont baseFont = BaseFont.createFont(Consts.FONT_FILE_PATH, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
			switch(name){
				case FONT12NOAML: this.FONT = new Font(baseFont, 12, Font.NORMAL); break;
				case FONT12BOLD: this.FONT = new Font(baseFont, 12, Font.BOLD); break;
				case FONT18NOAML: this.FONT = new Font(baseFont, 18, Font.NORMAL); break;
				case FONT20BOLD: this.FONT = new Font(baseFont, 20, Font.BOLD); break;
				default: this.FONT = new Font(baseFont, 12, Font.NORMAL);
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return this.FONT;
	}
	
	public Paragraph setParagraph(String text, Fonts font){
		return new Paragraph(text, getFont(font));
	}
	
    public Map<String, Object> getLicenseCertification(String userNo, String licenseFileName, HttpServletRequest req) throws Exception {
    	logger.info("_________getLicenseCertification: " +userNo+" "+licenseFileName);
    	String PDFFileName = userNo+licenseFileName;
    	String PDFFilePath = Consts.PDF_PATH+PDFFileName+".pdf";
    	String ImgFilePath = Consts.IMG_PATH+PDFFileName+"1."+Consts.IMG_FORMAT;
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("PDFFileName", PDFFileName+".pdf");
    	map.put("ImgFileName", PDFFileName+"1."+Consts.IMG_FORMAT);
    	
    	Map<String, Object> licenseInfo = (Map<String, Object>) managementDao.getLicenseCertification(userNo, licenseFileName);
    	
    	Document document = new Document();
    	try {
    		PdfWriter.getInstance(document, new FileOutputStream(PDFFilePath));
    		document.open();
		
    		Paragraph p0 = new Paragraph(" ");
			Paragraph p1 = null;
			
			p1 = setParagraph("License Certificate", Fonts.FONT20BOLD);
			p1.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(p1);
			
			document.add(p0);
			document.add(p0);
			
			document.add(setParagraph("● End User (고객명) : "+licenseInfo.get("USER_NAME"), Fonts.FONT12BOLD));
			document.add(setParagraph("● Address (주소): "+licenseInfo.get("USER_ADDRESS"), Fonts.FONT12BOLD));
			document.add(setParagraph("● Project (업무명): "+licenseInfo.get("PROJECT_NAME"), Fonts.FONT12BOLD));
			
			document.add(p0);
					        
			PdfPTable table = new PdfPTable(2);
			table.setWidthPercentage(100);
			
			PdfPCell cell;
			cell = new PdfPCell(new Phrase(" Product Description", getFont(Fonts.FONT12BOLD)));
			cell.setFixedHeight(30);
			cell.setPaddingTop(8f);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(" "+licenseInfo.get("PRODUCT_FILE_NAME"), getFont(Fonts.FONT12NOAML)));
			cell.setFixedHeight(30);
			cell.setPaddingTop(8f);
			table.addCell(cell);
			
			cell = new PdfPCell(new Phrase(" License Number", getFont(Fonts.FONT12BOLD)));
			cell.setFixedHeight(30);
			cell.setPaddingTop(8f);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(" "+licenseInfo.get("LICENSE_KEY"), getFont(Fonts.FONT12NOAML)));
			cell.setFixedHeight(30);
			cell.setPaddingTop(8f);
			table.addCell(cell);
			
			cell = new PdfPCell(new Phrase(" Quantity", getFont(Fonts.FONT12BOLD)));
			cell.setFixedHeight(30);
			cell.setPaddingTop(8f);
			table.addCell(cell);
			cell = new PdfPCell(new Phrase(" "+licenseInfo.get("LICENSE_QUANTITY")+" EA", getFont(Fonts.FONT12NOAML)));
			cell.setFixedHeight(30);
			cell.setPaddingTop(8f);
			table.addCell(cell);
			
			document.add(table);
			
			document.add(p0);
			
			List list = new List(false, 20);
			list.add(new ListItem("본 License Certificate는 위 고객이 상기 제품을 해당 업무에 합법적으로 사용할 수 있음을 인증합니다.", getFont(Fonts.FONT12NOAML)));
			list.add(new ListItem("License Certificate는 제품을 구입한 증거이며 유지보수 또는 기술지원 서비스를 받을 경우 필요하오니 안전한 장소에 보관하시기 바랍니다.", getFont(Fonts.FONT12NOAML)));
			list.add(new ListItem("단, 제품 업그레이드는 포함되지 않습니다.", getFont(Fonts.FONT12NOAML)));
			document.add(list);
			
			document.add(p0);
			document.add(p0);
			document.add(p0);
			document.add(p0);
			document.add(p0);
			document.add(p0);
			document.add(p0);
			document.add(p0);
			
			p1 = setParagraph(licenseInfo.get("USER_START_DATE").toString(),Fonts.FONT20BOLD);
			p1.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(p1);
			p1 = setParagraph(licenseInfo.get("COMPANY_NAME").toString(),Fonts.FONT20BOLD);
			p1.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(p1);
		
//			Image img = Image.getInstance(Consts.SIGNET_IMG_PATH);
//			img.setAbsolutePosition(350f, 390f);
//			document.add(img);
		
			document.close();
	   }
	   catch(DocumentException de) {
		   logger.error(ImgFilePath, de);
	   }
	   catch(IOException ioe) {
		   logger.error(ImgFilePath, ioe);
	   }
	   
       String temp = req.getSession().getServletContext().getRealPath(Consts.IMG_TEMP_FOLDER);
       System.out.println("________________________________________________"+temp);
	   if(extractPagesAsImage(PDFFilePath, PDFFileName, 100, "")){
		   fileCopy(ImgFilePath,temp+File.separator+map.get("ImgFileName"));
	   }
	   
	   return map;
    }
    
    public Map<String, Object> getTechSupportCertificationInfo(String userNo, String productFileId, HttpServletRequest req) throws Exception {
    	logger.info("_________getTechSupportCertificationInfo: " +userNo+" "+productFileId);
    	
    	String PDFFileName = userNo+"_TechSupportCertification";
    	String PDFFilePath = Consts.PDF_PATH+PDFFileName+".pdf";
    	String ImgFilePath = Consts.IMG_PATH+PDFFileName+"1."+Consts.IMG_FORMAT;
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("PDFFileName", PDFFileName+".pdf");
    	map.put("ImgFileName", PDFFileName+"1."+Consts.IMG_FORMAT);
    	
    	Map<String, Object> productInfo = managementDao.getTechSupportCertificationInfo(userNo, productFileId);
    	
    	if(productInfo.get("TECH_SUPPORT_DATE").equals("0")){
    		throw new UserException("제품이 설치되지 않았습니다. 설치후 관리자에 문의하세요.");
    	}
    	
    	Document document = new Document();
    	try {
    		PdfWriter.getInstance(document, new FileOutputStream(PDFFilePath));
    		document.open();
    		
    		Paragraph p0 = new Paragraph(" ");
    		Paragraph p1 = null;

    		Paragraph header = new Paragraph("기술지원 확약서", getFont(Fonts.FONT20BOLD));
    		header.setAlignment(Paragraph.ALIGN_CENTER);
    		document.add(header);

    		document.add(p0);
    		document.add(p0);
    		document.add(p0);
    		
    		p1 = setParagraph("POSCO ICT 는 본 프로젝트와 관련하여 공급되는 제품 "+productInfo.get("PRODUCT_FILE_NAME")+" 에 대하여,"
    				+"당사 제품에 관해 기술적으로 발생되는 문제는 당사의 책임 하에 성실하게 기술지원"
    				+"할 것을 확약 드립니다."
    				,Fonts.FONT18NOAML);
    		document.add(p1);

    		document.add(p0);
    		document.add(p0);
    		
    		p1 = setParagraph("- 아   래 -", Fonts.FONT18NOAML);
    		p1.setAlignment(Paragraph.ALIGN_CENTER);
    		document.add(p1);

    		document.add(p0);
    		document.add(p0);

    		List list = new List(false, 30);
			list.add(new ListItem("● 일     자 : "+productInfo.get("USER_START_DATE"), getFont(Fonts.FONT18NOAML)));
			list.add(new ListItem("● 제 품 명 : "+productInfo.get("PRODUCT_FILE_NAME")+" ("+productInfo.get("LICENSE_QUANTITY")+"식)", getFont(Fonts.FONT18NOAML)));
			list.add(new ListItem("● 제 조 자 : POSCO ICT", getFont(Fonts.FONT18NOAML)));
			list.add(new ListItem("● 업 무 명 : "+productInfo.get("PROJECT_NAME"), getFont(Fonts.FONT18NOAML)));
			list.add(new ListItem("● 설치기관 : "+productInfo.get("COMPANY_NAME"), getFont(Fonts.FONT18NOAML)));
			list.add(new ListItem("● 무상 유지보수 기간: "+productInfo.get("TECH_SUPPORT_DATE"), getFont(Fonts.FONT18NOAML)));
			document.add(list);
			
			document.add(p0);
			document.add(p0);
			document.add(p0);
			
			p1 = setParagraph("POSCO ICT", Fonts.FONT20BOLD);
			p1.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(p1);
		
//			Image img = Image.getInstance(Consts.SIGNET_IMG_PATH);
//			img.setAbsolutePosition(350f, 260f);
//			document.add(img);
		
			document.close();
	   }
	   catch(DocumentException de) {
		   logger.error(ImgFilePath, de);
	   }
	   catch(IOException ioe) {
		   logger.error(ImgFilePath, ioe);
	   }
       
       String temp = req.getSession().getServletContext().getRealPath(Consts.IMG_TEMP_FOLDER);
       if(extractPagesAsImage(PDFFilePath, PDFFileName, 100, "")){
		   fileCopy(ImgFilePath,temp+File.separator+map.get("ImgFileName"));
	   }
	   
	   return map;
    }
    
	public boolean extractPagesAsImage(String sourceFile, String fileName, int resolution, String password) {

		boolean result = false;
		//출력이미지 확장자
		String imageFormat = Consts.IMG_FORMAT;
		int pdfPageCn = 0;
		PDDocument pdfDoc = null;
		
		try {
			//PDF파일 정보 취득
			pdfDoc = PDDocument.load(sourceFile);
			
			//PDF파일 총페이지 수 취득
			pdfPageCn = pdfDoc.getNumberOfPages();
		} catch (IOException ioe) {
			logger.error("PDF 정보취득 실패 : ", ioe);
		}
		
		PDFImageWriter imageWriter = new PDFImageWriter();
		try {
			result = imageWriter.writeImage(pdfDoc,
					 imageFormat,
					 password,
					 1, //이미지 출력 시작페이지
					 pdfPageCn, //이미지 출력 종료페이지
					 //저장파일위치 및 파일명 지정 파일명+페이지 "파일명1.gif" 파일저장
					 Consts.IMG_PATH+fileName,
					 BufferedImage.TYPE_INT_RGB,
					 resolution //이미지 품질  300 추천
					 );
			pdfDoc.close();
		} catch (IOException ioe) {
			logger.error("PDF 이미지저장 실패 : ", ioe);
		}
		return result;
	}
	
	 public void fileCopy(String inFileName, String outFileName) {
		try {
			FileInputStream fis = new FileInputStream(inFileName);
			FileOutputStream fos = new FileOutputStream(outFileName);
			
			int data = 0;
			while((data=fis.read())!=-1) {
				fos.write(data);
			}
			fis.close();
			fos.close();
		} catch (IOException e) {
			logger.error("파일복사 실패: "+inFileName, e);
			e.printStackTrace();
		}
	}
}
