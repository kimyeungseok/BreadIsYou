<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="qna" value="${qnaMap.qnaVO}" />
<c:set var="goods_id" value="${goods_id}"/>

<%
  request.setCharacterEncoding("UTF-8");
%>

<head>
<meta charset="UTF-8">
<title>QNA상세</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

function backToList2(obj){
	obj.action="${contextPath}/goods/goodsDetail.do?goods_id="+${goods_id};
	obj.submit();
}

function fn_enable(obj){
	document.getElementById("i_title").disabled=false;
	document.getElementById("i_content").disabled=false;
}

function backToList(obj){
	obj.action="${contextPath}/board/qna/viewQna.do?qna_id="+${qna.qna_id};
	obj.submit();
}


//qna 수정
function fn_update_qna(obj){
	obj.action="${contextPath}/board/qna/updateQna.do";
	obj.submit();
}
 
</script> 
</head>
<html>
<body>

	
	<main class="mt-2 pt-2">
		<div class="container-fluid px-4" style="width:800px">
			<div class="title_underline">
				<h4 class="mt-4">QNA상세</h4>
			</div>
			<div class="card mb-4">
				<div class="card-body">
					<form name="formQna" method="post" action="${contextPath}" enctype="multipart/form-data">
						<div class="mb-3 mt-3">
							<label for="bno" class="form-label"><span>글번호</span></label> 
							<input type="text" class="form-control" value="${qna.qna_id}" disabled>
							<input type="hidden" name="qna_id" value="${qna.qna_id}"/>
						</div>
						<div class="mb-3">
							<label for="title" class="form-label"><span>제목</span></label> 
							<input type="text" class="form-control" id="i_title" name="qna_title" value="${qna.title}" disabled>
						</div>
						<div class="mb-3">
							<label for="content" class="form-label"><span>내용</span></label>
							<textarea class="form-control" id="i_content" name="qna_content" disabled>${qna.content}</textarea>
						</div>
						<div class="mb-3">
							<label for="regDate" class="form-label"><span>작성일</span></label>
							<input type="text" class="form-control" id="regDate" name="qna.write_date" value="${qna.write_date}" disabled>
						</div>
						<div class="mb-3">
							<label for="writer" class="form-label"><span>아이디</span></label>
							<input type="text" class="form-control" name="qna.member_id" value="${qna.member_id}" disabled>
						</div>
						<div class="mb-3">
							<label for="writer" class="form-label"><span>상품번호</span></label>
							<input type="text" class="form-control" name="goods_id" value="${qna.goods_id}" disabled>
						</div>
						
						<input type="button" value="상품페이지로 돌아가기" onClick="backToList2(formQna)" class="btn btn-secondary btn-sm" />
						
						
						<c:if test="${isLogOn==true and memberInfo.member_id == qna.member_id}">
							<input type="button" value="수정" onClick="fn_enable(this.form)" class="btn btn-secondary btn-sm" />
							<input type="button" value="수정반영" onClick="fn_update_qna(formQna)" class="btn btn-secondary btn-sm" />
							<input type="button" value="취소" onClick="backToList(formQna)" class="btn btn-secondary btn-sm" />
						</c:if>
						
					</form>
				</div>
			</div>
		</div>
	</main>
	
</body>
</html>