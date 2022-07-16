package com.kh.sinsa.product.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.*;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.kh.sinsa.product.model.dto.Product;
import com.kh.sinsa.product.model.exception.ProductException;

public class ProductDao {
	private Properties prop = new Properties();
	
	public ProductDao() {
		String filename = ProductDao.class.getResource("/sql/product/product-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
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
	
	
	public List<Product> contentFindAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Product> list = new ArrayList<>();
		String sql = prop.getProperty("contentFindAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Product product = handleProductResultSet(rset);
				list.add(product);
			}
			
		} catch (SQLException e) {
			throw new ProductException("상품조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int getTotalContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getTotalContent");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				totalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new ProductException("총 게시물수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
	}

}
