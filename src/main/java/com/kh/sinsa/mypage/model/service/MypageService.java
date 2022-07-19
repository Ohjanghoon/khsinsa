package com.kh.sinsa.mypage.model.service;

import static com.kh.sinsa.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.inquire.model.dto.Inquire;
import com.kh.sinsa.mypage.model.dao.MypageDao;

public class MypageService {
	
	private MypageDao mypageDao = new MypageDao();
	
	//##########janghoon MypageService begin#############
	public List<Inquire> inquireListFindById(String userId, Map<String, Object> param) {
		Connection conn = null;
		List<Inquire> list = null;
		try {
			conn = getConnection();
			list = mypageDao.inquireListFindById(conn, userId, param);
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return list;
	}

	public int getTotalMyInquireContent(String userId) {
		Connection conn = null;
		int totalMyInquireContent = 0;
		try {
			conn = getConnection();
			totalMyInquireContent = mypageDao.getTotalMyInquireContent(conn, userId);
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return totalMyInquireContent;
	}

	public int myInquireDelete(String[] inquireList) {
		Connection conn = null;
		int result = 0;
		try {
			conn = getConnection();
			result = mypageDao.myInquireDelete(conn, inquireList);
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<Community> communityListFindById(String userId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> list = mypageDao.communityListFindById(conn, userId, param);
		close(conn);
		return list;
	}

	//##########janghoon MypageService end#############
}
