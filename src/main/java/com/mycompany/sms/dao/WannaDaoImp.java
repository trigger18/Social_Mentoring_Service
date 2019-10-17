package com.mycompany.sms.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFieldDTO;
import com.mycompany.sms.dto.MentorFollowDTO;

@Repository
public class WannaDaoImp implements WannaDAO {
	private SqlSessionTemplate sqlSession;

	public WannaDaoImp() {

	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void save(MentorDTO dto) {
		sqlSession.insert("wannabe.save", dto);
	}

	@Override
	public void fieldInsertMethod(MentorFieldDTO dto) {
		sqlSession.insert("wannabe.field_insert", dto);
	}

	@Override
	public int getMentorNumMethod() {
		return sqlSession.selectOne("wannabe.get_mentor_num");
	}

	@Override
	public void mentorInsertMethod(MentorFollowDTO dto) {
		sqlSession.insert("wannabe.mentor_insert", dto);
	}

	@Override
	public int mentorCheckMethod(String user_id) {
		return sqlSession.selectOne("wannabe.mentor_check", user_id);
	}

	@Override
	public void updateMentorPicMethod(MentorDTO dto) {
		sqlSession.update("wannabe.mentorPicUpdate", dto);
	}

	@Override
	public void updateMentorMethod(MentorDTO dto) {
		sqlSession.update("wannabe.mentor_update", dto);
	}

	@Override
	public MentorDTO getMentorinfoMethod(String user_id) {
		return sqlSession.selectOne("wannabe.getMentor_info", user_id);
	}

	@Override
	public void deletFieldMethod(int mentor_num) {
		sqlSession.delete("wannabe.field_delete", mentor_num);
	}

}// end class
