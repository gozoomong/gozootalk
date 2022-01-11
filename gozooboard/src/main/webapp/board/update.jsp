<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.gozoo.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<title>update page</title>
</head>
<style>
 	*{
		font-family: 'Lobster';
	} 
	
	body{
   	  background-image: url('./images/background.jpg');
   }
   
   .frame{
      width: 402px;
      height: 726px;
      margin :auto;
      border: 0px solid black;
      text-align: center;
      background-image: url('./images/background.jpg');
   }
	
	.sub_frame{
		width: 300px;
		height : 400px;
		margin : auto;
		background-color: hsla(628, 100%, 38%, 0.3);
	}
	
	.title{
		width : 137px;
		background-color: white;
		border : 0px;
		border-radius: 15px;
		color : black;
		text-align: center;
	}
	
	table{
		text-align: left;
		margin: auto;
	}
	
	.label{
		color : white;
		font-weight: bold;
	}
	
	h3{
		color : white;
		padding-top : 2em;
	}
	.goback{
		color : white;
		background-color: gray;
		text-align: center;
	    cursor: pointer;
	    font-size: 15px;
	    border-radius: 12px;
	}
</style>
<script type="text/javascript">
	function goback(){
		window.history.back();
	}
</script>

<body>
<%
	int bno = Integer.parseInt(request.getParameter("bno"));
	
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

	String sql = "SELECT * FROM BOARD WHERE BNO = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, bno);
	ResultSet rs = pstmt.executeQuery();
	String title = "";
	String content = "";
	String writer = "";
	String write_date = "";
	while(rs.next()){
		int bno2 = rs.getInt("BNO");
		title = rs.getString("TITLE");
		content = rs.getString("CONTENT");
		writer = rs.getString("WRITER");
		write_date = rs.getString("WRITE_DATE");
		int hitcount = rs.getInt("HITCOUNT");
	}
	
	
%>
	<div class = "frame">
		<div class = "sub_frame">
			<form action="update_action.jsp" method="post">
			<input type = "hidden" name = "update_bno" value = "<%=bno%>">
				<h3>Update your posts in a free way, while maintaining good manners.</h3>
				<table>
					<tr>
						<td class= "label">WRITER</td>
						<td><input disabled="disabled" class = "title" type = "text" value="<%=writer %>" style = "font-weight: bold"> </td>
					</tr>
					<tr>
						<td class= "label">DATE</td>
						<td> <input disabled="disabled" class = "title" type = "text" value="<%=write_date %>"style = "font-weight: bold"> </td>
					</tr>
					<tr>
						<td class= "label">TITLE</td>
						<td> <input class = "title" type = "text" name = "update_title" value="<%=title %>"> </td>
					</tr>
					<tr>
						<td class= "label">CONTENT</td>
						<td><textarea rows="5" cols="" name = "update_content"><%=content %></textarea> </td>
					</tr>
				</table>
				<div style = "margin-top : 1.5em;">
					<input type = "submit" value = "update" style = "margin-left : 4em; width : 130px; border-radius: 15px; background-color : white; ">
			</form>
				</div>
		</div>
		<span class = "goback" onclick="goback()">go back</span>
	</div>

</body>
</html>