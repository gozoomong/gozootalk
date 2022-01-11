<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write loading...</title>
</head>
<body>

<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbid = "gozooboard";
	String dbpw = "1234";
	
	Connection conn = null;
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url,dbid,dbpw);
	}catch(Exception e){
		e.printStackTrace();
	}
	
	String login_id = (String)(session.getAttribute("login_id"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int pw =  Integer.parseInt(request.getParameter("pw"));
	
	if(login_id.equals("gozoomong")){
		login_id = "관리자";
	}

	
	String sql = "INSERT INTO BOARD(BNO,TITLE,CONTENT,WRITER,PW)"
				+" VALUES(SEQ_BOARD.NEXTVAL,?,?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, title);
	pstmt.setString(2, content);
	pstmt.setString(3, login_id);
	pstmt.setInt(4, pw);
	
	int r = pstmt.executeUpdate();
	if(r == 1){
%>

	<script type="text/javascript">
	alert("POSTING COMPLETE");
	location.href = "board.jsp";
	</script>

<%
	}
%>

</body>
</html>