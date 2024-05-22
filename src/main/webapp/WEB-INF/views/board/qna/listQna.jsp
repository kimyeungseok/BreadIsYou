<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:set var="qnaList" value="${qnaMap.qnaList}" />
<c:set var="section" value="${qnaMap.section}" />
<c:set var="pageNum" value="${qnaMap.pageNum}" />
<c:set var="totalQna" value="${qnaMap.totalQna}" />

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>묻고 답하기 목록</title>

<script>
	/* 묻고답하기 삭제 */
	function deleteQna(qna_id) {
		$.ajax({
		    type : "post",
		    async : true, //false인 경우 동기식으로 처리한다.
		    url : "${contextPath}/board/qna/removeQna.do",
		    data: {qna_id:qna_id},
		    success : function(data, textStatus) {
		    	location.reload();
		    	alert("QNA를 삭제했습니다.");
		        tr.style.display = 'none';
		   	},
		    error : function(data, textStatus) {
		    	alert("에러가 발생했습니다."+textStatus);
		    },
		    complete : function(data, textStatus) {
		    	//alert("작업을완료 했습니다");
		    }
		    
		}); //end ajax	
	}
	
	function backToList(obj) {
			obj.action = "${contextPath}/board/qna/listQna.do";
			obj.submit();
	}
	
</script>

</head>
<body>
	
	
	<div class="qna-div" >
	
		<div class="title_underline">
			<h3><b>질문과답변</b></h3>
		</div>
		
		<table class="table table-striped table-hover">
			<thead>
			<tr align="center" style="background:#00BFFE">
				<td width="7%"><b>번호</b></td>
				<td width="7%"><b>작성자</b></td>
				<td width="12%"><b>상품번호</b></td>
				<td width="30%"><b>제목</b></td>
				<td width="30%"><b>내용</b></td>
				<td width="14%"><b>날짜</b></td>
			</tr>
			</thead>
			
			<c:choose>
				<c:when test="${qnaList == null}">
					<tr>
						<td>
							<p>
								<b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
							</p>
						</td>
					</tr>
				</c:when>
		
				<c:when test="${qnaList != null}">
					<c:forEach var="qna" items="${qnaList}" varStatus="reviewNum" >
						<tr>
							<td align="center">
								${qna.rnum}
							</td>
							<td align="center">
								${qna.member_id}
							</td>
							<td align="center">
								${qna.goods_id}
							</td>
							<td align="center">
								${qna.title}
							</td>
							<td align="center">
								${qna.content}
							</td>
							<td align="left">
								${qna.write_date}
								<c:if test="${isLogOn == true and review.member_id == memberInfo.member_id || isLogOn == true and memberInfo.member_id == 'admin'}">
									&nbsp;<input type="button" value="X" onClick="deleteQna('${qna.qna_id}')">
								</c:if>
							</td>
							
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
	</div>

	<!-- 페이징 -->
	<div class="paging-div">
		<c:if test="${totalQna != null }">
			<c:choose>
				<c:when test="${totalQna >150 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<c:if test="${section >1 && page==1 }">
							<a class="no-uline" href="${contextPath }/board/qna/listQna.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;
								pre </a>
						</c:if>
							<a class="no-uline" href="${contextPath }/board/qna/listQna.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }
							</a>
						<c:if test="${page ==10 }">
							<a class="no-uline" href="${contextPath }/board/qna/listQna.do?section=${section+1}&pageNum=${section*10+1}">&nbsp;
								next</a>
						</c:if>
					</c:forEach>
				</c:when>
				<c:when test="${totalQna ==150 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<a class="no-uline" href="#">${page } </a>
					</c:forEach>
				</c:when>

				<c:when test="${totalQna< 150 }">
					<c:forEach var="page" begin="1" end="${totalQna/15 +1}" step="1">
						<c:choose>
							<c:when test="${page==pageNum }">
								<a class="sel-page" href="${contextPath }/board/qna/listQna.do?section=${section}&pageNum=${page}">${page }
								</a>
							</c:when>
							<c:otherwise>
								<a class="no-uline" href="${contextPath }/board/qna/listQna.do?section=${section}&pageNum=${page}">${page }
								</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
		</c:if>
	</div>
	
</body>
</html>