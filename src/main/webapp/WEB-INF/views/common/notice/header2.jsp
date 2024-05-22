<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
<title>헤더</title>
</head>
<body>

  <tr>
     <nav class="navbar navbar-expand-lg fixed-top" style="background:#2a4c34; margin-top:-10px;">
	
	    <div class="container-fluid">
	    
		    <a class="navbar-brand" href="${contextPath}/main/main.do">
		    	<img src="${contextPath}/resources/image/logo.jpg" style="width:120;height:30px;"/>
		    </a>
		    
		    
		    
		    <div class="collapse navbar-collapse justify-content-between" id="collapsibleNavbar">
		    
       <h1><font color = "white" >공지사항</font></h1>
     </div>
     </div>
     </nav>
     </tr>
     
     
     <td>
       <!-- <a href="#"><h3>로그인</h3></a> -->
       <c:choose>
          <c:when test="${isLogOn == true  && member!= null}">
          </c:when>
	   </c:choose>     
     </td>
  </tr>



</body>
</html>