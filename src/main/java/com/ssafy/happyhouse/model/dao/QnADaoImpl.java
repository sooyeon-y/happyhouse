/*
 * package com.ssafy.happyhouse.model.dao;
 * 
 * import java.util.List;
 * 
 * import org.apache.ibatis.session.SqlSession; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Repository;
 * 
 * import com.ssafy.happyhouse.model.dto.QnA;
 * 
 * @Repository public class QnADaoImpl implements QnADao {
 * 
 * private SqlSession sqlSession;
 * 
 * @Autowired public void setSqlSession(SqlSession sqlSession) { this.sqlSession
 * = sqlSession; }
 * 
 * @Override public List<QnA> selectQnA() { return
 * sqlSession.selectList("qna.selectQnA"); }
 * 
 * @Override public int addQnA(QnA qna) { return sqlSession.insert("qna.addQnA",
 * qna); }
 * 
 * @Override public int modifyQnA(QnA qna) { return
 * sqlSession.update("qna.modifyQnA", qna); }
 * 
 * @Override public int deleteQnA(int no) { return
 * sqlSession.delete("qna.deleteQnA", no); }
 * 
 * @Override public QnA getQnA(int no) { return
 * sqlSession.selectOne("qna.getQnA", no); }
 * 
 * }
 */