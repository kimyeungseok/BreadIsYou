<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
function search_member(search_period){	
	temp=calcPeriod(search_period);
	var date=temp.split(",");
	beginDate=date[0];
	endDate=date[1];
	//alert("beginDate:"+beginDate+",endDate:"+endDate);
	//return ;
	
	var formObj=document.createElement("form");
    
	var formObj=document.createElement("form");
	var i_beginDate = document.createElement("input"); 
	var i_endDate = document.createElement("input");
    
	i_beginDate.name="beginDate";
	i_beginDate.value=beginDate;
	i_endDate.name="endDate";
	i_endDate.value=endDate;
	
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="/pro31/admin/member/adminMemberMain.do";
    formObj.submit();
}

function fn_member_detail(order_id){
	//alert(order_id);
	var frm_delivery_list=document.frm_delivery_list;
	

	var formObj=document.createElement("form");
	var i_order_id = document.createElement("input");
	
	i_order_id.name="order_id";
	i_order_id.value=order_id;
	
    formObj.appendChild(i_order_id);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="/pro31/admin/member/memberDetail.do";
    formObj.submit();
	
}

//상세조회 버튼 클릭 시 수행
function fn_detail_search(){
	var frm_delivery_list=document.frm_delivery_list;
	
	beginYear=frm_delivery_list.beginYear.value;
	beginMonth=frm_delivery_list.beginMonth.value;
	beginDay=frm_delivery_list.beginDay.value;
	endYear=frm_delivery_list.endYear.value;
	endMonth=frm_delivery_list.endMonth.value;
	endDay=frm_delivery_list.endDay.value;
	search_type=frm_delivery_list.s_search_type.value;
	search_word=frm_delivery_list.t_search_word.value;

	var formObj=document.createElement("form");
	var i_command = document.createElement("input");
	var i_beginDate = document.createElement("input"); 
	var i_endDate = document.createElement("input");
	var i_search_type = document.createElement("input");
	var i_search_word = document.createElement("input");
    
	
    i_command.name="command";
    i_beginDate.name="beginDate";
    i_endDate.name="endDate";
    i_search_type.name="search_type";
    i_search_word.name="search_word";
    
    i_command.value="list_detail_order_goods";
	i_beginDate.value=beginYear+"-"+beginMonth+"-"+beginDay;
    i_endDate.value=endYear+"-"+endMonth+"-"+endDay;
    i_search_type.value=search_type;
    i_search_word.value=search_word;
	
    formObj.appendChild(i_command);
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    formObj.appendChild(i_search_type);
    formObj.appendChild(i_search_word);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="/pro31/admin/member/memberDetail.do";
    formObj.submit();
	
}
</script>
</head>
<body>

	<div class="title_underline">
		<h3 class="admin_member_title"><b>회원 조회</b></h3>
	</div>
	
<table class="table table-striped table-hover" style="width:1200px">
		<tbody align=center >
			<tr align=center bgcolor="#814725">
				<td><span><font color = "white"><b>회원아이디</b></font></span></td>
				<td><span><font color = "white"><b>회원이름</b></font></span></td>
				<td><span><font color = "white"><b>휴대폰번호</b></font></span></td>
				<td><span><font color = "white"><b>주소</b></font></span></td>
				<td><span><font color = "white"><b>가입일</b></font></span></td>
				<td><span><font color = "white"><b>탈퇴여부</b></font></span></td>
			</tr>
   <c:choose>
     <c:when test="${empty member_list}">			
			<tr>
		       <td colspan=5 class="fixed">
				  <strong>조회된 회원이 없습니다.</strong>
			   </td>
		     </tr>
	 </c:when>
	 <c:otherwise>
	     <c:forEach var="item" items="${member_list}" varStatus="item_num">
	            <tr >       
					<td width=10%>
					  <a href="${pageContext.request.contextPath}/admin/member/memberDetail.do?member_id=${item.member_id}">
					     <span>${item.member_id}</span>
					  </a>
					</td>
					<td width=10%>
					  <span>${item.member_name}</span><br>
					</td>
					<td width=17% >
					  <span>${item.hp1}-${item.hp2}-${item.hp3}</span><br>
					</td>
					<td width=37%>
					  <span>${item.roadAddress}</span><br>
					  <span>${item.jibunAddress}</span>
					  <span>${item.namujiAddress}</span><br>
					</td>
					<td width=15%>
					   <c:set var="join_date" value="${item.joinDate}" />
					   <c:set var="arr" value="${fn:split(join_date,' ')}" />
					   <span><c:out value="${arr[0]}" /></span>
				    </td>
				    <td width=10%>
				       <c:choose>
				         <c:when test="${item.del_yn=='N' }">
				           <span>활동중</span>  
				         </c:when>
				         <c:otherwise>
				           <span>탈퇴</span>
				         </c:otherwise>
				       </c:choose>
				    </td>
				</tr>
		</c:forEach>
	</c:otherwise>
  </c:choose>	
         <tr>
             <td colspan=8 class="fixed">
                  <c:forEach   var="page" begin="1" end="10" step="1" >
		         <c:if test="${section >1 && page==1 }">
		          <a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; &nbsp;</a>
		         </c:if>
		          <a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
		         <c:if test="${page ==10 }">
		          <a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp; next</a>
		         </c:if> 
	      		</c:forEach> 
           </td>
        </tr>  		   
		</tbody>
	</table>
  	
<c:choose>
 <c:when test="${not empty order_goods_list }">	
   <DIV id="page_wrap">
		  <c:forEach   var="page" begin="1" end="10" step="1" >
		         <c:if test="${section >1 && page==1 }">
		          <a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; &nbsp;</a>
		         </c:if>
		          <a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
		         <c:if test="${page ==10 }">
		          <a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp; next</a>
		         </c:if> 
	      		</c:forEach> 
	</DIV>	
 </c:when>
</c:choose>
</body>
</html>

 