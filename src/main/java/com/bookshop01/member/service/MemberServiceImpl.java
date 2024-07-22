package com.bookshop01.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop01.member.dao.MemberDAO;
import com.bookshop01.member.vo.MemberVO;

@Service("memberService")
@Transactional(propagation=Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {
	//의존성
	@Autowired
	private MemberDAO memberDAO;
	
	//로그인
	@Override
	public MemberVO login(Map loginMap) throws Exception{
		return memberDAO.login(loginMap);
	}
	
	//회원가입
	@Override
	public void addMember(MemberVO memberVO) throws Exception{
		memberDAO.insertNewMember(memberVO);
	}
	
	//아이디 중복검사
	@Override
	public String overlapped(String id) throws Exception{
		return memberDAO.selectOverlappedID(id);
	}
	
	//카카오 이메일 검사
	@Override
	public String emailCheck(String kakaoNewEmail) throws Exception {
		return memberDAO.checkEmail(kakaoNewEmail);
	}
	
	@Override
	public MemberVO email(String kakaoNewEmail) throws Exception {
		return memberDAO.email(kakaoNewEmail);
	}
	
}
