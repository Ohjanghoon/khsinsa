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

}
