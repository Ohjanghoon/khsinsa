package com.kh.sinsa.community.model.service;

import static com.kh.sinsa.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.community.model.dao.CommunityDao;
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.community.model.dto.CommunityAttachment;
import com.kh.sinsa.community.model.dto.CommunityComment;
import com.kh.sinsa.community.model.dto.CommunityExt;
import com.kh.sinsa.product.model.dto.Product;

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
	public CommunityExt findByNo(String no) {

		return findByNo(no, true);
	}

	public CommunityExt findByNo(String no, boolean hasRead) {
		Connection conn = getConnection();
		CommunityExt community = null;

		try {
			if (!hasRead) {
				int result = communityDao.updateReadCount(conn, no);
			}

			// community 테이블에서 조회
			community = communityDao.findByNo(conn, no);
			
			List<CommunityAttachment> attachments = communityDao.findAttachmentByCommNo(conn, no);

			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;

		} finally {
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
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
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
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	// 게시글 작성
	public int insertCommunity(CommunityExt community) {
		Connection conn = getConnection();
		int result = 0;

		try {
			result = communityDao.insertCommunity(conn, community);
			
			// 방금 등록된 boaard.no 컬럼값 조회
			String commNo = communityDao.getLastCommNo(conn);
					
			List<CommunityAttachment> attachments = ((CommunityExt) community).getAttachments();
			if(attachments != null && !attachments.isEmpty()) {
							
				for(CommunityAttachment attach : attachments) {
					attach.setCommNo(commNo);
					result = communityDao.insertAttachment(conn, attach);
				}
						}
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	// 개시글 삭제
	public int deleteCommunity(String no) {
		Connection conn = getConnection();
		int result = 0;

		try {
			result = communityDao.deleteCommunity(conn, no);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
//	게시글 수정
	public int editCommunity(CommunityExt community) {
		Connection conn = getConnection();
		int result = 0;

		try {
			// 게시글 수정
			result = communityDao.editCommunity(conn, community);
			// 첨부파일 등록
			List<CommunityAttachment> attachments = community.getAttachments();
			if(attachments != null || !attachments.isEmpty()) {
				for(CommunityAttachment attach : attachments) {
					result = communityDao.insertAttachment(conn, attach);
				}
			}
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	public CommunityAttachment findAttachmentByNo(String attachNo) {
		Connection conn = getConnection();
		CommunityAttachment attach = communityDao.findAttachmentByNo(conn, attachNo);
		close(conn);
		return attach;
	}

	public List<CommunityAttachment> findAttachmentByCommNo(String no) {
		Connection conn = getConnection();
		List<CommunityAttachment> attach = communityDao.findAttachmentByCommNo(conn, no);
		close(conn);
		return attach;
	}
	
	public int deleteAttachment(String attachNo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.deleteAttachment(conn, attachNo);
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
	
	 // 코디 전체 불러오기  // ilchan
	public List<Community> findCodiAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> codiList = communityDao.findCodaiAll(conn, param);
		close(conn);
		return codiList;
	}

	public List<CommunityAttachment> findCodiAttachmentFindAll() {
		Connection conn = getConnection();
		List<CommunityAttachment> codiAttachmentList = communityDao.findCodiAttachmentFindAll(conn);
		close(conn);
		return codiAttachmentList;
	}

	public int getCodiTotalContent() {
		Connection conn = getConnection();
		int codiTotalContent = communityDao.getCodiTotalContent(conn);
		close(conn);
		return codiTotalContent;
	}

	public int codiCommentAdd(CommunityComment communityComment) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.codiCommentAdd(conn, communityComment);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int recommendAdd(Community community) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.recommendAdd(conn, community);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public CommunityAttachment findCodiAttachmentByNo(String commAttachNo) {
		Connection conn = getConnection();
		CommunityAttachment commAttach = communityDao.findCodiAttachmentByNo(conn, commAttachNo);
		close(conn);
		return commAttach;
	}

	public int deleteCodiAttachment(String commAttachNo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.deleteCodiAttachment(conn, commAttachNo);
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

	public int codiEdit(CommunityExt codi) {
		Connection conn = getConnection();
		int result = 0;
		try {
			// 1. 게시글 수정
			result = communityDao.codiEdit(conn, codi);
			// 2. 첨부파일 등록
			List<CommunityAttachment> commAttachs = codi.getAttachments();
			if(commAttachs != null || !commAttachs.isEmpty()) {
				for(CommunityAttachment commAttach : commAttachs) {
					result = communityDao.insertCodiAttachment(conn, commAttach);
				}
			}
			
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

	public int codiAdd(CommunityExt codi) {
		Connection conn = getConnection();
		int result = 0;
		try {
			// board테이블에 insert
			result = communityDao.codiAdd(conn, codi);
			
			// 방금 등록된 board.no 컬럼값 조회
			String commNo = communityDao.getLastCodiCommNo(conn);
			
			// attachment테이블 insert
			List<CommunityAttachment> commAttachs = ((CommunityExt) codi).getAttachments();
			if(commAttachs != null && !commAttachs.isEmpty()) {
				
				for(CommunityAttachment commAttach : commAttachs) {
					commAttach.setCommNo(commNo);
					result = communityDao.insertCodiAttachment(conn, commAttach);
				}
			}
			commit(conn);
		}
		catch(Exception e) {
			rollback(conn);
			throw e;
		}
		finally {
			close(conn);
		}
		return result;
	}
	
	public List<Community> findFreeAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> result = communityDao.findFreeAll(conn, param);
		close(conn);
		return result;
	}

	// 게시글 상세조회
		public Community findByFreeNo(String no) {

			return findByFreeNo(no, true);
		}

		public Community findByFreeNo(String no, boolean hasRead) {
			Connection conn = getConnection();
			Community community = null;

			try {
				if (!hasRead) {
					int result = communityDao.updateReadCount(conn, no);
				}

				// community 테이블에서 조회
				community = communityDao.findByFreeNo(conn, no);

				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;

			} finally {
				close(conn);
			}
			return community;
		}

		public int insertFree(CommunityExt community) {
			Connection conn = getConnection();
			int result = 0;

			try {
				result = communityDao.insertFree(conn, community);
				
				// 방금 등록된 boaard.no 컬럼값 조회
				String commNo = communityDao.getLastFreeNo(conn);
						
				List<CommunityAttachment> attachments = ((CommunityExt) community).getAttachments();
				if(attachments != null && !attachments.isEmpty()) {
								
					for(CommunityAttachment attach : attachments) {
						attach.setCommNo(commNo);
						result = communityDao.insertFreeAttachment(conn, attach);
					}
							}
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			} finally {
				close(conn);
			}
			return result;
		}

		public int insertFreeComment(CommunityComment communityComment) {
			Connection conn = getConnection();
			int result = 0;
			try {
				result = communityDao.insertFreeComment(conn, communityComment);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			} finally {
				close(conn);
			}
			return result;
		}

		public int deleteFreeComment(String no) {
			Connection conn = getConnection();
			int result = 0;
			try {
				result = communityDao.deleteFreeComment(conn, no);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			} finally {
				close(conn);
			}
			return result;
		}

		public int editFree(Community community) {
			Connection conn = getConnection();
			int result = 0;

			try {
				result = communityDao.editFree(conn, community);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			} finally {
				close(conn);
			}
			return result;
		}

		public int deleteFree(String no) {
			Connection conn = getConnection();
			int result = 0;

			try {
				result = communityDao.deleteFree(conn, no);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			} finally {
				close(conn);
			}
			return result;
		}




		public List<Community> codiAlign(Map<String, Object> param) {
			Connection conn = getConnection();
			List<Community> codiList = communityDao.codiAlign(conn, param);
			close(conn);
			return codiList;
		}

		public List<Community> codiSearch(Map<String, Object> param) {
			Connection conn = getConnection();
			List<Community> codiList = communityDao.codiSearch(conn, param);
			close(conn);
			return codiList;
		}

}
