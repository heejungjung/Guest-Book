package guestbook.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import guestbook.dao.MessageDao2;
import guestbook.model.Message;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;

public class GetMessageListService2 {
	private static GetMessageListService2 instance = new GetMessageListService2();

	public static GetMessageListService2 getInstance() {
		return instance;
	}

	private GetMessageListService2() {
	}

	private static final int MESSAGE_COUNT_PER_PAGE = 3;

	public MessageListView2 getMessageList(int pageNumber, String searchName) {
		Connection conn = null;
		int currentPageNumber = pageNumber;
		System.out.print("0");
		try {
			conn = ConnectionProvider.getConnection();
			MessageDao2 messageDao = MessageDao2.getInstance();

			int messageTotalCount = messageDao.selectCount(conn,searchName);
			List<Message> messageList = null;
			int firstRow = 0;
			int endRow = 0;
			if (messageTotalCount > 0) {
				firstRow =
						(pageNumber - 1) * MESSAGE_COUNT_PER_PAGE + 1;
				endRow = firstRow + MESSAGE_COUNT_PER_PAGE - 1;
				messageList =
						messageDao.selectList(conn, firstRow, endRow, searchName);
			} else {
				currentPageNumber = 0;
				messageList = Collections.emptyList();
			}
			return new MessageListView2(messageList,
					messageTotalCount, currentPageNumber,
					MESSAGE_COUNT_PER_PAGE, firstRow, endRow);
		} catch (SQLException e) {
			throw new ServiceException("목록 구하기 실패: " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}