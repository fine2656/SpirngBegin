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

<style type="text/css">
	table {border: 1px solid gray;
	       border-collapse: collapse;
	      }
	
	th, td {border: 1px solid gray;}
    
	select.my_select {height: 25px;}  	
</style>

<script type="text/javascript" src="<%=ctxPath %>/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

    $(document).ready(function(){
    	callAjax("",$("#gender").val(), $("#ageline").val());
    	$("#btnSearch").click(function(){
    		var deptnoArr = new Array();
    		$(".department_id").each(function() {// 체크가 되어진 것만 each 문에 넣겠다
    			var bool = $(this).is(":checked");//체크박스의 체크 유무 검사
    			if(bool == true){ //체크박스에 체크가 되어 있으면
    				deptnoArr.push($(this).val());   				
    			}
			});
    		var deptnoesStr = deptnoArr.join();//배열에 있는 것이 문자열 한개로 합친다.( 괄호 안이 공백이면 ',' 로 확인한다.) [20,50,30,70]=>20,30,50,70
    		//console.log("확인용 : "+deptnoesStr);
    		
    		callAjax(deptnoesStr,$("#gender").val(), $("#ageline").val());
    	});
		
    	
    }); // end of $(document).ready()--------------------------------------------

   
    
	function callAjax(deptnoesStr, gender, ageline) {
		 var data_form = {"deptnoesStr":deptnoesStr,
				 "gender":gender,
				 "ageline":ageline};
		 
    	$.ajax({
    		url:"mybatisTest14JSON.action",
    		type:"GET",
    		data:data_form,
    		dataType:"JSON",
    		success:function(json){
    			$("#result").empty();// 비우고 시작한다
				if(json.length > 0){
					var html ="";
					$.each(json, function (entryIndex,entry) {
						//entryIndex 가 0부터 시작이기 때문에 1을 더해 준다.
						html = "<tr>"+
									"<td>"+(entryIndex+1)+"</td>"+
									"<td>"+entry.DEPARTMENT_ID+"</td>"+
									"<td>"+entry.DEPARTMENT_NAME+"</td>"+
									"<td>"+entry.EMPLOYEE_ID+"</td>"+
									"<td>"+entry.NAME+"</td>"+
									"<td>"+entry.JUBUN+"</td>"+
									"<td>"+entry.AGE+"</td>"+
									"<td>"+entry.GENDER+"</td>"+
									"<td>"+Number(entry.YEARPAY).toLocaleString('en')+"</td>"+
								"</tr>";								
						$("#result").append(html);
					});						
				}else{
					$("#result").append("<tr><td colspan ='8' style='color : red'>검색되어진 결과가 없습니다</td></tr>");
				}
				$("#display").show();    			
    		},	error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}    		
    	});
    	
    		
    	
    	
    }// end of function callAjax(addrSearch)------------
    
</script>	

</head>
<body>

	<div align="center">
		<h2>우리회사 사원명단</h2>
		<br/>
		
		<form name="searchFrm">
			<c:forEach var="deptno" items="${deptnoList}">				
				<c:if test="${deptno<0}"><input type="checkbox" class="department_id" name="department_id" id="department_id${deptno}" value="${deptno}"/><label for="department_id${deptno}">부서없음&nbsp;</label></c:if>
				<c:if test="${deptno>0}"><input type="checkbox" class="department_id" name="department_id" id="department_id${deptno}" value="${deptno}"/><label for="department_id${deptno}">${deptno}번 부서&nbsp;</label></c:if>				
			</c:forEach>
			
			<br/><br/>
			
			<select name="gender" id="gender" class="my_select">
				<option value="">성별</option>
				<option value="남">남</option>
				<option value="여">여</option>
			</select>
						
			<select name="ageline" id="ageline" class="my_select">
				<option value="">연령대</option>
				<option value="0">10대미만</option>
				<option value="10">10대</option>
				<option value="20">20대</option>
				<option value="30">30대</option>
				<option value="40">40대</option>
				<option value="50">50대</option>
				<option value="60">60대</option>
			</select>
			
			<button type="button" id="btnSearch">검색</button>&nbsp;&nbsp;
		</form>
	</div>
	
	<div id="display" align="center" style="margin-top: 50px;">
		<table style="width: 900px;">
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
			
			<tbody id="result"></tbody>
		</table>
	</div>
	
</body>
</html>
