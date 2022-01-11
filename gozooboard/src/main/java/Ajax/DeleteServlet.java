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

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
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
	
	
	String sql = "DELETE FROM BOARD WHERE BNO = ?";
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
			System.out.println("delete complete!!!");
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	
	
	
	}

}
