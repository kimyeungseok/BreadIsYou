<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:if test='${not empty message }'>

<script>
	window.onload=function()
	{
	  result();
	}
	
	function result(){
		alert("아이디나  비밀번호가 틀립니다. 다시 로그인해주세요");
	}
</script>

</c:if>
</head>
<body>
	<div class="login_div">
		
		<small style="opacity:0.6;"></small>
		<h1>BREAD IS YOU</h1><br><br>
		
		<form action="${contextPath}/member/login.do" method="post" class="login-form" id="login_form">
			<input name="member_id" type="text" placeholder=" 아이디" style="height:30px; width:300px;" /><br><br>
			<input name="member_pw" type="password" placeholder=" 비밀번호" style="height:30px; width:300px;" /><br><br>
			<input type="hidden" name="kakaoemail" id="kakaoemail" />
			<input type="submit" value="로그인" class="btn" style="width:200px; background:#FDBA69; color:white;"> 
			<input type="button" value="초기화" class="btn btn-secondary" style="width:90px">
			<br><br>
			<small style="opacity:0.6;">아직 회원이 아니시라면? </small>
			<a href="${contextPath}/member/memberForm.do" class="no-underline">회원가입</a>
			
			<br><br>
			<div class="kakaobtn">
				<a href="javascript:kakaoLogin()">
				<img src="https://www.gb.go.kr/Main/Images/ko/member/certi_kakao_login.png" style="width:250px; height:50px;" /></a>
			</div>
			
		</form>
		
	</div>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	window.Kakao.init("da4bef609228b4a716f5e04f6cd08cbc");
	
	function kakaoLogin() {
		window.Kakao.Auth.login({
			scope:'account_email',
			success: function(authObj) {
				window.Kakao.API.request({
					url:'/v2/user/me', 
					success: res => {
						const email = res.kakao_account.email;
						$('#kakaoemail').val(email);
						console.log(email);
						
						if(email != null)
							document.getElementById('login_form').submit();
					}
				});
			}
		});
	}
</script>
</body>
</html>