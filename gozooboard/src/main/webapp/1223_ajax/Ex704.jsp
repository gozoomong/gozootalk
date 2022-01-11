<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax with json1.1.1</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<script type="text/javascript">
	$(function(){
		$("#btn_login").click(function(){
			var id_value = $("#id").val();
			var pw_value = $("#pw").val();
			// && Using Ajax && 
			$.ajax({
				type : "post",
				url : "../LoginServlet",
				data : {"id":id_value,"pw":pw_value},
				datatype : "json",
				success : function(data){ 
					alert(data.login_check);	// 1 or 0 (Promise)		
				},
				
				error : function(request,status,error){
					alert("--ERROR--" + request + status + error);	
				}
			});
			
		});
	});

</script>

<body>
	<div>
		ID : <input type = "text" id = "id"> <br>
		PW : <input type = "password" id = "pw"> <br>
		<button id = "btn_login">LOGIN</button>
	</div>
</body>
</html>















