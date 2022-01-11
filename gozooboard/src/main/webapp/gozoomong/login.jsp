<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&family=Source+Serif+4&display=swap');
	*{
		  font-family: 'Source Serif 4'; 
	}
	
	.frame{
		width: 500px;
		height : 600px;
		margin :auto;
		border: 1px solid gray;
		text-align: center;
		background-image: url('./images/background.jpg');
	}
	
	h1{
		color : white;
		font-family : 'Lobster';
	}
	
	#id{
		color : white;
	}
	#pw{
		color : white;
	}
	.sub_frame{
		border: solid 1px yellow;
		border-radius : 20px;
		width : 250px;
		height : 300px;
		margin : auto;
		padding-top : 3em;
	}
</style>
</head>
<body>

	<div class = "frame">
		<h1>LOG IN</h1>
			<div class = "sub_frame">
				<form action="login_action.jsp">
					<label for = "id" id = "id"> ID </label> <br>
					<input type = "text" name = "id" placeholder="your id.."> <br><br>
					<label for = "pw" id = "pw"> PW </label> <br>
					<input type = "password" name = "pw" placeholder="your pw.."> <br><br>
					<input type = "submit" value = "LOGIN">
				</form>
			</div>
	</div>

</body>
</html>