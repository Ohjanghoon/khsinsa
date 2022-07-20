package com.kh.sinsa.order.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.*;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import com.kh.sinsa.order.model.dto.Order;
import com.kh.sinsa.order.model.exception.OrderException;

public class OrderDao {
	private Properties prop = new Properties();
	
	public OrderDao() {
		String filename = OrderDao.class.getResource("/sql/order/order-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
			System.err.println("하이~");
		}
	}

	public int insertOrder(Connection conn, Order order) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertOrder");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order.getUserId());
			pstmt.setString(2, order.getProNo());
			pstmt.setString(3, order.getOrderAddress());
			pstmt.setString(4, order.getOrderPhone());
			pstmt.setString(5, order.getOrderEmail());
			pstmt.setString(6, order.getOrderReq());
			pstmt.setInt(7, order.getOrderPrice());
			pstmt.setInt(8, order.getOrderAmount());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new OrderException("상품 주문 오류",e);
		} finally {
			close(pstmt);
		}
		return result;
	}

}
