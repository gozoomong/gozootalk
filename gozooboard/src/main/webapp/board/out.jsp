<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.File" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, 
  maximum-scale=1.0, minimum-scale=1.0" >
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>

<style>
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
	#imgcheck{
		width : 100px;
		margin-top : 10em;
	}
	
	.subframe{
		width: 150px;
    	height: 183px;
    	margin : auto;
    	border-radius: 20px;
    	margin-top : 1em;
	}
	
	#imgcheck{
		border-radius : 20px;
		width : 100%;
		height : 100%;
	}
	
	#save{
		margin-top : 13em;
		border-radius: 15px;
	}
	
</style>

<body>
	<%
		String filename="";
		int sizeLimit = 15*1024*1024;
		
		String realPath = request.getServletContext().getRealPath("upload");
		 
        File dir = new File(realPath);
		if(!dir.exists()) dir.mkdirs();
		
		MultipartRequest multipartRequest = null;
		multipartRequest = new MultipartRequest(request, realPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		filename = multipartRequest.getFilesystemName("photo");
	
		String profile_image = request.getParameter("photo");
		String login_id = (String)(session.getAttribute("login_id"));
		
	%>
	<script type="text/javascript">
		$(function(){
			var imgurl = $("#imgurl").val();
			$("#save").click(function(){
<%-- 				var login_id = <%=profile_image%>; --%>
				location.href = "out_action.jsp?image="+imgurl+"&login_id="+"<%=login_id%>";
			});
		});
		
	</script>
	<%-- 폼에서 전송된 원래 파일명 : <%=multipartRequest.getOriginalFileName("photo") %> <br />
	파일명 : <%=filename %> <br />
	업로드한 파일의 경로 : ${pageContext.request.contextPath}/upload/<%=filename %><br /> --%>
	<%-- 물리적인 저장경로 : <%=realPath %> <br /> --%>
<div class = "frame">
	<div class = "subframe">
		<img id = "imgcheck" src="${pageContext.request.contextPath}/upload/<%=filename%>" /> 
	</div>	
	<div style = width : 200px;	>
		<input type = "hidden" id = imgurl value = "${pageContext.request.contextPath}/upload/<%=filename%>"> 
		<button id = "save">save this image</button>	
	</div>
</div>
	
	
</body>
</html>