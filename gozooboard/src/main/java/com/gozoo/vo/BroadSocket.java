package com.gozoo.vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/broadcasting") // 클라이언트에서 서버로 접속할 주소를 지정함.
public class BroadSocket {
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());

	@OnMessage // 클라이언트로부터 메시지가 도착했을 때.
	public void onMessage(String message, Session session) throws IOException, ClassNotFoundException, SQLException {
		System.out.println("from client : " + message);
		// message |로 스플릿 -> 앞에꺼 아이디에 저장하고 뒤에꺼 m_content에 저장
		String whole_message = message;
		String splitMessage = "//.\\$/";
		String[] messageArr = whole_message.split(splitMessage);
		String content = messageArr[0];
		System.out.println(content);
		String login_id = messageArr[1];
		System.out.println(login_id);
		String login_image = messageArr[2];
		System.out.println(login_image);

		// jdbc

		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@210.114.10.27:1521:xe";
		String dbid = "gozootalk";
		String dbpw = "gozootalk1234";

		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, dbid, dbpw);

		Scanner sc = new Scanner(System.in);

		
		 String sql =
		 "INSERT INTO CHATTING (M_CONTENT,M_ID,M_W_EMAIL,M_W_PROFILE)"
		 +"VALUES (?,'M'||SEQ_CHATTING.NEXTVAL,?,?)"; 
		 PreparedStatement pstmt = conn.prepareStatement(sql); 
		 pstmt.setString(1, content);
		 pstmt.setString(2, login_id); 
		 pstmt.setString(3, login_image);
		 
		 pstmt.executeUpdate();

		synchronized (clients) {
			for (Session client : clients) {
				if (!client.equals(session)) {
					client.getBasicRemote().sendText(message);
				}
			}
		}
	}

	@OnOpen // 클라이언트가 서버로 접속했을 때.
	public void onOpen(Session session) {
		System.out.println(session);
		clients.add(session);
	}

	@OnClose // 클라이언트의 접속이 끊겼을 때.
	public void onClose(Session session) {
		clients.remove(session);
	}
}
