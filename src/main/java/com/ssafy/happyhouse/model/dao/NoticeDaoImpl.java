
package com.ssafy.happyhouse.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.model.dto.Notice;
import com.ssafy.happyhouse.util.DBUtil;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void addNotice(Notice n) throws SQLException {
		sqlSession.insert("notice.addNotice", n);
	}

	@Override
	public List<Notice> printNoticeList() throws SQLException {
		return sqlSession.selectList("notice.printNoticeList");
	}

	@Override
	public Notice getNotice(int no) throws SQLException {
		return sqlSession.selectOne("notice.getNotice", no);
	}

	@Override
	public void deleteNotice(int no) throws SQLException {
		sqlSession.delete("notice.deleteNotice", no);
	}

	@Override
	public void modifyNotice(Notice n) throws SQLException {
		sqlSession.update("notice.modifyNotice", n);
	}

}
