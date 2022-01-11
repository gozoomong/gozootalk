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
<title>hitaction...</title>
</head>
<body>
<%
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@210.114.10.27:1521:xe";
	String dbid = "gozootalk";
	String dbpw = "gozootalk1234";

	/* 로그인되어있는 아이디 */
	String login_id = (String)(session.getAttribute("login_id"));
	int bno = Integer.parseInt(request.getParameter("bno"));
	
	Connection conn = null;
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url,dbid,dbpw);
	}catch(Exception e){
		e.printStackTrace();
	}
	
	String sql = "UPDATE BOARD SET HITCOUNT = HITCOUNT + 1 WHERE BNO = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, bno);
	
	int ret = pstmt.executeUpdate();
	if(ret==1){
		%>
		<script type="text/javascript">
			window.history.back();
		</script>
		<%
	}
			
%>

</body>
</html>