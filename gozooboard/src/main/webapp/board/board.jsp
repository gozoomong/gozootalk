<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.gozoo.vo.*" %>
<%
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@210.114.10.27:1521:xe";
	String dbid = "gozootalk";
	String dbpw = "gozootalk1234";
	
	String trim = "  ";

	/* 로그인되어있는 아이디 */
	String login_id = (String)(session.getAttribute("login_id"));
	
	int pageNum = 0;
	int beginNum, endNum; 
	/* 페이지당 게시글 10개씩 출력시 */
	/* ex pageNum = 2 라면, beginNum = 11, endNum = 20 */
	
	try{
		pageNum = Integer.parseInt(request.getParameter("page"));
	} catch(Exception e){
		pageNum = 1;
	};
	
	beginNum = pageNum * 10 - 9;
	endNum = pageNum * 10;
																										
																										
	Connection conn = null;
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url,dbid,dbpw);
	}catch(Exception e){
		e.printStackTrace();
	}

	ArrayList<BoardVO> list = new ArrayList<BoardVO>();
	String sql = "SELECT * FROM (SELECT ROWNUM RNUM, E.* FROM (SELECT * FROM BOARD ORDER BY BNO DESC) E) E2 WHERE E2.RNUM >=? AND E2.RNUM<=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, beginNum);
	pstmt.setInt(2, endNum);
	ResultSet rs = pstmt.executeQuery();
	while(rs.next()){
		int bno = rs.getInt("BNO");
		String title = rs.getString("TITLE");
		String content = rs.getString("CONTENT");
		String writer = rs.getString("WRITER");
		String write_date = rs.getString("WRITE_DATE");	
		int hitcount = rs.getInt("HITCOUNT");
		String img = rs.getString("IMG");
		
		list.add(new BoardVO(bno,title,content,writer,write_date,hitcount,img));
	}
	
	// MemberVO 
	ArrayList<MemberVO> memberlist = new ArrayList<MemberVO>();
	String sql2 = "SELECT ID FROM MEMBER";
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = pstmt2.executeQuery();
	while(rs2.next()){
		String id = rs2.getString("ID");		
		memberlist.add(new MemberVO(id));
	}
	
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<title>BOARD LIST</title>
<!-- <meta http-equiv="refresh" content="1"> 1초마다 새로고침-->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<style>
	table{
		border-collapse : collapse;
		color : white;
		width : 490px;
		margin : auto;
		background-color : hsla(628, 100%, 38%, 0.3);
	}
	
	
	th,td{
		padding : 5px;
	}
	td{
		font-size: 10px;
	}
	th{
		background-color: black;
	}
	
	table,tr,td{
			border: 0px solid white;
		    text-overflow: ellipsis;
		    white-space: nowrap;
		    max-width: 358px;
		    width: 400px;
		    overflow: hidden;
		    margin-top: 1em;
		    table-layout: fixed;
	}
	
	*{
		font-family: 'Lobster';
	} 
	

	
	body{
   	 background-image: url('./images/background.jpg');
   }
   
   .frame{
      width: 402px;
      height: 726px;
      margin :auto;
      border: 0px solid black;
      text-align: center;
      background-image: url('./images/background.jpg');
   }
	h1{
		color : white;
	}

	
	.hit{
		width : 50px;
	}
	
	#pagination{
		
	}
	
	#pagination a{
		text-decoration: none;
		color : white;
	}
	
	#pagination span{
		color : yellow;
	}
	
	.changeB{
		font-size: 20px;
		cursor: pointer;
		transition : all 2s;
	}
	.changeB:hover{
		color : yellow;
	}
	
	
		.seemore{
			width: 348px;
		    background-color: hsla(257, 100%, 54%, 0.5);
		    margin: auto;
		    height: 120px;
		}
        .titleA{
            width: 150px;
            background-color : transparent;
            border : 0px;
            font-weight: bold;
            font-size: 10px;
   			color: black;
        }
        .writerA{
            width: 125px;
			background-color : transparent;
            border : 0px;
        	font-weight: bold;
        	font-size: 10px;
   			color: black;
        }
        .dateA{
            width: 150px;
			background-color : transparent;
            border : 0px;
        	font-weight: bold;
        	font-size: 10px;
   			color: black;
        }
        
        .bnoA{
            width: 150px;
			background-color : transparent;
            border : 0px;
        	font-weight: bold;
        	font-size: 10px;
   			color: black;        
        }
        
        .tableA{
        	border: solid 0px;
        }
        .contentA{
			background-color: hsla(257, 100%, 54%, 0.5);
		    font-weight: bold;
		    width: 342px;
		    height: 68px;
		    font-size: 10px;
		    color: black;
		    position: relative;
		    top: 14px;
        }
        .tableA>td{
        	border : solid 0px;
        }
        .update_btn{
	        background-color: hsla(875, 100%, 75%, 0.5);
	        border-radius: 15px;
	        border: 1px solid aquamarine;
        }
       #delete_btn{
	        background-color: hsla(875, 100%, 75%, 0.5);
	        border-radius: 15px;
	        border: 1px solid aquamarine;
	        width : 58px;
	        margin-top : 1em;
        }
        
        
        .btn_menu{
        	width: 55px;
		    font-size: 8px;
		    background-color: black;
		    color: white;
		    border-radius: 10px;
		    text-align: center;
		    cursor: pointer;
        }
        .btn_menu:hover{
        	background-color: purple;
        	color : yellow;
        }
        
        .getter_id{
        	background-color: transparent;
        	color : white;
        	font-weight: bold;
        	border: 0px;
        }
	
	
	input[type="text"]:disabled{
		background-color : red;
	}
	
	textarea:disabled{
		background-color : red;
	}
	
