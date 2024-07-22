package com.bookshop01.board.review.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("reviewArticleVO")
public class reviewArticleVO {
	
	private int articleNO;
	private String content;
	private String imageFileName;
	private String member_id;
	private String goods_id;
	private Date  writeDate;
	private int groupNO;
	
	private int rnum;

	public String getMember_id() {
		return member_id;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}

	public reviewArticleVO( int articleNO, String content, String imageFileName, String member_id,
			String goods_id, Date writeDate, int groupNO) {
		super();
		
		this.articleNO = articleNO;
		this.content = content;
		this.imageFileName = imageFileName;
		this.member_id = member_id;
		this.goods_id = goods_id;
		this.writeDate = writeDate;
		this.groupNO = groupNO;
	}

	public int getGroupNO() {
		return groupNO;
	}

	public void setGroupNO(int groupNO) {
		this.groupNO = groupNO;
	}

	
	
	
	
	public reviewArticleVO() {
		System.out.println("reviewArticleVO ������");
	}

	public int getArticleNO() {
		return articleNO;
	}

	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
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
	
	

	

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}


	
	
}
