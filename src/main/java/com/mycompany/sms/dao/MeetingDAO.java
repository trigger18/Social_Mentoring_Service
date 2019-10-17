package com.mycompany.sms.dao;

import java.util.HashMap;
import java.util.List;


import com.mycompany.sms.dto.MeetingDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.PageDTO;

public interface MeetingDAO {

	public void meetingInsertProcess(MeetingDTO dto);

	public List<MeetingDTO> mainmeetingList(PageDTO pv);

	public MeetingDTO meeting_info(int dto);

	public MentorDTO mentor_infor(MeetingDTO dto);


	public int getMentorNumMethod(String str);

	public String mentor_id(int str);

	public int login_user(String str);
	
	public int count();
	
	public void update(MeetingDTO dto);

	public void delete(int meeting_num);
	
	public String getFile(int meeting_num);
	
	public void meeting_apply(HashMap<String, Object> hash);
	
	public int meeting_count(int meeting_num);
	
	public int memberCheckMethod(HashMap<String, Object> hash);

	public void memeberCancel(String str);
	
	public List<MeetingDTO> meeting_list();
	// for mypage 멘티
	public List<Integer> forMyPage(String user_id);
		
		// for mypage 멘토
	public List<MeetingDTO> forMyPage2(Integer meeting_num);
	
	public int memberCheckList(int hash);

}
