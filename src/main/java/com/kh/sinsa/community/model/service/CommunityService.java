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

	
	// ================================ Share ===========================================
	// ==================================================================================
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
	
	
	public List<Community> communitySearch(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> list = communityDao.communitySearch(conn, param);
		close(conn);
		return list;
	}
	
	public List<Community> communityAlign(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> list = communityDao.communityAlign(conn, param);
		close(conn);
		return list;
	}
	
	// ================================ Codi ===========================================
	// =================================================================================
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
	
	// ================================ Free ===========================================
	// ==================================================================================
	public List<Community> findFreeAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> result = communityDao.findFreeAll(conn, param);
		close(conn);
		return result;
	}
		
	// 게시글 상세조회
		public CommunityExt findFreeByNo(String no) {

			return findFreeByNo(no, true);
		}

		public CommunityExt findFreeByNo(String no, boolean hasRead) {
			Connection conn = getConnection();
			CommunityExt community = null;

			try {
				if (!hasRead) {
					int result = communityDao.updateFreeReadCount(conn, no);
				}

				// community 테이블에서 조회
				community = communityDao.findFreeByNo(conn, no);
				
				List<CommunityAttachment> attachments = communityDao.findFreeAttachmentByCommNo(conn, no);

				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;

			} finally {
				close(conn);
			}
			return community;
		}

		public List<CommunityComment> findFreeCommentByCommNo(String no) {
			Connection conn = getConnection();
			List<CommunityComment> commentList = communityDao.findFreeCommentByCommNo(conn, no);
			close(conn);
			return commentList;
		}

		public List<CommunityAttachment> findFreeAttachmentByCommNo(String no) {
			Connection conn = getConnection();
			List<CommunityAttachment> attach = communityDao.findFreeAttachmentByCommNo(conn, no);
			close(conn);
			return attach;
		}

		public int insertFree(CommunityExt community) {
			Connection conn = getConnection();
			int result = 0;

			try {
				result = communityDao.insertFree(conn, community);
				
				// 방금 등록된 boaard.no 컬럼값 조회
				String commNo = communityDao.getFreeLastCommNo(conn);
						
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

		public int editFree(CommunityExt community) {
			Connection conn = getConnection();
			int result = 0;

			try {
				// 게시글 수정
				result = communityDao.editFree(conn, community);
				// 첨부파일 등록
				List<CommunityAttachment> attachments = community.getAttachments();
				if(attachments != null || !attachments.isEmpty()) {
					for(CommunityAttachment attach : attachments) {
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

		public CommunityAttachment findFreeAttachmentByNo(String attachNo) {
			Connection conn = getConnection();
			CommunityAttachment attach = communityDao.findFreeAttachmentByNo(conn, attachNo);
			close(conn);
			return attach;
		}

		public int deleteFreeAttachment(String attachNo) {
			Connection conn = getConnection();
			int result = 0;
			try {
				result = communityDao.deleteFreeAttachment(conn, attachNo);
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

		public List<Community> freeAlign(Map<String, Object> param) {
			Connection conn = getConnection();
			List<Community> codiList = communityDao.freeAlign(conn, param);
			close(conn);
			return codiList;
		}

		public int getFreeTotalContent() {
			Connection conn = getConnection();
			int totalContent = communityDao.getFreeTotalContent(conn);
			close(conn);
			return totalContent;
		}

		public List<Community> freeSearch(Map<String, Object> param) {
			Connection conn = getConnection();
			List<Community> list = communityDao.freeSearch(conn, param);
			close(conn);
			return list;
		}
		

	// ================================ Talk ============================================
	// ==================================================================================		
		
	public List<Community> findTalkAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> result = communityDao.findTalkAll(conn, param);
		close(conn);
		return result;
	}
		
	// 게시글 상세조회
		public CommunityExt findTalkByNo(String no) {

			return findTalkByNo(no, true);
		}

		public CommunityExt findTalkByNo(String no, boolean hasRead) {
			Connection conn = getConnection();
			CommunityExt community = null;

			try {
				if (!hasRead) {
					int result = communityDao.updateTalkReadCount(conn, no);
				}

				// community 테이블에서 조회
				community = communityDao.findTalkByNo(conn, no);
				
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

		public List<CommunityComment> findTalkCommentByCommNo(String no) {
			Connection conn = getConnection();
			List<CommunityComment> commentList = communityDao.findTalkCommentByCommNo(conn, no);
			close(conn);
			return commentList;
		}

		public List<CommunityAttachment> findTalkAttachmentByCommNo(String no) {
			Connection conn = getConnection();
			List<CommunityAttachment> attach = communityDao.findTalkAttachmentByCommNo(conn, no);
			close(conn);
			return attach;
		}

		public int insertTalk(CommunityExt community) {
			Connection conn = getConnection();
			int result = 0;

			try {
				result = communityDao.insertTalk(conn, community);
				
				// 방금 등록된 boaard.no 컬럼값 조회
				String commNo = communityDao.getTalkLastCommNo(conn);
						
				List<CommunityAttachment> attachments = ((CommunityExt) community).getAttachments();
				if(attachments != null && !attachments.isEmpty()) {
								
					for(CommunityAttachment attach : attachments) {
						attach.setCommNo(commNo);
						result = communityDao.insertTalkAttachment(conn, attach);
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

		public int editTalk(CommunityExt community) {
			Connection conn = getConnection();
			int result = 0;

			try {
				// 게시글 수정
				result = communityDao.editTalk(conn, community);
				// 첨부파일 등록
				List<CommunityAttachment> attachments = community.getAttachments();
				if(attachments != null || !attachments.isEmpty()) {
					for(CommunityAttachment attach : attachments) {
						result = communityDao.insertTalkAttachment(conn, attach);
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

		public CommunityAttachment findTalkAttachmentByNo(String attachNo) {
			Connection conn = getConnection();
			CommunityAttachment attach = communityDao.findTalkAttachmentByNo(conn, attachNo);
			close(conn);
			return attach;
		}

		public int deleteTalkAttachment(String attachNo) {
			Connection conn = getConnection();
			int result = 0;
			try {
				result = communityDao.deleteTalkAttachment(conn, attachNo);
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

		public int deleteTalk(String no) {
			Connection conn = getConnection();
			int result = 0;

			try {
				result = communityDao.deleteTalk(conn, no);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			} finally {
				close(conn);
			}
			return result;
		}

		public int insertTalkComment(CommunityComment communityComment) {
			Connection conn = getConnection();
			int result = 0;
			try {
				result = communityDao.insertTalkComment(conn, communityComment);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			} finally {
				close(conn);
			}
			return result;
		}

		public int deleteTalkComment(String no) {
			Connection conn = getConnection();
			int result = 0;
			try {
				result = communityDao.deleteTalkComment(conn, no);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			} finally {
				close(conn);
			}
			return result;
		}

		public List<Community> talkAlign(Map<String, Object> param) {
			Connection conn = getConnection();
			List<Community> list = communityDao.talkAlign(conn, param);
			close(conn);
			return list;
		}

		public int getTalkTotalContent() {
			Connection conn = getConnection();
			int totalContent = communityDao.getTalkTotalContent(conn);
			close(conn);
			return totalContent;
		}

		public List<Community> talkSearch(Map<String, Object> param) {
			Connection conn = getConnection();
			List<Community> list = communityDao.talkSearch(conn, param);
			close(conn);
			return list;
		}


		
}








