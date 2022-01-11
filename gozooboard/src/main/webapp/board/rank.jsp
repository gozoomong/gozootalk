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
<title>Chatting</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<style>
    *{
      font-family: 'Lobster';
      color : white;
   } 
   .frame{
      width: 500px;
      height : 600px;
      margin :auto;
      border: 1px solid gray;
      text-align: center;
      background-image: url('./images/galaxyL.gif');
   }
   
   .subframe{
   	margin : auto;
   	width : 420px;
   	height : 400px;
   	border-radius : 30px;
   	background-color: rgba(0, 0, 0, 0.6);
   }

	.send_btn{
	    position: absolute;
	    margin-top: 12px;
	    height: 30px;
	    color : black;
	    width : 60px;
	    border-radius: 10px;
	}
	
	.back_btn{
	    position: absolute;
    	margin-left: 0px;
    	margin-top: 45px;
		color : black;
		width : 60px;
	    border-radius: 10px;
	}
	
	.first{
		width: 140px;
	    height: 156px;
	    margin: auto;
	    margin-bottom: 1em;
	    font-size: 14px;
	    text-align: center;
	    background-color: rgba(130, -104, 161, 0.6);
	    border-radius: 28px;
   }

   .second{
      width:130px ;
      height: 70px;
      margin-left: 3.3em;
      margin-top:-3em;
      font-size: 12px;
   }

   .third{
      width:130px ;
      height: 70px;
      margin-left: 20em;
      margin-top: -5.8em;
      font-size: 12px;
   }

   .fourth{
      width:90px ;
      height: 30px;
      margin-left: 3.3em;
      margin-top:6em;
      font-size: 10px;
   }
   
   .fifth{
		width: 90px;
	    height: 30px;
	    margin-left: 10.3em;
	    margin-top: -3em;
	    font-size: 10px;
   }
   
    .sixth{
	    width: 90px;
	    height: 30px;
	    margin-left: 17.3em;
	    margin-top: -3em;
	    font-size: 10px;
   }
   
   .seventh{
		width: 90px;
	    height: 30px;
	    margin-left: 24.3em;
	    margin-top: -3em;
	    font-size: 10px;
   }
   
    .eighth{
		width: 90px;
	    height: 30px;
	    margin-left: 30.3em;
	    margin-top: -3em;
	    font-size: 10px;
   }

   ul{
      list-style: none;
      text-align: left;
   }
   
   #back_btn{
   	cursor: pointer;
   }
	
	#back_btn:hover{
		color : yellow;
	}
</style>
<body>
	<script type="text/javascript">

	function back(){
		window.history.back();
	}
	</script>
<%
	String login_id  = request.getParameter("login_id");

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
	
	String sql = "select writer as \"writer\", img, count(*) as \"cnt\" from board  group by writer, img order by \"cnt\" asc";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	String first_writer = "";
	String first_img = "";
	String first_cnt = "";
	
	String second_writer = "";
	String second_img = "";
	String second_cnt = "";
	
	String test = "";
	ArrayList<String> writer_list = new ArrayList<String>();
	ArrayList<String> img_list = new ArrayList<String>();
	ArrayList<String> cnt_list = new ArrayList<String>();
	while(rs.next()){
		first_writer = rs.getString(1);
		first_img = rs.getString(2);
		first_cnt = rs.getString(3);
		
	
			writer_list.add(0, first_writer);
			img_list.add(0, first_img);
			cnt_list.add(0, first_cnt);
	}




%>

	
	<div class = "frame">
		<h3><%=login_id %>'s RANKING ROOM</h3>
		<div class = "subframe">
		
		
		<div>
            <div style="clear: both;"></div>
				<h3>Real-time ranking</h3>
				<div class = "first">
                  RANK 1 <br>
               <img src="<%=img_list.get(0) %>" alt="" style="width: 80px; height: 80px; border-radius: 40px">
                 <br>  <%=writer_list.get(0) %>   
                 <br> Number of posts : <%=cnt_list.get(0) %> 
				</div>

				<div style="clear: both;"></div>
				
            <div class = "second">
               RANK 2 <br>
               <img src="<%=img_list.get(1) %>" alt="" style="width: 60px; height: 60px; border-radius: 40px">
                 <br>  <%=writer_list.get(1) %>  
                 <br> Number of posts : <%=cnt_list.get(1) %> 
				</div>

				
				<div class = "third">
               RANK 3 <br>
               <img src="<%=img_list.get(2) %>" alt="" style="width: 60px; height: 60px; border-radius: 40px">
                 <br>  <%=writer_list.get(2) %>
                 <br> Number of posts : <%=cnt_list.get(2) %> 
				</div>
				
				
	          <div class="fourth">
               RANK 4 <br>
               <img src="<%=img_list.get(3) %>" alt="" style="width: 30px; height: 30px; border-radius: 40px">
                 <br>  <%=writer_list.get(3) %>
                 <br> posts : <%=cnt_list.get(3) %> 
           	 </div>
           	 
           	 
           	  <div class="fifth">
               RANK 5 <br>
               <img src="<%=img_list.get(4) %>" alt="" style="width: 30px; height: 30px; border-radius: 40px">
                 <br>  <%=writer_list.get(4) %>
                 <br> posts : <%=cnt_list.get(4) %> 
           	 </div>
           	 
          	  <div class="sixth">
               RANK 6 <br>
               <img src="<%=img_list.get(5) %>" alt="" style="width: 30px; height: 30px; border-radius: 40px">
                 <br>  <%=writer_list.get(5) %>
                 <br> posts : <%=cnt_list.get(5) %> 
           	 </div>
           	 
	    	  <div class="seventh">
               RANK 7 <br>
               <img src="<%=img_list.get(6) %>" alt="" style="width: 30px; height: 30px; border-radius: 40px">
                 <br>  <%=writer_list.get(6) %>
                 <br> posts : <%=cnt_list.get(6) %> 
           	 </div>
           	 
          	  <div class="eighth">
               RANK 8 <br>
               <img src="<%=img_list.get(7) %>" alt="" style="width: 30px; height: 30px; border-radius: 40px">
                 <br>  <%=writer_list.get(7) %>
                 <br> posts : <%=cnt_list.get(7) %> 
           	 </div>
           	 
					
				
		</div>
		
		</div>
		
				<span id = "back_btn" onclick ="back()">◀ go back to main page</span>
		

		
		
		
		
		
	</div>

</body>
</html>