<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<head>
 <title>제품 검색 페이지</title>
</head>
<body>

	<div class="search-div">
		<div class="main-title">
			<h3>검색제품</h3>
		</div>
	</div>
		
	<c:set var="goods_count" value="0" />
	
	<div class="main_goods_div">
		
		<div class="main_goods">
		
			<c:forEach var="item" items="${goodsList}">
			
				<c:set var="goods_count" value="${goods_count+1 }" />
		
					<div class="goods">
						
					<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
						<img width="200" height="200" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
					</a>
					
					<div class="title"><b><br>${item.goods_title}</b></div>
					<div class="price">
						<fmt:formatNumber value="${item.goods_price}" type="number" var="goods_price" />
						<b>${goods_price}원</b>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
</body>