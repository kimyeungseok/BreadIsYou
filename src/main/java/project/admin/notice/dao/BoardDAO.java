package project.admin.notice.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import project.admin.notice.vo.ArticleVO;


public interface BoardDAO {
	public List selectAllArticlesList(Map pagingMap) throws DataAccessException;
	public int selectTotArticles() throws DataAccessException;
	public int insertNewArticle(Map articleMap) throws DataAccessException;
	public int updateViewCounts(int articleNO) throws DataAccessException;
	//public void insertNewImage(Map articleMap) throws DataAccessException;
	
	public ArticleVO selectArticle(int articleNO) throws DataAccessException;
	public void updateArticle(Map articleMap) throws DataAccessException;
	public void deleteArticle(int articleNO) throws DataAccessException;
	public List selectImageFileList(int articleNO) throws DataAccessException;
	
}
