<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register loading..</title>
</head>
<body>
	<%
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
		
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		
	

		
		
		String sql = "INSERT INTO MEMBER(ID,PW,NAME,GENDER) VALUES(?,?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, name);
		pstmt.setString(4, gender);
		int r = pstmt.executeUpdate();
		if(r==1){
			sql = "INSERT INTO MESSAGE(SENDER,GETTER,M_CONTENT,M_ID,SENDER_IMG)"
					+" VALUES('gozoomong',?,'Hello welcome to Gozoomong Talk!!',SEQ_MESSAGE.NEXTVAL,'/gozooboard/upload/KakaoTalk_20210128_174947457.jpg')";
			PreparedStatement pstmt2 = conn.prepareStatement(sql);
			pstmt2.setString(1, id);
			pstmt2.executeUpdate();
			
			%>
				<script type="text/javascript">
					/* alert("WELCOME TO GOZOOBOARD, " + id + " :P"); */
					location.href="firstpage.jsp"
				</script>
			<%
		}else{
			%>
				<script type="text/javascript">
					alert("ERROR! contact to our manager..:P");
					location.href= "register.jsp";
				</script>
			<%
		}
	%>
</body>
</html>