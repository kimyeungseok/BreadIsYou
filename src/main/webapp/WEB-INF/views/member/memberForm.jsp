<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script>

	function fn_overlapped() {
		var _id = $("#_member_id").val();
		if (_id == '') {
			alert("ID를 입력하세요");
			return;
		}
		$.ajax({
			type : "post",
			async : false,
			url : "${contextPath}/member/overlapped.do",
			dataType : "text",
			data : {
				id : _id
			},
			success : function(data, textStatus) {
				if (data == 'false') {
					alert("사용할 수 있는 ID입니다.");
					$('#btnOverlapped').prop("disabled", true);
					$('#_member_id').prop("disabled", true);
					$('#member_id').val(_id);
				} else {
					alert("사용할 수 없는 ID입니다.");
				}
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다.");
				ㅣ
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
			}
		}); //end ajax	 
	}
</script>
</head>
<body>
	<div class="signup_div">
	
	<small style="opacity:0.6;"></small>
	<h1>BREAD IS YOU</h1><br><br>
	
	<form action="${contextPath}/member/addMember.do" method="post">
	
		<input type="text" name="_member_id" id="_member_id" placeholder=" 아이디" style="height:30px; width:190px;" />&nbsp;
		<input type="hidden" name="member_id" id="member_id" />
		<input type="button" id="btnOverlapped" value="중복체크" onClick="fn_overlapped()" class="btn" style="width:100px; background:#FDBA69; color:white;" /><br><br>
		
		<input name="member_pw" type="password" placeholder=" 비밀번호" style="height:30px; width:300px;" /><br><br>
		
		<input name="member_name" type="text" placeholder=" 이름" style="height:30px; width:240px;" />
		
		<select name="member_gender" style="height:30px">
			<option value="102">여성</option>
			<option value="101">남성</option>
		</select>
		
		<br><br>
		
		<select name="member_birth_y" style="height:30px; width:90px;" required>
			<c:forEach var="year" begin="0" end="100">
				<c:choose>
					<c:when test="${year < 1 }">
						<option value="" disabled selected>생년</option>
					</c:when>
					<c:when test="${year==80}">
						<option value="${ 1920+year}">${ 1920+year}</option>
					</c:when>
					<c:otherwise>
						<option value="${ 1920+year}">${ 1920+year}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>

		<select name="member_birth_m" style="height:30px; width:70px;" required>
			<c:forEach var="month" begin="0" end="12">
				<c:choose>
					<c:when test="${month < 1 }">
						<option value="" disabled selected>월</option>
					</c:when>
					<c:when test="${month==5 }">
						<option value="${month }">${month }</option>
					</c:when>
					<c:otherwise>
						<option value="${month }">${month}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
			
		<select name="member_birth_d" style="height:30px; width:70px;" required>
			<c:forEach var="day" begin="0" end="31">
				<c:choose>
					<c:when test="${day < 1 }">
						<option value="" disabled selected>일</option>
					</c:when>
					<c:when test="${day==10 }">
						<option value="${day}">${day}</option>
					</c:when>
					<c:otherwise>
						<option value="${day}">${day}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>	
		</select> 
		
		<select name="member_birth_gn" style="height:30px;">
			<option value="2">양력</option>
			<option value="1">음력</option>
		</select>
		
		<br><br> 
		
		<select name="tel1" style="height:30px; ">
			<option>없음</option>
			<option value="02">02</option>
			<option value="031">031</option>
			<option value="032">032</option>
			<option value="033">033</option>
			<option value="041">041</option>
			<option value="042">042</option>
			<option value="043">043</option>
			<option value="044">044</option>
			<option value="051">051</option>
			<option value="052">052</option>
			<option value="053">053</option>
			<option value="054">054</option>
			<option value="055">055</option>
			<option value="061">061</option>
			<option value="062">062</option>
			<option value="063">063</option>
			<option value="064">064</option>
			<option value="0502">0502</option>
			<option value="0503">0503</option>
			<option value="0505">0505</option>
			<option value="0506">0506</option>
			<option value="0507">0507</option>
			<option value="0508">0508</option>
			<option value="070">070</option>
		</select> - 
			
		<input size="10px" type="text" name="tel2" style="width:107px;"> - 
		<input size="10px" type="text" name="tel3" style="width:107px;"> 
		
		<br><br> 
			
		<select name="hp1" style="height:30px;">
			<option>없음</option>
			<option selected value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
		</select> - <input size="10px" type="text" name="hp2" style="width:109px;"> - 
		<input size="10px" type="text" name="hp3" style="width:109px;">
		<br> <br>
			<input type="checkbox" name="smssts_yn" value="Y" checked /> 쇼핑몰에서 발송하는 SMS 소식을 수신<br><br> 
		
		<input size="10px" type="text" name="email1" style="width:93px;" /> @
		<input size="10px" type="text" name="email2" id="email2" style="width:93px;" />
		<select name="email3" id="email3" onChange="updateEmail2()" title="직접입력" style="height:30px; width:90px;">
	<option value="non">직접입력</option>
	<option value="hanmail.net">hanmail.net</option>
	<option value="naver.com">naver.com</option>
	<option value="yahoo.co.kr">yahoo.co.kr</option>
	<option value="hotmail.com">hotmail.com</option>
	<option value="paran.com">paran.com</option>
	<option value="nate.com">nate.com</option>
	<option value="google.com">google.com</option>
	<option value="gmail.com">gmail.com</option>
	<option value="empal.com">empal.com</option>
	<option value="korea.com">korea.com</option>
	<option value="freechal.com">freechal.com</option>
