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
 String newid= request.getParameter("newid");
 String oldid = (String)(session.getAttribute("login_id"));
 String oldid_B = oldid;
 session.removeAttribute("login_id"); 
 %>
<% 
 session.setAttribute("login_id", newid);


 String renewid = (String)(session.getAttribute("login_id"));

 
 %>
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
	String sql = "UPDATE BOARD SET WRITER = ? WHERE WRITER = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, renewid);
	pstmt.setString(2, oldid_B);
	pstmt.executeUpdate();
 
 %>
 <script type="text/javascript">
 	location.href = "profile.jsp?old_id="+"<%=renewid%>";
 </script>
 <% 
 
%>
</body>
</html>