package com.kh.sinsa.product.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.product.model.dao.ProductDao;
import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.product.model.dto.ProductExt;

public class ProductService {
	private ProductDao productDao = new ProductDao();

	public List<Product> contentFindAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Product> list = productDao.contentFindAll(conn, param);
		close(conn);
		return list;
	}

	public int getBottomTotalContent() {
		Connection conn = getConnection();
		int totalContent = productDao.getBottomTotalContent(conn); 
		close(conn);
		return totalContent;
	}
	
	public int getTopTotalContent() {
		Connection conn = getConnection();
		int totalContent = productDao.getTopTotalContent(conn); 
		close(conn);
		return totalContent;
	}
	
	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = productDao.getTotalContent(conn); 
		close(conn);
		return totalContent;
	}

	public Product findByProNo(String proNo) {
		Connection conn = getConnection();
		Product product = productDao.findByProNo(conn, proNo);
		close(conn);
		return product;
	}

	public List<ProductAttachment> findProductAttachmentByProductProNo(String proNo) {
		Connection conn = getConnection();
		List<ProductAttachment> attachmentList = productDao.findProductAttachmentByProductProNo(conn,proNo);
		close(conn);
		return attachmentList;
	}

	public List<ProductAttachment> productAttachmentFindAll() {
		Connection conn = getConnection();
		List<ProductAttachment> attachmentList = productDao.productAttachmentFindAll(conn);
		close(conn);
		return attachmentList;
	}

	public List<Product> productSearch(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Product> list = productDao.productSearch(conn, param);
		close(conn);
		return list;
	}

	public List<Product> productAlign(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Product> list = productDao.productAlign(conn, param);
		close(conn);
		return list;
	}

	public List<Product> productTypeFind(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Product> list = productDao.productTypeFind(conn, param);
		close(conn);
		return list;
	}


}
