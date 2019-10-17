package com.mycompany.sms.service;

import java.util.List;

import com.mycompany.sms.dto.EssayDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.PageDTO;

public interface EssayService {
	public int countProcess();

	public List<EssayDTO> essayListProcess(PageDTO pv);
	public EssayDTO essayViewProcess(int essay_num);
	public void essayInsertProcess(EssayDTO dto);
	public String essayUpViImgProcess(int essay_num);
	public EssayDTO essayUpViewProcess(int essay_num);
	public void essayUpdateProcess(EssayDTO dto);
	public void essayDeleteProcess(int essay_num);
	public int checkMentorMethod(String user_id);
	public int getMentorNumMethod(String user_id);
	public MentorDTO getMentorInfo(int mentor_num);
	public int compareMentorAndUser(MentorDTO dto);
	public int getEssayNum();
	public MentorDTO getMentorInfoFromUserIdProcess(String user_id);
	public List<EssayDTO> mainEssayProcess();
	public List<EssayDTO> myPageEssay(Integer mentor_num); //for mypage

}// end interface
