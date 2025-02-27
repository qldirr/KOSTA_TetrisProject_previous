package org.tetris.service;

import java.util.List;

import org.tetris.domain.user.AuthVO;
import org.tetris.domain.user.UserVO;

public interface UserService {

	public void insertUser(UserVO user);

	public void insertAuthmapping(AuthVO auth);

	public List<UserVO> getList();

	public UserVO detailUser(String e_id);
 
	public AuthVO detailAuth(String e_id);

	public void updateUser(UserVO user);

	public int idCheck(UserVO user);
}