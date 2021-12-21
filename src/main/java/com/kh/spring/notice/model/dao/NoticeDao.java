package com.kh.spring.notice.model.dao;

import java.util.List;

import com.kh.spring.notice.model.vo.Notice;
import com.kh.spring.sharing.model.vo.Attachment;

public interface NoticeDao {

	List<Notice> selectNoticeList(int offset, int limit);

	int countTotalContent();

	int insertNotice(Notice notice);

	int insertAttachment(Attachment attach);

}