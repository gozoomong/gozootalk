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
		// Test1. html �ܿ��� ���� �����͸� �� �޾Ҵ���?
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
		//System.out.println("dopost���� : " + id + "," + pw); 
			
		// Test2. html ������ ����� ������ �� �� ���޵Ǵ���?
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			// �α��� ���� : {"login_check" : 1}
			
			JSONObject obj = new JSONObject();
			obj.put("login_check",1);
			out.print(obj);
	}

}
