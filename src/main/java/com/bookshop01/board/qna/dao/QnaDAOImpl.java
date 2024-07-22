package com.bookshop01.board.qna.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop01.board.qna.vo.QnaArticleVO;
import com.bookshop01.board.qna.vo.qnaImageVO;


@Repository("qnaDAO")
public class QnaDAOImpl implements QnaDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectAllArticlesList(Map pagingMap) throws DataAccessException {
		List<QnaArticleVO> articlesList  = sqlSession.selectList("mapper.board.qna.selectAllArticlesList", pagingMap);
		return articlesList;
	}
	
	@Override
	public int selectTotArticles() throws DataAccessException {
		int totArticles = sqlSession.selectOne("mapper.board.qna.selectTotArticles");
		return totArticles;
	}

	
		
	@Override
	public int insertNewArticle(Map articleMap) throws DataAccessException {
		int groupNO  = selectNewGroupNO(); 
		articleMap.put("groupNO", groupNO);
		int articleNO = selectNewArticleNO();
		articleMap.put("articleNO", articleNO);
		sqlSession.insert("mapper.board.qna.insertNewArticle",articleMap);
		return articleNO;
	}
	
	@Override
	public int insertReplyArticle(Map articleMap) throws DataAccessException {
		int articleNO = selectNewArticleNO();
		articleMap.put("articleNO", articleNO);
		sqlSession.insert("mapper.board.qna.insertReplyArticle",articleMap);
		return articleNO;
	}
	
	//���� ���� ���ε�
		@Override
		public void insertNewImage(Map articleMap) throws DataAccessException {
			List<qnaImageVO> imageFileList = (ArrayList)articleMap.get("imageFileList");
			int articleNO = (Integer)articleMap.get("articleNO");
			int imageFileNO = selectNewImageFileNO();
			
			if(imageFileList != null && imageFileList.size() != 0) {
				for(qnaImageVO imageVO : imageFileList){
					imageVO.setImageFileNO(++imageFileNO);
					imageVO.setArticleNO(articleNO);
				}
				sqlSession.insert("mapper.board.qna.insertNewImage",imageFileList);
			}
			
		}
		
	
	@Override
	public int selectNewGroupNO() throws DataAccessException {
			int maxGroupNO = sqlSession.selectOne("mapper.board.qna.selectNewGroupNO");
			return maxGroupNO;
	}
    
	
	
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
	public QnaArticleVO selectArticle(int articleNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.board.qna.selectArticle", articleNO);
	}
		
	@Override
	public void updateArticle(Map articleMap) throws DataAccessException {
		sqlSession.update("mapper.board.qna.updateArticle", articleMap);
	}
	
	@Override
	public void updateImageFile(Map articleMap) throws DataAccessException {
		
		List<qnaImageVO> imageFileList = (ArrayList)articleMap.get("imageFileList");
		int articleNO = Integer.parseInt((String)articleMap.get("articleNO"));
		
		for(int i = imageFileList.size()-1; i >= 0; i--){
			qnaImageVO imageVO = imageFileList.get(i);
			String imageFileName = imageVO.getImageFileName();
			if(imageFileName == null) {  //������ �̹����� �������� �ʴ� ��� ���ϸ��� null �̹Ƿ�  ������ �ʿ䰡 ����.
				imageFileList.remove(i);
			}else {
				imageVO.setArticleNO(articleNO);
			}
		}
		
		if(imageFileList != null && imageFileList.size() != 0) {
			sqlSession.update("mapper.board.qna.updateImageFile", imageFileList);
		}
		
	}

	
	

	@Override
	public void deleteArticle(int articleNO) throws DataAccessException {
		sqlSession.delete("mapper.board.qna.deleteArticle", articleNO);
		
	}
	
	@Override
	public List selectImageFileList(int articleNO) throws DataAccessException {
		List<qnaImageVO> imageFileList = null;
		imageFileList = sqlSession.selectList("mapper.board.qna.selectImageFileList",articleNO);
		return imageFileList;
	}
	
	

	@Override
	public void updateViewCounts(int articleNO) throws DataAccessException {
		sqlSession.update("mapper.board.qna.updateViewCounts", articleNO);
	}

	private int selectNewArticleNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.qna.selectNewArticleNO");
	}
	
	private int selectNewImageFileNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.qna.selectNewImageFileNO");
	}


	@Override
	public void deleteModImage(qnaImageVO imageVO) throws DataAccessException {
		sqlSession.delete("mapper.board.qna.deleteModImage", imageVO );
		
	}


	@Override
	public void insertModNewImage(Map articleMap) throws DataAccessException {
		List<qnaImageVO> modAddimageFileList = (ArrayList<qnaImageVO>)articleMap.get("modAddimageFileList");
		int articleNO = Integer.parseInt((String)articleMap.get("articleNO"));
		
		int imageFileNO = selectNewImageFileNO();
		
		for(qnaImageVO imageVO : modAddimageFileList){
			imageVO.setArticleNO(articleNO);
			imageVO.setImageFileNO(++imageFileNO);
		}
		
//		sqlSession.delete("mapper.board.insertModNewImage", modAddimageFileList );
		sqlSession.insert("mapper.board.qna.insertModNewImage", modAddimageFileList );
		
	}

	
	
	
}
