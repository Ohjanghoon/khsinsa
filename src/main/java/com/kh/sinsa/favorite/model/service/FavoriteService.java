package com.kh.sinsa.favorite.model.service;

import static com.kh.sinsa.common.JdbcTemplate.*;


import java.sql.Connection;

import com.kh.sinsa.favorite.model.dao.FavoriteDao;
import com.kh.sinsa.favorite.model.dto.Favorite;

public class FavoriteService {

	private FavoriteDao favoriteDao = new FavoriteDao();
	
	public int favoriteAdd(Favorite favorite) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = favoriteDao.favoriteAdd(conn, favorite);
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
