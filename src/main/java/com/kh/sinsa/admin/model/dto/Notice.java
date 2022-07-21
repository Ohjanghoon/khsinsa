package com.kh.sinsa.admin.model.dto;

import java.sql.Date;

public class Notice {
		private String notice_no;
		private String notice_title;
		private String notice_content;
		private String notice_writer;
		private Date notice_date;
		private int notice_read_count;
		
		public Notice() {
			super();
			
		}

		public Notice(String notice_no2, String notice_title, String notice_content, String notice_writer, Date notice_date,
				int notice_read_count) {
			super();
			this.notice_no = notice_no2;
			this.notice_title = notice_title;
			this.notice_content = notice_content;
			this.notice_writer = notice_writer;
			this.notice_date = notice_date;
			this.notice_read_count = notice_read_count;
		}

		public String getNotice_no() {
			return notice_no;
		}

		public void setNotice_no(String notice_no) {
			this.notice_no = notice_no;
		}

		public String getNotice_title() {
			return notice_title;
		}

		public void setNotice_title(String notice_title) {
			this.notice_title = notice_title;
		}

		public String getNotice_content() {
			return notice_content;
		}

		public void setNotice_content(String notice_content) {
			this.notice_content = notice_content;
		}

		public String getNotice_writer() {
			return notice_writer;
		}

		public void setNotice_writer(String notice_writer) {
			this.notice_writer = notice_writer;
		}

		public Date getNotice_date() {
			return notice_date;
		}

		public void setNotice_date(Date notice_date) {
			this.notice_date = notice_date;
		}

		public int getNotice_read_count() {
			return notice_read_count;
		}

		public void setNotice_read_count(int notice_read_count) {
			this.notice_read_count = notice_read_count;
		}

		@Override
		public String toString() {
			return "Notice [notice_no=" + notice_no + ", notice_title=" + notice_title + ", notice_content="
					+ notice_content + ", notice_writer=" + notice_writer + ", notice_date=" + notice_date
					+ ", notice_read_count=" + notice_read_count + "]";
		}
		
		
		
		}
