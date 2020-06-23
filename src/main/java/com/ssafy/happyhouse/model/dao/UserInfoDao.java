package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.model.dto.UserInfo;

public interface UserInfoDao {
	public UserInfo login(String id, String password);
	public void join(UserInfo user);
	public UserInfo findUser(String id, String phone);
	public boolean delete(String id, String password);
	public void modify(UserInfo userInfo);
	public List<UserInfo> printUserList();
}