<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.gozoo.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<title>CHATTING ROOM</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');

    *{
      font-family: 'Source Serif 4'; 
   } 
    body{
   	  background-image: url('./images/galaxyL.gif');
   }
   
   .frame{
      width: 402px;
      height: 726px;
      margin :auto;
      border: 0px solid black;
      text-align: center;
      background-image: url('./images/galaxyL.gif');
   }
   
     .sub{
	    width: 400px;
	    margin: auto;
	    background-color: rgba(0, 0, 0, 0.6);
	    overflow-x: hidden;
	    overflow-y: scroll;
	    height: 562px;
	    margin-top: -2em;
   }


	fieldset{
		width: 373px;
	    heigh: 70px;
	    background-color: lightgray;
	    margin: auto;
	    border : 0px;
		border-bottom-left-radius: 15px;
	    border-bottom-right-radius: 15px;
	}
	
	#inputMessage{
		width: 361px;
	    height: 55px;
	    margin-top: -15px;
	    border: 0px;
  		border-radius: 17px;
	}
	
	#login_id{
		text-align: center;
		border : 0px;
		background-color : transparent;
	}
	
	#send_btn{
		border: 0px;
	    border-radius: 10px;
	    width: 101px;
	    margin-top: 6px;
	    cursor : pointer;
	}
	
	#send_btn:hover{
		background-color: purple;
		color : yellow;
	}
	
	.goback{
	    width: 26px;
	    border-radius: 20px;
	    position: relative;
	    left: 49px;
	    top: -43px;
	    text-align: center;
	    cursor : pointer;
	}
</style>
<%
	String login_id = request.getParameter("login_id");

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
	
	String sql = "SELECT IMG FROM MEMBER WHERE ID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, login_id);
		ResultSet rs = pstmt.executeQuery();
		String login_image = "";
		if(rs.next()){
			login_image = rs.getString("IMG");
		}
		
		
	ArrayList<ChattingVO> m_list = new ArrayList<ChattingVO>();
	String sql2 = "SELECT * FROM CHATTING ORDER BY M_DATE ASC";
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = pstmt2.executeQuery();
	String m_content = "";
	String m_w_email = "";
	String m_date = "";
	String m_w_profile = "";
	
	while(rs2.next()){
		m_content = rs2.getString("M_CONTENT");
		m_date = rs2.getString("M_DATE");
		m_w_email = rs2.getString("M_W_EMAIL");
		m_w_profile = rs2.getString("M_W_PROFILE");
		
		m_list.add(new ChattingVO(m_content,m_date,m_w_email,m_w_profile));
	}

%>

<script type="text/javascript">

	var webSocket = new WebSocket('ws://210.114.10.27:9090/gozooboard/broadcasting');
	var inputMessage = document.getElementById('inputMessage');
	webSocket.onerror = function(event) {
	    onError(event)
	};
	webSocket.onopen = function(event) {
	    onOpen(event)
	};
	webSocket.onmessage = function(event) {
	    onMessage(event)
	};
	
	function onMessage(event) {
	    var message = event.data.split("//.$/");
	    var content = message[0];
	    var sender = message[1];
	    var login_image = message[2];
	    
	    var chatMessageReceived = "<div style='clear:both;'></div>" 
 			+ "<div class= 'msg_frame' style = 'height:55px;'><div class='msg-profile'>"
			+ " <span><img src='"+ login_image +"' alt='star image' style='width: 30px; height: 30px; float: left;margin-top:17px; border-radius:30px;'>"
			+ " </span>"
			+ " <div class='msg_text' style='float: left; color : white; margin-left : 10px; margin-top : 12px;'>"
			+ " <span class = 'msg-name' style = 'float:left; font-size : 13px;' >" + sender + "</span>"
			+ " <div class='msg-item_text"
			+ "'><div style = 'clear:both'></div>"
			+ " <span class='msg-item_text_span' style = 'background-color: lightgreen; height: 18px; border-radius: 40px; color: black; font-size: 14px; float:right;'>"+ content +"</span>"
			+ " </div>"
			+ " </div>"
			+ " </div>"
			+ "<div class='like1'>"
			+ "</div></div>";
	    

	   		
	    if (content == "") {
	        
	    } else {
	        if (content.match("/")) {
	            if (content.match(("/" + $("#chat_id").val()))) {
	                var temp = content.replace("/" + $("#chat_id").val(), "(귓속말) :").split(":");
	                if (temp[1].trim() == "") {
	                } else {
	                    $("#messageWindow").html($("#messageWindow").html() + "<p class='whisper'>"
	                        + sender + content.replace("/" + $("#chat_id").val(), "(귓속말) :") + "</p>");
	                }
	            } 
	            else {
	            }
	        } else {
	            if (content.match("!")) {
	                $(".sub").html($(".sub").html()
	                	+ chatMessageReceived);
	            } else {
	                $(".sub").html($(".sub").html()
	                	+ chatMessageReceived);
	            }
	        }
	    }
	    $('.sub').scrollTop($('.sub')[0].scrollHeight);
	}

	function onOpen(event) {
	    
	}
	function onError(event) {
	    alert(event.data);
	    alert('연결 실패');
	}

	function send() {
		
		
		// 내가 보낸 메세지 바로 뜨게 하는 part
/* 			+ "<div class= 'msg_frame "
 			+ (login_id.equals(m_w_emailA) ? "me" : "")
 			+ " style = 'height:55px;'><div class='msg-profile'>" */
		var chatMessageNew = "<div style='clear:both;'></div>" 
	 			+ "<div class= 'msg_frame me' style = 'height:55px;'><div class='msg-profile'>"
				+ " <span><img src='"+ $("#login_image").val() +"' alt='star image' style='width: 30px; height: 30px; float: right;margin-top:17px; border-radius:30px;'>"
				+ " </span>"
				+ " <div class='msg_text' style='float: left; color : white; margin-left : 10px; margin-top : 12px;'>"
				+ " <span class = 'msg-name' style = 'float:right; font-size : 13px;' >" + $("#login_id").val() + "</span>"
				+ " <div class='msg-item_text"
				+ "'><div style = 'clear:both'></div>"
				+ " <span class='msg-item_text_span' style = 'background-color: yellow; height: 18px; border-radius: 40px; color: black; font-size: 14px; float:right;'>"+ $("#inputMessage").val() +"</span>"
				+ " </div>"
				+ " </div>"
				+ " </div>"
				+ "<div class='like1'>"
				+ "</div></div>";
				
				
		    
			
		    if ($("#inputMessage").val() != "") {
		        $(".sub").html($(".sub").html() + chatMessageNew);
		    	}
	   
	    webSocket.send($("#inputMessage").val()+"//.$/"+$("#login_id").val()+"//.$/"+$("#login_image").val());
		$("#inputMessage").val("");
		$('.sub').scrollTop($('.sub')[0].scrollHeight);
	}
	
	
