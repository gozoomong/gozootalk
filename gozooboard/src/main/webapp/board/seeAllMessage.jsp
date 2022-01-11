<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.gozoo.vo.*" %>
<%@ page import = "Ajax.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>SEEALLMESSAGE</title>
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
      background-image: url('./images/galaxyL.gif');
   }
   
   .sub{
		width: 400px;
	    border-radius: 20px;
	    margin: auto;
	    background-color: rgba(0, 0, 0, 0.6);
	    overflow-x: hidden;
	    overflow-y: scroll;
	    height: 490px;
	    margin-top: 1em;
	    border-radius: 20px;
   }
   
   
   
   #title{
	   color: white;
	   font-size: 20px;
   }

	#msg{
	    border-radius: 15px;
	    margin-top: 3px;
	    width: 250px;
	    border: 0px;
	    background-color: transparent;
	    color: white;
	    font-size: 11px;
	    margin-left: 56px;
	    overflow: hidden;
	}
	

	#sender{
		width: 134px;
	    margin-right: 139px;
	    border-radius: 15px;
	    background-color: transparent;
	    border: 0px;
	    color: white;
	    margin-top : 12PX;
	}


	#member{
		width: 200px;
		margin-left: -44px;
		border-radius: 10px;
		margin-top: 5px;
	}

	
	#date{
		width: 300px;
	    margin-left: 76px;
	    background-color: transparent;
	    border: 0px;
	    color: white;
	    font-size: 11px;
	}
	
	.pr_img{
	    width: 50px;
	    height: 50px;
	    position: relative;
	    float: left;
	    top: 25px;
	    left: 15px;
	    border-radius: 20px;
	    margin-bottom: -13px;
	}
	
	.msg_frame{
		background: rgba(10, 96, 249, 0.54);
	    border-radius: 71px;
	    height: 104px;
	    border-left: groove;
	    border-bottom-style: groove;
	    border-top-right-radius: 0px;
	    border-bottom-right-radius: 0px;
	}
	
	.goback{
		margin-left: 3em;
		width : 100px;
		color : white;
		cursor : pointer;
	}
	
	.goback:hover{
		color : yellow;
	}
	
	.trashcan{
	    position: relative;
	    width: 24px;
	    left: 20px;
		cursor: pointer;
	}
	
	.trashcan:hover{
		border-radius : 25px;
		background-color : yellow;
	}

</style>
<script type="text/javascript">
	$(function(){
		
		$(".goback").click(function(){
			var login_id = $(".login_id").val();
			location.href = "mailbox.jsp?login_id="+login_id
		});
		
		
		$(".trashcan").click(function(){
			var m_id = $(this).parent().find(".m_id").val();
			/* alert(m_id); */
			$.ajax({
				type : "post",
				url : "../TrashServlet",
				data : {"m_id":m_id},
				datatype : "json",
				success : function(data){
					 /* alert("야 축하한다. 성공이다..");  */
					 location.href = location.href; 
				},
				error : function(request,status,error){
					alert("정신차려라 실패다 임마");
				}
			});
			
		});
		
		
	});
</script>
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
	String sql = "SELECT * FROM MESSAGE WHERE GETTER = ? AND M_CHECK = 1 order by m_id desc";
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

%>
<body>

	<div class = "frame">
	<span id = "title"><%=login_id %>'s messagebox</span>
	<div class = "goback"> ◀ go back </div>
		<span style = "font-size : 8px; color : white;">These emails have already been read</span>
		<div class = "sub">
			<%
				for(MessageVO vo : messagelist){
			%>
			<div class = "msg_frame">
				<input type = "hidden" class="login_id" value = "<%=login_id%>">
			 	<input type = "hidden" class="m_id" value = "<%=vo.getM_id()%>"> 
				<input type="text" disabled="disabled" id="sender" value="ID : <%=vo.getSender()%>"> 
			 	<img alt="" src="<%=vo.getSender_img() %>" class= "pr_img">
				<input type="text" disabled="disabled" id="date" value = "DATE : <%=vo.getM_date()%>">
				<textarea class="msg" disabled="disabled" name="msg" id="msg"  rows="2"><%=vo.getM_content() %></textarea> 
				<img class = "trashcan" alt="" src="./images/trashcan.png">
				<br><br>
			</div>
			<br>
			<%
				}
			%>
		</div>	



	</div>

</body>
</html>