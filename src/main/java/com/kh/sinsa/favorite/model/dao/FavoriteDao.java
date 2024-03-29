package com.kh.sinsa.favorite.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.*;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.kh.sinsa.favorite.model.dto.Favorite;
import com.kh.sinsa.favorite.model.exception.FavoriteException;

public class FavoriteDao {
	private Properties prop = new Properties();
	
	public FavoriteDao() {
		String filename = FavoriteDao.class.getResource("/sql/favorite/favorite-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public int favoriteAdd(Connection conn, Favorite favorite) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("favoriteAdd");
		//favoriteAdd =
		//	merge into favorite f
		//  using dual
		//		on (f.user_id = ? and f.pro_no = ?)
		//	when not matched then
		//	insert (f.pro_no, f.user_id, f.fav_date) values (?, ?, default)
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, favorite.getUserId());
			pstmt.setString(2, favorite.getProNo());
			pstmt.setString(3, favorite.getProNo());
			pstmt.setString(4, favorite.getUserId());
			
			result = pstmt.executeUpdate();
	
		} catch (SQLException e) {
			throw new FavoriteException("관심 상품 등록 오류",e);
		} finally {
			close(pstmt);
		}
		return result;
	
	}

	public int proByFavorite(Connection conn, String proNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalfavorite = 0;
		String sql = prop.getProperty("proByFavorite");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, proNo);
			rset = pstmt.executeQuery();
			
			if (rset.next())
				totalfavorite = rset.getInt(1);
			
		} catch (SQLException e) {
			throw new FavoriteException("관심 상품 등록 오류",e);
		} finally {
			close(rset);
			close(pstmt);
		} 
		return totalfavorite;
	}			
}
