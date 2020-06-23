package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.QnA;

@Mapper
public interface QnADao {
	//전체 조회
	public List<QnA> selectQnA();	
	//등록 
	public int addQnA(QnA qna); 	
	//수정 
	public int modifyQnA(QnA qna); 	
	//삭제 
	public int deleteQnA(int no); 	
	//상세 조회
	public QnA getQnA(int no);
	 
}
