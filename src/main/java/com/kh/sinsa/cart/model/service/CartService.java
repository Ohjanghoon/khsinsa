package com.kh.sinsa.cart.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.commit;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;
import static com.kh.sinsa.common.JdbcTemplate.rollback;

import java.sql.Connection;

import com.kh.sinsa.cart.model.dao.CartDao;
import com.kh.sinsa.cart.model.dto.Cart;

public class CartService {

	private CartDao cartDao = new CartDao();
	
	public int cartAdd(Cart cart) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = cartDao.favoriteAdd(conn, cart);
			commit(conn);
			
		} catch(Exception e) {
			rollback(conn);
			throw e;
			
		} finally {
			close(conn);
			
		}
		return result;
	}

}
