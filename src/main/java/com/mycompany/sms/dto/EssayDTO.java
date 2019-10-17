package com.mycompany.sms.dto;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class EssayDTO {
	private int mentor_num;
	private int essay_num;
	private String essay_subject;
	private String essay_summary;
	private String essay_content;
	private String essay_date;
	private int essay_hit;
	private String essay_img;
	private MultipartFile filepath;
	
	
	public EssayDTO() {}

	public int getMentor_num() {
		return mentor_num;
	}
	
	public void setMentor_num(int mentor_num) {
		this.mentor_num = mentor_num;
	}
	
	public int getEssay_num() {
		return essay_num;
	}

	public void setEssay_num(int essay_num) {
		this.essay_num = essay_num;
	}

	public String getEssay_subject() {
		return essay_subject;
	}

	public void setEssay_subject(String essay_subject) {
		this.essay_subject = essay_subject;
	}
	
	public String getEssay_summary() {
		return essay_summary;
	}

	public void setEssay_summary(String essay_summary) {
		this.essay_summary = essay_summary;
	}

	public String getEssay_content() {
		return essay_content;
	}

	public void setEssay_content(String essay_content) {
		this.essay_content = essay_content;
	}


	public String getEssay_date() {
		return essay_date;
	}

	public void setEssay_date(String essay_date) {
		this.essay_date = essay_date;
	}

	public int getEssay_hit() {
		return essay_hit;
	}

	public void setEssay_hit(int essay_hit) {
		this.essay_hit = essay_hit;
	}
	
	public MultipartFile getFilepath() {
		return filepath;
	}

	public void setFilepath(MultipartFile filepath) {
		this.filepath = filepath;
	}

	public String getEssay_img() {
		return essay_img;
	}

	public void setEssay_img(String essay_img) {
		this.essay_img = essay_img;
	}

}// end class
