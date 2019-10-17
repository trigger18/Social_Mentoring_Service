package com.mycompany.sms.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mycompany.sms.dto.MeetingDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.PageDTO;

@Repository
public class MeetingDaoImg implements MeetingDAO {
	private SqlSessionTemplate sqlSession;

	public MeetingDaoImg() {

	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void meetingInsertProcess(MeetingDTO dto) {
		sqlSession.insert("mt.ins_meeting", dto);

	}

	@Override
	public MeetingDTO meeting_info(int dto) {
		return sqlSession.selectOne("mt.select_meeting", dto);
	}

	@Override
	public MentorDTO mentor_infor(MeetingDTO dto) {
		return sqlSession.selectOne("mt.select_mentor", dto);
	}

	@Override
	public List<MeetingDTO> mainmeetingList(PageDTO pv) {
		return sqlSession.selectList("mt.list", pv);
	}

	@Override
	public int getMentorNumMethod(String str) {
		return sqlSession.selectOne("mt.mentorNum", str);
	}

	@Override
	public String mentor_id(int str) {
		return sqlSession.selectOne("mt.meuser", str);
	}

	@Override
	public int login_user(String str) {
		return sqlSession.selectOne("mt.login_user", str);
	}

	@Override
	public int count() {
		return sqlSession.selectOne("mt.count");
	}

	@Override
	public void update(MeetingDTO dto) {
		sqlSession.update("mt.update", dto);

	}

	@Override
	public void delete(int meeting_num) {
		sqlSession.delete("mt.delete", meeting_num);
	}

	@Override
	public String getFile(int meeting_num) {
		return sqlSession.selectOne("mt.uploadFile", meeting_num);
	}

	@Override
	public void meeting_apply(HashMap<String, Object> hash) {
		sqlSession.insert("mt.meetin_cnt", hash);

	}

	@Override
	public int meeting_count(int meeting_num) {
		return sqlSession.selectOne("mt.registered", meeting_num);
	}

	@Override
	public int memberCheckMethod(HashMap<String, Object> hash) {
		return sqlSession.selectOne("mt.member_check", hash);
	}

	@Override
	public void memeberCancel(String str) {

		sqlSession.delete("mt.member_cancel", str);
	}

	@Override
	public List<MeetingDTO> meeting_list() {
		return sqlSession.selectList("mt.meeting_list");
	}

	// for mypage 멘티
	@Override
	public List<Integer> forMyPage(String user_id) {

		return sqlSession.selectList("mt.forMyPage", user_id);
	}

	// for mypage 멘토
	@Override
	public List<MeetingDTO> forMyPage2(Integer mentor_num) {

		return sqlSession.selectList("mt.forMyPage2", mentor_num);
	}

	@Override
	public int memberCheckList(int hash) {
		return sqlSession.selectOne("mt.membercheck_List", hash);
	}

}// end class
