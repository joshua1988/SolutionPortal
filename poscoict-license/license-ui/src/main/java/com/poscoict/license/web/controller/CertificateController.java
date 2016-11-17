package com.poscoict.license.web.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.poscoict.license.service.CertificateService;

@Controller
public class CertificateController extends ExceptionControllerAdvice {
    
	@Autowired CertificateService certificateService;
	
    // 라이센스 인증서 다운로드 정보
    @RequestMapping( value = { "certificateDownloadInfo" }, method = { RequestMethod.POST } )
    public ModelAndView getLicenseCertification(HttpSession session, String licenseFileName, HttpServletRequest req) throws Exception {
    	System.out.println("~~~~~~~~~~~~~~~~~~licenseFileName: " + licenseFileName);
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "certificateDownload/certificateView" );
        
        Map<String, Object> map = (Map<String, Object>) certificateService.getLicenseCertification((String)session.getAttribute("USER_NO"), licenseFileName, req);
        mv.addObject("ImgFileName", map.get("ImgFileName"));
        mv.addObject("PDFFileName", map.get("PDFFileName"));
        
        return mv;
    }
    
    // 기술지원 확약서 다운로드 정보
    @RequestMapping( value = { "techSupportCertificationInfo" }, method = { RequestMethod.POST } )
    public ModelAndView getTechSupportCertificationInfo(HttpSession session, String productFileId, HttpServletRequest req) throws Exception {
    	System.out.println("~~~~~~~~~~~~~~~~~~productFileName: " + productFileId);
        ModelAndView mv = new ModelAndView();
        mv.setViewName( "certificateDownload/certificateView" );
        
        Map<String, Object> map = (Map<String, Object>) certificateService.getTechSupportCertificationInfo((String)session.getAttribute("USER_NO"), productFileId, req);
        mv.addObject("ImgFileName", map.get("ImgFileName"));
        mv.addObject("PDFFileName", map.get("PDFFileName"));
        return mv;
    }
}
