package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.dto.Notice;

public interface NoticeService {
	public void addNotice(Notice n) throws SQLException;
	public List<Notice> printNoticeList() throws SQLException;
	public Notice getNotice(int no) throws SQLException;
	public void deleteNotice(int no) throws SQLException;
	public void modifyNotice(Notice n) throws SQLException;
}
