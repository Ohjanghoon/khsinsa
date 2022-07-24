package com.kh.sinsa.admin.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.getConnection;
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
import com.kh.sinsa.admin.model.dto.ProductManagementExt;

import com.kh.sinsa.inquire.model.dto.Inquire;
import com.kh.sinsa.inquire.model.dto.InquireExt;
import com.kh.sinsa.inquire.model.exception.InquireException;

import com.kh.sinsa.admin.model.exception.AdminException;
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.community.model.exception.CommunityException;

import com.kh.sinsa.order.model.dto.Order;


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
	
	private ProductManagementExt handleProductManagementExtResultSet(ResultSet rset) throws SQLException {
		String proNo = rset.getString("pro_no");
		String proType = rset.getString("pro_type");
		String proName = rset.getString("pro_name");
		int proPrice = rset.getInt("pro_price");
		String proSize = rset.getString("pro_size");
		Timestamp regDate = rset.getTimestamp("reg_date");
		String proContent = rset.getString("pro_content");		
		return new ProductManagementExt(proNo, proType, proName, proPrice, proSize, regDate, proContent);
	}
	
	
	public List<Product> productFindAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Product> productlist = new ArrayList<>();
		String sql = prop.getProperty("productFindAll");
//		productFindAll = select * from ( select row_number () over (order by pro_no desc) rnum, p.* from product p ) p where rnum between ? and ?
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
		ProductAttachment productattach = new ProductAttachment();
		productattach.setProAttachmentNo(rset.getInt("pro_attachment_no"));
		productattach.setProNo(rset.getString("pro_no"));
		productattach.setProOriginalFilename(rset.getString("pro_original_filename"));
		productattach.setProRenameFilename(rset.getString("pro_rename_filename"));
		return productattach;
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
	
	public int insertProduct(Connection conn, Product product) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertProduct");
		//insertProduct = insert into product (pro_no,pro_type,pro_name,pro_price,pro_size,pro_content) values (A10 || seq_product_pro_no.nextval, ?, ?, ?, ?, ?)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProType());
			pstmt.setString(2, product.getProName());
			pstmt.setInt(3, product.getProPrice());
			pstmt.setString(4, product.getProSize());
			pstmt.setString(5, product.getProContent());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			throw new AdminException("상품 등록 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
//	create table product_attachment(
//	        pro_attachment_no number,
//	        pro_no varchar2(100) not null,
//	        pro_original_filename varchar2(255) not null,
//	        pro_rename_filename varchar2(255) not null,
	        
//	insertProductAttachment = insert into attachment values(seq_product_attachment_pro_attachment_no.nextval, ?, ?, ?)
	
	public String getLastTopProNo(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String ProNo = null;
		String sql = prop.getProperty("getLastTopProNo");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				ProNo = rset.getString(1);
		} 
		catch (SQLException e) {
			throw new AdminException("생성된 상품번호 조회 오류!", e);
		}
		finally {
			close(rset);
			close(pstmt);
		}
		return ProNo;
	}
	
//	create table product_attachment(
//	        pro_attachment_no number,
//	        pro_no varchar2(100) not null,
//	        pro_original_filename varchar2(255) not null,
//	        pro_rename_filename varchar2(255) not null,
	        
//	insertProductAttachment = insert into attachment values(seq_product_attachment_pro_attachment_no.nextval, ?, ?, ?)
	
	public String getLastBottomProNo(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String ProNo = null;
		String sql = prop.getProperty("getLastBottomProNo");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				ProNo = rset.getString(1);
		} 
		catch (SQLException e) {
			throw new AdminException("생성된 상품번호 조회 오류!", e);
		}
		finally {
			close(rset);
			close(pstmt);
		}
		return ProNo;
	}
	
	public int insertProductAttachment(Connection conn, ProductAttachment productAttach) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertProductAttachment");
