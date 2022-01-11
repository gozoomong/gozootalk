package Ajax;

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

@WebServlet("/HitServlet")
public class HitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
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
		
		String sql = "UPDATE BOARD SET HITCOUNT = HITCOUNT + 1 WHERE BNO = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			int ret = pstmt.executeUpdate();
			if(ret==1) {
				System.out.println("update complete!!!");
				int hitup = 0;
				String sql2 = "SELECT HITCOUNT FROM BOARD WHERE BNO = ?";
				PreparedStatement pstmt2 = null;
				try {
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setInt(1, bno);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				try {
					ResultSet rs = pstmt2.executeQuery();
					if(rs.next()) {
						 hitup = rs.getInt("HITCOUNT");
					}
					response.setContentType("application/json");
					PrintWriter out = response.getWriter();
					JSONObject obj = new JSONObject();
					obj.put("hitup",hitup);
					out.print(obj);
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
