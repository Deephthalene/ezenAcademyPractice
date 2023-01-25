package com.ezen.myProject.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.myProject.domain.BoardDTO;
import com.ezen.myProject.domain.BoardVO;
import com.ezen.myProject.domain.FileVO;
import com.ezen.myProject.domain.PagingVO;
import com.ezen.myProject.domain.UserVO;
import com.ezen.myProject.handler.FileHandler;
import com.ezen.myProject.handler.PagingHandler;
import com.ezen.myProject.repository.UserDAO;
import com.ezen.myProject.service.BoardService;
import com.ezen.myProject.service.UserServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board/*")
@Controller
public class BoardController {

	@Inject
	private BoardService bsv;
	@Inject
	private UserDAO userDao;
	@Inject
	private UserServiceImpl usv;
	
	@Inject
	private FileHandler fhd;
	

	@GetMapping("/register")
	public String boardRegisterGet() {
		return "/board/register";
	}
	// insert, update, delete => redirect처리
	
	@PostMapping("/register")
	public String register(BoardVO bvo, RedirectAttributes rAttr,
			@RequestParam(name="files", required = false)MultipartFile[] files) {
		log.info(">>> bvo register : "+bvo.toString());
		log.info(">>> files register : "+files.toString());
		List<FileVO> fList = null;
		if(files[0].getSize()>0) {
			fList = fhd.uploadFiles(files);
		}else {
			
			log.info("file null");
		}
		BoardDTO bdto = new BoardDTO(bvo, fList);
		int isOk = bsv.register(bdto);
//		int isOk = bsv.register(bvo);
		rAttr.addAttribute("isOk",  isOk>0 ? "1":"0");
		log.info("board register >> "+( isOk>0 ? "OK":"FAIL"));
		return "redirect:/board/list";
	}
	
	@GetMapping("/list")
	public String list(Model model, PagingVO pvo) {
		log.info(">>>> pageNo : "+pvo.getPageNo());
		List<BoardVO> list = bsv.getList(pvo);
		model.addAttribute("list", list);
		int totalCount = bsv.getTotalCount(pvo);
		PagingHandler ph = new PagingHandler(pvo, totalCount);
		model.addAttribute("pgn", ph);
		return "/board/list";
	}
		
	@GetMapping({"/detail","/modify"})
	public void detail(Model model, @RequestParam("bno")int bno) {
		BoardDTO bdto = bsv.getDetailFile(bno);
		//BoardVO board = bsv.getDetail(bno);
		log.info(">>>> bdto.bvo : "+ bdto.getBvo().toString()); //bvo
		//log.info(">>>> bdto.fList : "+bdto.getFList().get(0).toString()); //fList
		//model.addAttribute("bdto", bdto);
		model.addAttribute("board", bdto.getBvo());
		model.addAttribute("fList", bdto.getFList());
	}
	
	@PostMapping("/modify")
	public String modify(RedirectAttributes reAttr, BoardVO bvo, 
			@RequestParam(name="files", required = false)MultipartFile[] files ) {
		log.info("modify >>> : "+ bvo.toString());
		UserVO user = userDao.getUser(bvo.getWriter());
		List<FileVO> fList = null;
		//파일의 값이 있다면
		if(files[0].getSize()>0) {
			fList = fhd.uploadFiles(files);
		}
		int isUp = bsv.modify(new BoardDTO(bvo, fList), user);
		//int isUp = bsv.modify(bvo, user);
		log.info(">>> modify : "+(isUp >0? "ok":"fail"));
		reAttr.addFlashAttribute(isUp>0 ? "1" : "0");
		return "redirect:/board/list";
	}
	
	@GetMapping("/remove")
	public String remove(RedirectAttributes reAttr, @RequestParam("bno")int bno, 
			HttpServletRequest request) {
//		1. HttpSession ses = request.getSession();
//		UserVO user = (UserVO)ses.getAttribute("ses");
//		log.info(user.toString());
//		2. UserVO user = userDao.getUsers((UserVO)request.getSession().getAttribute("ses"));
		UserVO user = usv.getUser(request);
		
		int isUp = bsv.remove(bno, user);
		log.info(">>> remove : "+(isUp >0? "ok":"fail"));
		return "redirect:/board/list";
	}
	
	@DeleteMapping(value = "/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeFile(@PathVariable("uuid")String uuid){		
		return bsv.removeFile(uuid) > 0 ? 
				new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
