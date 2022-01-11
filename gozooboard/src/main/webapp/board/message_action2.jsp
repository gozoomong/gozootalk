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
<%
	String text = request.getParameter("text");
	String id = request.getParameter("id");
	String login_id = (String)(session.getAttribute("login_id"));

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
			
	
	String sql2 = "SELECT IMG FROM MEMBER WHERE ID = ?";
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	pstmt2.setString(1, login_id);
	ResultSet rs2 = pstmt2.executeQuery();
	String sender_img ="";
	if(rs2.next()){
		sender_img = rs2.getString("IMG");
	}
	
	String sql = "INSERT INTO MESSAGE(SENDER,GETTER,M_CONTENT,M_ID,SENDER_IMG) VALUES(?,?,?,SEQ_MESSAGE.NEXTVAL,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, login_id);
	pstmt.setString(2, id);
	pstmt.setString(3, text);
	pstmt.setString(4, sender_img);
	
	int r = pstmt.executeUpdate();
	if(r==1){
		%>
		<script type="text/javascript">
			alert("SEND COMPLETE!")
			location.href="mailbox.jsp"
		</script>
		<%
	}


%>
보낸사람 : <%=login_id %> <br>
받는사람 : <%=id %> <br>
문자내용 : <%=text %>

</body>
</html>