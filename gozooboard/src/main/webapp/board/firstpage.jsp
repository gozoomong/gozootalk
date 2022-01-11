<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<title>firstpage</title>
<%


String login_id = (String)(session.getAttribute("login_id"));
String old_id = request.getParameter("old_id");

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

   String sql = "SELECT * FROM MEMBER WHERE ID = ?";
   PreparedStatement pstmt = conn.prepareStatement(sql);
   pstmt.setString(1, login_id);
   ResultSet rs = pstmt.executeQuery();
   String id = "";
   String pw = "";
   String name = "";
   String gender = "";
   String img = "";
   
   while(rs.next()){
      id = rs.getString("ID");
      pw = rs.getString("PW");
      name = rs.getString("NAME");
      gender = rs.getString("GENDER");
      img = rs.getString("IMG");
   }


   String sql2 = "SELECT COUNT(*) FROM MESSAGE WHERE GETTER = ? AND M_CHECK = 0";
   PreparedStatement pstmt2 = conn.prepareStatement(sql2);
   pstmt2.setString(1, login_id);
   ResultSet rs2 = pstmt2.executeQuery();
   int msg_cnt = 0;
   if(rs2.next()){
	   msg_cnt = rs2.getInt(1);
   }
   

%>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Lobster&family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
</style>
</head>
<style>
    *{
      font-family: 'Lobster';
   } 
   
   body{
   	  background-image: url('./images/galaxyL.gif');
   }
   
   .frame{
      width: 379px;
      height: 726px;
      margin :auto;
      border: 0px solid black;
      text-align: center;
      background-image: url('./images/galaxyL.gif');
   }
   
   .btnA{
      font-family: 'Bebas Neue';
      border-radius : 15px;
      width: 50px;
       height: 20px;
       font-size: 10px;
       background-color: blue;
       color: yellow;
      cursor: pointer;
      margin-top : 2em;
   }
   
   .btnA:hover{
      background : yellow;
      color : purple;
   }
   
   .btn{
    width: 130px;
    height: 40px;
    color: white;
    background: purple;
    border-radius: 15px;
    font-family: 'Bebas Neue';
    font-size: 20px;
    cursor: pointer;
    text-transform: uppercase;
    transition: all 0.8s ease-out;
    background: linear-gradient(purple, blue);
   }
   
   .btn:hover{
      background-color: yellow;
      color : yellow;
   }
   
   h1{
      color : white;
      font-weight: bold;
   }
   
   .hello{
      color : white;
      font-size: 15px;
      margin-top : 1em;
   }
   
   .intro{
      margin-top : 8em;
      color : white;
   }
   
   .change{
      cursor: pointer;
      transition : all 2s;
   }
   
   .change:hover{
      color : yellow;
   }
   
   .changeB{
      cursor: pointer;
      transition : all 2s;
   }
   
   .changeB:hover{
      color : yellow;
   }
   
   h3{
      color : white;
   }
   #login{
       background-color: transparent;
       border: 0px;
       color: white;
       font-size: 23px;
       width: 201px;
       margin: auto;
       text-align: center;
   }
   
   	#img_frame{
		width: 52px;
	    height: 52px;
	    border-radius: 48px;
	    margin: auto;
	    background-color: black;
	}
	
	#img_profile{
		width: 100%;
	    height: 100%;
	    border-radius: 48px;
	}
	
	#profile_menu{
		width: 107px;
	    height: 45px;
	    margin: auto;
	    margin-top: -14px;
	}
	
	.messagecheck{
		width: 177px;
	    color: white;
	    border-radius: 20px;
	    font-size: 12px;
	    margin: auto;
	}
		
  .msms{
		    font-size: 10px;
		    width: 12px;
		    border: 0px;
		    color: white;
		    background-color: red;
		    border-radius: 20px;
		    position: absolute;
		    margin-top: 17px;
		    margin-left: 97px;
		  }
		  
	.m_cnt{
		color : red;
	}
	
</style>

