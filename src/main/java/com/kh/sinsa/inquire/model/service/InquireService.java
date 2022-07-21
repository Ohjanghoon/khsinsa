package com.kh.sinsa.inquire.model.service;





import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.commit;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;
import static com.kh.sinsa.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.inquire.model.dao.InquireDao;
import com.kh.sinsa.inquire.model.dto.Inquire;

public class InquireService {
	private InquireDao inquireDao = new InquireDao();

	public List<Inquire> findAll(Map<String, Object> param) {
		Connection conn = null;
		List<Inquire> list = null;
		try {
		conn = getConnection();
	list = inquireDao.findAll(conn, param);
		}catch (Exception e) {
			throw e;
		}finally {
			close(conn);
		}
		return list;
	}

	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = inquireDao.getTotalContent(conn); 
		close(conn);
		return totalContent;
	}

	public List<Inquire> findInquireLike(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Inquire> list = inquireDao.findInquireLike(conn, param);
		close(conn);
		return list;
	}

	public int getTotalContentLike(Map<String, Object> param) {
		Connection conn = getConnection();
		int totalContent = inquireDao.getTotalContentLike(conn, param); 
		close(conn);
		return totalContent;
	}

	

	public Inquire findByNo(String inquireNo) {
		Connection conn = getConnection();
		Inquire inquire = null;
		
		try {		
			inquire = inquireDao.findByNo(conn, inquireNo);
			commit(conn);
		} 
		catch(Exception e) {
			rollback(conn);
			throw e;
		} 
		finally {
			close(conn);			
		}
		
		return inquire;
	}

	public int deleteInquire(String inquireNo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = inquireDao.deleteInquire(conn,inquireNo);
		}catch(Exception e){
			rollback(conn);
			throw e;
		}
		close(conn);
		return result;
	}




}
