package com.kh.sinsa.product.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.close;

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
import com.kh.sinsa.product.model.dto.ProductAttachment;
import com.kh.sinsa.product.model.dto.ProductExt;
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
				list.add(handleProductResultSet(rset));
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
			throw new ProductException("총 상품수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
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
		List<ProductAttachment> attachmentList = new ArrayList<>();
		String sql = prop.getProperty("findProductAttachmentByProductProNo");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, proNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				attachmentList.add(handleProductAttachmentResultSet(rset));
			}
		} catch (SQLException e) {
			throw new ProductException("상품 사진 조회 오류!", e);
		}
		finally {
			close(rset);
			close(pstmt);
		}
		return attachmentList;
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
		List<ProductAttachment> attachmentList = new ArrayList<>();
		String sql = prop.getProperty("productAttachmentFindAll");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				attachmentList.add(handleProductAttachmentResultSet(rset));
			}
		} catch (SQLException e) {
			throw new ProductException("상품 사진 전체가져오기 오류!", e);
		}
		finally {
			close(rset);
			close(pstmt);
		}
		return attachmentList;
	}

	public List<Product> productFind(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Product> list = new ArrayList<>();
		String sql = prop.getProperty("productFind");
		String search = (String) param.get("search");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(handleProductResultSet(rset));
			}
			
		} catch (SQLException e) {
			throw new ProductException("상품 검색 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public List<Product> productAlign(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Product> list = new ArrayList<>();
		String sql = prop.getProperty("productAlign");
		String align = (String) param.get("align");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, align);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(handleProductResultSet(rset));
			}
			
		} catch (SQLException e) {
			throw new ProductException("상품 검색 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

}
