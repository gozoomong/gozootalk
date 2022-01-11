<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<title>login</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&family=Source+Serif+4&display=swap');
	*{
		  font-family: 'Source Serif 4'; 
	} 
	 body{
   	  background-image: url('./images/galaxyL.gif');
   }
   
   .frame{
      width: 379px;
      height: 726px;
      margin :auto;
      border: 0px solid black;
      text-align: center;
      background-image: url('./images/galaxyL.gif');
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
		border: solid 0px yellow;
		border-radius : 20px;
		width : 250px;
		height : 300px;
		margin : auto;
		padding-top : 3em;
		background-color: hsla(659, 127%, 69%, 0.4);
	}
	
	.login_btn{
		border: solid 1px yellow;
		border-radius : 20px;
		margin-top : 2em;
		width : 150px;
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
					<input type = "submit" class = "login_btn" value = "LOGIN">
				</form>
			</div>
	</div>

</body>
</html>