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
	
	String login_id = (String)(session.getAttribute("login_id"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int pw =  Integer.parseInt(request.getParameter("pw"));
	

	
	// 프로필사진 가져오기
	String sql2 = "SELECT IMG FROM MEMBER WHERE ID = ?";
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	pstmt2.setString(1, login_id);
	ResultSet rs = pstmt2.executeQuery();
	String img = "";
	if(rs.next()){
		img = rs.getString("IMG");
	}
	
	String sql = "INSERT INTO BOARD(BNO,TITLE,CONTENT,WRITER,PW,IMG)"
				+" VALUES(SEQ_BOARD.NEXTVAL,?,?,?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, title);
	pstmt.setString(2, content);
	pstmt.setString(3, login_id);
	pstmt.setInt(4, pw);
	pstmt.setString(5, img);
	
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