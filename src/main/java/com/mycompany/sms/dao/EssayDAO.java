package com.mycompany.sms.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.mycompany.sms.dto.EssayDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.PageDTO;

@Repository
public interface EssayDAO {
	public int count();
	public List<EssayDTO> essayListMethod(PageDTO pv);
	public EssayDTO essayViewMethod(int essay_num);
	public void essayInsetMethod(EssayDTO dto); 
	public String essayUpViImgMethod(int essay_num);
	public EssayDTO essayUpViewMethod(int essay_num);
	public void essayUpdateMethod(EssayDTO dto);
	public void essayDeleteMethod(int essay_num);
	public int checkMentorMethod(String user_id);
	public int getMentorNumMethod(String user_id);
	public MentorDTO getMentorInfo(int mentor_num);
	public int compareMentorAndUser(MentorDTO dto);
	public int getEssayNum();
	public MentorDTO getMentorInfoFromUserIdMethod(String user_id);
	public List<EssayDTO> mainEssayProcess();
	public List<EssayDTO> myPageEssay(Integer mentor_num); //for mypage
	
}// end interface
