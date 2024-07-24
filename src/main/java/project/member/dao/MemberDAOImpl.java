package project.member.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import project.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl  implements MemberDAO{
	
	//의존성
	@Autowired
	private SqlSession sqlSession;	
	
	//로그인
	@Override
	public MemberVO login(Map loginMap) throws DataAccessException{
		MemberVO member=(MemberVO)sqlSession.selectOne("mapper.member.login",loginMap);
		
	    return member;
	}
	
	//회원가입
	@Override
	public void insertNewMember(MemberVO memberVO) throws DataAccessException{
		sqlSession.insert("mapper.member.insertNewMember",memberVO);
	}

	//아이디 중복검사
	@Override
	public String selectOverlappedID(String id) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.member.selectOverlappedID",id);
		
		return result;
	}
	
	//카카오 이메일 검사
	@Override
	public String checkEmail(String kakaoNewEmail) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.member.checkEmail", kakaoNewEmail);
		
		return result;
	}
	
	@Override
	public MemberVO email(String kakaoNewEmail) throws DataAccessException {
		MemberVO member = (MemberVO) sqlSession.selectOne("mapper.member.email", kakaoNewEmail);
		
		return member;
	}
	
}
