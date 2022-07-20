package com.kh.sinsa.admin.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.kh.sinsa.user.model.dao.UserDao;
import com.kh.sinsa.user.model.dto.Del;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.dto.UserRole;
import com.kh.sinsa.user.model.exception.UserException;

import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.product.model.dto.ProductExt;
import com.kh.sinsa.product.model.exception.ProductException;

import com.kh.sinsa.admin.model.dto.Notice;

import com.kh.sinsa.admin.model.exception.AdminException;


public class AdminDao {
	private Properties prop = new Properties();

	public AdminDao() {
		String filename = AdminDao.class.getResource("/sql/admin/admin-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// ##########User begins#############

	private User handleUserResultSet(ResultSet rset) throws SQLException {
		String userId = rset.getString("user_id"); // 왼쪽은 자바 오른쪽은 sql
		Timestamp enrollDate = rset.getTimestamp("enroll_date");
		String userName = rset.getString("user_name");
		String userPwd = rset.getString("user_pwd");
		String userPhone = rset.getString("user_phone");
		Date userBirthday = rset.getDate("user_birthday");
		String userEmail = rset.getString("user_email");
		String userAddress = rset.getString("user_address");
		Del userDel = Del.valueOf(rset.getString("user_del"));
		UserRole userRole = UserRole.valueOf(rset.getString("user_role"));
		return new User(userId, userPwd, userName, userRole, userBirthday, userDel, userEmail, userPhone, userAddress,
				enrollDate);

	}
	
	

	public List<User> userFindAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<User> userlist = new ArrayList<>();
		String sql = prop.getProperty("userFindAll");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();

			while (rset.next()) {
				User user = handleUserResultSet(rset);
				userlist.add(user);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return userlist;
	}

	public int userGetTotalContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int usertotalContent = 0;
		String sql = prop.getProperty("userGetTotalContent");

		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if (rset.next())
				usertotalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new UserException("전체회원수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return usertotalContent;
	}

	public List<User> findUserLike(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<User> userlist = new ArrayList<>();
		String sql = prop.getProperty("findUserLike");
		// select * from ( select row_number () over (order by enroll_date desc) rnum,
		// u.* from kh_user u where # like ?) u where rnum between ? and ?
		String col = (String) param.get("usersearchType");
		String val = (String) param.get("usersearchType");
		int start = (int) param.get("start");
		int end = (int) param.get("end");

		sql = sql.replace("#", col);
		System.out.println(sql);

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + val + "%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rset = pstmt.executeQuery();
			while (rset.next())
				userlist.add(handleUserResultSet(rset));

		} catch (SQLException e) {
			throw new UserException("관리자 회원검색 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return userlist;
	}

	public int userGetTotalContentLike(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int usertotalContent = 0;
		String sql = prop.getProperty("userGetTotalContentLike");
		String col = (String) param.get("usersearchType");
		String val = (String) param.get("usersearchType");
		sql = sql.replace("#", col);

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + val + "%");
			rset = pstmt.executeQuery();
			if (rset.next())
				usertotalContent = rset.getInt(1);

		} catch (SQLException e) {
			throw new UserException("관리자 검색된 회원수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return usertotalContent;
	}
	// ##########User ends#############
	
	// ##########Product begins#############
	
	private Product handleProductResultSet(ResultSet rset) throws SQLException {
		String proNo = rset.getString("pro_no");
		String proType = rset.getString("pro_type");
		String proName = rset.getString("pro_name");
		int proPrice = rset.getInt("pro_price");
		String proSize = rset.getString("pro_size");
		Timestamp regDate = rset.getTimestamp("reg_date");
		String proContent = rset.getString("pro_content");		
		return new Product(proNo, proType, proName, proPrice, proSize, regDate, proContent);
	}
	
	private ProductExt handleProductExtResultSet(ResultSet rset) throws SQLException {
		String proNo = rset.getString("pro_no");
		String proType = rset.getString("pro_type");
		String proName = rset.getString("pro_name");
		int proPrice = rset.getInt("pro_price");
		String proSize = rset.getString("pro_size");
		Timestamp regDate = rset.getTimestamp("reg_date");
		String proContent = rset.getString("pro_content");		
		String proOriginalFilename = rset.getString("pro_original_filename");
		return new ProductExt(proNo, proType, proName, proPrice, proSize, regDate, proContent, proOriginalFilename);
	}
	
	
	public List<Product> productFindAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Product> productlist = new ArrayList<>();
		String sql = prop.getProperty("productFindAll");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			
			rset = pstmt.executeQuery();

			while (rset.next()) {
				productlist.add(handleProductResultSet(rset));
			}

		} catch (SQLException e) {
			throw new ProductException("상품조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return productlist;
	}

	public int productGetTotalContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int producttotalContent = 0;
		String sql = prop.getProperty("productGetTotalContent");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if (rset.next())
				producttotalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new ProductException("총 상품수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return producttotalContent;
	}
	
	public Product findByProNo(Connection conn, String proNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Product product = null;
		String sql = prop.getProperty("findByProNo");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, proNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				product = handleProductResultSet(rset);
			}
			
		} catch (SQLException e) {
			throw new ProductException("상품상세조회 오류!", e);
			
		} finally {
			close(rset);
			close(pstmt);
			
		}
		return product;
	}
	
	public List<ProductAttachment> findProductAttachmentByProductProNo(Connection conn, String proNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductAttachment> productattachmentList = new ArrayList<>();
		String sql = prop.getProperty("findProductAttachmentByProductProNo");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, proNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				productattachmentList.add(handleProductAttachmentResultSet(rset));
			}
		} catch (SQLException e) {
			throw new ProductException("상품 사진 조회 오류!", e);
		}
		finally {
			close(rset);
			close(pstmt);
		}
		return productattachmentList;
	}

	private ProductAttachment handleProductAttachmentResultSet(ResultSet rset) throws SQLException {
		int proAttachmentNo = rset.getInt("pro_attachment_no");
		String proNo = rset.getString("pro_no");
		String proOriginalFilename = rset.getString("pro_original_filename");
		String proRenameFilename = rset.getString("pro_rename_filename");
		return new ProductAttachment(proAttachmentNo,proNo,proOriginalFilename,proRenameFilename);
	}

	public List<ProductAttachment> productAttachmentFindAll(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductAttachment> productattachmentList = new ArrayList<>();
		String sql = prop.getProperty("productAttachmentFindAll");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				productattachmentList.add(handleProductAttachmentResultSet(rset));
			}
		} catch (SQLException e) {
			throw new ProductException("상품 사진 전체가져오기 오류!", e);
		}
		finally {
			close(rset);
			close(pstmt);
		}
		return productattachmentList;
	}

	public List<Product> productFind(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Product> productlist = new ArrayList<>();
		String sql = prop.getProperty("productFind");
		String search = (String) param.get("search");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				productlist.add(handleProductResultSet(rset));
			}
			
		} catch (SQLException e) {
			throw new ProductException("상품 검색 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return productlist;
	}

	public List<Product> productAlign(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Product> productlist = new ArrayList<>();
		String sql = prop.getProperty("productAlign");
		String align = (String) param.get("align");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, align);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				productlist.add(handleProductResultSet(rset));
			}
			
		} catch (SQLException e) {
			throw new ProductException("상품 검색 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return productlist;
	}
	
	// ##########Product ends#############
	
	//##########Notice begins#############

	// 게시글 목록 조회
		private Notice handlerNoticeResultSet(ResultSet rset) throws SQLException {
		String notice_no = rset.getString("notice_no");
		String notice_title = rset.getString("notice_title");
		String notice_content = rset.getString("notice_content");
		String notice_writer = rset.getString("notice_writer");
		Date notice_date = rset.getDate("notice_date");
		int notice_read_count = rset.getInt("notice_read_count");
		
		return new Notice(notice_no, notice_title, notice_content, notice_writer, notice_date, notice_read_count);
	}
		
		public List<Notice> noticeFindAll(Connection conn, Map<String, Object> param) {
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			List<Notice> noticelist = new ArrayList<>();
			String sql = prop.getProperty("noticeFindAll");
			
			try {
				pstmt = conn.prepareStatement(sql);
				rset = pstmt.executeQuery();
				while(rset.next()) {
					Notice notice = handlerNoticeResultSet(rset);
					noticelist.add(notice);
					
				}
			} catch (SQLException e) {
				throw new AdminException("공지사항 게시글 목록 오류", e);
			} finally {
				close(rset);
				close(pstmt);
			}
			
			return noticelist;
		}
		
		// 게시글 목록 조회 페이지바
		public int noticeGetTotalContent(Connection conn) {
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			int noticetotalContent = 0;
			String sql = prop.getProperty("noticegetTotalContent");
			try {
				pstmt = conn.prepareStatement(sql);
				rset = pstmt.executeQuery();
				if(rset.next())
					noticetotalContent = rset.getInt(1);
			} catch (SQLException e) {
				throw new AdminException("총 게시물수 조회 오류!", e);
			} finally {
				close(rset);
				close(pstmt);
			}
			
			return noticetotalContent;
		}

		
		public int updateNoticeReadCount(Connection conn, String no) {
			PreparedStatement pstmt = null;
			int result = 0;
			String sql = prop.getProperty("updateReadCount");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, no);
				result = pstmt.executeUpdate();
			} 
			catch (SQLException e) {
				throw new AdminException("조회수 증가 오류!", e);
			}
			finally {
				close(pstmt);
			}
			
			return result;
		}

		//##########Notice ends##############
	}

