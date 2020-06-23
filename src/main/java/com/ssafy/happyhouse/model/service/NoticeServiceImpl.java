package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ssafy.happyhouse.model.dao.NoticeDao;
import com.ssafy.happyhouse.model.dto.Notice;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	private NoticeDao nDao;
	/*
	 * public NoticeServiceImpl() { nDao = new NoticeDaoImpl(); }
	 */

	@Autowired
	public void setNoticeDao(NoticeDao nDao) {

		this.nDao = nDao;
	}
	
	@Override
	public void addNotice(Notice n) throws SQLException {
		nDao.addNotice(n);
	}

	@Override
	public List<Notice> printNoticeList() throws SQLException {
		return nDao.printNoticeList();
	}

	@Override
	public Notice getNotice(int no) throws SQLException {
		return nDao.getNotice(no);
	}

	@Override
	public void deleteNotice(int no) throws SQLException {
		nDao.deleteNotice(no);
	}

	@Override
	public void modifyNotice(Notice n) throws SQLException {
		nDao.modifyNotice(n);
	}

}