//	     엔터키를 통해 send함 [잠깐 막음 엔터가 두번눌림]
 	function enterkey() {
	    if (window.event.keyCode == 13) {
	        send();
	        $('.sub').scrollTop($('.sub')[0].scrollHeight);
	    }
	}     
	    
	$(function(){
		$('.sub').scrollTop($('.sub')[0].scrollHeight);

		$(".goback").click(function(){
			location.href = "firstpage.jsp"
		});
	})
	
		
</script>
<body>


<div class = "frame">

	<h3 style = "color : white;">CHATTING ROOM</h3>
	 <div class = "goback"> <img style= "width:26px;" alt="./images/goback.png" src="./images/back.png"> </div> 
	<div class = "sub">
		<div style = "clear : both"></div>
	
	 	
	<%
		String content = "";
		String m_w_profileA = "";
		String m_w_emailA = "";
		String profile_img = "";
		for(int i = 0; i <= m_list.size()-1; i++){
			
			content = m_list.get(i).getM_content();
			m_w_profileA = m_list.get(i).getM_w_profile();
			profile_img = m_list.get(i).getM_w_profile();
			m_w_emailA = m_list.get(i).getM_w_email();
			
			
			
		String chatMessage = "<div style='clear:both;'></div>" 
 			+ "<div class= 'msg_frame "
 			+ (login_id.equals(m_w_emailA) ? "me" : "")
 			+ " style = 'height:55px;'><div class='msg-profile' style = 'margin-top : 16px;'>"
			+ " <span><img class='profile_img' src='"+profile_img+"' alt='star image'>"
			+ " </span>"
			+ " <div class='msg_text'>"
			+ " <span class = 'msg-name'>" + m_w_emailA + "</span>"
			+ " <div class='msg-item_text'> "
			+ "<div style = 'clear:both'></div>"
			+ " <span class='msg-item_text_span'>"+ content +"</span>"
			+ " </div>"
			+ " </div>"
			+ " </div>"
			+ "<div class='like1'>"
			+ "</div></div><br>";

		%>
			<%=chatMessage%>
		<% 			
			
			}
			
		%>
			<style>
				.msg_frame.me {
				background-color: transparent;
				float:right;
				height : 55px;
				}
				
				.msg-item_text_span{
					background-color:lightgreen;
					float: left;
					height : 18px; 
					border-radius:40px;
					color:black;
					font-size:14px;
				}
				/* ★★★★★★ me 일때 스타일 주는 법 모르겠음 ★★★★★ */
				/* 스타일부분들.. */
				/* 두개 띄어놓고 할 때 새로고침해야하는거는 에이잭스로 해결해야하나? */
				/* 서버재시작을 너무 자주해야함. 뭐가 문제일까 */
				.msg_frame.me .msg-item_text_span{
						background-color: yellow;
						height: 18px;
					    border-radius: 40px;
					    color: black;
					    font-size: 14px;
					    float:right;
				}
				
				.msg_frame.me .profile_img{
					float:right;
				}
				
				.msg_frame.me .msg-name{
				   font-size: 13px;
	    		   float : right;
				}
				
				.msg_frame.me .msg_text{
				 color : white; 
				 margin-top : 6px;
				 font-size:13px;
				 float : right;
				 
				}
				
				.profile_img{
					 width: 30px; 
					 height: 30px; 
					 float: left;
					 margin-top:10px; 
					 border-radius:30px;
				}
				
				.msg-name{
				 float:left; 
				 font-size : 13px;
				}
				.msg_text{
				 float: left; 
				 color : white; 
				 margin-left : 10px; 
				 margin-top : 6px;
				 font-size:13px;
				}
				
				

				
			</style>	
	
	</div>
	
	<fieldset>
		<div id = "messageWindow"></div> <br>
		<input id = "inputMessage" placeholder="Write your message here..." type = "text" onkeyup = "enterkey()"/>
		<input type = "hidden"  id = "login_id" value = "<%=login_id%>">
		<input type = "hidden" id = "login_image" value = "<%=login_image%>"/>
		<input id= "send_btn" type = "submit" value = "send" onclick= "send()"/>
	</fieldset>


</div>

</body>
</html>