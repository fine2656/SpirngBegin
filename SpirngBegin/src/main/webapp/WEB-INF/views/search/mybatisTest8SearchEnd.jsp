<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
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
</style>

</head>
<body>

	<div align="center">
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>성명</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>주소</th>
					<th>가입일자</th>
				</tr>
			</thead>
			
			<tbody>
			<c:if test="${not empty memberList}">
				<c:forEach items="${memberList}" var="mvo">
						<tr>		
							<td>${mvo.no}</td>
							<td>${mvo.name}</td>
							<td>${mvo.email}</td>
							<td>${mvo.tel}</td>
							<td>${mvo.addr}</td>
							<td>${mvo.writeday}</td>
							</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty memberList}">
				<tr>
					<td colspan="6">조회하려는 주소지 ${addr} 이 없습니다.</td>
				</tr>
			</c:if>
			</tbody>
		</table>
	</div>

</body>
</html>