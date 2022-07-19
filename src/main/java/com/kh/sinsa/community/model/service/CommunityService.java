package com.kh.sinsa.community.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.commit;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;
import static com.kh.sinsa.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.community.model.dao.CommunityDao;
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.community.model.dto.CommunityComment;

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

	
public Community findByNo(String no) {
		
		
		return findByNo(no, true);
	}

	public Community findByNo(String no, boolean hasRead) {
		Connection conn = getConnection();
		Community community = null;
		
		try {
			if(!hasRead) {
				int result = communityDao.updateReadCount(conn, no);
			}
			
			// community 테이블에서 조회
			community = communityDao.findByNo(conn, no);
			
			
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		
		}finally {
			close(conn);
		}
		return community;
	}

	public List<CommunityComment> findCommunityCommentByCommNo(String no) {
		Connection conn = getConnection();
		List<CommunityComment> commentList = communityDao.findCommunityCommentByCommNo(conn, no);
		close(conn);
		return commentList;
	}

	                                         
}
