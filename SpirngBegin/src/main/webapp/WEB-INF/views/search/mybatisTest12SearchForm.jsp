<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% 
   String ctxPath = request.getContextPath(); 
   //  /startspring 임.
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	table {border: 1px solid gray;
	       border-collapse: collapse;
	      }
	
	th, td {border: 1px solid gray;}
	
	.total {background-color: #ffff99; 
	        font-weight: bold;
	        text-align: center;}
</style>

<script type="text/javascript" src="<%=ctxPath %>/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

    $(document).ready(function(){   
    	if("${deapartment_id}" != ""){
    		searchKeep();	
    	} 
    });// end of $(document).ready()---------------------

    
    function searchKeep() { 
    	$("#department_id").val("${deapartment_id}");
    	$("#gender").val("${gender}");
    }// end of function searchKeep()---------------------
    
    
	function goSearch() {
	
		var frm = document.searchFrm;
		frm.method="GET";
		frm.action = "<%= ctxPath %>/mybatistest/mybatisTest12.action";
		frm.submit();
		
	}// end of function goSearch()------------------

</script>	

</head>
<body>

	<div align="center">
		<h2>우리회사 사원명단</h2>
		<br/>
			
		<form name="searchFrm">
			<select name="department_id" id="department_id">
				<option value=""> 모든부서</option>
				<c:forEach var="deptno" items="${deptnoList}" >
					<c:if test="${deptno > 0}">
						<option value="${deptno}">${deptno}</option>
					</c:if>		
					<c:if test="${deptno < 0}">
						<option value="${deptno}">부서없음</option>
					</c:if>			   	 
			    </c:forEach>
			</select>
			
			<select name="gender" id="gender">
				<option value="전체">전체</option>
				<option value="남">남</option>
				<option value="여">여</option>
			</select>
			
			<button type="button" onClick="goSearch();">검색</button>&nbsp;&nbsp;
			<button type="button" onClick="javascript:location.href='mybatisTest12.action'">초기화</button>
		</form>
	</div>
	
	<c:if test="${empList != null}">
		<div align="center" style="margin-top: 50px;">
		  <table>
			<thead>
				<tr>
				    <th>일련번호</th>
					<th>부서번호</th>
					<th>부서명</th>
					<th>사원번호</th>
					<th>사원명</th>
					<th>주민번호</th>
					<th>성별</th>
					<th>나이</th>
					<th>연봉</th>
				</tr>
			</thead>			
			<tbody>
				<c:if test="${not empty empList}" >
				    <c:forEach var="employee" items="${empList}" varStatus="status">
				    <tr>
						<td>${status.count}</td>
						<td>${employee.DEPARTMENT_ID}</td>
						<td>${employee.DEPARTMENT_NAME}</td>
						<td>${employee.EMPLOYEE_ID}</td>
						<td>${employee.NAME}</td>
						<td>${employee.JUBUN}</td>
						<td>${employee.GENDER}</td>
						<td>${employee.AGE}</td>						
						<td align="left"><fmt:formatNumber value="${employee.YEARPAY}" pattern="###,###"></fmt:formatNumber></td>
				    </tr>
				    </c:forEach>
			    </c:if>
			</tbody>
		  </table>
		</div>
	</c:if>
	
</body>
</html>
