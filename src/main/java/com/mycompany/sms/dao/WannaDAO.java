package com.mycompany.sms.dao;

import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFieldDTO;
import com.mycompany.sms.dto.MentorFollowDTO;

public interface WannaDAO {	
	public void save(MentorDTO dto);
	
	public void fieldInsertMethod(MentorFieldDTO dto);

	public int getMentorNumMethod();
	
	public void mentorInsertMethod(MentorFollowDTO dto);
	
	public int mentorCheckMethod(String user_id);
	
	public void updateMentorPicMethod(MentorDTO dto);
	
	public void updateMentorMethod(MentorDTO dto);
	
	public MentorDTO getMentorinfoMethod(String user_id);
	
	public void deletFieldMethod(int mentor_num);
}// end WannaDAO
