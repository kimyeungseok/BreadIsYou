package com.bookshop01.board.qna.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.bookshop01.board.qna.vo.qnaImageVO;

public interface QnaService {
	public Map listArticles(Map pagingMap) throws Exception;
	public int addNewArticle(Map articleMap) throws Exception;
	public Map viewArticle(Map viewMap,HttpSession session) throws Exception;
	//public Map viewArticle(int articleNO) throws Exception;
	public void modArticle(Map articleMap) throws Exception;
	public void removeArticle(int articleNO) throws Exception;
	public int addReplyArticle(Map articleMap) throws Exception;
	public void removeModImage(qnaImageVO imageVO) throws Exception;
}
