package com.mycompany.sms.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.sms.dao.MeetingDAO;
import com.mycompany.sms.dto.MeetingDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.PageDTO;

@Service
public class MeetingServiceImp implements MeetingService {
	@Autowired
	private MeetingDAO meetingdao;

	public void setMeetingDao(MeetingDAO meetingdao) {
		this.meetingdao = meetingdao;
	}

	@Override
	public void meetingInsertProcess(MeetingDTO dto) {
		meetingdao.meetingInsertProcess(dto);
	}

	@Override
	public MeetingDTO meeting_info(int dto) {
		return meetingdao.meeting_info(dto);
	}

	@Override
	public List<MeetingDTO> mainmeetingList(PageDTO pv) {
		return meetingdao.mainmeetingList(pv);
	}

	@Override
	public MentorDTO mentor_infor(MeetingDTO num) {
		return meetingdao.mentor_infor(num);
	}

	@Override
	public int getMentorNumMethod(String str) {
		return meetingdao.getMentorNumMethod(str);
	}

	@Override
	public String mentor_id(int str) {
		return meetingdao.mentor_id(str);
	}

	@Override
	public int login_user(String str) {
		return meetingdao.login_user(str);
	}

	@Override
	public int countProcess() {
		return meetingdao.count();
	}

	@Override
	public void update(MeetingDTO dto) {
		meetingdao.update(dto);
	}

	@Override
	public void delete(int meeting_num) {
		meetingdao.delete(meeting_num);

	}

	@Override
	public String fileSelectprocess(int meeting_num) {
		return meetingdao.getFile(meeting_num);
	}

	@Override
	public void meeting_apply(HashMap<String, Object> hash) {
		meetingdao.meeting_apply(hash);

	}

	@Override
	public int meeting_count(int meeting_num) {

		return meetingdao.meeting_count(meeting_num);
	}

	@Override
	public int memberCheckMethod(HashMap<String, Object> hash) {
		return meetingdao.memberCheckMethod(hash);
	}

	@Override
	public void memeberCancel(String str) {
		meetingdao.memeberCancel(str);

	}

	@Override
	public List<MeetingDTO> meeting_listProcess() {
		return meetingdao.meeting_list();
	}

	// mypage for 멘티 =============================
	// 첫번째 service =======================
	@Override
	public List<MeetingDTO> forMyPage(String user_id) {
		List<Integer> forMyPage = meetingdao.forMyPage(user_id);

		return myPage2(forMyPage);
	}

	private List<MeetingDTO> myPage2(List<Integer> meetingNums) {
		List<MeetingDTO> meetingDTO = new ArrayList<MeetingDTO>();
		for (Integer meetingNum : meetingNums) {
			meetingDTO.add(meetingdao.meeting_info(meetingNum));
		}
		return meetingDTO;
	}
	// for 멘토

	@Override
	public List<MeetingDTO> forMyPage2(Integer mentor_num) {

		return meetingdao.forMyPage2(mentor_num);
	}

	@Override
	public int memberCheckList(int hash) {

		return meetingdao.memberCheckList(hash);
	}

}
