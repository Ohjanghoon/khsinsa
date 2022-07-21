package com.kh.sinsa.cart.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import com.kh.sinsa.cart.model.dto.Cart;
import com.kh.sinsa.cart.model.exception.CartException;

public class CartDao {
	
	private Properties prop = new Properties();
	
	public CartDao() {
		String filename = CartDao.class.getResource("/sql/cart/cart-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public int favoriteAdd(Connection conn, Cart cart) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("cartAdd");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cart.getUserId());
			pstmt.setString(2, cart.getProNo());
			pstmt.setInt(3, cart.getCartBuyStock());
			pstmt.setString(4, cart.getCartSize());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new CartException("장바구니 담기 오류",e);
		} finally {
			close(pstmt);
		}
		return result;
	}

}
