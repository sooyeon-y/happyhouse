package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.QnADao;
import com.ssafy.happyhouse.model.dto.QnA;

@Service
public class QnAServiceImpl implements QnAService {
	
	@Autowired
	private QnADao dao;
	

	/*
	 * public void setDao(QnADao dao) { this.dao = dao; }
	 */

	@Override
	public List<QnA> selectQnA() {
		return dao.selectQnA();
	}

	@Override
	public boolean addQnA(QnA qna) {
		return dao.addQnA(qna) == 1;
	}

	@Override
	public boolean modifyQnA(QnA qna){
		return dao.modifyQnA(qna) == 1;
	}

	@Override
	public boolean deleteQnA(int no){
		return dao.deleteQnA(no) == 1;
	}

	@Override
	public QnA getQnA(int no) {
		return dao.getQnA(no);
	}
	
}