package com.mycompany.sms.dto;

import java.util.Date;

public class QuestionDTO {
	private int question_num, mentor_num;
	private String user_id, user_name, question_title, question_content;
	private Date question_date;
	
	public QuestionDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getQuestion_num() {
		return question_num;
	}

	public void setQuestion_num(int question_num) {
		this.question_num = question_num;
	}

	public int getMentor_num() {
		return mentor_num;
	}

	public void setMentor_num(int mentor_num) {
		this.mentor_num = mentor_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getQuestion_title() {
		return question_title;
	}

	public void setQuestion_title(String question_title) {
		this.question_title = question_title;
	}

	public String getQuestion_content() {
		return question_content;
	}

	public void setQuestion_content(String question_content) {
		this.question_content = question_content;
	}

	public Date getQuestion_date() {
		return question_date;
	}

	public void setQuestion_date(Date question_date) {
		this.question_date = question_date;
	}

}//end class
