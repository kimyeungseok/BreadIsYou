package com.bookshop01.admin.notice.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop01.admin.notice.vo.ArticleVO;
import com.bookshop01.admin.notice.vo.ImageVO;


@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectAllArticlesList(Map pagingMap) throws DataAccessException {
		List<ArticleVO> articlesList = articlesList = sqlSession.selectList("mapper.admin.notice.selectAllArticlesList",pagingMap);
		return articlesList;
	}
	@Override
	public int selectTotArticles() throws DataAccessException{
		int totArticles= sqlSession.selectOne("mapper.admin.notice.selectTotArticles");
		return totArticles;
	}
	
	
	
	@Override
	public int insertNewArticle(Map articleMap) throws DataAccessException {
//		int groupNO = selectNewGroupNO();
//		articleMap.put("groupNO", groupNO);
		int articleNO = selectNewArticleNO();
		articleMap.put("articleNO", articleNO);
		sqlSession.insert("mapper.admin.notice.insertNewArticle",articleMap);
		return articleNO;
	}
    
	//���� ���� ���ε�
	/*
	@Override
	public void insertNewImage(Map articleMap) throws DataAccessException {
		List<ImageVO> imageFileList = (ArrayList)articleMap.get("imageFileList");
		int articleNO = (Integer)articleMap.get("articleNO");
		int imageFileNO = selectNewImageFileNO();
		for(ImageVO imageVO : imageFileList){
			imageVO.setImageFileNO(++imageFileNO);
			imageVO.setArticleNO(articleNO);
		}
		sqlSession.insert("mapper.board.insertNewImage",imageFileList);
	}
	
   */
	
	@Override
	public ArticleVO selectArticle(int articleNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.admin.notice.selectArticle", articleNO);
	}

	@Override
	public void updateArticle(Map articleMap) throws DataAccessException {
		sqlSession.update("mapper.admin.notice.updateArticle", articleMap);
	}
	@Override
	public int updateViewCounts(int articleNO) throws DataAccessException {
		return sqlSession.update("mapper.admin.notice.updateViewCounts", articleNO);
	}
	
	
	@Override
	public void deleteArticle(int articleNO) throws DataAccessException {
		sqlSession.delete("mapper.admin.notice.deleteArticle", articleNO);
		
	}
	
	@Override
	public List selectImageFileList(int articleNO) throws DataAccessException {
		List<ImageVO> imageFileList = null;
		imageFileList = sqlSession.selectList("mapper.admin.notice.selectImageFileList",articleNO);
		return imageFileList;
	}
	
	private int selectNewArticleNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.admin.notice.selectNewArticleNO");
	}
//	private int selectNewGroupNO() throws DataAccessException {
//		return sqlSession.selectOne("mapper.admin.notice.selectNewGroupNO");
//	}
	
	private int selectNewImageFileNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.admin.notice.selectNewImageFileNO");
	}

}
