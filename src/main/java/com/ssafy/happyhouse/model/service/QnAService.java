package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.dto.QnA;

public interface QnAService {

	//전체 조회
	public List<QnA> selectQnA();
	
	//등록 
	public boolean addQnA(QnA qna);
	
	//수정 
	public boolean modifyQnA(QnA qna);
	
	//삭제 
	public boolean deleteQnA(int no);
	
	//상세 조회
	public QnA getQnA(int no);
	 
}