</style>

<script type="text/javascript">
	
	function gowrite(){
		location.href = "write.jsp";
	};
	function goback(){
		location.href = "firstpage.jsp";
	};
	var cnt = 1;
	var cnt2 = 1;
	function gomessage(){
		cnt++;
		if(cnt%2==1){
		$(".message_frame").css("display","none");
		}else{
		$(".message_frame").css("display","block");
		}
	};
	
	function gomessage2(){
		var getter_id = $(".writerA").val();
		$(".getter_id").val(getter_id);
		cnt2++;
		if(cnt2%2==1){
		$(".message_frame2").css("display","none");
		}else{
		$(".message_frame2").css("display","block");
		}
	};
	
	function cancle(){
		$(".message_frame").css("display","none");
	};
	
	function send(){
		var send_text = $(".send_text").val();
		var member_id = $("#member_id option:selected").val();
		
		if(send_text==""||member_id==="Members"){
			alert("There is no content or Member.")
		}else{
			location.href = "message_action.jsp?text="+send_text+"&id="+member_id;
		}
		
		
	};
	
	function cancle2(){
		$(".message_frame2").css("display","none");
	};
	
	function send2(){
		var send_text = $(".send_text2").val();
		/* var member_id = $("#member_id option:selected").val(); */
		var member_id = $(".writerA").val();
		
		if(send_text==""||member_id==""){
			alert("There is no content or Member!!")

		}else{
			 location.href = "message_action.jsp?text="+send_text+"&id="+member_id; 
		}
		
		
	};
	
	
	var bgname = ['galaxy.png','galaxyC.jpg','galaxyD.jpg','galaxyE.jpg','bg2.jpg','background.jpg',
		'galaxyF.jpg','galaxyI.gif','galaxyJ.gif','galaxyK.jpg','galaxyL.gif'];

	function bgChange(){
	var url = bgname[Math.floor(Math.random()*bgname.length)];
	$('.frame').css({"transition":"background 1s ease-in","background-image":"url('./images/"+url+"')"});
	}
	
		
	$(function(){
		$(".update_btn").click(function(){
			bno = $('.bnoA').val();
			writer = $('.writerA').val();
			
			/* writer가 세션의 아이디와 맞다면 pass 아니면 back */
			 login_id = $('.login_id').val();
			
			 if(writer===login_id){
				location.href = "update.jsp?bno="+bno 
			}else{
				alert("You do not have permission");
			}
			 
		});
		
		$(".information").click(function(){
			_this = $(this);
			bno = $(this).find(".board_bno").text();
			title = $(this).find(".board_title").text();
			writer = $(this).find(".board_writer").text();
			date = $(this).find(".board_write_date").text();
			content = $(this).find(".board_content").text();
			
			
			$(".bnoA").val(bno);
			$(".titleA").val(title);
			$(".writerA").val(writer);
			$(".dateA").val(date);
			$(".contentA").val(content); 
			
			// hitcount 올리기 start
			$.ajax({
				type : "post",
				url : "../HitServlet",
				data : {"bno" : bno},
				datatype : "json",
				success : function(data){
				hit_up = Number(_this.find(".board_hit").text());
				/* alert( Number(_this.find(".board_hit").text())+1 ); */
				$(_this.find(".board_hit")).text(data.hitup);  
				},
				error : function(request,status,error){
					alert("Failed..");
				}
			});
			// hitcount 올리기 end

		});
		
		
		$("#delete_btn").click(function(){
			bno = $('.bnoA').val();
			writer = $('.writerA').val();
			
			 login_id = $('.login_id').val();
				
			if(writer===login_id){
				
				$.ajax({
					type : "post",
					url : "../DeleteServlet",
					data : {"bno":bno},
					datatype : "json",
					success : function(data){
						alert("delete complete")
						location.reload();
					},
					error : function(request,status,error){
						alert("delete failed")
					}
				});
				
				
				
			}else{
				alert("You do not have permission");
			}
			
		});
		
		
		
	});

