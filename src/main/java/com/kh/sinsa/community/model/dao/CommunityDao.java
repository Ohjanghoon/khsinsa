package com.kh.sinsa.community.model.dao;


import static com.kh.sinsa.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.kh.sinsa.community.model.dto.CommentLevel;
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.community.model.dto.CommunityAttachment;
import com.kh.sinsa.community.model.dto.CommunityComment;
import com.kh.sinsa.community.model.exception.CommunityException;

public class CommunityDao {

	private Properties prop = new Properties();

	public CommunityDao() {
		String filename = CommunityDao.class.getResource("/sql/community/community-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 게시글 목록 조회
	public List<Community> findAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Community> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		//findAll = select * from (select row_number () over (order by comm_date desc)rnum, c.* from community c) c
		// 			where rnum between ? and ? and substr(comm_no,1,3) in 'C30'
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Community communtiy = handlerCommunityResultSet(rset);
				list.add(communtiy);

			}
		} catch (SQLException e) {
			throw new CommunityException("게시글 목록 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

	// 게시글 목록 조회
	private Community handlerCommunityResultSet(ResultSet rset) throws SQLException {
		String commNo = rset.getString("comm_no");
		String userId = rset.getString("user_id");
		String commTitle = rset.getString("comm_title");
		String commContent = rset.getString("comm_content");
		Date commDate = rset.getDate("comm_date");
		int commRecommend = rset.getInt("comm_recommend");
		int commReadCount = rset.getInt("comm_readCount");

		return new Community(commNo, userId, commTitle, commContent, commDate, commRecommend, commReadCount);
	}

	// 게시글 목록 조회 페이지바
	public int getTotalContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getTotalContent");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if (rset.next())
				totalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new CommunityException("총 게시물수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}

		return totalContent;
	}

	public int updateReadCount(Connection conn, String no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateReadCount");
		// updateReadCount = update community set comm_read_count = comm_read_count + 1 where comm_no = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new CommunityException("조회수 증가 오류!", e);
		} finally {
			close(pstmt);
		}

		return result;
	}

	public Community findByNo(Connection conn, String no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Community community = null;
		String sql = prop.getProperty("findByNo");
//		findByNo = select * from community where comm_no = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			rset = pstmt.executeQuery();
			while (rset.next())
				community = handlerCommunityResultSet(rset);

		} catch (SQLException e) {
			throw new CommunityException("게시글 1건 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return community;
	}

	public List<CommunityComment> findCommunityCommentByCommNo(Connection conn, String CommNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<CommunityComment> commentList = new ArrayList<>();
		String sql = prop.getProperty("findCommunityCommentByCommNo");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, CommNo);
			rset = pstmt.executeQuery();
			while (rset.next())
				commentList.add(handleCommunityCommentResultSet(rset));

		} catch (SQLException e) {
			throw new CommunityException("게시글별 댓글 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return commentList;
	}

	private CommunityComment handleCommunityCommentResultSet(ResultSet rset) throws SQLException {
		String no = rset.getString("comm_comment_no");
		String commNo = rset.getString("comm_no");
		String writer = rset.getString("user_id");
		String content = rset.getString("comm_comment_content");
		Date regDate = rset.getDate("comm_comment_date");
		CommentLevel commentLevel = CommentLevel.valueOf(rset.getInt("comm_comment_level"));
		String commentRef = rset.getString("comm_comment_ref"); 
		return new CommunityComment(no, commNo, writer, content, regDate, commentLevel, commentRef);
	}


	public int deleteCommunityComment(Connection conn, String no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteCommunityComment");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new CommunityException("댓글/답글 삭제 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int insertCommunity(Connection conn, Community community) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertCommunity");
		//insertCommunity = insert into community (comm_no, user_id, comm_title, comm_content) values ('C30' || seq_community_comm_no.nextval, ?, ?, ?)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, community.getUserId());
			pstmt.setString(2, community.getCommTitle());
			pstmt.setString(3, community.getCommContent());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			throw new CommunityException("게시글 등록 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteCommunity(Connection conn, String no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteCommunity");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			throw new CommunityException("게시글 등록 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int editCommunity(Connection conn, Community community) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("editCommunity");
		// updateCommunity = update community set comm_title = ?, comm_content = ? where comm_no = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, community.getCommTitle());
			pstmt.setString(2, community.getCommContent());
			pstmt.setString(3, community.getCommNo());
			result = pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			throw new CommunityException("게시글 수정 오류!", e);
		}
		finally {
			close(pstmt);
		}
		return result;
	}

	public int insertCommunityComment(Connection conn, CommunityComment communityComment) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertCommunityComment");
		// insertCommunityComment = insert into comm_comment values ('C31' || seq_comm_comment_comm_comment_no.nextval, ?, ?, ?, default, ?, ?)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, communityComment.getCommNo());
			pstmt.setString(2, communityComment.getUserId());
			pstmt.setString(3, communityComment.getCommentContent());
			pstmt.setInt(4, communityComment.getCommentLevel().getValue());
			pstmt.setObject(5, Integer.parseInt(communityComment.getCommentRef()) == 0 ? null : communityComment.getCommentRef());
			
			result = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			throw new CommunityException("댓글 등록 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public List<CommunityAttachment> findAttachmentByCommNo(Connection conn, String no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<CommunityAttachment> attach = new ArrayList<>();
		String sql = prop.getProperty("findAttachmentByCommNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			rset = pstmt.executeQuery();
			while(rset.next())
				attach.add(handlerAttachmentResultSet(rset));
		} 
		catch (SQLException e) {
			throw new CommunityException("게시물 첨부파일 1건 조회 오류", e);	
		} 
		finally {
			close(rset);
			close(pstmt);
		}
		
		return attach;
	}

	private CommunityAttachment handlerAttachmentResultSet(ResultSet rset) throws SQLException {

		String no = rset.getString("comm_attachment_no");
		String commNo = rset.getString("comm_no");
		String originalFilename =rset.getString("comm_original_filename");
		String renamedFilename = rset.getString("comm_rename_filename");
		return new CommunityAttachment(no, commNo, originalFilename, renamedFilename);
	}

	public String getLastCommNo(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String commNo = null;
		String sql = prop.getProperty("getLastCommNo");
		// getLastCommNo = select 'C30' || seq_community_comm_no.currval from dual
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				commNo = rset.getString(1);
		} catch (SQLException e) {
			throw new CommunityException("생성된 게시글 번호 조회 오류", e);
			
		} finally {
			close(rset);
			close(pstmt);
		}
		return commNo;
	}

	public int insertAttachment(Connection conn, CommunityAttachment attach) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertAttachment");
		//insertAttachment = insert into comm_attachment values('C32' || seq_comm_attachment_comm_attachment_no.nextval, ?, ?, ?)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, attach.getCommNo());
			pstmt.setString(2, attach.getOriginalFilename());
			pstmt.setString(3, attach.getRenamedFilename());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new CommunityException("첨부파일 등록 오류", e);
			
		} finally {
			close(pstmt);
		}
		return result;
	}
	


}
