package com.kh.sinsa.order.model.service;

import static com.kh.sinsa.common.JdbcTemplate.*;

import java.sql.Connection;

import com.kh.sinsa.order.model.dao.OrderDao;
import com.kh.sinsa.order.model.dto.Order;

public class OrderService {
	private OrderDao orderDao = new OrderDao();
	
	
	public int insertOrder(Order order) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = orderDao.insertOrder(conn, order);
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
