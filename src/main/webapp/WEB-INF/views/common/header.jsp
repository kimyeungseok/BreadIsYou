<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>

<script type="text/javascript">

	var loopSearch=true; // 제시된 키워드를 클릭하면 keywordSearch() 함수의 실행을 중지시킵니다.
	function keywordSearch(){
		if(loopSearch==false)
			return;
	var value=document.frmSearch.searchWord.value;
		$.ajax({
			type : "get",
			async : true, // false인 경우 동기식으로 처리합니다.
			url : "${contextPath}/goods/keywordSearch.do",
			data : {keyword:value},
			success : function(data, textStatus) {
				if(data != null && data != "")
			    var jsonInfo = JSON.parse(data); // 전송된 데이터를 JSON으로 파싱합니다.
				displayResult(jsonInfo); // 전송된 JSON 데이터를 표시합니다.
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다."+data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
				
			}
		}); //end ajax	
	}
	
	function displayResult(jsonInfo){
		if(jsonInfo != null && jsonInfo != "")
		var count = jsonInfo.keyword.length; // JSON 데이터 개수를 구합니다.
		if(count > 0) {
		    var html = '';
		    // JSON 데이터를 차례대로 <a> 태그를 이용해 키워드 목록을 만듭니다.
		    for(var i in jsonInfo.keyword){
			   html += "<a href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
		    }
		    // <a> 태그로 만든 키워드 목록을 <div> 태그에 차례대로 표시합니다.
		    var listView = document.getElementById("search-box-list");
		    listView.innerHTML = html;
		    show('search-box');
		    
		}else{
		    hide('search-box');
		} 
	}
	
	function select(selectedKeyword) {
		 document.frmSearch.searchWord.value=selectedKeyword;
		 loopSearch = false;
		 hide('search-box');
	}
	
	function show(elementId) {
		var element = document.getElementById(elementId);
		if(element) {
			element.style.display = 'block';
		}
	}
	
	function hide(elementId){
	   var element = document.getElementById(elementId);
	   if(element){
		  element.style.display = 'none';
	   }
	}
	
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	
	<nav class="navbar navbar-expand-lg fixed-top" style="background:white; margin-top:-10px;">
	
	    <div class="container-fluid">
	    
		    <a class="navbar-brand" href="${contextPath}/main/main.do">
		    	<img src="${contextPath}/resources/image/logofinal.jpg" style="width:120px;height:80px;"/>
		    </a>
		    
		    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
		        <span class="navbar-toggler-icon"></span>
		    </button>
		    
		    <div class="collapse navbar-collapse justify-content-between" id="collapsibleNavbar">
		    
		        <ul class="navbar-nav">
		        	
		        	<c:choose>
		            
						<c:when test="${isLogOn==true and not empty memberInfo}">
						
							<li class="nav-item">
								<a class="nav-link" href="${contextPath}/member/logout.do"><font color = "black">로그아웃</font></a>
							</li>
							
							<c:if test="${isLogOn==true and memberInfo.member_id =='admin' }">
						        <li class="nav-item dropdown">
						        <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							    <font color = "black">관리자메뉴</font>
							    </a>
									<ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
										<li><a class="dropdown-item" href="${contextPath}/admin/goods/adminGoodsMain.do">상품관리</a></li>
							            <li><a class="dropdown-item" href="${contextPath}/admin/order/adminOrderMain.do">주문관리</a></li>
							            <li><a class="dropdown-item" href="${contextPath}/admin/member/adminMemberMain.do">회원관리</a></li>
									</ul>
								</li>
							</c:if>
							
						</c:when>
						
						<c:otherwise>
						
							<li class="nav-item">
								<a class="nav-link" href="${contextPath}/member/loginForm.do"><font color = "black"  >로그인</font></a>
							</li>
							
							<li class="nav-item">
			         			<a class="nav-link" href="${contextPath}/member/memberForm.do"><font color = "black" >회원가입</font></a>
			     	   		</li>
							
						</c:otherwise>
						
					</c:choose>
		            
		        </ul>
		        
		        
				<ul class="navbar-nav" id="navbar-nav-2">
		            
		            
		      
		            <li class="nav-item">
		                <a class="nav-link" href="${contextPath}/admin/notice/listNotice.do"><font color = "black" >공지사항</font></a>
		            </li>
		            
		            <li class="nav-item">
		                <a class="nav-link" href="${contextPath}/board/qna/listQna.do"><font color = "black" >질문과답변</font></a>
		            </li>
		            
		            <li class="nav-item">
		                <a class="nav-link" href="${contextPath}/board/review/listReview.do"><font color = "black" >후기</font></a>
		            </li>
		            
		            <c:choose>
		            	<c:when test="${isLogOn==true and not empty memberInfo}">
		            
				            <li class="nav-item">
								<a class="nav-link" href="${contextPath}/cart/myCartList.do"><font color = "black" >장바구니</font></a>
							</li>
									
							<li class="nav-item">
								<a class="nav-link" href="${contextPath}/mypage/myPageMain.do"><font color = "black" >마이페이지</font></a>
							</li>
							
						</c:when>
					</c:choose>
		            
		            <form class="d-flex align-items-center justify-content-center" role="search" name="frmSearch" action="${contextPath}/goods/searchGoods.do" style="margin-top:17px">
						<input class="form-control me-2" name="searchWord" type="search" placeholder="제품 검색" aria-label="Search" style="height:30px" onKeyUp="keywordSearch()">
						<button class="btn btn-outline-light btn-sm" type="submit" style="width:100px;"><font color = "black" >검&nbsp;색</font></button>
					</form>
					<div id="search-box">
				        <div id="search-box-list"></div>
				   </div>
					
		        </ul>
		        	
		    </div>
		    
	    </div>
	    
	</nav>

</body>
</html>