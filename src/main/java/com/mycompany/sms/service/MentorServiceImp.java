package com.mycompany.sms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.sms.dao.MentorDAO;
import com.mycompany.sms.dto.AnswerDTO;
import com.mycompany.sms.dto.BestFollow;
import com.mycompany.sms.dto.FieldDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFieldDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.QuestionDTO;

@Service
public class MentorServiceImp implements MentorService {
	@Autowired
	private MentorDAO mentodao;

	public MentorServiceImp() {

	}

	public void setMentodao(MentorDAO mentodao) {
		this.mentodao = mentodao;
	}

	@Override
	public List<MentorDTO> listProcess() {
		return mentodao.list();
	}

	@Override
	public List<MentorDTO> listProcess(List<MentorFieldDTO> mflist) {
		return mentodao.list(mflist);
	}

	@Override
	public MentorDTO viewProcess(int num) {
		return mentodao.view(num);
	}

	@Override
	public List<FieldDTO> fieldviewProcess(int num) {
		return mentodao.fieldview(num);
	}

	@Override
	public List<MentorFieldDTO> fieldcheckProcess(int field_num) {
		return mentodao.fieldcheck(field_num);
	}

	@Override
	public void followupdateProcess(MentorFollowDTO fdto) {
		mentodao.followupdate(fdto);
	}

	@Override
	public int followcheckProcess(HashMap<String, Object> map) {
		return mentodao.followcheck(map);
	}

	@Override
	public void followdelProcess(MentorFollowDTO fdto) {
		mentodao.followdel(fdto);
	}

	@Override
	public void qsinsertProcess(QuestionDTO qdto) {
		mentodao.questioninsert(qdto);
	}

	@Override
	public List<QuestionDTO> qslistProcess(String user_id) {
		return mentodao.questionlist(user_id);
	}

	@Override
	public List<QuestionDTO> qslistProcess2(String user_id) {
		return mentodao.questionlist2(user_id);
	}

	@Override
	public QuestionDTO qsviewProcess(int question_num) {
		return mentodao.questionview(question_num);
	}

	@Override
	public List<AnswerDTO> aslistProcess(int question_num) {
		return mentodao.answerlist(question_num);
	}

	@Override
	public void asinsertProcess(AnswerDTO adto) {
		mentodao.answerinsert(adto);
	}

	@Override
	public List<BestFollow> getBestFollowProcess() {
		return mentodao.getBestFollowMethod();
	}

	@Override
	public List<MentorFollowDTO> myfollowProcess(String user_id) {
		return mentodao.myfollow(user_id);
	}

	@Override
	public MentorDTO checkMentor(String user_id) {
		return mentodao.checkMentor(user_id);
	}

	@Override
	public int mentorMemberCheck(int field_num) {
		return mentodao.mentorMemberCheck(field_num);
	}

	@Override
	public int followerCnt(int num) {
		return mentodao.followercnt(num);
	}

}// end class
