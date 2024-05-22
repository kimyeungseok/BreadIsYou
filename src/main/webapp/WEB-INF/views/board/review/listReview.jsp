<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:set var="reviewList" value="${reviewMap.reviewList}" />
<c:set var="section" value="${reviewMap.section}" />
<c:set var="pageNum" value="${reviewMap.pageNum}" />
<c:set var="totalReview" value="${reviewMap.totalReview}" />

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 목록</title>

<script>
	/* 후기 삭제 */
	function deleteReview(review_id) {
		$.ajax({
		    type : "post",
		    async : true, //false인 경우 동기식으로 처리한다.
		    url : "${contextPath}/board/review/removeReview.do",
		    data: {review_id:review_id},
		    success : function(data, textStatus) {
		    	location.reload();
		    	alert("후기를 삭제했습니다.");
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
			obj.action = "${contextPath}/board/review/listReview.do";
			obj.submit();
	}
	
</script>

</head>
<body>
	
	
	<div class="review-div" >
		
		<div class="title_underline">
			<h3><b>후기</b></h3>
		</div>
		
		<table class="table table-striped table-hover">
			<thead>
			<tr align="center" style="background:#00BFFE">
				<td width="7%"><b>번호</b></td>
				<td width="10%"><b>작성자</b></td>
				<td width="10%"><b>상품번호</b></td>
				<td width="49%"><b>제목</b></td>
				<td width="10%"><b>별점</b></td>
				<td width="14%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>날짜</b></td>
			</tr>
			</thead>
			
			<c:choose>
				<c:when test="${reviewList == null}">
					<tr>
						<td>
							<p>
								<b>등록된 글이 없습니다.</b>
							</p>
						</td>
					</tr>
				</c:when>
		
				<c:when test="${reviewList != null}">
					<c:forEach var="review" items="${reviewList}" varStatus="reviewNum" >
						<tr>
							<td align="center">
								${review.rnum}
							</td>
							<td align="center">
								${review.member_id}
							</td>
							<td align="center">
								${review.goods_id}
							</td>
							<td align="center">
								${review.content}
							</td>
							
							<c:if test="${review.star == 5}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
							<c:if test="${review.star == 4}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
							<c:if test="${review.star == 3}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
							<c:if test="${review.star == 2}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
							<c:if test="${review.star == 1}"><td><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
							
							<td align="left">
								${review.write_date}
								<c:if test="${isLogOn == true and review.member_id == memberInfo.member_id || isLogOn == true and memberInfo.member_id == 'admin'}">
									&nbsp;<input type="button" value="X" onClick="deleteReview('${review.review_id}')"> <!-- style="border:none;" -->
								</c:if>
							</td>
							
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
	</div>

	<!--  -->
	<div class="paging-div">
		<c:if test="${totalReview != null }">
			<c:choose>
				<c:when test="${totalReview >150 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<c:if test="${section >1 && page==1 }">
							<a class="no-uline"
								href="${contextPath }/board/review/listReview.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;
								pre </a>
						</c:if>
						<a class="no-uline"
							href="${contextPath }/board/review/listReview.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }
						</a>
						<c:if test="${page ==10 }">
							<a class="no-uline"
								href="${contextPath }/board/review/listReview.do?section=${section+1}&pageNum=${section*10+1}">&nbsp;
								next</a>
						</c:if>
					</c:forEach>
				</c:when>
				<c:when test="${totalReview ==150 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<a class="no-uline" href="#">${page } </a>
					</c:forEach>
				</c:when>

				<c:when test="${totalReview< 150 }">
					<c:forEach var="page" begin="1" end="${totalReview/10 +1}" step="1">
						<c:choose>
							<c:when test="${page==pageNum }">
								<a class="sel-page"
									href="${contextPath }/board/review/listReview.do?section=${section}&pageNum=${page}">${page }
								</a>
							</c:when>
							<c:otherwise>
								<a class="no-uline"
									href="${contextPath }/board/review/listReview.do?section=${section}&pageNum=${page}">${page }
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