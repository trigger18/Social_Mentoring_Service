package com.mycompany.sms.dto;

import java.util.List;

public class MentorDTO {
	private int mentor_num, follow_num;
	private String mentor_name, mentor_co, mentor_dept, mentor_level, mentor_career, mentor_info, mentor_sub,
			mentor_image, user_id;

	public MentorDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getFollow_num() {
		return follow_num;
	}

	public void setFollow_num(int follow_num) {
		this.follow_num = follow_num;
	}

	public int getMentor_num() {
		return mentor_num;
	}

	public void setMentor_num(int mentor_num) {
		this.mentor_num = mentor_num;
	}

	public String getMentor_name() {
		return mentor_name;
	}

	public void setMentor_name(String mentor_name) {
		this.mentor_name = mentor_name;
	}

	public String getMentor_co() {
		return mentor_co;
	}

	public void setMentor_co(String mentor_co) {
		this.mentor_co = mentor_co;
	}

	public String getMentor_dept() {
		return mentor_dept;
	}

	public void setMentor_dept(String mentor_dept) {
		this.mentor_dept = mentor_dept;
	}

	public String getMentor_level() {
		return mentor_level;
	}

	public void setMentor_level(String mentor_level) {
		this.mentor_level = mentor_level;
	}

	public String getMentor_career() {
		return mentor_career;
	}

	public void setMentor_career(String mentor_career) {
		this.mentor_career = mentor_career;
	}

	public String getMentor_info() {
		return mentor_info;
	}

	public void setMentor_info(String mentor_info) {
		this.mentor_info = mentor_info;
	}

	public String getMentor_sub() {
		return mentor_sub;
	}

	public void setMentor_sub(String mentor_sub) {
		this.mentor_sub = mentor_sub;
	}

	public String getMentor_image() {
		return mentor_image;
	}

	public void setMentor_image(String mentor_image) {
		this.mentor_image = mentor_image;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

}// end class
