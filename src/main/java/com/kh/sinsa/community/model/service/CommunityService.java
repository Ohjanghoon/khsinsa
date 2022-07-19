package com.kh.sinsa.community.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.community.model.dao.CommunityDao;
import com.kh.sinsa.community.model.dto.Community;

public class CommunityService {
	private CommunityDao communityDao = new CommunityDao();

	public List<Community> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> result = communityDao.findAll(conn, param);
		close(conn);
		return result;
	}
	
	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = communityDao.getTotalContent(conn); 
		close(conn);
		return totalContent;
		
	}
	                                         
}
