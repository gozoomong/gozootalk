<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update loading..</title>
</head>
<body>
<%
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
	
	request.setCharacterEncoding("UTF-8");
	String update_title = request.getParameter("update_title");
	String update_content = request.getParameter("update_content");
	int bno = Integer.parseInt(request.getParameter("update_bno"));

	String sql = "UPDATE BOARD SET TITLE = ?, CONTENT = ? WHERE BNO = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, update_title);
	pstmt.setString(2, update_content);
	pstmt.setInt(3, bno);
	int r = pstmt.executeUpdate();
	if(r==1){
		%>
			<script type="text/javascript">
				location.href = "board.jsp";
			</script>
		<%
	}

%>



</body>
</html>