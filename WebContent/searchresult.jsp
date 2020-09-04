<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="guestbook.model.Message"%>
<%@ page import="guestbook.service.MessageListView2"%>
<%@ page import="guestbook.service.GetMessageListService2"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String searchName = request.getParameter("searchName");
	String pageNumberStr = request.getParameter("page");
	System.out.print("searchName:"+searchName);
	System.out.print("page:"+page);
	int pageNumber = 1;
	if (pageNumberStr != null) {
		pageNumber = Integer.parseInt(pageNumberStr);
	}

	GetMessageListService2 messageListService = 
			GetMessageListService2.getInstance();
	MessageListView2 viewData = 
			messageListService.getMessageList(pageNumber,searchName);
%>
<c:set var="viewData" value="<%= viewData %>"/>
<html>
<head>
	<title>검색하기</title>
</head>
<body>

<c:if test="${viewData.isEmpty()}">
등록된 메시지가 없습니다.
</c:if>

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
<a href="searchresult.jsp?searchName=<%=searchName%>&page=${pageNum}">[${pageNum}]</a> 
</c:forEach>

</c:if>
</body>
</html>