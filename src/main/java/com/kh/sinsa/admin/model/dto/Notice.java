package com.kh.sinsa.admin.model.dto;

import java.sql.Date;

public class Notice {
	private String noticeNo;
	private String noticeTitle;
	private String notice_content;
	private String notice_writer;
	private Date notice_date;
	private int notice_read_count;
	
	public Notice() {
		super();
	}

	public Notice(String noticeNo, String noticeTitle, String notice_content, String notice_writer, Date notice_date, int notice_read_count) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.notice_content = notice_content;
		this.notice_writer = notice_writer;
		this.notice_date = notice_date;
		this.notice_read_count = notice_read_count;
	}

	public String noticeNo() {
		return noticeNo;
	}

	public void setnoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getnoticeTitle() {
		return noticeTitle;
	}

	public void setnoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getnotice_content() {
		return notice_content;
	}

	public void setnotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public String getnotice_writer() {
		return notice_writer;
	}

	public void setnotice_writer(String notice_writer) {
		this.notice_writer = notice_writer;
	}

	public Date getnotice_date() {
		return notice_date;
	}

	public void setnotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}

	public int getnotice_read_count() {
		return notice_read_count;
	}

	public void setnotice_read_count(int notice_read_count) {
		this.notice_read_count = notice_read_count;
	}

	@Override
	public String toString() {
		return "Community [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", notice_content=" + notice_content + ", notice_writer="
				+ notice_writer + ", notice_date=" + notice_date + ", notice_read_count=" + notice_read_count + "]";
	}
	
}


