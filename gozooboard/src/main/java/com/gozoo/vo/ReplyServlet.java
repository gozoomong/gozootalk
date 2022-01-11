package com.gozoo.vo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ReplyServlet")
public class ReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	String re_content = request.getParameter("re_content");
	String login_id = request.getParameter("login_id");
	String re_sender = request.getParameter("re_sender");
	
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
	
	String sql = "INSERT INTO CHATTING(CH_SENDER,CH_GETTER,CH_CONTENT,CH_ID) VALUES"
			+"(?,?,?,SEQ_CHATTING.NEXTVAL)";
	PreparedStatement pstmt = null;
	try {
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, login_id);
		pstmt.setString(2, re_sender);
		pstmt.setString(3, re_content);

		int ret = pstmt.executeUpdate();
		if(ret==1) {
			
			String sql2 = "select CH_CONTENT from chatting where ch_id = (select max(ch_id) from chatting)";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			ResultSet rs2 = pstmt2.executeQuery();
			String ch_content = "";
			if(rs2.next()) {
				ch_content = rs2.getString("CH_CONTENT");
				
				System.out.println("Message check!!!");
				response.setContentType("application/json");
				PrintWriter out = response.getWriter(); 
				JSONObject obj = new JSONObject(); 
				obj.put("updatecontent",re_content);
				obj.put("ch_content", ch_content);
				out.print(obj); 
				
			}
		}else {
			System.out.println("FAILED");
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	
	}

}
