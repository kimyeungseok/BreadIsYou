<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active" data-bs-interval="3000">
    	<img src="${contextPath}/resources/image/bb3.jpg" class="d-block w-100" alt="..." >
    </div>
     <div class="carousel-item" data-bs-interval="3000">
    	<img src="${contextPath}/resources/image/bb4.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item" data-bs-interval="3000">
    	<img src="${contextPath}/resources/image/bb1.jpg" class="d-block w-100" alt="...">
    </div> 
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

	<!-- 버튼 -->
	<div class="main_btn_div">
		
		<a href="#total">
			<div class="btn" id="main_btn_menu">
			<font color = "black" >
				전체제품
				</font>
			</div>
		</a>
		<a href="#best">
			<div class="btn" id="main_btn_menu">
			<font color = "black" >
				인기제품
				</font>
			</div>
		</a>
		<a href="#new">
			<div class="btn" id="main_btn_menu">
			<font color = "black" >
				신제품
				</font>
			</div>
		</a>
		<a href="#discount">
			<div class="btn" id="main_btn_menu">
			<font color = "black" >
				사장님 추천 제품
				</font>
			</div>
		</a>
	</div>
	<!--  -->
	
	
	
	<div class="main-title-div" id="best">
		<div class="main-title">
			<h3>인기제품</h3>
		</div>
	</div>
		
	<div class="main_goods_div">
		<div class="main_goods">
			<c:set var="goods_count" value="0" />
			<c:forEach var="item" items="${goodsMap.bestgoods }">
				<c:set var="goods_count" value="${goods_count+1 }" />
				<div class="goods">
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
			<img class="link"  src="${contextPath}/resources/image/1px.gif"> 
			</a> 
				<img width="200" height="200" 
				     src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">

			<div class="title">${item.goods_title }</div>
			<div class="price">
		  	   <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		          ${goods_price}원
			</div>
		</div>
	   <c:if test="${goods_count==15   }">
         <div class="goods">
           <font size=20> <a href="#">더보기</a></font>
         </div>
         </c:if>
			</c:forEach>
		</div>
	</div>
	
	
	
	<%-- <div class="main_goods_div">
		
		<div class="main_goods">
		
			<c:forEach var="item" items="${goodsMap.bestgoods}">
			
				<c:set var="goods_count" value="${goods_count+1 }" />
				<c:if test="${item.goods_avg_star >= 1 && item.goods_review_count >= 10}">
					<div class="goods">
						
					<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
						<img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" style="width:200px; height:200px;">
					</a>
					
					<div class="title"><small>${item.goods_publisher}</small><b><br>${item.goods_title}</b></div>
					<div class="price">
						<fmt:formatNumber value="${item.goods_price}" type="number" var="goods_price" />
						<b>${goods_price}원</b><br>
						<c:if test="${item.goods_avg_star == 5}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
						<c:if test="${item.goods_avg_star == 4}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
						<c:if test="${item.goods_avg_star == 3}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
						<c:if test="${item.goods_avg_star == 2}"><td><img src="${contextPath}/resources/image/star1.jpg"><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
						<c:if test="${item.goods_avg_star == 1}"><td><img src="${contextPath}/resources/image/star1.jpg"></td></c:if>
						후기(${item.goods_review_count})
					</div>
				</div>
				</c:if>
			</c:forEach>
		</div>
		
	</div> --%>
		
	
	<div class="main-title-div" id="new">
		<div class="main-title">
			<h3>신제품</h3>
		</div>
	</div>
		
	<div class="main_goods_div">
		<div class="main_goods">
			<c:set var="goods_count" value="0" />
			<c:forEach var="item" items="${goodsMap.newgoods }">
				<c:set var="goods_count" value="${goods_count+1 }" />
				<div class="goods">
					
					<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
					<img class="link"  src="${contextPath}/resources/image/1px.gif"> 
	      </a>
		 <img width="200" height="200" 
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
		<div class="title">${item.goods_title }</div>
		<div class="price">
		    <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		       ${goods_price}원
		  </div>
	</div>
	 <c:if test="${goods_count==15   }">
     <div class="goods">
       <font size=20> <a href="#">more</a></font>
     </div>
         </c:if>
			</c:forEach>
		</div>
	</div>
	
	
	
	<div class="main-title-div" id="discount">
		<div class="main-title">
			<h3>사장님 추천 제품</h3>
		</div>
	</div>
	
	<div class="main_goods_div">
		<div class="main_goods">
			<c:set var="goods_count" value="0" />
			<c:forEach var="item" items="${goodsMap.on_sale }">
				<c:set var="goods_count" value="${goods_count+1 }" />
				<div class="goods">
					
					<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
						 <img class="link"  src="${contextPath}/resources/image/1px.gif"> 
	      </a>
		 <img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" style="width:200px; height:200px;">
		<div class="title">${item.goods_title }</div>
		<div class="price">
		    <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		       ${goods_price}원
		  </div>
	</div>
	 <c:if test="${goods_count==15   }">
     <div class="goods">
       <font size=20> <a href="#">more</a></font>
     </div>
   </c:if>
	</c:forEach>
		</div>
	</div>
	
	<%-- <img src="${contextPath}/resources/image/lineimage1.jpg" class="line-image" /> --%>
	
	<div class="main-title-div" id="total">
		<div class="main-title">
			<h3>전체제품</h3>
		</div>
	</div>
	
	<div class="main_goods_div">
		<div class="main_goods">
			<c:set var="goods_count" value="0" />
			<c:forEach var="item" items="${goodsMap.bestgoods }">
				<c:set var="goods_count" value="${goods_count+1 }" />
				<div class="goods">
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
			<img class="link"  src="${contextPath}/resources/image/1px.gif"> 
			</a> 
				<img width="200" height="200" 
				     src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">

			<div class="title">${item.goods_title }</div>
			<div class="price">
		  	   <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		          ${goods_price}원
			</div>
		</div>
	   <c:if test="${goods_count==15   }">
         <div class="goods">
           <font size=20> <a href="#">더보기</a></font>
         </div>
         </c:if>
			</c:forEach>
			
			
			<c:set var="goods_count" value="0" />
			<c:forEach var="item" items="${goodsMap.newgoods }">
				<c:set var="goods_count" value="${goods_count+1 }" />
				<div class="goods">
					
					<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
					<img class="link"  src="${contextPath}/resources/image/1px.gif"> 
	      </a>
		 <img width="200" height="200" 
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
		<div class="title">${item.goods_title }</div>
		<div class="price">
		    <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		       ${goods_price}원
		  </div>
	</div>
	 <c:if test="${goods_count==15   }">
     <div class="goods">
       <font size=20> <a href="#">more</a></font>
     </div>
         </c:if>
			</c:forEach>
			
			
			<c:set var="goods_count" value="0" />
			<c:forEach var="item" items="${goodsMap.on_sale }">
				<c:set var="goods_count" value="${goods_count+1 }" />
				<div class="goods">
					
					<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
						 <img class="link"  src="${contextPath}/resources/image/1px.gif"> 
	      </a>
		 <img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" style="width:200px; height:200px;">
		<div class="title">${item.goods_title }</div>
		<div class="price">
		    <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		       ${goods_price}원
		  </div>
	</div>
	 <c:if test="${goods_count==15   }">
     <div class="goods">
       <font size=20> <a href="#">more</a></font>
     </div>
   </c:if>
	</c:forEach>
		</div>
	</div>
	
</body>
</html>
