package Ajax;

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

@WebServlet("/LoginCheckServlet")
public class LoginCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/*
	 * protected void doGet(HttpServletRequest request, HttpServletResponse
	 * response) throws ServletException, IOException {
	 * response.getWriter().append("Served at: ").append(request.getContextPath());
	 * }
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbid = "TEST";
		String dbpw = "1234";
		
		
		Connection conn = null;
		try{
			Class.forName(driver);
			conn = DriverManager.getConnection(url,dbid,dbpw);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		String sql = "INSERT INTO MEMBERS(ID,PW) VALUES(?,?)";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			pstmt.setString(1, id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			pstmt.setString(2, pw);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		try {
			int ret = pstmt.executeUpdate();
			if(ret==1) {
				System.out.println("JDBC INSERT COMPLTET!!");
				
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();
				
				JSONObject obj = new JSONObject();
				obj.put("login_check",id);
				obj.put("login_pw", pw);
				out.print(obj);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}
}
