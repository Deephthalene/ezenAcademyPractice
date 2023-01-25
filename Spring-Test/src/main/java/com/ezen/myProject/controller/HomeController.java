package com.ezen.myProject.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.myProject.domain.UserVO;
import com.ezen.myProject.service.UserService;


@RequestMapping("/member/*")
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private UserService userService;
	
	
	@GetMapping("/")
	public String home(Model m, @RequestParam("isOk") String isOk) {
		logger.info(isOk);
		m.addAttribute("isOk", isOk);
//		mv.setViewName("/index");
		return "/index";
	}
	//{"/signup", "/login"}
	@GetMapping("/signup")
	public ModelAndView signUpGet(ModelAndView mv) {
		mv.setViewName("/user/signup");
		return mv;
	}
	
	@PostMapping("/signup")
	public ModelAndView sinUpPost(ModelAndView mv, UserVO user) {
		logger.info(user.toString());
		// 비밀번호 암호화 설정 완료 후
		boolean isUp = userService.signUp(user); //서비스 구현 라인
		if(isUp) {
			mv.setViewName("/user/login");
		}else {
			mv.setViewName("/user/signup");
			mv.addObject("msg", "0");
		}
		return mv;
	}
	
	@GetMapping("/login")
	public ModelAndView loginGet(ModelAndView mv) {
		mv.setViewName("/user/login");
		return mv;
	}
	
	@PostMapping("/login")
	public ModelAndView loginPost(ModelAndView mv, String id, String pw,
			HttpServletRequest request) {
		//id, pw를 받아서 일치하는 회원이 있으면 회원정보를 가져오고, 없으면 null
		logger.info(">>>> id : "+ id+ ">>>> pw : "+ pw);
		UserVO isUser = userService.isUser(id, pw);
		logger.info(isUser.toString());
		//isUser가 null이 아니라면 세션 연결
		if(isUser!= null) {
			HttpSession session  = request.getSession();
			session.setAttribute("ses", isUser);
			mv.addObject("user", isUser);
			mv.addObject("msg", "1");
			mv.setViewName("/index");
		}else {
			mv.setViewName("/user/login");  //로그인 실패시
			mv.addObject("msg", "0");
			}
		return mv;
	}
	
	@GetMapping("/logout")
	public ModelAndView logoutGet(ModelAndView mv, HttpServletRequest request) {
		request.getSession().removeAttribute("ses");
		request.getSession().invalidate();
		mv.setViewName("redirect:/");
		return mv;
	}
	
}
