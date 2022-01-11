<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login page</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<script type="text/javascript">
	$(function(){
		
		$("#update").click(function(){
			var update_id = $("#update_id").val();
			var result_id = $("#result_id").val();
			
			$.ajax({
				type : "post",
				url : "../UpdateIdServlet",
				data : {"update_id":update_id,"result_id":result_id},
				datatype : "json",
				success : function(data){
					$("#result_id").val(data.updatesuccess);
					$("#old_id").val(data.old_id);
					$("#new_id").val(data.updatesuccess);
				},
				error : function(request,status,error){
					alert("update failed")
				}
			});
			
		});
		
		$("#login_btn").click(function(){
			var id_value = $("#id_A").val();
			var pw_value = $("#pw_A").val();
			
			$.ajax({
				type : "post",
				url : "../LoginCheckServlet",
				data : {"id":id_value,"pw":pw_value},
				datatype : "json",
				success : function(data){
					$("#result_id").val(data.login_check);
				},
				
				error : function(request,status,error){
					alert("ERROR");
				}
				
			});
			
		});
	});
</script>
<body>
	회원가입
	<table>
		<tr>
			<td>ID</td>
			<td> <input type = "text" id = "id_A"> </td>
		</tr>
		<tr>
			<td>PW</td>
			<td> <input type = "text" id = "pw_A"> </td>
			<td><button id = "login_btn">LOGIN</button></td>
		</tr>
	</table>
	<br> <br>
	<div>
		로그인 되어있는 아이디 : <input disabled="disabled" type = "text" id = "result_id" value="nothing" style = "border : 0px;">
	</div>
	
	<div>
		아이디 수정하기 : <input type = "text" id = "update_id">
		<button id="update">UPDATE ID</button>
	</div>		
	
	<div>
		기존 아이디 :	<input type = "text" id = "old_id"> <br>
		바뀐 아이디 : <input type = "text" id = "new_id">
	</div>
	
	
</body>
</html>