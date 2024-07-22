package com.bookshop01.board.review.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bookshop01.board.review.vo.reviewArticleVO;
import com.bookshop01.board.review.vo.reviewImageVO;


public interface reviewDAO {
	public List selectAllArticlesList(Map pagingMap) throws DataAccessException;
	
	public int selectTotArticles() throws DataAccessException;
	public List selectReviewList(String goods_id) throws DataAccessException;
	public int insertNewArticle(Map articleMap) throws DataAccessException;
	
	
	public void insertNewImage(Map articleMap) throws DataAccessException;
//	public int selectNewGroupNO() throws DataAccessException;
	
	public reviewArticleVO selectArticle(int articleNO) throws DataAccessException;
	public void updateArticle(Map articleMap) throws DataAccessException;
	public void deleteArticle(int articleNO) throws DataAccessException;
	public List selectImageFileList(int articleNO) throws DataAccessException;
	public void deleteModImage(reviewImageVO imageVO) throws DataAccessException;
	public void insertModNewImage(Map articleMap) throws DataAccessException;
	void updateImageFile(Map articleMap) throws DataAccessException;
	//public int updateViewCount(int articleNO) throws DataAccessException;
}
