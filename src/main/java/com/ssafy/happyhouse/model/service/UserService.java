package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.dto.UserInfo;

public interface UserService {

	public UserInfo login(String id, String password);

	public void join(UserInfo user);
	
	public boolean delete(String id, String password);

	public UserInfo findUser(String id, String phone);

	public void modify(UserInfo userInfo);
	
	public List<UserInfo> printUserList();

}
