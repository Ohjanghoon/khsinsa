package com.kh.sinsa.community.model.service;



import static com.kh.sinsa.common.JdbcTemplate.*;


import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.community.model.dao.CommunityDao;
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.community.model.dto.CommunityComment;

public class CommunityService {
	private CommunityDao communityDao = new CommunityDao();
	
	// 게시글 목록 조회
	public List<Community> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> result = communityDao.findAll(conn, param);
		close(conn);
		return result;
	}
	
	// 게시글 목록 조회(페이지바 총 갯수)
	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = communityDao.getTotalContent(conn); 
		close(conn);
		return totalContent;
		
	}

	// 게시글 상세조회
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
	
	// 게시글 상세조회 댓글
	public List<CommunityComment> findCommunityCommentByCommNo(String no) {
		Connection conn = getConnection();
		List<CommunityComment> commentList = communityDao.findCommunityCommentByCommNo(conn, no);
		close(conn);
		return commentList;
	}
	
	// 게시글 상세조회 댓글 작성
	public int insertCommunityComment(CommunityComment communityComment) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.insertCommunityComment(conn, communityComment);
			commit(conn);
		} 
		catch (Exception e) {
			rollback(conn);
			throw e;
		}
		finally {
			close(conn);			
		}
		return result;	
	}
	
	// 게시글 상세보기 댓글 삭제
	public int deletecommunityComment(String no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.deleteCommunityComment(conn, no);
			commit(conn);
		} 
		catch (Exception e) {
			rollback(conn);
			throw e;
		}
		finally {
			close(conn);			
		}
		return result;
	}
	
	// 게시글 작성
	public int insertCommunity(Community community) {
		Connection conn = getConnection();
		int result = 0; 
		
		try {
		result = communityDao.insertCommunity(conn, community);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	                                         
}
