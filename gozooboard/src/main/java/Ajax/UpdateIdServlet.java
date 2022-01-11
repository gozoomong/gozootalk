package Ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

@WebServlet("/UpdateIdServlet")
public class UpdateIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String update_id = request.getParameter("update_id");
		String result_id = request.getParameter("result_id");
		
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
		
		
		String sql = "UPDATE MEMBERS SET ID = ? WHERE ID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, update_id);
			pstmt.setString(2, result_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		try {
			int ret = pstmt.executeUpdate();
			if(ret==1) {
				System.out.println("update complete!!!");
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();
				
				JSONObject obj = new JSONObject();
				obj.put("updatesuccess",update_id);
				obj.put("old_id", result_id);
				out.print(obj);
			
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		
	}

}
