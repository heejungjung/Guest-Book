<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="guestbook.service.UpdateMessageService" %>
<%@ page import="guestbook.service.InvalidPassowrdException" %>
<%
	int messageId = Integer.parseInt(request.getParameter("messageId"));
	String password = request.getParameter("password");
	String message = request.getParameter("message");
	message = new String(message.getBytes("ISO-8859-1"), "UTF-8");
	boolean invalidPassowrd = false;
	try {
		UpdateMessageService updateService = 
				UpdateMessageService.getInstance();
		updateService.updateMessage(messageId, password ,message);
	} catch(InvalidPassowrdException ex) {
		invalidPassowrd = true;
	}
%>
<html>
<head>
	<title>방명록 메시지 수정함</title>
</head>
<body>
<%  if (!invalidPassowrd) { %>
메시지를 수정하였습니다.
<%  } else { %>
입력한 암호가 올바르지 않습니다. 암호를 확인해주세요.
<%  }%>
<br/>
<a href="list.jsp">[목록 보기]</a>
</body>
</html>