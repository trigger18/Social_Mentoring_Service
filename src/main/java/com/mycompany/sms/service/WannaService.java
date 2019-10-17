package com.mycompany.sms.service;

import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFieldDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.UserDTO;

public interface WannaService {
	public void insertProcess(MentorDTO dto);
	
	public void insertFieldMethod(MentorFieldDTO dto);
	
	public int getMentorNumMethod();
	
	public void InsertmentorMethod(MentorFollowDTO dto);
	
	public int getMentorCheckMethod(String user_id);
	
	public void updateMentorPicMethod(MentorDTO dto);
	
	public void updateMentorMethod(MentorDTO dto);
	
	public MentorDTO getMentorinfoMethod(String user_id);
	public void deletFieldMethod(int mentor_num);
}
