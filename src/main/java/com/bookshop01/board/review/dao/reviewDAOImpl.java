package com.bookshop01.board.review.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop01.board.review.vo.reviewArticleVO;
import com.bookshop01.board.review.vo.reviewImageVO;


@Repository("reviewDAO")
public class reviewDAOImpl implements reviewDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectAllArticlesList(Map pagingMap) throws DataAccessException {
		List<reviewArticleVO> articlesList  = sqlSession.selectList("mapper.board.review.selectAllArticlesList", pagingMap);
		return articlesList;
	}
	
	@Override
	public int selectTotArticles() throws DataAccessException {
		int totArticles = sqlSession.selectOne("mapper.board.review.selectTotArticles");
		return totArticles;
	}
	
	@Override
	public List selectReviewList(String goods_id) throws DataAccessException {
		List<reviewArticleVO> reviewList = sqlSession.selectList("mapper.board.review.selectReviewList",goods_id);
		return reviewList;
	}
	
		
	@Override
	public int insertNewArticle(Map articleMap) throws DataAccessException {
		
		int articleNO = selectNewArticleNO();
		articleMap.put("articleNO", articleNO);
		sqlSession.insert("mapper.board.review.insertNewArticle",articleMap);
		return articleNO;
	}
	
	
	
	//���� ���� ���ε�
		@Override
		public void insertNewImage(Map articleMap) throws DataAccessException {
			List<reviewImageVO> imageFileList = (ArrayList)articleMap.get("imageFileList");
			int articleNO = (Integer)articleMap.get("articleNO");
			int imageFileNO = selectNewImageFileNO();
			
			if(imageFileList != null && imageFileList.size() != 0) {
				for(reviewImageVO imageVO : imageFileList){
					imageVO.setImageFileNO(++imageFileNO);
					imageVO.setArticleNO(articleNO);
				}
				sqlSession.insert("mapper.board.review.insertNewImage",imageFileList);
			}
			
		}
		
	
//	@Override
//	public int selectNewGroupNO() throws DataAccessException {
//			int maxGroupNO = sqlSession.selectOne("mapper.board.review.selectNewGroupNO");
//			return maxGroupNO;
//	}
    
	
	
//	@Override
//	public int updateViewCount(int articleNO) throws DataAccessException {
//		return sqlSession.update("mapper.board.updateViewCount", articleNO);
//	}
	
	
	
	
	
	
	/*
	 * @Override public ArticleVO selectArticle1(int articleNO) throws
	 * DataAccessException { //��ȸ�� ī��Ʈ addCount(articleNO); return
	 * sqlSession.selectOne("mapper.board.selectArticle", articleNO); }
	 * 
	 * 
	 * //��ȸ�� ī��Ʈ �ø��� private void addCount(int articleNO, HttpSession session) {
	 * 
	 * // sqlSession.selectOne("mapper.board.selectbdcount",articleNO);
	 * 
	 * String articleNum = "articleNO:" + articleNO; System.out.println(articleNum);
	 * 
	 * 
	 * if (session.getAttribute(articleNum) == null) {
	 * sqlSession.update("mapper.board.updateBdcount", articleNO);
	 * 
	 * session.setAttribute(articleNum, true); System.out.println(articleNum); } }
	 */
	
	
	@Override
	public reviewArticleVO selectArticle(int articleNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.board.review.selectArticle", articleNO);
	}
		
	@Override
	public void updateArticle(Map articleMap) throws DataAccessException {
		sqlSession.update("mapper.board.review.updateArticle", articleMap);
	}
	
	@Override
	public void updateImageFile(Map articleMap) throws DataAccessException {
		
		List<reviewImageVO> imageFileList = (ArrayList)articleMap.get("imageFileList");
		int articleNO = Integer.parseInt((String)articleMap.get("articleNO"));
		
		for(int i = imageFileList.size()-1; i >= 0; i--){
			reviewImageVO imageVO = imageFileList.get(i);
			String imageFileName = imageVO.getImageFileName();
			if(imageFileName == null) {  //������ �̹����� �������� �ʴ� ��� ���ϸ��� null �̹Ƿ�  ������ �ʿ䰡 ����.
				imageFileList.remove(i);
			}else {
				imageVO.setArticleNO(articleNO);
			}
		}
		
		if(imageFileList != null && imageFileList.size() != 0) {
			sqlSession.update("mapper.board.review.updateImageFile", imageFileList);
		}
		
	}

	
	

	@Override
	public void deleteArticle(int articleNO) throws DataAccessException {
		sqlSession.delete("mapper.board.review.deleteArticle", articleNO);
		
	}
	
	@Override
	public List selectImageFileList(int articleNO) throws DataAccessException {
		List<reviewImageVO> imageFileList = null;
		imageFileList = sqlSession.selectList("mapper.board.review.selectImageFileList",articleNO);
		return imageFileList;
	}
	
	

	

	private int selectNewArticleNO() throws DataAccessException {
		int articleNO = sqlSession.selectOne("mapper.board.review.selectNewArticleNO");
		return articleNO;
	}
	
	private int selectNewImageFileNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.review.selectNewImageFileNO");
	}


	@Override
	public void deleteModImage(reviewImageVO imageVO) throws DataAccessException {
		sqlSession.delete("mapper.board.review.deleteModImage", imageVO );
		
	}


	@Override
	public void insertModNewImage(Map articleMap) throws DataAccessException {
		List<reviewImageVO> modAddimageFileList = (ArrayList<reviewImageVO>)articleMap.get("modAddimageFileList");
		int articleNO = Integer.parseInt((String)articleMap.get("articleNO"));
		
		int imageFileNO = selectNewImageFileNO();
		
		for(reviewImageVO imageVO : modAddimageFileList){
			imageVO.setArticleNO(articleNO);
			imageVO.setImageFileNO(++imageFileNO);
		}
		
//		sqlSession.delete("mapper.board.insertModNewImage", modAddimageFileList );
		sqlSession.insert("mapper.board.review.insertModNewImage", modAddimageFileList );
		
	}

	
	
	
}
