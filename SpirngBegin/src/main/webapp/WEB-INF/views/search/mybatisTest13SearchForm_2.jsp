<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
   String ctxPath = request.getContextPath(); 
   //  /startspring 임.
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소를 입력받아 해당 주소지에 거주하는 회원들을 찾아주는 페이지(AJAX JSONObject, JSONArray 사용)</title>
<style type="text/css">
	table{border:1px solid gray;
		  border-collapse:collpase;}
    th,td{border:1px solid gray;
		  border-collapse:collpase;}
</style>
<script type="text/javascript" src="<%= ctxPath %>/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
	
	$(document).ready(function() {
		$("#display").hide();
		
		$("#btnSearch").click(function() {// 클릭을 했을 경우
			var addrSearch = $("#addrSearch").val();
			callAjax(addrSearch);
		});// end of $("#btnSearch").click(function()
		$("#addrSearch").keydown(function(event) { /* event : keydown 이벤트 */
			if(event.keyCode == 13) {// 엔터를 했을 경우
				var addrSearch = $(this).val();
				callAjax(addrSearch); // ajax를 해주는 함수 만들기				
				return false;
			/*
  		      JSP 페이지에서 Enter 이벤트 발생시
  		      JSP 페이지에 input type의 text 박스가 오로지 하나인 경우에는
  		           엔터를 치면 입력한 글자가 사라진다.
  		           그래서 입력한 글자가 사라지지 않게 하려면
  		           맨끝에 return false; 를 적어주면 사라지지 않는다.
  		   */
			} 
		});// end of $("#addrSearch").keydown(function(event)
		$("#btnClear").click(function() {
			$("#addSearch").val("");
			$("#addSearch").focus();
			$("#result").empty();
			$("#display").hide();			
		});
	});// end of $(document).ready(function()
	
			
	
	function callAjax(addrSearch) {
		var data_form ={"addrSearch":addrSearch};
		$.ajax({
			url:"mybatisTest13JSON_2.action",
			type:"GET",
			dataType:"JSON",
			data:data_form,
			success:function(json){
				$("#result").empty();// 비우고 시작한다
					if(json.length > 0){
						var html ="";
						$.each(json, function (entryIndex,entry) {
							//entryIndex 가 0부터 시작이기 때문에 1을 더해 준다.
							html = "<tr>"+
										"<td>"+(entryIndex+1)+"</td>"+
										"<td>"+entry.NO+"</td>"+
										"<td>"+entry.NAME+"</td>"+
										"<td>"+entry.EMAIl+"</td>"+
										"<td>"+entry.TEL+"</td>"+
										"<td>"+entry.ADDR+"</td>"+
										"<td>"+entry.WRITEDAY+"</td>"+
										"<td>"+entry.BIRTHDAY+"</td>"+
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
	}// end of function callAjax(addrSearch) 
</script>
	
</head>
<body>
	<div align="center">
		<h2>주소를 입력받아 해당 주소지에 거주하는 회원들을 찾아주는 페이지(AJAX JSON Jackson,@ResponseBody 사용)</h2>
			<h3>(/mybatistest/mybatisTest13_2.action)</h3>		
		<form name="searchFrm">
			주소 : <input type="text" id="addrSearch" />
			<br/><br/>
			<button type="button" id="btnSearch">찾기</button>&nbsp;&nbsp;<button type="button" id="btnClear">초기화</button>
		</form>
	</div>
	
	<div id="display" align="center" style="margin-top: 50px;">
		<table>
			<thead>
				<tr style="background-color: #0055ff;color: #ffffff;">
					<th>일련번호</th>
					<th>회원번호</th>
					<th>성명</th>
					<th>이메일</th>
					<th>전화</th>
					<th>주소</th>
					<th>가입일자</th>
					<th>생일</th>
				</tr>
			</thead>
			
			<tbody id="result"></tbody>
		</table>
	</div>
</body>
</html>
