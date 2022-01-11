<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>여기서 데이터베이스저장</h1>
<%
	String image = request.getParameter("image");
	String login_id = request.getParameter("login_id");
	
	request.setCharacterEncoding("UTF-8");
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
	
	String sql = "UPDATE MEMBER SET IMG = ? WHERE ID = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, image);
	pstmt.setString(2, login_id);
	int r = pstmt.executeUpdate();
	if(r == 1){
			String sql2 = "UPDATE BOARD SET IMG = ? WHERE WRITER = ?";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, image);
			pstmt2.setString(2, login_id);
			int r2 = pstmt2.executeUpdate();
			
			String sql3 = "UPDATE MESSAGE SET SENDER_IMG = ? WHERE SENDER = ?";
			PreparedStatement pstmt3 = conn.prepareStatement(sql3);
			pstmt3.setString(1, image);
			pstmt3.setString(2, login_id);
			int r3 = pstmt3.executeUpdate();
			
			String sql4 = "UPDATE CHATTING SET M_W_PROFILE = ? WHERE M_W_EMAIL = ?";
			PreparedStatement pstmt4 = conn.prepareStatement(sql4);
			pstmt4.setString(1, image);
			pstmt4.setString(2, login_id);
			int r4 = pstmt4.executeUpdate();
			
			
		%>
		
			<script type="text/javascript">
				location.href = "profile.jsp?old_id="+"<%=login_id%>";	
			/* alert("plz.."); */
			</script>
		<%
	}
	
	
%>
받은 이미지 : <%=image %> <br>
로그인 아이디 : <%=login_id %>
</body>
</html>