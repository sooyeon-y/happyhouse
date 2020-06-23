package com.ssafy.happyhouse.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.dto.QnA;
import com.ssafy.happyhouse.model.service.QnAService;

import io.swagger.annotations.ApiOperation;

//http://localhost:7777/happyhouse/swagger-ui.html
@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/api/qna")
public class QnAController {

	private static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";


	private QnAService qnaService;	
	
	@Autowired
    public void setQnaService(QnAService qnaService) {
		this.qnaService = qnaService;
	}
	
	
	@ApiOperation(value = "모든 질문게시판 정보를 반환한다.", response = List.class)
	@GetMapping
	public ResponseEntity<List<QnA>> selectQnA() throws Exception {
		logger.debug("selectQnA - 호출");
		return new ResponseEntity<List<QnA>>(qnaService.selectQnA(), HttpStatus.OK);
	}
    
    @ApiOperation(value = "글번호에 해당하는 게시글의 정보를 반환한다.", response = QnA.class)    
 	@GetMapping("{no}")
 	public ResponseEntity<QnA> getQnA(@PathVariable int no) {
 		logger.debug("getQnA - 호출");
 		return new ResponseEntity<QnA>(qnaService.getQnA(no), HttpStatus.OK);
 	}

    @ApiOperation(value = "새로운 게시글 정보를 입력한다. 그리고 DB입력 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
 	@PostMapping
 	public ResponseEntity<String> addQnA(@RequestBody QnA qna) {
 		logger.debug("addQnA - 호출");
 		if (qnaService.addQnA(qna)) {
 			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
 		}
 		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
 	}

     @ApiOperation(value = "글번호에 해당하는 게시글의 정보를 수정한다. 그리고 DB수정 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
 	@PutMapping("{no}")
 	public ResponseEntity<String> modifyQnA(@RequestBody QnA qna) {
 		logger.debug("modifyQnA - 호출");
 		logger.debug("" + qna);
 		
 		System.out.println(qna.getQnaDatetime());
 		System.out.println(qna.getReplyDatetime());
 		
 		
 		if (qna.getQnaDatetime() != null && qna.getQnaDatetime().contains("T")) {
 			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX");
 			Date date = null;
			try {
				date = sdf.parse(qna.getQnaDatetime());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			System.out.println(sdf2.format(date));
 			qna.setQnaDatetime(sdf2.format(date));
 		}
 		
 		if (qna.getReplyDatetime() != null && qna.getReplyDatetime().contains("T")) {
 			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX");
 			Date date = null;
			try {
				date = sdf.parse(qna.getReplyDatetime());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			System.out.println(sdf2.format(date));
 			qna.setReplyDatetime(sdf2.format(date));
 		}
 		
 		
 		if (qnaService.modifyQnA(qna)) {
 			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
 		}
 		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
 	}

     @ApiOperation(value = "글번호에 해당하는 게시글의 정보를 삭제한다. 그리고 DB삭제 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
 	@DeleteMapping("{no}")
 	public ResponseEntity<String> deleteQnA(@PathVariable int no) {
 		logger.debug("deleteQnA - 호출");
 		if (qnaService.deleteQnA(no)) {
 			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
 		}
 		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
 	}      
    
}