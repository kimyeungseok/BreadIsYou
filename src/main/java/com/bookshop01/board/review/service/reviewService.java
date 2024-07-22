package com.bookshop01.board.review.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.bookshop01.board.review.vo.reviewArticleVO;
import com.bookshop01.board.review.vo.reviewImageVO;

public interface reviewService {
	public Map listArticles(Map pagingMap) throws Exception;
	public List<reviewArticleVO> listReview(String goods_id) throws Exception;
	public int addNewArticle(Map articleMap) throws Exception;
	public Map viewArticle(Map viewMap,HttpSession session) throws Exception;
	//public Map viewArticle(int articleNO) throws Exception;
	public void modArticle(Map articleMap) throws Exception;
	public void removeArticle(int articleNO) throws Exception;
	
	public void removeModImage(reviewImageVO imageVO) throws Exception;
}
