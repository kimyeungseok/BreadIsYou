package project.board.qna.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import project.board.qna.vo.QnaArticleVO;
import project.board.qna.vo.qnaImageVO;


public interface QnaDAO {
	public List selectAllArticlesList(Map pagingMap) throws DataAccessException;
	public int selectTotArticles() throws DataAccessException;
	public int insertNewArticle(Map articleMap) throws DataAccessException;
	public void updateViewCounts(int articleNO) throws DataAccessException;
	public void insertNewImage(Map articleMap) throws DataAccessException;
	public int selectNewGroupNO() throws DataAccessException;
	public int insertReplyArticle(Map articleMap) throws DataAccessException;
	public QnaArticleVO selectArticle(int articleNO) throws DataAccessException;
	public void updateArticle(Map articleMap) throws DataAccessException;
	public void deleteArticle(int articleNO) throws DataAccessException;
	public List selectImageFileList(int articleNO) throws DataAccessException;
	public void deleteModImage(qnaImageVO imageVO) throws DataAccessException;
	public void insertModNewImage(Map articleMap) throws DataAccessException;
	void updateImageFile(Map articleMap) throws DataAccessException;
	//public int updateViewCount(int articleNO) throws DataAccessException;
}
