package org.tetris.service;

import java.util.List;
import java.util.Map;

import org.tetris.domain.CalendarVO;

public interface CalendarService {

	public void register(CalendarVO calendar);
	public CalendarVO get(int cl_num);
	public boolean modify(CalendarVO calendar);
	public boolean remove(int cl_num);
	public List<CalendarVO> getList();
}
