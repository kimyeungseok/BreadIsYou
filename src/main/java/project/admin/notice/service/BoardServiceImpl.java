package project.admin.notice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import project.admin.notice.dao.BoardDAO;
import project.admin.notice.vo.ArticleVO;
import project.admin.notice.vo.ImageVO;


@Service("boardService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardServiceImpl  implements BoardService{
	@Autowired
	private BoardDAO boardDAO;
	
	public Map listArticles(Map pagingMap) throws Exception{
		Map articlesMap=new HashMap();
		List<ArticleVO> articlesList =  boardDAO.selectAllArticlesList(pagingMap);
		
		int totArticles = boardDAO.selectTotArticles();
		articlesMap.put("articlesList", articlesList);
		articlesMap.put("totArticles", totArticles);
		
		
        return articlesMap;
	}

	
	//���� �̹��� �߰��ϱ�
	@Override
	public int addNewArticle(Map articleMap) throws Exception{
		return boardDAO.insertNewArticle(articleMap);
	}
	
	 //���� �̹��� �߰��ϱ�
	/*
	@Override
	public int addNewArticle(Map articleMap) throws Exception{
		int articleNO = boardDAO.insertNewArticle(articleMap);
		articleMap.put("articleNO", articleNO);
		boardDAO.insertNewImage(articleMap);
		return articleNO;
	}
	*/
	/*
	//���� ���� ���̱�
	@Override
	public Map viewArticle(int articleNO) throws Exception {
		Map articleMap = new HashMap();
		ArticleVO articleVO = boardDAO.selectArticle(articleNO);
		List<ImageVO> imageFileList = boardDAO.selectImageFileList(articleNO);
		articleMap.put("article", articleVO);
		articleMap.put("imageFileList", imageFileList);
		return articleMap;
	}
   */
	
	
	 //���� ���� ���̱�
	@Override
	public Map viewArticle(Map viewMap,HttpSession session) throws Exception {
		Map articleMap = new HashMap();
		int articleNO = (Integer)viewMap.get("articleNO");
		 String id = (String) viewMap.get("member_id");
		ArticleVO articleVO = boardDAO.selectArticle(articleNO);
		String writerId = articleVO.getMember_id();
		 
		if (id == null || !(id.equals(writerId))) { // 로그인 아이디와 글쓴이 아이디가 같지 않으면 조회수를
		        if (session.getAttribute("viewedArticles") == null) {
		            session.setAttribute("viewedArticles", new HashMap<Integer, Boolean>());
		        }
		
		 Map<Integer, Boolean> viewedArticles = (Map<Integer, Boolean>) session.getAttribute("viewedArticles");
	        if (!viewedArticles.containsKey(articleNO) || !viewedArticles.get(articleNO)) { // 28 
	            boardDAO.updateViewCounts(articleNO);
	            articleVO = boardDAO.selectArticle(articleNO);
	            // 현재 조회한 글번호를 세션에 저장
	            viewedArticles.put(articleNO, true);//33
	            session.setAttribute("viewedArticles", viewedArticles); //23,44,33
	        }
	    }
	        List<ImageVO> imageFileList = boardDAO.selectImageFileList(articleNO);
		    articleMap.put("article", articleVO);
		    articleMap.put("imageFileList", imageFileList);
	    return articleMap;
	}
	
	
	@Override
	public void modArticle(Map articleMap) throws Exception {
		boardDAO.updateArticle(articleMap);
	}
	
	@Override
	public void removeArticle(int articleNO) throws Exception {
		boardDAO.deleteArticle(articleNO);
	}
	

	
}
