package com.mycompany.sms.dao;

import java.util.HashMap;
import java.util.List;

import com.mycompany.sms.dto.AnswerDTO;
import com.mycompany.sms.dto.BestFollow;
import com.mycompany.sms.dto.FieldDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFieldDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.QuestionDTO;

public interface MentorDAO {
	public List<MentorDTO> list();
	public List<MentorDTO> list(List<MentorFieldDTO> mflist);
	public MentorDTO view(int num);
	public List<FieldDTO> fieldview(int num);
	public List<MentorFieldDTO> fieldcheck(int field_num);
	public void followupdate(MentorFollowDTO fdto);
	public int followcheck(HashMap<String, Object> map);
	public void followdel(MentorFollowDTO fdto);
	public void questioninsert(QuestionDTO qdto);
	public List<QuestionDTO> questionlist(String user_id);
	public List<QuestionDTO> questionlist2(String user_id);
	public QuestionDTO questionview(int question_num);
	public List<AnswerDTO> answerlist(int question_num);
	public void answerinsert(AnswerDTO adto);
	public List<BestFollow> getBestFollowMethod();
	public List<MentorFollowDTO> myfollow(String user_id);
	public MentorDTO checkMentor(String user_id);//mypage
	public int mentorMemberCheck(int field_num);
	public int followercnt(int num);
}
