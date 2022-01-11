<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
 *{
      font-family: 'Lobster';
   } 
   .frame{
      width: 500px;
      height : 600px;
      margin :auto;
      border: 1px solid gray;
      text-align: center;
      background-image: url('./images/galaxyL.gif');
   }

   .sub{
		width : 400px;
		height: 500px;
		margin: auto;
		background-color: black;
   }

   #title{
	   color: white;
   }




	#msg{
		float: left;
		border-radius: 15px;
	
	}
	
	textarea{
		resize: none;
		overflow: hidden;
	}


</style>
	<script>
			$('document').ready(function(){
				$(this).css('height','auto');
				$(this).height(this.scrollHeight);
			});

			$(".msg").click(function(){
				alert("2");
			});
			
	</script>
<body>

<div class = "frame">
	<h3>gozoo's mailbox</h3>
	<div class = "sub">
		<span id="title">M A I L B O X</span> <br><br><br>

		<textarea class="msg" name="msg" id="msg" cols="30" rows="1"></textarea>




	</div>


</div>

</body>
</html>