//		insertProductAttachment = insert into product_attachment values(seq_product_attachment_pro_attachment_no.nextval, ?, ?, ?) 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productAttach.getProNo());
			pstmt.setString(2, productAttach.getProOriginalFilename());
			pstmt.setString(3, productAttach.getProRenameFilename());
			
			result = pstmt.executeUpdate();
			
		} 
		catch (SQLException e) {
			throw new AdminException("상품 첨부파일 등록 오류!", e);
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	
//	productEdit = update product set pro_name = ?, pro_price = ?, pro_size = ?, pro_content = ? where pro_no = ?
//	deleteProductAttachment = delete from product_attachment where pro_attachment_no = ?
//	findProductAttachmentByProAttachmentNo = select * from product_attachment where pro_attachment_no = ?
		
	public int productEdit(Connection conn, ProductManagementExt product) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("productEdit");
//		update board set pro_name = ?, pro_price = ?, pro_size = ?, pro_content = ? where pro_no = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProName());
			pstmt.setInt(2, product.getProPrice());
			pstmt.setString(3, product.getProSize());
			pstmt.setString(4, product.getProContent());
			pstmt.setString(5, product.getProNo());
			result = pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			throw new AdminException("상품 수정 오류!", e);
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	
	public int deleteProductAttachment(Connection conn, int proAttachmentNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteProductAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, proAttachmentNo);
			result = pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			throw new AdminException("상품 사진 삭제 오류!", e);
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	
	public ProductAttachment findProductAttachmentByProAttachmentNo(Connection conn, int proAttachmentNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ProductAttachment productattach = null;
		String sql = prop.getProperty("findProductAttachmentByProAttachmentNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, proAttachmentNo);
			rset = pstmt.executeQuery();
			while(rset.next()) 
				productattach = handleProductAttachmentResultSet(rset);
		} 
		catch (SQLException e) {
			throw new AdminException("상품 사진 조회 오류!", e);
		}
		finally {
			close(rset);
			close(pstmt);
		}
		return productattach;
	}
	
	public int deleteProduct(Connection conn, String proNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteProduct");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, proNo);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new AdminException("상품 삭제 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public List<ProductAttachment> findProductAttachmentByProNo(Connection conn, String proNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductAttachment> productattachmentList = new ArrayList<>();
		String sql = prop.getProperty("findProductAttachmentByProNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, proNo);
			rset = pstmt.executeQuery();
			while(rset.next())
				productattachmentList.add(handleProductAttachmentResultSet(rset));
		} 
		catch (SQLException e) {
			throw new AdminException("상품 사진 조회 오류!", e);
		}
		finally {
			close(rset);
			close(pstmt);
		}
		
		return productattachmentList;
	}
	


//create table product(
//        pro_no varchar2(100) ,
//        pro_type varchar2(30),
//        pro_name varchar2(50) not null,
//        pro_price number not null,
//        pro_size varchar2(2) not null,
//        reg_date date default current_date,
//        pro_content varchar2(4000) not null,
//        constraint pk_pro_no primary key(pro_no)
//);
//
//create table product_attachment(
//        pro_attachment_no number,
//        pro_no varchar2(100) not null,
//        pro_original_filename varchar2(255) not null,
//        pro_rename_filename varchar2(255) not null,
//        constraint pk_pro_attachment_no primary key (pro_attachment_no),
//        constraint fk_pro_no_03 foreign key (pro_no) references product(pro_no)
//);
//
//create sequence seq_product_pro_no;
//create sequence seq_product_attachment_pro_attachment_no;
	
	// ##########Product ends#############

	//##########Inquire begins#############
	
private Inquire handleInquireResultSet(ResultSet rset) throws SQLException {
		String inquireNo = rset.getString("inquire_no");
		String userId = rset.getString("user_id");
		String inquireAnswerRef = rset.getString("inquire_answer_ref");
		String inquireTitle = rset.getString("inquire_title");
		String inquireContent = rset.getString("inquire_content");
		Date inquireDate = rset.getDate("inquire_date");
		String inquireCategory = rset.getString("inquire_category");
		return new Inquire(inquireNo, userId, inquireAnswerRef, inquireTitle, inquireContent, inquireDate,
				inquireCategory);
	}
//inquireFindAll = select * from (select row_number() over(order by inquire_date desc) rnum, i.*, (select count(*) from inquire inq where i.inquire_no = inq.inquire_answer_ref) answer_status from inquire i) i where rnum between ? and ?
public List<Inquire> inquireFindAll(Connection conn, Map<String, Object> param) {
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	List<Inquire> inquirelist = new ArrayList<>();
	String sql = prop.getProperty("inquireFindAll");
	System.out.println(sql);
	try {
		pstmt = conn.prepareStatement(sql);

		pstmt.setInt(1, (int) param.get("start"));
		pstmt.setInt(2, (int) param.get("end"));
		rset = pstmt.executeQuery();
		
		while (rset.next()) {
			Inquire inquire = handleInquireResultSet(rset);
			inquirelist.add(inquire);
		}

	} catch (SQLException e) {
		throw new InquireException("요청처리 목록 조회 오류", e);
	} finally {
		close(rset);
		close(pstmt);
	}
	return inquirelist;
}

public int inquireGetTotalContent(Connection conn) {
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	int inquireTotalContent = 0;
	String sql = prop.getProperty("inquireGetTotalContent");
	try {
		pstmt = conn.prepareStatement(sql);
		rset = pstmt.executeQuery();
		if (rset.next())
			inquireTotalContent = rset.getInt(1);
	} catch (SQLException e) {
		throw new InquireException("총 요청처리 조회 오류!", e);
	} finally {
		close(rset);
		close(pstmt);
	}

	return inquireTotalContent;
}
//public int insertAttachment(Connection conn, Attachment attach) {
//	PreparedStatement pstmt = null;
//	int result = 0;
//	String sql = prop.getProperty("insertAttachment");
//
//	try {
//		pstmt = conn.prepareStatement(sql);
//		pstmt.setString(1, attach.getInquireNo());
//		pstmt.setString(2, attach.getInqOriginalFilename());
//		pstmt.setString(3, attach.getInqRenamedFilename());
//		result = pstmt.executeUpdate();
//	} catch (SQLException e) {
//		throw new InquireException("첨부파일 오류 ");
//	} finally {
//		close(pstmt);
//	}
//	return result;
//}



// ##########Inquire ends#############

//##########Order begins#############


private Order handleOrderResultSet(ResultSet rset) throws SQLException {
	int orderNo = rset.getInt("order_no"); 
	String userId = rset.getString("user_id");
	String proNo = rset.getString("pro_no");
	String orderAddress = rset.getString("order_address");
	String orderPhone = rset.getString("order_phone");
	String orderEmail = rset.getString("order_email");
	Timestamp orderDate = rset.getTimestamp("order_date");
	String orderReq = rset.getString("order_req");
	int orderPrice = rset.getInt("order_price");
	String orderStatus = rset.getString("order_status");
	int orderAmount = rset.getInt("order_amount");
	return new Order(orderNo, userId, proNo, orderAddress, orderPhone, orderEmail,
				     orderDate, orderReq, orderPrice, orderStatus, orderAmount); }

//order_no number,
//user_id varchar2(100) not null,
//pro_no varchar2(100) not null,
//order_address varchar2(50) not null,
//order_phone varchar2(11) not null,
//order_email varchar2(100) not null,
//order_date date default current_date,
//order_req varchar2(100) not null,
//order_price number not null,
//order_status varchar2(100) not null, 
//order_amount number default 1,
 

public List<Order> orderFindAll(Connection conn, Map<String, Object> param) {
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	List<Order> orderlist = new ArrayList<>();
	String sql = prop.getProperty("orderFindAll");

	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, (int) param.get("start"));
		pstmt.setInt(2, (int) param.get("end"));
		rset = pstmt.executeQuery();

		while (rset.next()) {
			Order order = handleOrderResultSet(rset);
			orderlist.add(order);
		}

	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		close(rset);
		close(pstmt);
	}
	return orderlist;
}

