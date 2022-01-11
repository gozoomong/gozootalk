package Ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	
//	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Test1. html 단에서 보낸 데이터를 잘 받았는지?
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
		//System.out.println("dopost에서 : " + id + "," + pw); 
			
		// Test2. html 단으로 결과를 보냈을 때 잘 전달되는지?
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			// 로그인 성공 : {"login_check" : 1}
			
			JSONObject obj = new JSONObject();
			obj.put("login_check",1);
			out.print(obj);
	}

}
