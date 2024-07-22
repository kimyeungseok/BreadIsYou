package com.bookshop01.board.qna.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("qnaArticleVO")
public class QnaArticleVO {
	private int  level;
	private int articleNO;
	private int parentNO;
	private String title;
	private String content;
	private String imageFileName;
	private String member_id;
	private Date  writeDate;
	private int viewCounts;
	private int groupNO;
	
	
	
	
	

	

	public QnaArticleVO(int level, int articleNO, int parentNO, String title, String content, String imageFileName,
			String member_id, Date writeDate, int viewCounts, int groupNO, String newArticle) {
		super();
		this.level = level;
		this.articleNO = articleNO;
		this.parentNO = parentNO;
		this.title = title;
		this.content = content;
		this.imageFileName = imageFileName;
		this.member_id = member_id;
		this.writeDate = writeDate;
		this.viewCounts = viewCounts;
		this.groupNO = groupNO;
		this.newArticle = newArticle;
	}

	public int getArticleNO() {
		return articleNO;
	}

	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}

	public int getGroupNO() {
		return groupNO;
	}

	public void setGroupNO(int groupNO) {
		this.groupNO = groupNO;
	}

	public void setViewCounts(int viewCounts) {
		this.viewCounts = viewCounts;
	}

	public int getViewCounts() {
		return viewCounts;
	}

	public void setViewCounst(int viewCounts) {
		this.viewCounts = viewCounts;
	}

	public String getNewArticle() {
		return newArticle;
	}

	public void setNewArticle(String newArticle) {
		this.newArticle = newArticle;
	}

	private String newArticle;
	
	
	
	public QnaArticleVO() {
		System.out.println("QnaArticleVO ������");
	}

	

	public int getParentNO() {
		return parentNO;
	}

	public void setParentNO(int parentNO) {
		this.parentNO = parentNO;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}


	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImageFileName() {
		try {
			if (imageFileName != null && imageFileName.length() != 0) {
				imageFileName = URLDecoder.decode(imageFileName, "UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		try {
			if(imageFileName!= null && imageFileName.length()!=0) {
				this.imageFileName = URLEncoder.encode(imageFileName,"UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	



	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}


	
	
}
