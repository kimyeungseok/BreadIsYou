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
		obj.action="${contextPath}/goods/goodsDetail.do?goods_id=${goods_id}";
		obj.submit();
	}
  
</script> 
<title>리뷰 쓰기 페이지</title>
</head>

<body>


	<main class="mt-2 pt-2">
		<div class="container-fluid px-4" style="width:800px">
			<div class="title_underline">
				<h3 class="mt-4">후기</h3>
			</div>
			<div class="card mb-4">
				<div class="card-body">
					<form name="frmReply" method="post" action="${contextPath}/board/review/addNewReview.do" enctype="multipart/form-data">
						<div class="mb-3">
							<label class="form-label"><span>작성자</span></label> 
							<input type="text" class="form-control" value="${memberInfo.member_id}" readonly />
						</div>
						<div class="mb-3">
							<label class="form-label"><span>제품이름</span></label>
							<input type="text" class="form-control" value="${goodsInfo.goods_title}" readonly/>
						</div>
						<div class="mb-3">
							<label class="form-label"><span>별점</span></label>
							<br><input type="radio" name="star" value="5" checked />&nbsp;<img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg">
							<br><br><input type="radio" name="star" value="4"/>&nbsp;<img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg">
							<br><br><input type="radio" name="star" value="3"/>&nbsp;<img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg">
							<br><br><input type="radio" name="star" value="2"/>&nbsp;<img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg">
							<br><br><input type="radio" name="star" value="1"/>&nbsp;<img src="${contextPath}/resources/image/star1.jpg">
						</div>
						<div class="mb-3">
							<label class="form-label"><span>글내용</span></label>
							<textarea class="form-control" name="content"></textarea>
						</div>
						
						<input type=submit value="답글반영하기" class="btn btn-secondary btn-sm" />
						<input type=button value="취소"onClick="backToList(this.form)" class="btn btn-secondary btn-sm" />
								
					</form>
				</div>
			</div>
		</div>
	</main>

</body>
</html>