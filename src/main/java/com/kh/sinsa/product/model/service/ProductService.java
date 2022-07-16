package com.kh.sinsa.product.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.product.model.dao.ProductDao;
import com.kh.sinsa.product.model.dto.Product;

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

}
