<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
   String ctxPath = request.getContextPath(); 
   //  /startspring 임.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%= ctxPath %>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
 	$(document).ready(function() {
 		 $("#jobId").change(function() {
 			var optionVal = $(this).val();
 			goGetMember(optionVal);
		}); 		
	});
 	function goGetMember(optionVal) {
 		
 		var date_form = {"optionVal":optionVal};
		$.ajax({
			url:"testJSON.action",
			type:"GET",
			dataType:"JSON",
			data:date_form,
			success:function(json){				
				if(json.length >0){
					var html="";
					$.each(json,function(entryIndex,entry){						
						html = "<tr>"+
									"<td>"+entry.job_id+"</td>"+
									"<td>"+entry.employee_id+"</td>"+
									"<td>"+entry.name+"</td>"+
									"<td>"+entry.jubun+"</td>"+
									"<td>"+entry.age+"</td>"+
									"<td>"+entry.gender+"</td>"+
									"<td>"+entry.yearpay+"</td>"+
								"</tr>";
						$("#result").append(html);
					});
				}else{
					$("#result").append("검색된 결과가 없습니다.");
				}
			},	error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
</script>

</head>

<body>
<form name="optionFrm">
	부서명
	<select name="jobId" id="jobId">
		<c:forEach var="id" items="${jobId}" >
				<option value="${id}">${id}</option>
		</c:forEach>
	</select>
   
</form>
   <table>
      <thead>
         <tr>
            <th>일련번호</th>
            <th>부서번호</th>
            <th>사원번호</th>
            <th>사원명</th>
            <th>주민번호</th>
            <th>성별</th>
            <th>나이</th>
            <th>연봉</th>
         </tr>
      </thead>
      <tbody id="result"></tbody>
   </table>
   
</body>
</html>