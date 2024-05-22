<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	
	<div class="title_underline">
		<h3 class="order-main-title"><b>상품 조회</b></h3>
	</div>
	
	<TABLE class="table table-striped table-hover" style="width:1200px ">
		<TBODY align=center >
			<tr style="background:#2a4c34" >
				<td><span><font color = "white"><b>상품번호</b></font></span></td>
				<td><span><font color = "white"><b>상품이름</b></font></span></td>
				<td><span><font color = "white"><b>회사</b></font></span></td>
				<td><span><font color = "white"><b>상품가격</b></font></span></td>
				<td><span><font color = "white"><b>입고일</b></font></span></td>
			</tr>
   <c:choose>
     <c:when test="${empty newGoodsList }">			
			<TR>
		       <TD colspan=8 class="fixed">
				  <strong>조회된 상품이 없습니다.</strong>
			   </TD>
		     </TR>
	 </c:when>
	 <c:otherwise>
     <c:forEach var="item" items="${newGoodsList }">
			 <TR>       
				<TD>
				  <span>${item.goods_id }</span>
				</TD>
				<TD >
				 <a href="${pageContext.request.contextPath}/admin/goods/modifyGoodsForm.do?goods_id=${item.goods_id}">
				    <span>${item.goods_title } </span>
				 </a> 
				</TD>
				<TD >
				   <span>${item.goods_publisher }</span> 
				</TD>
				<td>
				  <span>${item.goods_sales_price}</span>
				</td>
				<td>
				 <span>${item.goods_credate }</span> 
				</td>
				
			</TR>
	</c:forEach>
	</c:otherwise>
  </c:choose>
           <tr>
             <td colspan=8 class="fixed">
                 <c:forEach   var="page" begin="1" end="10" step="1" >
		         <c:if test="${section >1 && page==1 }">
		          <a href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; &nbsp;</a>
		         </c:if>
		          <a href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
		         <c:if test="${page ==10 }">
		          <a href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp; next</a>
		         </c:if> 
	      		</c:forEach>
	      		</td>
     
		</TBODY>
	</TABLE>
	
	<form class="add-goods-form" action="${contextPath}/admin/goods/addNewGoodsForm.do">
		<input type="submit" value="상품 등록하기" class="btn btn-secondary btn-sm">
	</form>
		
</body>
</html>