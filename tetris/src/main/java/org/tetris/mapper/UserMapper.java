package org.tetris.mapper;

import java.util.List;

import org.tetris.domain.AuthVO;
import org.tetris.domain.UserVO;


public interface UserMapper {

	public UserVO read(String e_id);
	public void insertUser(UserVO user);
	public void insertAuthmapping(AuthVO auth);
	public List<UserVO> getList();
	//public UserVO detailUser(int userNumber);
	public UserVO detailUser(String e_id);
	public AuthVO detailAuth(String e_id);
	public void updateUser(UserVO user);
	public int idCheck(UserVO user);
	
}