</select><br><br>
			<input type="checkbox" name="emailsts_yn" value="Y" checked /> 쇼핑몰에서 발송하는 e-mail을 수신<br><br> 
				
		<input type="text" id="zipcode" name="zipcode" placeholder=" 우편번호" style="height:30px; width:165px;">&nbsp;
		<input type="button" value="우편번호검색" onClick="javascript:execDaumPostcode()" class="btn" style="width:130px; background:#FDBA69; color:white;"><br><br>
					
		<input type="text" id="jibunAddress" name="jibunAddress" placeholder=" 지번주소" style="height:30px; width:305px;" ><br><br>
					
		<input type="text" id="roadAddress" name="roadAddress" placeholder=" 도로명주소" style="height:30px; width:305px; border:1px solid black; border-bottom:none; "><br>
					
		<input type="text" name="namujiAddress" placeholder=" 나머지주소" style="height:30px; width:305px; border:1px solid black; border-top:none;"><br><br>
			
		<input type="submit" value="회원가입" class="btn" style="width: 200px; height: 50px; background:#FDBA69; color:white;">
		
		<input type="reset" value="다시입력" class="btn btn-secondary" style="width: 100px; height: 50px;">
	</form>
	</div>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        var fullRoadAddr = data.roadAddress;
        var extraRoadAddr = '';
        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
          extraRoadAddr += data.bname;
        }
        if (data.buildingName !== '' && data.apartment === 'Y') {
          extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
        }
        if (extraRoadAddr !== '') {
          extraRoadAddr = ' (' + extraRoadAddr + ')';
        }
        if (fullRoadAddr !== '') {
          fullRoadAddr += extraRoadAddr;
        }

        document.getElementById('zipcode').value = data.zonecode;
        document.getElementById('roadAddress').value = fullRoadAddr;
        document.getElementById('jibunAddress').value = data.jibunAddress;

        if (data.autoRoadAddress) {
          var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
          document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
        } else if (data.autoJibunAddress) {
          var expJibunAddr = data.autoJibunAddress;
          document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
        } else {
         /*  document.getElementById('guide').innerHTML = ''; */
        }
       
      }
    }).open();
  }
  
function updateEmail2() {
	  var email3 = document.getElementById("email3").value;
	  if (email3 == "non") {
	    document.getElementById("email2").value = "";
	    document.getElementById("email2").readOnly = false;
	  } else {
	    document.getElementById("email2").value = email3;
	    document.getElementById("email2").readOnly = true;
	  }
	}
  
</script>
</body>
</html>