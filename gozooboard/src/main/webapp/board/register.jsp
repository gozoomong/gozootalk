<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<title>register</title>
<%request.setCharacterEncoding("UTF-8");%>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
	/* *{
		font-family: 'Source Serif 4';
	} */
	 body{
   	  background-image: url('./images/background.jpg');
  	 }
	.frame{
		width: 400px;
		height : 726px;
		margin :auto;
		border: 0px solid gray;
		text-align: center;
		background-image: url('./images/background.jpg');
	}
	
	h1{
		color : white;
	}
	
	table{
		margin: auto;
		line-height: 3em;
		color : white;
	}
	
	.agree{
		color : white;
		font-size: 12px;
		border: solid 0px black;
		width : 350px;
		margin : auto;
		margin-top : 5em;
	}
	
	.submit_btn{
		width : 180px;
		
	}
	.back_btn{
		margin-top : 1em;
		width : 180px
	}
	
	.submit_btn:hover{
		background-color: purple;
		color : white;
	}
	.back_btn:hover{
		background-color: purple;
		color : white;
	}
	
</style>

<script type="text/javascript">
	function goback(){
		location.href = "firstpage.jsp";
	};
</script>
</head>
<body>

	<div class = "frame">
		<h1  style = "font-family:Lobster "> CREATE ACCOUNT</h1>
		
		
		<form action="register_action.jsp" style = "margin-top : 2em;">
			<table>
				<tr>
					<td>ID</td>
					<td> <input type = "text" name = "id" id = "id"> </td>
				</tr>
				<tr>
					<td>PW</td>
					<td> <input type = "password" name = "pw" id = "pw"> </td>
				</tr>
				<tr>
					<td>NAME</td>
					<td> <input type = "text" name = "name" id = "name"> </td>
				</tr>
				<tr>
					<td>GENDER</td>
					<td>
						MAN	<input type = "radio" name = "gender" value = "man">
						WOMEN<input type = "radio" name = "gender" value = "women">
					</td>
				</tr>
			</table>
			<input type = "submit" value = "Create" class = "submit_btn"> 
		</form>
			<button onclick="goback()" class ="back_btn">BACK</button>
		
		
			<div class = "agree">
			The gozoomong board is a simple but colorful and diverse communication window. 
			Gozoomong board is small now, but we promise to become a bigger and more wonderful 
			board community. Sincerely welcome to gozoomong board
			</div>
		
		
		
	</div>

</body>
</html>