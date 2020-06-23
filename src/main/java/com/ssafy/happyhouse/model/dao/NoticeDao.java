package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.model.dto.Notice;

public interface NoticeDao {
	public void addNotice(Notice p) throws SQLException;
	public List<Notice> printNoticeList() throws SQLException;
	public Notice getNotice(int no) throws SQLException;
	public void deleteNotice(int no) throws SQLException;
	public void modifyNotice(Notice n) throws SQLException;
}
