package org.tetris.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CalendarVO {
	private int cl_num;
	private String cl_name;
	private String cl_startdate;
	private String cl_enddate;
	private String cl_type;
	private String cl_contents;
	private String cl_color;
	private String e_id;
	
	
}
