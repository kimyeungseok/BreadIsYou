<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%> 

<head>
<meta charset="UTF-8">
 <script src="//code.jquery.com/jquery-3.3.1.js"></script> 
<script type="text/javascript">

 function backToList(obj){
	 obj.action="${contextPath}/main/main.do";
	 obj.submit();
 }
  
</script> 
<title>QNA 쓰기 페이지</title>
</head>

<body>

	<main class="mt-2 pt-2">
		<div class="container-fluid px-4" style="width:800px">
			<div class="title_underline">
				<h3 class="mt-4">질문과 답변</h3>
			</div>
			<div class="card mb-4">
				<div class="card-body">
					<form action="${contextPath}/board/qna/addNewQna.do" method="post">
					
						<div class="mb-3 mt-3">
							<label class="form-label"><span>작성자</span></label> 
							<input type="text" class="form-control" value="${memberInfo.member_id}" readonly/>
						</div>
						<div class="mb-3 mt-3">
							<label class="form-label"><span>제품 이름</span></label> 				<!-- 세션에 바인딩 시킨 goodsInfo에서 goods_title을 빼온다. -->
							<input type="text" class="form-control" value="${goodsInfo.goods_title}" readonly/>
						</div>
											
						<div class="mb-3">
							<label class="form-label"><span>제목</span></label> 
							<input type="text" class="form-control" name="title" />
						</div>
						<div class="mb-3">
							<label class="form-label"><span>내용</span></label>
							<textarea class="form-control" name="content"></textarea>
						</div>
						
						
						<input type=submit value="질문 쓰기" class="btn btn-secondary btn-sm"/>
						<input type=button value="취소" class="btn btn-secondary btn-sm" onClick="backToList(this.form)" />
								
					</form>
				</div>
			</div>
		</div>
	</main>
	
</body>
</html>