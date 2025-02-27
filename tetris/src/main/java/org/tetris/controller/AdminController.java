package org.tetris.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tetris.domain.user.AuthVO;
import org.tetris.domain.user.UserVO;
import org.tetris.security.CustomNoOpPasswordEncoder;

import org.tetris.service.UserService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/hr/*")
@Controller
public class AdminController {
	@Autowired
	UserService service;

	@Autowired
	CustomNoOpPasswordEncoder passEncoder;

	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("AdminOnly");
	}

	@Secured({"ROLE_ADMIN"})
	@GetMapping("/register")	
	public void register() {
		log.info("get register");
	}

	@PostMapping("/register")
	public String register(UserVO vo, AuthVO auth) {
		String inputPass = vo.getE_pw();
		String pass = passEncoder.encode(inputPass);
		int result = service.idCheck(vo);
		try {
			if(result ==1) {
				return "/hr/register";
			}else if(result ==0) {
				service.insertUser(vo);
				service.insertAuthmapping(auth);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return "redirect:/hr/list";

	}
	
	@ResponseBody
	@PostMapping("/idCheck")
	public int idCheck(UserVO vo) {
		//String e_id = vo.getE_id();
		int result = service.idCheck(vo);
		log.info(vo+".................................");
		log.info(result);
		return result;
	}

	@Secured({ "ROLE_ADMIN" })
	@GetMapping("/list")
	public void list(Model model) {
		List<UserVO> user = service.getList();
		model.addAttribute("list", user);
	}
	/*
	 * @Secured({"ROLE_ADMIN"})
	 * 
	 * @GetMapping("/detail") public void detail(Model model, int userNumber, String
	 * userId) { UserVO vo = service.detailUser(userId); AuthVO auth =
	 * service.detailAuth(userId); model.addAttribute("u",vo);
	 * //model.addAttribute("a", auth); log.info("get detail");
	 * //service.detailUser(user);
	 * 
	 * }
	 */
	 @Secured({"ROLE_ADMIN"})
	 @GetMapping("/detail")
	 public void detail(Model model, String e_id) {
		UserVO vo = service.detailUser(e_id);
		AuthVO auth = service.detailAuth(e_id);
		model.addAttribute("u",vo);	
		model.addAttribute("a", auth);
		 log.info("get detail");
		 //service.detailUser(user);

	 }
	 @Secured({"ROLE_ADMIN"})
	 @GetMapping("/modifyView")
	 public void modify(Model model, String e_id) {
			UserVO vo = service.detailUser(e_id);
			model.addAttribute("u",vo);	
		 log.info("get UPDATE");
	 }
	 
	 @PostMapping("/modify")
	 public String modify(UserVO user) {
		service.updateUser(user);
		return "redirect:/hr/list";
	 }
}