package com.kh.sinsa.notice.model.dto;

import java.sql.Date;

public class Notice {
		private int noticeNo;
		private String noticeTitle;
		private String noticeContent;
		private String noticeWriter;
		private Date noticeDate;
		private int noticeReadCount;
		
		public Notice() {
			super();
			
		}

		public Notice(int noticeNo, String noticeTitle, String noticeContent, String noticeWriter, Date noticeDate,
				int noticeReadCount) {
			super();
			this.noticeNo = noticeNo;
			this.noticeTitle = noticeTitle;
			this.noticeContent = noticeContent;
			this.noticeWriter = noticeWriter;
			this.noticeDate = noticeDate;
			this.noticeReadCount = noticeReadCount;
		}

		public int getNoticeNo() {
			return noticeNo;
		}

		public void setNoticeNo(int noticeNo) {
			this.noticeNo = noticeNo;
		}

		public String getNoticeTitle() {
			return noticeTitle;
		}

		public void setNoticeTitle(String noticeTitle) {
			this.noticeTitle = noticeTitle;
		}

		public String getNoticeContent() {
			return noticeContent;
		}

		public void setNoticeContent(String noticeContent) {
			this.noticeContent = noticeContent;
		}

		public String getNoticeWriter() {
			return noticeWriter;
		}

		public void setNoticeWriter(String noticeWriter) {
			this.noticeWriter = noticeWriter;
		}

		public Date getNoticeDate() {
			return noticeDate;
		}

		public void setNoticeDate(Date noticeDate) {
			this.noticeDate = noticeDate;
		}

		public int getNoticeReadCount() {
			return noticeReadCount;
		}

		public void setNoticeReadCount(int noticeReadCount) {
			this.noticeReadCount = noticeReadCount;
		}

		@Override
		public String toString() {
			return "Notice [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
					+ ", noticeWriter=" + noticeWriter + ", noticeDate=" + noticeDate + ", noticeReadCount_="
					+ noticeReadCount + "]";
		}
		
		
}