<script type="text/javascript">
   function on_btn_register(){
      location.href = "register.jsp";
   };
   
   function on_btn_login(){
      location.href = "login.jsp";
   };
   
   function on_btn_logout(){
      location.href = "logout_action.jsp";
   };
   
   function on_btn_board(){
      location.href = "board.jsp";
   };
   
   function alertA(){
      alert("login or register first!");
   };
   
   function alertB(){
      alert("You already login")
   }
   
   function change(){
   /*    $('body').css({"transition":"background 1s ease-in","background":"lightcoral"}); */
      $('.frame').css({"transition":"background 1s ease-in","background-image":"url('./images/bg2.jpg')"});
   }
   
   function changeB(){
      /*    $('body').css({"transition":"background 1s ease-in","background":"lightcoral"}); */
         $('.frame').css({"transition":"background 1s ease-in","background-image":"url('./images/background.jpg')"});
      }
   
   
   var bgname = ['galaxy.png','galaxyC.jpg','galaxyD.jpg','galaxyE.jpg','bg2.jpg','background.jpg',
            'galaxyF.jpg','galaxyI.gif','galaxyJ.gif','galaxyK.jpg','galaxyL.gif'];
   
   function bgChange(){
      var url = bgname[Math.floor(Math.random()*bgname.length)];
      $('.frame').css({"transition":"background 1s ease-in","background-image":"url('./images/"+url+"')"});
   }
   
   function seeprofile(){
      var login = $("#login").val();
      location.href = "profile.jsp?old_id="+login;
   }
   
   function seemessage(){
	  var login = $("#login").val();
	  location.href = "mailbox.jsp?login_id="+login;
   }
   
   function gorank(){
		  var login = $("#login").val();
		  location.href = "rank.jsp?login_id="+login;
	   }
   
   function gochat(){
	   	var login = $("#login").val();
	   	location.href = "chat.jsp?login_id="+login;
 	  }
   
   
   
   
</script>

<body>
   <div class = "frame">
      <h1 style = "font-family:Lobster "> <span onclick="bgChange();" class = "changeB">◀</span> GOZOOMONG TALK <span onclick="bgChange()" class = "change">▶</span></h1>
      <br><br>
      <%
         if(login_id != null){
      %>
      
      <%
      // 메세지가 와있으면 나오는 문구
      	if(msg_cnt>0){
      %>
      <div class = "messagecheck">
		Check out <span class = m_cnt><%=msg_cnt %></span> new messages!
      </div>
      <%
      	}
      %>
     	<br>
      <input disabled="disabled" id = "login" type ="text" value = "<%=login_id %>"> <br>
      <div id = "img_frame">
      	<img id = "img_profile" alt="" src="<%=img%>"> 
      </div> <br>
      <div id = "profile_menu">
      <%
      	if(msg_cnt>0){
      %>
      <div class="msms"><%=msg_cnt %></div>
	<%
      	}
	%>
      <table>
			<tr>
				<td><button class = "btnA" onclick="seeprofile()">PROFILE</button></td>
				<td><button class = "btnA" onclick="seemessage()">MESSAGE</button></td>
			</tr>
			<tr>
				<td><button class = "btnA" onclick="gorank()">RANK</button></td>
				<td><button class = "btnA" onclick="on_btn_register()">REGISTER</button></td>
			</tr>
      </table>
      </div>
      <br><br><br>
      <%
         }
         
         else{
            %>
            <h3>Please Login</h3>   
            <%
         }
      
      %>
      
      <%
         if(login_id == null){
      %>
      	 <button class = "btn" onclick="on_btn_register()">REGISTER</button> <br><br>
         <button class = "btn" onclick="on_btn_login()">LOG IN</button> <br><br>
         <button class = "btn" onclick="alertA()">LOG OUT</button> <br><br>
         <button class = "btn" onclick="alertA()">BOARD</button> <br><br>
      <%
         }else{
      %>
         <button class = "btn" onclick="gochat()">CHATTING</button> <br><br>
         <button class = "btn" onclick="on_btn_logout()">LOG OUT</button> <br><br>
        <!--  <button class = "btn" onclick="alertB()">LOG IN</button> <br><br> -->
         <button class = "btn" onclick="on_btn_board()">BOARD</button> <br><br>
 	
      <%
         }   
      %>
         
         <div class = "intro">
            <span>made by gozoomongKR</span>
         </div>
   </div>
   
</body>
</html>