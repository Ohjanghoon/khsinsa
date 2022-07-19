package com.kh.sinsa.inquire.model.service;





import static com.kh.sinsa.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;


import com.kh.sinsa.inquire.model.dao.InquireDao;
import com.kh.sinsa.inquire.model.dto.Inquire;

public class InquireService {
	private InquireDao inquireDao = new InquireDao();

	public List<Inquire> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Inquire> list = inquireDao.findAll(conn, param);
		close(conn);
		return list;
	}

	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = inquireDao.getTotalContent(conn); 
		close(conn);
		return totalContent;
	}

	




}