</script>



<body>
<div class="frame">
	
<h1 style = "font-family:Lobster "> <span onclick="bgChange();" class = "changeB">◀ </span>GOZOO BOARD<span onclick="bgChange()" class = "changeB"> ▶</span></h1>
	
			<button class = "btn_menu" onclick="gomessage()" >MESSAGE</button>
			<button class = "btn_menu">LOGOUT</button>
			<button name="write" class = "btn_menu" onclick="gowrite()">WRITE</button>
			<button name="back" class = "btn_menu" onclick="goback()">BACK</button>
		
	
	
	<input type = "hidden" class="login_id" disabled="disabled" value = "<%=login_id%>">
	
	<table>
		<tr>
			<td style = "background-color : black; color : white; font-weight: bold; width: 18px;">No.</td>
			<td style = "background-color : black; color : white; font-weight: bold; width: 22px;">PC.</td>
			<td style = "background-color : black; color : white; font-weight: bold; width: 30px;">WRITER</td>
			<td style = "background-color : black; color : white; font-weight: bold; width: 30px;">TITLE</td>
			<td style = "background-color : black; color : white; font-weight: bold; width: 30px;">CONTENT</td>
			<td style = "background-color : black; color : white; font-weight: bold; width : 24px;">DATE</td> 
			<td class = "hit" style = "background-color : black; color : white; font-weight: bold;width: 22px;">HIT</td>
		</tr>
		
		<%
			for(BoardVO vo : list){
		%>
			
			<tr class = "information" style = "cursor:pointer">
				<td class = "board_bno"><%= vo.getBno() %></td>
				<td class = "board_img"> <img style = "width :20px; height : 20px;border-radius : 15px;"src="<%= vo.getImg() %>"> </td>
				<td class = "board_writer"><%= vo.getWriter()%></td>
				<td class = "board_title"><%= vo.getTitle() %></td>
				<td class = "board_content"><%= vo.getContent() %></td>
				 <td class = "board_write_date"><%= vo.getWrite_date() %></td> 
				<td class = "board_hit"> <%= vo.getHitcount()%> </td>
			</tr>
		
		<%
			}
		%>
	</table>
	
	<%!
		int getLastPageNum(Connection conn) throws Exception{
			String sql = "SELECT COUNT(*) FROM BOARD";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				int cnt = rs.getInt(1);
				int lastPageNum = 0;
				if(cnt == cnt/10*10){
					lastPageNum = cnt/10;
				}else{
					lastPageNum = cnt/10+1;
				}
				return lastPageNum;
			}
			return -1;
		}
	%>
	
	<div id="pagination">
         <%
            if (pageNum == 1) {
            } else {
            %>
            <a href="board.jsp?page=<%=pageNum - 1%>">◀</a>
            <%
            }
         %>
         <%
            int start, end;
            if (pageNum % 10 > 0) {
               start = (pageNum - pageNum % 10) + 1;
               end = (pageNum - pageNum % 10) + 10;
            }else {
               start = pageNum - 9;
               end = pageNum;
            }
   
            int lastPageNum = getLastPageNum(conn);
            if (end > lastPageNum) {
               end = lastPageNum;
            }
            if (start >= 2) {
               %>
                  <a href="board.jsp?page=<%=start - 1%>">이전페이지</a>d
               <%
            }
            for (int i = start; i <= end; i++) {
               if (pageNum != i) {
               %>
                  <a href="board.jsp?page=<%=i%>"><%=i%></a>
               <%
                  } else {
               %>
                  <span><%=i%></span>
               <%
               }
            }
            %>
         <%
            if (pageNum == end) {
   
            } else {
            %>
            <a href="board.jsp?page=<%=pageNum + 1%>">▶</a>
            <%
            }
         %>

      </div>
	<span style = "color : white"> <%=pageNum %> page </span>

	
	<div class = "seemore">
        <div style = "margin-top: 2px;padding-top: 8px;">

            <table style="float: left;border: solid 0px white; margin-top : 0em; background-color: transparent; margin-left : 0em;" class = "tableA">
                <tr style = "border : 0px">
                    <td style = "border : 0px; width : 10px;">NO.</td>
                    <td style = "border : 0px; width : 28px;"><input disabled="disabled" type = "text" class="bnoA" name = "bnoA" value = "" style = "color : white;"></td>
                </tr>
                <tr style = "border : 0px">
                    <td style = "border : 0px;">TITLE</td>
                    <td style = "border : 0px;max-width: 117px;"><input disabled="disabled" type = "text" class="titleA" name = "titleA" value = "" style = "color : white;"></td>
                </tr>
                <tr>
                    <td style = "border : 0px">WRITER</td>
                    <td style = "border : 0px"><input disabled="disabled" type = "text" class = "writerA" name = "writerA" value = "" style = "color : white;width:150px;"></td>
                </tr>
                <tr>
                    <td style = "border : 0px">DATE</td>
                    <td style = "border : 0px"><input disabled="disabled" type = "text" class = "dateA" name = "dateA" value = "" style = "color : white;"></td>
                </tr>
            </table>
        </div>        
                <textarea disabled="disabled" rows="6" class="contentA" name = "contentA" style = "color : white;"></textarea>
                    <button class= "update_btn" onclick="goupdate()">update</button> 
                    <button id= "delete_btn">delete</button> 
                    <button id= "delete_btn" onclick="gomessage2()">send</button>
               
	</div>
	
	<style>
		.message_frame{
		    display: none;
		    width: 200px;
		    height: 271px;
		    margin: auto;
		    position: absolute;
		    background-color: hsla(1046, 121%, 52%, 0.4);
		    margin-top: -20em;
		    margin-left: 6.2em;
		    border-radius: 44px;
		    line-height: 41px;
		}
		.message_frame2{
		    display: none;
			width: 200px;
		    height: 271px;
		    margin: auto;
		    position: absolute;
		    background-color: hsla(1046, 121%, 52%, 0.8);
		    margin-top: -20em;
		    margin-left: 6.2em;
		    border-radius: 44px;
		    line-height: 41px;
		}
		#member_id{
			width : 148px;
		}
		#spanA{
			color : white;
			font-weight: bold;
		}
		#send_btn{
			margin-top : 1em;
			border-radius: 15px;
			cursor : pointer;
			background-color: black;
			color : white;
			height : 30px;
			text-align: center;
		}
		#send_btn:hover{
			background-color : purple;
			color : yellow;
		}
	</style>
 
<div class = "message_frame">
	 <span id = "spanA">Member select</span> <br>
			<select id = "member_id">
				<option selected="selected" disabled="disabled">Members</option>
		 <%
			for(MemberVO vo2 : memberlist){
		 %>
				<option value="<%= vo2.getId()%>"><%= vo2.getId()%></option>
	   	 <%
				}
		 %>
			</select>
			<textarea rows="6" cols="" placeholder="Text Message.." class="send_text"></textarea>
			<br>
			<button id = "send_btn" onclick="send()">send</button>
			<button id = "send_btn" onclick="cancle()" >back</button>
		
		
</div>


<div class = "message_frame2">
	 <span id = "spanA">Member select</span> <br>
	 		<input type = "text" class = "getter_id" value = "" disabled="disabled">
				
			<textarea rows="6" cols="" placeholder="Text Message.." class="send_text2"></textarea>
			<br>
			<button id = "send_btn" onclick="send2()">send</button>
			<button id = "send_btn" onclick="cancle2()" >back</button>
		
		
</div>


</div>
</body>
</html>