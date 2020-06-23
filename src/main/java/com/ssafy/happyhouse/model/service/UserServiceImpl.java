package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.UserInfoDao;
import com.ssafy.happyhouse.model.dto.UserInfo;

@Service
public class UserServiceImpl implements UserService {
	
	private UserInfoDao userDao;
	
	@Autowired
	public void setUserDao(UserInfoDao userDao) {
		this.userDao = userDao;
	}

	@Override
	public UserInfo login(String id, String password) {
		if (id == null || password == null)
			return null;
		return userDao.login(id, password);
	}

	@Override
	public void join(UserInfo user) {
		userDao.join(user);

	}

	@Override
	public UserInfo findUser(String id, String phone) {
		return userDao.findUser(id, phone);
	}

	@Override
	public boolean delete(String id, String password) {
		return userDao.delete(id, password);

	}

	@Override
	public void modify(UserInfo userInfo) {
		userDao.modify(userInfo);

	}

	@Override
	public List<UserInfo> printUserList() {
		return userDao.printUserList();
	}

}
