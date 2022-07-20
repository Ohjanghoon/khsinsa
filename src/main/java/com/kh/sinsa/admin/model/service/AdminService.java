package com.kh.sinsa.admin.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.admin.model.dao.AdminDao;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.product.model.dto.ProductExt;

public class AdminService {

	private AdminDao adminDao = new AdminDao();
	
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
	
	// ##########jaekyung ProductService ends#############
}
