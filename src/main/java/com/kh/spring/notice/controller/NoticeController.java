package com.kh.spring.notice.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.common.HiSpringUtils;
import com.kh.spring.notice.model.service.NoticeService;
import com.kh.spring.notice.model.vo.Notice;
import com.kh.spring.sharing.model.vo.Attachment;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/notice", method= {RequestMethod.GET, RequestMethod.POST})
@Slf4j
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	ServletContext application;
	
	@GetMapping("/noticeList.do")
	public String noticeList(
			Model model,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request) {
		
		try {
			log.debug("cPage = {}", cPage); // defaultValue = "1" 로 해둬서 cPage 값이 없으면 1이 나온다.
			
			int limit = 10; // 한페이지당 게시글 수 
			int offset = (cPage - 1) * limit;
			
			// 전체 게시물 목록( 첨부파일 개수 )
			List<Notice> noticeList = noticeService.selectNoticeList(offset, limit);
			log.debug("noticeList = {}", noticeList);
			// jsp에 추가될 수 있도록 model에 담아줌
			model.addAttribute("noticeList", noticeList);
			
			// 전체 게시물 수 구하기
			int totalContent = noticeService.countTotalContent();
			log.debug("전체 게시물 수 = {}", totalContent);
			model.addAttribute("totalContent", totalContent);
			
			// pagebar
			String url = request.getRequestURI(); // /spring/notice/noticeList.do
			String pagebar = HiSpringUtils.getPagebar(cPage, limit, totalContent, url);
			log.debug("pagebar = {}", pagebar);
			model.addAttribute("pagebar", pagebar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "notice/noticeList";
	}

	@GetMapping("/noticeForm.do")
	public void noticeForm() {}
	
	
	@PostMapping("/noticeEnroll.do")
	public String noticeEnroll(
			// 한 게시물에 여러 첨부파일이라 [] 형식
	         @RequestParam(value = "upFile", required = false) MultipartFile[] upFiles,
	         @ModelAttribute Notice notice, 
	         RedirectAttributes redirectAttr
			 ) throws Exception {
		
		try {
			String saveDirectory = application.getRealPath("/resources/upload/notice");
			log.debug("saveDirectory = {}", saveDirectory);
			
			// 첨부파일 List 생성
			List<Attachment> attachments = new ArrayList<>();
			
			for(MultipartFile upFile : upFiles) {
				
				if(!upFile.isEmpty() && upFile.getSize() != 0) {
					
					log.debug("upFile = {}", upFile);
					log.debug("upFile.name = {}", upFile.getOriginalFilename());
					log.debug("upFile.size = {}", upFile.getSize());
					
					// 새이름 부여해서 관리하기
					String originalFilename = upFile.getOriginalFilename();
			        String renamedFilename = HiSpringUtils.getRenamedFilename(originalFilename);
					
					File dest = new File(saveDirectory, renamedFilename);
					log.debug("dest  = {}", dest);
					upFile.transferTo(dest);
					
					// 파일별로 attachment 테이블에 저장되어야 함.
		            // 2. db에 attachment 레코드 등록
		            Attachment attach = new Attachment();
		            attach.setRenamedFilename(renamedFilename);
		            attach.setOriginalFilename(originalFilename);
		            
		            attachments.add(attach);
		            
		            log.debug("하이");
					
				}
			}
			
			if(!attachments.isEmpty()) {
				notice.setAttachments(attachments);
			}
			int result = noticeService.insertNotice(notice);
			
			String msg = result > 0 ? "공지사항이 등록되었습니다." : "등록 실패";
			redirectAttr.addFlashAttribute("msg", msg);
			
			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		
		return "redirect:/notice/noticeList.do";
	}
	
}