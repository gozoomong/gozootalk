package com.gozoo.vo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;


@WebServlet("/TrashServlet")
public class TrashServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
 

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int m_id = Integer.parseInt(request.getParameter("m_id"));
		
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
		
		String sql = "DELETE FROM MESSAGE WHERE M_ID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, m_id);

			int ret = pstmt.executeUpdate();
			if(ret==1) {
				System.out.println("complete Message delete!!!");
				response.setContentType("application/json");
				PrintWriter out = response.getWriter(); 
				 JSONObject obj = new JSONObject(); 
				 obj.put("updatesuccess",m_id); 
				 out.print(obj); 
			}
			else {
				System.out.println("failed...");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	
	}

}
