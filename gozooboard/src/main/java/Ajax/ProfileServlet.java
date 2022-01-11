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


@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;


   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

   String oldid = request.getParameter("oldid");
   String newid = request.getParameter("newid");
   String newname = request.getParameter("newname");
   int newpw = Integer.parseInt(request.getParameter("newpw"));
   String newgender2 = request.getParameter("newgender2");

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
   
   String sql = "UPDATE MEMBER SET ID = ?,NAME = ?,PW = ?,GENDER = ? WHERE ID = ?";
   PreparedStatement pstmt = null;
   try {
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, newid);
      pstmt.setString(2, newname);
      pstmt.setInt(3, newpw);
      pstmt.setString(4, newgender2);
      pstmt.setString(5, oldid);
      int ret = pstmt.executeUpdate();
      if(ret==1) {
         System.out.println("update complete!!!");
         response.setContentType("application/json");
         PrintWriter out = response.getWriter();
         
         JSONObject obj = new JSONObject();
         obj.put("new_id",newid);
         obj.put("new_name", newname);
         obj.put("new_pw", newpw);
         obj.put("new_gender2", newgender2);
         out.print(obj);
      
      }
   } catch (SQLException e) {
      e.printStackTrace();
   }
   
   
   
   
   
   
   
   
   
   }

}