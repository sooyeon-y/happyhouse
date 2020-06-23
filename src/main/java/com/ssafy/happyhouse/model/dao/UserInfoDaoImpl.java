
package com.ssafy.happyhouse.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.model.dto.Notice;
import com.ssafy.happyhouse.model.dto.UserInfo;
import com.ssafy.happyhouse.model.service.UserService;
import com.ssafy.happyhouse.util.DBUtil;

@Repository
public class UserInfoDaoImpl implements UserInfoDao {

	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public UserInfo login(String id, String password) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("password", password);
		return sqlSession.selectOne("userinfo.login", map);
	}

	@Override
	public void join(UserInfo user) {
		sqlSession.insert("userinfo.join", user);
	}

	@Override
	public UserInfo findUser(String id, String phone) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("contact", phone);
		return sqlSession.selectOne("userinfo.findUser", map);
	}

	@Override
	public boolean delete(String id, String password) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("password", password);
		return sqlSession.delete("userinfo.delete", map) == 1;
	}

	@Override
	public void modify(UserInfo userInfo) {
		sqlSession.update("userinfo.modify", userInfo);
	}

	@Override
	public List<UserInfo> printUserList() {
		return sqlSession.selectList("userinfo.printUserList");
	}

}
