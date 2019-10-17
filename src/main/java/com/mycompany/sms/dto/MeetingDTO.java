package com.mycompany.sms.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MeetingDTO {
	private int meeting_num;// 모임번호
	private int mentor_num;// 멘토번호
	private int meeting_recruitment;// 모집인원
	private int meeting_price;// 모임참가비
	private String meeting_title; // 미팅제목
	private String meeting_comment;// 모임내용
	private String meeting_date; // 모임 날짜
	private String meeting_time; // 모임 시간
	private String meeting_introduction; // 모임 소개글
	private String meeting_place; // 모임 장소
	private String meeting_address; // 모임 주소
	private String meeting_img_name; // 모임 이미지패스
	private MultipartFile meeting_file; // 미팅 사진 파일
	private List<MentorDTO> mentorDTO;
	private int memberCheck;
	


	public MeetingDTO() {

	}
		





	public List<MentorDTO> getMentorDTO() {
		return mentorDTO;
	}




	public void setMentorDTO(List<MentorDTO> mentorDTO) {
		this.mentorDTO = mentorDTO;
	}
	
	


	public int getMemberCheck() {
		return memberCheck;
	}

	public void setMemberCheck(int memberCheck) {
		this.memberCheck = memberCheck;
	}

	public int getMeeting_num() {
		return meeting_num;
	}

	public void setMeeting_num(int meeting_num) {
		this.meeting_num = meeting_num;
	}

	public int getMentor_num() {
		return mentor_num;
	}

	public void setMentor_num(int mentor_num) {
		this.mentor_num = mentor_num;
	}

	public int getMeeting_recruitment() {
		return meeting_recruitment;
	}

	public void setMeeting_recruitment(int meeting_recruitment) {
		this.meeting_recruitment = meeting_recruitment;
	}

	public int getMeeting_price() {
		return meeting_price;
	}

	public void setMeeting_price(int meeting_price) {
		this.meeting_price = meeting_price;
	}

	public String getMeeting_title() {
		return meeting_title;
	}

	public void setMeeting_title(String meeting_title) {
		this.meeting_title = meeting_title;
	}

	public String getMeeting_comment() {
		return meeting_comment;
	}

	public void setMeeting_comment(String meeting_comment) {
		this.meeting_comment = meeting_comment;
	}

	public String getMeeting_date() {
		return meeting_date;
	}

	public void setMeeting_date(String meeting_date) {
		this.meeting_date = meeting_date;
	}

	public String getMeeting_introduction() {
		return meeting_introduction;
	}

	public void setMeeting_introduction(String meeting_introduction) {
		this.meeting_introduction = meeting_introduction;
	}

	public String getMeeting_place() {
		return meeting_place;
	}

	public void setMeeting_place(String meeting_place) {
		this.meeting_place = meeting_place;
	}

	public String getMeeting_address() {
		return meeting_address;
	}

	public void setMeeting_address(String meeting_address) {
		this.meeting_address = meeting_address;
	}

	public String getMeeting_img_name() {
		return meeting_img_name;
	}

	public void setMeeting_img_name(String meeting_img_name) {
		this.meeting_img_name = meeting_img_name;
	}

	public MultipartFile getMeeting_file() {
		return meeting_file;
	}

	public void setMeeting_file(MultipartFile meeting_file) {
		this.meeting_file = meeting_file;
	}

	public void setMeeting_time(String meeting_time) {
		this.meeting_time = meeting_time;
	}

	public String getMeeting_time() {
		return meeting_time;
	}

}// end class
