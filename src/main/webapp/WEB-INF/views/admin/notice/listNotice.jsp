<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:set var="articlesList" value="${articlesMap.articlesList}" />
<c:set var="section" value="${articlesMap.section}" />
<c:set var="pageNum" value="${articlesMap.pageNum}" />
<c:set var="totArticles" value="${articlesMap.totArticles}" />

<%
	request.setCharacterEncoding("UTF-8");
%>
<%-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 목록</title>

<script>
	/* 공지 삭제 */
	function deleteNotice(member_id) {
		$.ajax({
		    type : "post",
		    async : true, //false인 경우 동기식으로 처리한다.
		    url : "${contextPath}/admin/notice/removeArticle.do",
		    data: {member_id:member_id},
		    success : function(data, textStatus) {
		    	location.reload();
		    	alert("공지를 삭제했습니다.");
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
			obj.action = "${contextPath}/admin/notice/listNotice.do";
			obj.submit();
	}
	
</script>

</head>
<body>
	
	
	<div class="notice-div" >
	
		<div class="title_underline">
			<h3><b>공지사항</b></h3>
		</div>
		
		<table class="table table-striped table-hover">
			<thead>
			<tr align="center" style="background:#00BFFE">
				<td width="5%"><b>번호</b></td>
				<td width="65%"><b>제목</b></td>
				<td width="20%"><b>날짜</b></td>
				<td width="10%" align="left"><b>조회수</b></td>
			</tr>
			</thead>
			
			<c:choose>
				<c:when test="${articlesList == null}">
					<tr>
						<td>
							<p>
								<b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
							</p>
						</td>
					</tr>
				</c:when>
		
				<c:when test="${articlesList != null}">
					<c:forEach var="notice" items="${articlesList}" varStatus="noticeNum" >
						<tr>
							<td align="center">
								${notice.rnum}
							</td>
							<td align="center">
								<a href="${contextPath}/admin/notice/viewNotice.do?notice_id=${notice.member_id}">
									${notice.title}
								</a>
							</td>
							<td align="center">
								${notice.write_date}
							</td>
							<td align="center">
								${notice.cnt}
								<c:if test="${isLogOn==true and memberInfo.member_id == 'admin'}">
									&nbsp;&nbsp;<input type="button" value="X" onClick="deleteNotice('${notice.member_id}')">
								</c:if>
							</td>
							
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
		
	</div>

	<div class="paging-div">
		<c:if test="${totArticles != null }">
			<c:choose>
				<c:when test="${totArticles >100 }">
					<!-- 글 개수가 100 초과인경우 -->
					<c:forEach var="page" begin="1" end="10" step="1">
						<c:if test="${section >1 && page==1 }">
							<a class="no-uline"
								href="${contextPath }/admin/notice/listNotice.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;
								pre </a>
						</c:if>
						<a class="no-uline"
							href="${contextPath }/admin/notice/listNotice.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }
						</a>
						<c:if test="${page ==10 }">
							<a class="no-uline"
								href="${contextPath }/admin/notice/listNotice.do?section=${section+1}&pageNum=${section*10+1}">&nbsp;
								next</a>
						</c:if>
					</c:forEach>
				</c:when>
				<c:when test="${totArticles ==100 }">
					<!--등록된 글 개수가 100개인경우  -->
					<c:forEach var="page" begin="1" end="10" step="1">
						<a class="no-uline" href="#">${page } </a>
					</c:forEach>
				</c:when>

				<c:when test="${totArticles< 100 }">
					<!--등록된 글 개수가 100개 미만인 경우  -->
					<c:forEach var="page" begin="1" end="${totArticles/10 +1}" step="1">
						<c:choose>
							<c:when test="${page==pageNum }">
								<a class="sel-page"
									href="${contextPath }/admin/notice/listNotice.do?section=${section}&pageNum=${page}">${page }
								</a>
							</c:when>
							<c:otherwise>
								<a class="no-uline"
									href="${contextPath }/admin/notice/listNotice.do?section=${section}&pageNum=${page}">${page }
								</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
		</c:if>
		<br>
		<c:if test="${isLogOn==true and memberInfo.member_id =='admin'}">
			<form action="${contextPath}/admin/notice/insertNotice.do">
				<br>
				<input type="submit" value="공지쓰기" class="btn btn-secondary">
			</form>
		</c:if>
	
	</div>
	
	
	
</body>
</html> --%>





<!DOCTYPE html>
<html>
<head>
<style>
.no-uline {
	text-decoration: none;
}

.sel-page {
	text-decoration: none;
	color: red;
}

.cls1 {
	text-decoration: none;
}

.cls2 {
	text-align: center;
	font-size: 30px;
}
</style>
<meta charset="UTF-8">
<title>글목록창</title>
</head>
<script>
	function fn_articleForm(isLogOn, articleForm, loginForm) {
		if (isLogOn != '' && isLogOn != 'false') {
			location.href = articleForm;
		} else {
			alert("로그인 후 글쓰기가 가능합니다.")
			location.href = loginForm
					+ '?action=/admin/noitce/insertNoticeForm.do';
		}
	}
</script>
<body>
	<table align="center" border="1" width="80%">
		<tr height="10" align="center" bgcolor="#2a4c34">
			<td><font color="white">글번호</font></td>
			<!-- <td ><font color = "white" >작성자</font></td>  -->
			<td><font color="white">제목</font></td>
			<td><font color="white">작성일</font></td>
			<td><font color="white">조회수</font></td>

		</tr>
		<c:choose>
			<c:when test="${articlesList == null }">
				<tr height="10">
					<td colspan="4">
						<p align="center">
							<b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
						</p>
					</td>
				</tr>
			</c:when>
			<c:when test="${articlesList != null }">
				<c:forEach var="article" items="${articlesList }"
					varStatus="articleNum">
					<tr align="center">
						<td width="5%">${articleNum.count}</td>
						<%-- <td width="10%">${article.member_id }</td>  --%>
						<td align='left' width="35%"><span
							style="padding-right: 30px"></span> <c:choose>
								<c:when test='${article.level > 1 }'>
									<c:forEach begin="1" end="${article.level }" step="1">
										<span style="padding-left: 20px"></span>
									</c:forEach>
									<span style="font-size: 12px;"><img
										src="${contextPath}/resources/image/ico_re.gif" /></span>
									<a class='cls1'
										href="${contextPath}/admin/notice/viewNotice.do?articleNO=${article.articleNO}">${article.title}</a>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${article.newArticle==true}">
											<a class='cls1'
												href="${contextPath}/admin/notice/viewNotice.do?articleNO=${article.articleNO}">${article.title }</a>
											<img src="${contextPath}/resources/image/ico_new.gif" />
										</c:when>
										<c:otherwise>
											<a class='cls1'
												href="${contextPath}/admin/notice/viewNotice.do?articleNO=${article.articleNO}">${article.title }</a>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose></td>
						<td width="10%"><fmt:formatDate value="${article.writeDate}" /></td>
						<td width="10%">${article.viewCounts}</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>


	<div class="cls2">
		<c:if test="${not empty totArticles }">
			<c:choose>
				<c:when test="${totArticles >100 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<c:if test="${section >1 && page==1 }">
							<a class="no-uline"
								href="${contextPath }/admin/notice/listNotice.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;
								pre</a>
						</c:if>
						<a class="no-uline"
							href="${contextPath }/admin/notice/listNotice.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }
						</a>
						<c:if test="${page==10 }">
							<a class="no-uline"
								href="${contextPath }/admin/notice/listNotice.do?section=${section+1}&pageNum=${section*10+1}">&nbsp;
								next</a>
						</c:if>
					</c:forEach>
				</c:when>
				<c:when test="${totArticles == 100 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<a class="no-uline" href="#">${page } </a>
					</c:forEach>
				</c:when>
				
				<c:when test="${totArticles< 100 }">
					<c:forEach var="page" begin="1" end="${totArticles/10 +1}" step="1">
						<c:choose>
							<c:when test="${page == pageNum }">
								<a class="sel-page"
									href="${contextPath }/admin/notice/listNotice.do?section=${section}&pageNum=${page}">${page }
								</a>
							</c:when>
							<c:otherwise>
								<a class="no-uline"
									href="${contextPath }/admin/notice/listNotice.do?section=${section}&pageNum=${page}">${page }
								</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
		</c:if>

	</div>

	<!-- <a  class="cls1"  href="#"><p class="cls2">글쓰기</p></a> -->
	 <a  class="cls1"  href="javascript:fn_articleForm('${isLogOn}',
			'${contextPath}/admin/notice/insertNoticeForm.do' , 
 			'${contextPath}/member/loginForm.do' )"><p class="cls2"><font color = "black" >글쓰기</font></p></a>  

	<%-- <c:if test="${isLogOn==true and memberInfo.member_id =='admin'}">
		<form action="${contextPath}/admin/notice/insertNoticeForm.do">
			<br> <input type="submit" value="공지쓰기" class="btn btn-secondary">
		</form>
	</c:if> --%>

</body>
</html>








