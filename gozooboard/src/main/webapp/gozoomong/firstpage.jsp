<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>firstpage</title>
<%
	String login_id = (String)(session.getAttribute("login_id"));
%>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
</style>
</head>
<style>
	*{
		font-family: 'Lobster';
	}
	.frame{
		width: 500px;
		height : 600px;
		margin :auto;
		border: 1px solid gray;
		text-align: center;
		background-image: url('./images/background.jpg');
	}

	.btn{
		width : 130px;
		height : 40px;
		color : white;
		background : purple;
		border-radius: 15px;
		font-family: 'Bebas Neue';
		font-size: 20px;
		cursor: pointer;
	}
	
	.btn:hover{
		background-color: yellow;
		color : black;
	}
	
	h1{
		color : white;
		font-weight: bold;
	}
	
	.hello{
		color : white;
	}
	
	.intro{
		margin-top : 8em;
		color : white;
	}
	
	.change{
		cursor: pointer;
		transition : all 2s;
	}
	
	.change:hover{
		color : yellow;
	}
	
	.changeB{
		cursor: pointer;
		transition : all 2s;
	}
	
	.changeB:hover{
		color : yellow;
	}
	
</style>

<script type="text/javascript">
	function on_btn_register(){
		location.href = "register.jsp";
	};
	
	function on_btn_login(){
		location.href = "login.jsp";
	};
	
	function on_btn_logout(){
		location.href = "logout_action.jsp";
	};
	
	function on_btn_board(){
		location.href = "board.jsp";
	};
	
	function alertA(){
		alert("login or register first!");
	};
	
	function alertB(){
		alert("You already login")
	}
	
	function change(){
	/* 	$('body').css({"transition":"background 1s ease-in","background":"lightcoral"}); */
		$('.frame').css({"transition":"background 1s ease-in","background-image":"url('./images/bg2.jpg')"});
	}
	
	function changeB(){
		/* 	$('body').css({"transition":"background 1s ease-in","background":"lightcoral"}); */
			$('.frame').css({"transition":"background 1s ease-in","background-image":"url('./images/background.jpg')"});
		}
	
	
</script>

<body>
	<div class = "frame">
		<h1 style = "font-family:Lobster "> <span onclick="changeB()" class = "changeB">◀</span> GOZOOMONG BOARD <span onclick="change()" class = "change">▶</span></h1>
		<br><br><br>
		<%
			if(login_id != null){
		%>
		<span class = "hello">hello <%=login_id %></span> <br><br><br>
		<%
			}
		%>
			<button class = "btn" onclick="on_btn_register()">REGISTER</button> <br><br>
		
		<%
			if(login_id == null){
		%>
			<button class = "btn" onclick="on_btn_login()">LOG IN</button> <br><br>
			<button class = "btn" onclick="alertA()">LOG OUT</button> <br><br>
			<button class = "btn" onclick="alertA()">BOARD</button> <br><br>
		<%
			}else{
		%>
			<button class = "btn" onclick="on_btn_logout()">LOG OUT</button> <br><br>
			<button class = "btn" onclick="alertB()">LOG IN</button> <br><br>
			<button class = "btn" onclick="on_btn_board()">BOARD</button> <br><br>
		<%
			}	
		%>
			
			<div class = "intro">
				<span>made by gozoomongKR</span>
			</div>
	</div>
</body>
</html>