<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login loading...</title>
</head>
<body>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbid = "gozooboard";
	String dbpw = "1234";
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	Connection conn = null;
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url,dbid,dbpw);
	}catch(Exception e){
		e.printStackTrace();
	}
	
	request.setCharacterEncoding("UTF-8");
	
	String sql = "SELECT COUNT(*) FROM MEMBER WHERE ID = ? AND PW = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, pw);
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){
		int cnt = rs.getInt(1);
		if(cnt == 1){
			/* login complete & save id  */
			session.setAttribute("login_id", id);
		%>
			<script type="text/javascript">
				/* alert("HELLO " + id); */
				location.href = "firstpage.jsp";
			</script>
		<%
		}else{
			%>
			<script type="text/javascript">
				alert("ERROR..please contact to us manager");
				location.href = "firstpage.jsp";
			</script>
		<%
		}
	}
	

%>
</body>
</html>