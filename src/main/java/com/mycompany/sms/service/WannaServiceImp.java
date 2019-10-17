package com.mycompany.sms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.sms.dao.WannaDAO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFieldDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.UserDTO;

@Service
public class WannaServiceImp implements WannaService {
	@Autowired
	private WannaDAO wannabedao;

	public WannaServiceImp() {

	}

	public void setDao(WannaDAO wannabedao) {
		this.wannabedao = wannabedao;
	}

	@Override
	public void insertProcess(MentorDTO dto) {
		wannabedao.save(dto);
	}

	@Override
	public void insertFieldMethod(MentorFieldDTO dto) {
		wannabedao.fieldInsertMethod(dto);
	}

	@Override
	public int getMentorNumMethod() {
		return wannabedao.getMentorNumMethod();
	}

	@Override
	public void InsertmentorMethod(MentorFollowDTO dto) {
		wannabedao.mentorInsertMethod(dto);
	}

	@Override
	public int getMentorCheckMethod(String user_id) {
		return wannabedao.mentorCheckMethod(user_id);

	}

	@Override
	public void updateMentorPicMethod(MentorDTO dto) {
		wannabedao.updateMentorPicMethod(dto);

	}

	@Override
	public void updateMentorMethod(MentorDTO dto) {
		wannabedao.updateMentorMethod(dto);
	}

	@Override
	public MentorDTO getMentorinfoMethod(String user_id) {
		return wannabedao.getMentorinfoMethod(user_id);
	}

	@Override
	public void deletFieldMethod(int mentor_num) {
		wannabedao.deletFieldMethod(mentor_num);
	}

}// end class
