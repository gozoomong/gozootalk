<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.gozoo.vo.*" %>
<%
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbid = "gozooboard";
	String dbpw = "1234";

	/* 로그인되어있는 아이디 */
	String login_id = (String)(session.getAttribute("login_id"));
	
	Connection conn = null;
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url,dbid,dbpw);
	}catch(Exception e){
		e.printStackTrace();
	}

	ArrayList<BoardVO> list = new ArrayList<BoardVO>();
	String sql = "SELECT * FROM BOARD";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	while(rs.next()){
		int bno = rs.getInt("BNO");
		String title = rs.getString("TITLE");
		String content = rs.getString("CONTENT");
		String writer = rs.getString("WRITER");
		String write_date = rs.getString("WRITE_DATE");
		int hitcount = rs.getInt("HITCOUNT");
		
		list.add(new BoardVO(bno,title,content,writer,write_date,hitcount));
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD LIST</title>
</head>
<style>
	table{
		border-collapse : collapse;
	}
	
	table,th,td{
		border : 1px solid purple;
	}
	
	th,td{
		padding : 10px;
	}
	
	table,tr,td{
		text-overflow: ellipsis;
		white-space : nowrap;
		max-width: 240px;
		overflow: hidden;
	}
	
</style>
<body>

<table>
	<tr>
		<th>No.</th>
		<th>TITLE</th>
		<th>CONTENT</th>
		<th>WRITER</th>
		<th>DATE</th>
		<th>HITCOUNT</th>
	</tr>
	
	<%
		for(BoardVO vo : list){
	%>
		
		<tr>
			<td><%= vo.getBno() %></td>
			<td><%= vo.getTitle() %></td>
			<td><%= vo.getContent() %></td>
			<td><%= vo.getWriter()%></td>
			<td><%= vo.getWrite_date() %></td>
			<td><%= vo.getHitcount() %></td>
		</tr>
	
	<%
		}
	%>
</table>

</body>
</html> --%>