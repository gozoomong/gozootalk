<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<title>profile</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Source+Serif+4&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
</style>
</head>
<%
	String login_id = (String)(session.getAttribute("login_id"));
	String old_id = request.getParameter("old_id");

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@210.114.10.27:1521:xe";
	String dbid = "gozootalk";
	String dbpw = "gozootalk1234";
	   
	   
	   Connection conn = null;
	   try{
	      Class.forName(driver);
	      conn = DriverManager.getConnection(url,dbid,dbpw);
	   }catch(Exception e){
	      e.printStackTrace();
	   }

	   String sql = "SELECT * FROM MEMBER WHERE ID = ?";
	   PreparedStatement pstmt = conn.prepareStatement(sql);
	   pstmt.setString(1, old_id);
	   ResultSet rs = pstmt.executeQuery();
	   String id = "";
	   String pw = "";
	   String name = "";
	   String gender = "";
	   String img = "";
	   
	   while(rs.next()){
	      id = rs.getString("ID");
	      pw = rs.getString("PW");
	      name = rs.getString("NAME");
	      gender = rs.getString("GENDER");
	      img = rs.getString("IMG");
	   }

	
	
%>
<style>
	 *{
		font-family: 'Lobster';
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
   
	.subframe{
		background-color: rgba(6, 107, -18, 0.6);
		width : 340px;
		height : 530px;
		margin : auto;
		margin-top : 1.2em;
		border-radius: 17px;
	}
	
	.label{
		color : white;
		font-size : 30px;
	}
	
	.label2{
		margin-top : 10px;
		margin-bottom : 1em;
	}
	
	#name, #id, #pw, #gender,#gender2{
		font-size : 20px;
		background-color: transparent;
		color : white;
		border : 0px;
		text-align: center;
		font-family: serif;
	}
	
	#gender2{
		color : white;
		background-color: transparent;
		text-align : center;
	}
	
	img{
		width : 100px;
	}
	

	
	#btn{
		border-radius: 15px;
		width : 100px;
	}
	#btn2{
		border-radius : 15px;
		width : 100px;
	}
	.btn2{
		  z-index: 1;
    	  margin-top: -21px;
    	  display: none;
	}
	
	.goback{
		color : white;
	    margin-left: -16em;
	    cursor: pointer;
	}
	
	.goback:hover{
		color : yellow;
	}
	
	#gender_option{
		text-align:center;
		color : black;
	}
	select { border-radius:0; /* 아이폰 사파리 보더 없애기 */ 
		-webkit-appearance:none; /* 화살표 없애기 for chrome*/ 
		-moz-appearance:none; /* 화살표 없애기 for firefox*/ 
		appearance:none /* 화살표 없애기 공통*/ 
		}
		
	select::-ms-expand{
		   display:none;/*for IE10,11*/
	}
	
	#file_upload{
	    width: 138px;
    	font-size: 10px;
	}

	#img_frame{
		width: 112px;
	    height: 102px;
	    border-radius: 48px;
	    margin: auto;
	    background-color: black;
	}
	
	#img_profile{
		width: 100%;
	    height: 100%;
	    border-radius: 48px;
	}
	
</style>	
<body>


<script type="text/javascript">
$(function(){
	
	$("#btn").click(function(){
		$("#name,#id,#pw,#gender").css({"background-color":"white","color":"black","border-radius":"15px"}	);
		$(".btn2").css("display","block");
		$("#id").attr("disabled", false);
		$("#name").attr("disabled", false);
		$("#pw").attr("disabled",false);
		$("#gender2").attr("disabled",false);
		$("#gender2").css({"border":"1px","background-color":"white","color":"black","border-radius":"15px","width":"200px","cursor":"pointer","font-weight":"bold"});
		$("#gender2").css({"-webkit-appearance":"auto","-moz-appearance":"auto","appearance":"auto"});
		$("#new_genderA").attr("disabled",true);

		
		$(".changeimg").css("display","block");
	});
	
	
	$("#btn2").click(function(){
		$("#new_genderA").attr("disabled",false);
		var oldid = $("#oldid").val();
		var newid = $("#id").val();
		var newname = $("#name").val();
		var newpw = $("#pw").val();
		var newgender = $("#gender").val();
		var newgender2 = $("#gender2").val();
		/* alert($("#oldid").val()); */  
		 $.ajax({
			type : "post",
			url : "../ProfileServlet",
			async:false,
			data : {"oldid":oldid,"newid":newid,"newname":newname,"newpw":newpw,"newgender2":newgender2},
			datatype : "json",
			success : function(data){
				$("#id").val(data.new_id);
				$("#name").val(data.new_name);
				$("#pw").val(data.new_pw);
				$("#gender2").val(data.new_gender2);
				$("#name,#id,#pw,#gender").css({"background-color":"transparent","color":"white","border":"0px"});
				$(".btn2").css("display","none");
				$("#id").attr("disabled", true);
	
				
				// session 떄문에 잠시 막아놓음
				location.href = "relogin.jsp?newid="+newid; 
			
			},
			error : function(request,status,error){
				alert("실패ㅋㅋ");
			}
		}); 
	});
	
	$(".goback").click(function(){
		location.href = "firstpage.jsp"
	});
	
});

</script>
	<div class = "frame">
		<input type = "hidden" id="oldid" value = "<%=old_id%>">
		<div class = "subframe">
			<div class = "goback"> ◀ go back </div>
			<div id = "img_frame"> 
				<img id = "img_profile" alt="" src="<%=img%>"> 
			</div>
				<div class = "changeimg" style = "display : none">
					<form method = "post" action="out.jsp" enctype = "multipart/form-data">
						<input type = "file" name = "photo" id="file_upload"/>
						<input type = "submit" value = "upload" style = "font-size:12px"/>
					</form>
				</div>
			<div class = "label">NAME</div>
			<div class = "label2"> <input disabled="disabled" type = "text" id = "name" value = "<%=name%>"> </div>
			<div class = "label">ID</div>
			<div class = "label2"> <input disabled="disabled" type = "text" id = "id" value = "<%=id%>"> </div>
			<div class = "label">PW</div>
			<div class = "label2"> <input disabled="disabled" type = "password" id = "pw" value = "<%=pw%>"> </div>
			<div class = "label">GENDER</div>
			<div class = "label2">
				<select id = "gender2" disabled>
				 <option id="new_genderA" selected="selected" ><%=gender%></option>
					<option id = "gender_option" value = "man">man</option>
					<option id = "gender_option" value = "women">women</option>
					<option id = "gender_option" value = "other">other</option>
				</select>
			</div>
			
			<div class = "btn"> <button id = "btn" >edit Profile</button> </div>
			<div class = "btn2"> <button id = "btn2"> update </button> </div>
		</div>	
	</div>
	



</body>
</html>