<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.gozoo.vo.*" %>
<%@ page import = "Ajax.*" %>

<%
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@210.114.10.27:1521:xe";
String dbid = "gozootalk";
String dbpw = "gozootalk1234";
String login_id = (String)(session.getAttribute("login_id"));

Connection conn = null;
try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url,dbid,dbpw);
}catch(Exception e){
	e.printStackTrace();
}

ArrayList<MessageVO> messagelist = new ArrayList<MessageVO>();
String sql = "SELECT * FROM MESSAGE WHERE GETTER = ? AND M_CHECK = 0  order by m_id desc";
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setString(1, login_id);
ResultSet rs = pstmt.executeQuery();

while(rs.next()){
	String sender = rs.getString("SENDER");
	String m_content = rs.getString("m_content");
	String m_date = rs.getString("m_date");
	int m_id = rs.getInt("m_id");
	String sender_img = rs.getString("SENDER_IMG");
	
	messagelist.add(new MessageVO(sender,m_content,m_date,m_id,sender_img));
}

ArrayList<MessageVO> memberlist = new ArrayList<MessageVO>();
String sql2 = "SELECT distinct SENDER FROM MESSAGE WHERE GETTER = ?";
PreparedStatement pstmt2 = conn.prepareStatement(sql2);
pstmt2.setString(1, login_id);
ResultSet rs2 = pstmt2.executeQuery();
while(rs2.next()){
	String sender = rs2.getString("SENDER");
	memberlist.add(new MessageVO(sender));
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>MAILBOX</title>
<style type="text/css">
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

   .sub{
		width : 375px;
		border-radius: 20px;
		margin: auto;
		background-color: rgba(0, 0, 0, 0.6);
		overflow-x:hidden;
		 overflow-y:scroll; 
		 height:250px;
		 border-radius: 20px;
   }

   .sub2{
		width : 375px;
		margin: auto;
	   	margin-top: 1em;
		border-radius: 20px;
		background-color: rgba(0, 0, 0, 0.6);
		height: 170px;
   }

   #title{
	   color: white;
   }

	#msg{
		border-radius: 15px;
		margin-top:3px;
		width: 250px;
		border : 0px;
		background-color: transparent;
		color : white;
		margin-left : 40px;
		overflow : hidden;
	}
	
	#reply{
	    margin-top: 3px;
	    width: 200px;
	    border: 0px;
	    color: black;
	    border-radius: 10px;
	    margin-left: -3em;
	}

	#sender{
		width: 134px;
	    margin-right: 10em;
	    border-radius: 15px;
	    background-color: transparent;
	    border: 0px;
	    color: white;
	}

	
	.read{
	    position: relative;
    	top: -23px;
		cursor : pointer;
		border-radius: 20px;
	}
	
	.read:hover{
		background-color: yellow;
		color : purple;
	}

	#member{
		width: 200px;
		margin-left: -44px;
		border-radius: 10px;
		margin-top: 5px;
	}

	h2{
		color : white;
	}
	
	#date{
		width: 300px;
	    margin-left: 0em;
	    background-color: transparent;
	    border: 0px;
	    color: white;
	}
	#send_btn{
	    width: 159px;
	    margin-top: -13px;
	    margin-left: -56px;
	    border-radius: 16px;
	    cursor : pointer;
	}
	
	.goback{
		width : 100px;
		color : white;
		cursor : pointer;
	}
	
	.goback:hover{
		color : yellow;
	}
	
	.seeAll{
		margin-left: 2em;
	    width: 100px;
	    position: relative;
	    top: -21px;
	    left: 269px;
	    color: white;
	    cursor: pointer;
	}
	
	.seeAll:hover{
		color : yellow;
	}
	
	.pr_img{
	    width: 34px;
	    height: 34px;
	    position: relative;
	    margin-left: -6px;
	    margin-top: -5px;
	    border-radius: 20px;
	    margin-bottom: -13px;
	}
</style>
</head>
<body>
<script type="text/javascript">

	function sendreply(){
		var reply = $("#reply").val();
		var member_id = $("#member option:selected").val();
	 	if(reply==""||member_id==="Members"){
			alert("There is no content or Member.")
		}else{
		 	location.href = "message_action2.jsp?text="+reply+"&id="+member_id; 
		} 
	};
	
	


	
	$(function(){
		
		$(".goback").click(function(){
			location.href = "firstpage.jsp"
		});
		
		$(".seeAll").click(function(){
			location.href = "seeAllMessage.jsp"
		});
		
		$(".m_id").click(function(){
			check = $(this).val();
			alert(check);
		});
		
	
		$(".read").click(function(){
		var	m_number = $(this).parent().find(".m_id").val();
		var	login_id = $(this).parent().find(".login_id").val();
		/* 	alert(m_number + "@@"); */
			$.ajax({
				type : "post",
				url : "../MailCheckServlet",
				data : {"m_number":m_number},
				datatype : "json",
				success : function(data){
					/* alert("야 축하한다. 성공이다.."); */
					 location.href = location.href; 
				},
				error : function(request,status,error){
					alert("정신차려라 실패다 임마");
				}
			});
/* 			alert(m_number);
			alert(login_id); */
		});
		
		
	});
	

</script>


<div class = "frame">
<h2><%=login_id %>'s mailbox</h2>
<div class = "goback"> ◀ go back </div>
<div class = "seeAll"> see all ▶ </div>
		<span id="title">M E S S A G E &nbsp; B O X</span> <br><br>
	<div class = "sub">
		
		<%
			for(MessageVO vo : messagelist){
		%>
		<div>
			<input type = "hidden" class="login_id" value = "<%=login_id%>">
		 	<input type = "hidden" class="m_id" value = "<%=vo.getM_id()%>"> 
			<input type="text" disabled="disabled" id="sender" value="ID : <%=vo.getSender()%>"> <br>
		 	<img alt="" src="<%=vo.getSender_img() %>" class= "pr_img">
			<input type="text" disabled="disabled" id="date" value = "DATE : <%=vo.getM_date()%>">
			<textarea class="msg" disabled="disabled" name="msg" id="msg"  rows="2"><%=vo.getM_content() %></textarea> 
			<button class="read" >Check</button>
			<br><br>
		</div>
		<%
			}
		%>
	</div>

	<div class = "sub2">
		<span id="title">S E N D &nbsp; R E P L Y &nbsp; M E S S A G E </span> 
		<br> 
		<select name="member" id="member">
		<option selected="selected" disabled="disabled">Members</option>
		<%
			for(MessageVO vo2 : memberlist){
		%>
			<option value="<%=vo2.getSender() %>"><%=vo2.getSender() %></option>
		<%
			}
		%>
		</select>
		<br>
		<textarea  name="content" id="reply"  rows="3"></textarea> <br>
		<br>
		 <button id = "send_btn" onclick="sendreply()"> SEND </button>
		
	
	</div>


</div>



</body>
</html>