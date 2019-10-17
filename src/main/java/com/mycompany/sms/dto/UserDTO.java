package com.mycompany.sms.dto;

import org.springframework.web.multipart.MultipartFile;

public class UserDTO {
	private String user_id;
	private String user_name;
	private String user_pass;
	private String user_email;
	private String user_image;
	private String user_phone;
	
	private MultipartFile user_image_filename;
	
	public UserDTO() {
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

	public String getUser_pass() {
		return user_pass;
	}

	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_image() {
		return user_image;
	}

	public void setUser_image(String user_image) {
		this.user_image = user_image;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public MultipartFile getUser_image_filename() {
		return user_image_filename;
	}

	public void setUser_image_filename(MultipartFile user_image_filename) {
		this.user_image_filename = user_image_filename;
	}




}
