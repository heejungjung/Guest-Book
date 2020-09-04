<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="guestbook.model.Message"%>
<%@ page import="guestbook.service.MessageListView"%>
<%@ page import="guestbook.service.GetMessageListService"%>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String pageNumberStr = request.getParameter("page");
	int pageNumber = 1;
	if (pageNumberStr != null) {
		pageNumber = Integer.parseInt(pageNumberStr);
	}

	GetMessageListService messageListService = 
			GetMessageListService.getInstance();
	MessageListView viewData = 
			messageListService.getMessageList(pageNumber);
%>
<c:set var="viewData" value="<%= viewData %>"/>
<html>
<head>
	<title>방명록 메시지 목록</title>
	<style>
		body {
		max-width: max-content;
		margin: auto;
		}
		h1 {
		max-width: max-content;
		margin: auto;
		}
	</style>
</head>
<body> <br>
<h1>방명록</h1> <br>
<form action="searchresult.jsp?param=<%=URLEncoder.encode("한글문자열", "EUC-KR")%>">
	<fieldset>
		<legend>검색기능</legend>
		이름: <input type="text" name="searchName">
		<input type="submit" value="검색하기" />
	</fieldset>
</form>
<form action="writeMessage.jsp" method="post">
<fieldset>
<legend>메시지 남기기</legend>
이   름: <input type="text" name="guestName"> <br>
암   호: <input type="password" name="password"> <br>
내   용: <textarea name="message" cols="30" rows="5"></textarea>
<input type="submit" value="메시지 남기기" />
</fieldset>
</form>
<hr>
<c:if test="${viewData.isEmpty()}">
등록된 메시지가 없습니다.
</c:if> <br> <br>
<h1>메시지 목록</h1>
<c:if test="${!viewData.isEmpty()}">
<table border="1">
	<c:forEach var="message" items="${viewData.messageList}">
	<tr>
		<td>메시지 번호: ${message.id}</td>
		<td>손님 이름: ${message.guestName}</td>
		<td>메시지: ${message.message}</td>
		<td><a href="confirmDeletion.jsp?messageId=${message.id}">[삭제하기]</a></td>
		<td><a href="confirmUpdate.jsp?messageId=${message.id}">[수정하기]</a></td>
		
	</tr>
	</c:forEach>
</table>

<c:forEach var="pageNum" begin="1" end="${viewData.pageTotalCount}">
<a href="list.jsp?page=${pageNum}">[${pageNum}]</a> 
</c:forEach>

</c:if>

</body>
</html>