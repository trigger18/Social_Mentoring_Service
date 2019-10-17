package com.mycompany.sms.service;
import java.util.HashMap;
import java.util.List;

import com.mycompany.sms.dto.AnswerDTO;
import com.mycompany.sms.dto.BestFollow;
import com.mycompany.sms.dto.FieldDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFieldDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.QuestionDTO;

public interface MentorService {
	public List<MentorDTO> listProcess();
	public List<MentorDTO> listProcess(List<MentorFieldDTO> mflist);
	public MentorDTO viewProcess(int num);
	public List<FieldDTO> fieldviewProcess(int num);
	public List<MentorFieldDTO> fieldcheckProcess(int field_num);
	public void followupdateProcess(MentorFollowDTO fdto);
	public int followcheckProcess(HashMap<String, Object> map);
	public void followdelProcess(MentorFollowDTO fdto);
	public void qsinsertProcess(QuestionDTO qdto);
	public List<QuestionDTO> qslistProcess(String user_id);
	public List<QuestionDTO> qslistProcess2(String user_id);
	public QuestionDTO qsviewProcess(int question_num);
	public List<AnswerDTO> aslistProcess(int question_num);
	public void asinsertProcess(AnswerDTO adto);
	public List<BestFollow> getBestFollowProcess();
	public List<MentorFollowDTO> myfollowProcess(String user_id);
	public MentorDTO checkMentor(String user_id); //for my page
	public int mentorMemberCheck(int field_num);
	public int followerCnt(int num);
}//end interface