public int orderGetTotalContent(Connection conn) {
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	int orderTotalContent = 0;
	String sql = prop.getProperty("orderGetTotalContent");

	try {
		pstmt = conn.prepareStatement(sql);
		rset = pstmt.executeQuery();
		if (rset.next())
			orderTotalContent = rset.getInt(1);
	} catch (SQLException e) {
		throw new UserException("전체 주문 조회 오류!", e);
	} finally {
		close(rset);
		close(pstmt);
	}
	return orderTotalContent;
}

public int editOrderStatus(Connection conn, Order order) {
	PreparedStatement pstmt = null;
	int result = 0;
	String sql = prop.getProperty("editOrderStatus");
//	editOrderStatus = update kh_order set order_status = ? where order_no = ?
//	editFree = update community set comm_title = ?, comm_content = ? where comm_no = ?
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, order.getOrderStatus());
		pstmt.setInt(2, order.getOrderNo());
		result = pstmt.executeUpdate();
	} 
	catch (SQLException e) {
		throw new CommunityException("주문상태 수정 오류!", e);
	}
	finally {
		close(pstmt);
	}
	return result;
}

public Order findByOrderNo(Connection conn, int orderNo) {
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	Order order = null;
	String sql = prop.getProperty("findByOrderNo");
//	findByNo = select * from community where comm_no = ?
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, orderNo);
		rset = pstmt.executeQuery();
		while (rset.next())
			order = handleOrderResultSet(rset);

	} catch (SQLException e) {
		throw new AdminException("주문 조회 오류!", e);
	} finally {
		close(rset);
		close(pstmt);
	}
	return order;
}}
//##########Order ends#############





