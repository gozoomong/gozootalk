<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<title>write page</title>
</head>
<style>
	*{
		font-family: 'Lobster';
	} 
	
	 body{
   	  background-image: url('./images/galaxyL.gif');
   }
   
   .frame{
      width: 402px;
      height: 726px;
      margin :auto;
      border: 0px solid black;
      text-align: center;
      background-image: url('./images/bg2.jpg');
   }
	
	
	
	h1{
		color : white;
	}
	
	table{
		color : white;
		font-weight : bold;
		width : 100px;
		margin : auto;
		padding-top : 2em;
	}
	td{
		padding : 5px;
	}
	
	.title{
		margin-left: -2px;
		width : 150px;
	}
	
	.post{
		margin-top : 1em;
		width : 150px;
		border-radius: 20px;
	}
	.subframe{
		background-color: hsla(321, 100%, 75%, 0.3);
		width : 372px;
		height : 400px;
		magint : auto;
	}
	
	input:invalid {
 		 border: 3px solid red;
	}
	
	.goback{
		margin-top : 1em;
		width : 150px;
		border-radius: 20px;
	}
</style>


<body>
<script type="text/javascript">
$(document).ready( function() {
	$('.post').click(function(){
		if($('.title').val() == ''){
			alert("You probably missed something...")
			return false;
		}
		if($('.content').val() == ''){
			alert("You probably missed something...")
			return false;
		}
		return true;
	});
});


function goback(){
	location.href = "board.jsp";
};
</script>

		<div class = "frame">
			<h1>POSTING</h1>
			
			<div class = "subframe" style = "margin: auto;">
			
			<form action="write_action.jsp">
				<table>
					<tr>
						<td>TITLE</td>
						<td><input type = "text" name = "title" class = "title"> </td>
					</tr>
					<tr>
						<td>PASSWORD</td>
						<td><input type = "password" name = "pw" class = "title"  pattern="[0-9]+" maxlength='4'> </td>
					</tr>
					<tr>
						<td>CONTENT</td>
						<td> <textarea rows="5" cols = "25" name = "content" class = "content"></textarea> </td>
					</tr>
					<tr>
						<td>  </td>
						<td>Please set the password only with 4 numbers</td>
					</tr>
				</table>
				<input type = "submit" value = "post" class = "post"> <br>
			</form>
				<button onclick="goback()" class = "goback">go back</button>
			</div>
		
		
	</div>

</body>
</html>