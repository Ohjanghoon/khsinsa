package com.kh.sinsa.admin.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.commit;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;
import static com.kh.sinsa.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.admin.model.dao.AdminDao;
import com.kh.sinsa.admin.model.dto.ProductManagementExt;
import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.product.model.dto.ProductExt;

import com.kh.sinsa.inquire.model.dto.Attachment;
import com.kh.sinsa.inquire.model.dto.Inquire;
import com.kh.sinsa.inquire.model.dto.InquireExt;
import com.kh.sinsa.order.model.dto.Order;

public class AdminService {

	private static AdminDao adminDao = new AdminDao();
	
	// ##########jaekyung UserService begin#############

	public List<User> userFindAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<User> userlist = adminDao.userFindAll(conn, param);
		close(conn);
		return userlist;
	}

	public int userGetTotalContent() {
		Connection conn = getConnection();
		int usertotalContent = adminDao.userGetTotalContent(conn);
		close(conn);
		return usertotalContent;
	}

	public List<User> findUserLike(Map<String, Object> param) {
		Connection conn = getConnection();
		List<User> userlist = adminDao.findUserLike(conn, param);
		close(conn);
		return userlist;
	}

	public int userGetTotalContentLike(Map<String, Object> param) {
		Connection conn = getConnection();
		int usertotalContent = adminDao.userGetTotalContentLike(conn, param);
		close(conn);
		return usertotalContent;
	}
	// ##########jaekyung UserService end#############
	
	// ##########jaekyung ProductService begins#############
	public List<Product> productFindAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Product> productlist = adminDao.productFindAll(conn, param);
		close(conn);
		return productlist;
	}

	public int productGetTotalContent() {
		Connection conn = getConnection();
		int producttotalContent = adminDao.productGetTotalContent(conn);
		close(conn);
		return producttotalContent;
	}
	
	public Product findByProNo(String proNo) {
		Connection conn = getConnection();
		Product product = adminDao.findByProNo(conn, proNo);
		close(conn);
		return product;
	}

	public List<ProductAttachment> findProductAttachmentByProductProNo(String proNo) {
		Connection conn = getConnection();
		List<ProductAttachment> productattachmentList = adminDao.findProductAttachmentByProductProNo(conn,proNo);
		close(conn);
		return productattachmentList;
	}

	public List<ProductAttachment> productAttachmentFindAll() {
		Connection conn = getConnection();
		List<ProductAttachment> productattachmentList = adminDao.productAttachmentFindAll(conn);
		close(conn);
		return productattachmentList;
	}

	public List<Product> productFind(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Product> productlist = adminDao.productFind(conn, param);
		close(conn);
		return productlist;
	}

	public List<Product> productAlign(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Product> productlist = adminDao.productAlign(conn, param);
		close(conn);
		return productlist;
	}
	
	// 상품 등록
		public int insertProduct(Product product, Map<String, Object> param) {
			Connection conn = getConnection();
			int result = 0; 
			
			try {
			result = adminDao.insertProduct(conn, product, param);
			
			// 방금 등록된 board.no 컬럼값 조회
			String proNo = adminDao.getLastProNo(conn);
			System.out.println("proNo = " + proNo);
						
			// attachment테이블 insert
			List<ProductAttachment> productattachments = ((ProductManagementExt) product).getProductAttachment();
			if(productattachments != null && !productattachments.isEmpty()) {
							
			for(ProductAttachment productattach : productattachments) {
				productattach.setProNo(proNo);
				result = adminDao.insertProductAttachment(conn, productattach);
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
		
		public int updateProduct(ProductManagementExt product) {
			Connection conn = getConnection();
			int result = 0;
			try {
				// 1. 게시글 수정
				result = adminDao.updateProduct(conn, product);
				// 2. 첨부파일 등록
				List<ProductAttachment> productattachments = product.getProductAttachment();
				if(productattachments != null || !productattachments.isEmpty()) {
					for(ProductAttachment productattach : productattachments) {
						result = adminDao.insertProductAttachment(conn, productattach);
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

		public int deleteProductAttachment(int proAttachmentNo) {
			Connection conn = getConnection();
			int result = 0;
			try {
				result = adminDao.deleteProductAttachment(conn, proAttachmentNo);
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

		public ProductAttachment findProductAttachmentByProAttachmentNo(int proAttachmentNo) {
			Connection conn = getConnection();
			ProductAttachment productattach = adminDao.findProductAttachmentByProAttachmentNo(conn, proAttachmentNo);
			close(conn);
			return productattach;
		}
		
		public int deleteProduct(String proNo) {
			Connection conn = getConnection();
			int result = 0;
			try {
				result = adminDao.deleteProduct(conn, proNo);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			}
			close(conn);
			return result;
		}

		public static List<ProductAttachment> findProductAttachmentByProNo(String proNo) {
			Connection conn = getConnection();
			List<ProductAttachment> productattachmentList = adminDao.findProductAttachmentByProNo(conn, proNo);
			close(conn);
			return productattachmentList;
		}
	// ##########jaekyung ProductService ends#############
		
	// ##########jaekyung InquireService begins#############
		
		public List<Inquire> inquireFindAll(Map<String, Object> param) {
			Connection conn = null;
			List<Inquire> inquirelist = null;
			try {
				conn = getConnection();
				inquirelist = adminDao.inquireFindAll(conn, param);
			} catch (Exception e) {
				throw e;
			} finally {
				close(conn);
			}
			return inquirelist;
		}

		public int inquireGetTotalContent() {
			Connection conn = getConnection();
			int inquireTotalContent = adminDao.inquireGetTotalContent(conn);
			close(conn);
			return inquireTotalContent;
		}
		
	// ##########jaekyung InquireService ends#############

// ##########jaekyung OrderService begins#############

public List<Order> orderFindAll(Map<String, Object> param) {
	Connection conn = getConnection();
	List<Order> orderlist = adminDao.orderFindAll(conn, param);
	close(conn);
	return orderlist;
}

public int orderGetTotalContent() {
	Connection conn = getConnection();
	int orderTotalContent = adminDao.orderGetTotalContent(conn);
	close(conn);
	return orderTotalContent;
}}

//##########jaekyung OrderService ends#############
