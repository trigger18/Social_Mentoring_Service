package com.mycompany.sms.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mycompany.sms.dto.AnswerDTO;
import com.mycompany.sms.dto.BestFollow;
import com.mycompany.sms.dto.FieldDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFieldDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.QuestionDTO;

@Repository
public class MentorDaoImp implements MentorDAO {
	private SqlSessionTemplate sqlSession;

	public MentorDaoImp() {

	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<MentorDTO> list() {
		return sqlSession.selectList("mentor.list");
	}

	@Override
	public List<MentorDTO> list(List<MentorFieldDTO> mflist) {
		return sqlSession.selectList("mentor.list2", mflist);
	}

	@Override
	public MentorDTO view(int num) {
		return sqlSession.selectOne("mentor.view", num);
	}

	@Override
	public List<FieldDTO> fieldview(int num) {
		return sqlSession.selectList("mentor.fieldlist", num);
	}

	@Override
	public List<MentorFieldDTO> fieldcheck(int field_num) {
		return sqlSession.selectList("mentor.fieldcheck", field_num);
	}

	@Override
	public void followupdate(MentorFollowDTO fdto) {
		sqlSession.insert("mentor.followupdate", fdto);
	}

	@Override
	public int followcheck(HashMap<String, Object> map) {
		return sqlSession.selectOne("mentor.followcheck", map);
	}

	@Override
	public void followdel(MentorFollowDTO fdto) {
		sqlSession.delete("mentor.followdel", fdto);
	}

	@Override
	public void questioninsert(QuestionDTO qdto) {
		sqlSession.insert("mentor.qsinsert", qdto);
	}

	@Override
	public List<QuestionDTO> questionlist(String user_id) {
		return sqlSession.selectList("mentor.qslist", user_id);
	}

	@Override
	public List<QuestionDTO> questionlist2(String user_id) {
		return sqlSession.selectList("mentor.qslist2", user_id);
	}

	@Override
	public QuestionDTO questionview(int question_num) {
		return sqlSession.selectOne("mentor.qsview", question_num);
	}

	@Override
	public List<AnswerDTO> answerlist(int question_num) {
		return sqlSession.selectList("mentor.aslist", question_num);
	}

	@Override
	public void answerinsert(AnswerDTO adto) {
		sqlSession.insert("mentor.asinsert", adto);
	}

	@Override
	public List<BestFollow> getBestFollowMethod() {
		return sqlSession.selectList("mentor.bestfollow");
	}

	@Override
	public List<MentorFollowDTO> myfollow(String user_id) {
		return sqlSession.selectList("mentor.myfollow", user_id);
	}

	@Override
	public MentorDTO checkMentor(String user_id) {

		return sqlSession.selectOne("mentor.chkMentor", user_id);
	}

	@Override
	public int mentorMemberCheck(int field_num) {
		return sqlSession.selectOne("mentor.fieldmembercheck", field_num);
	}

	@Override
	public int followercnt(int num) {
		return sqlSession.selectOne("mentor.follower", num);
	}

}// end class
