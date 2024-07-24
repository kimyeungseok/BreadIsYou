package project.member.service;

import java.util.Map;

import project.member.vo.MemberVO;

public interface MemberService {
	//로그인
	public MemberVO login(Map  loginMap) throws Exception;
	//회원가입
	public void addMember(MemberVO memberVO) throws Exception;
	//아이디 중복검사
	public String overlapped(String id) throws Exception;
	
	//카카오 이메일 검사
	public String emailCheck(String kakaoNewEmail) throws Exception;
	
	public MemberVO email(String kakaoNewEmail) throws Exception;
}
