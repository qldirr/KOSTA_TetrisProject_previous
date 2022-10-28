package org.tetris.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.tetris.service.CalendarService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/todo")
public class TodoController {

	@GetMapping("/list")
	public void todolist() {
		log.info("list..");
		
	}
}
