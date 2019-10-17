package com.mycompany.sms.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mycompany.sms.dto.EssayDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.PageDTO;
@Repository
public class EssayDaoImp implements EssayDAO{

	private SqlSessionTemplate sqlSession;
	
	public EssayDaoImp() {}
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public int count() {
		return sqlSession.selectOne("essay.count");
	}

	@Override
	public List<EssayDTO> essayListMethod(PageDTO pv) {
		return sqlSession.selectList("essay.e_list", pv);
	}
	
	@Override
	public void essayInsetMethod(EssayDTO dto) {
		sqlSession.insert("essay.e_ins", dto);
	}
	
	@Override
	public  EssayDTO essayViewMethod(int essay_num) {
		return sqlSession.selectOne("essay.e_view", essay_num);
	}

	public String essayUpViImgMethod(int essay_num) {
		return sqlSession.selectOne("essay.e_img", essay_num);
	}
	
	@Override
	public EssayDTO essayUpViewMethod(int essay_num) {
		return sqlSession.selectOne("essay.e_view", essay_num);
	}
	
	@Override
	public void essayUpdateMethod(EssayDTO dto) {
		sqlSession.update("essay.e_update", dto);
	}

	@Override
	public void essayDeleteMethod(int essay_num) {
		sqlSession.selectOne("essay.e_del", essay_num);
		
	}

	@Override
	public int checkMentorMethod(String user_id) {
		return sqlSession.selectOne("essay.checkMentor", user_id);
	}

	@Override
	public int getMentorNumMethod(String user_id) {
		return sqlSession.selectOne("essay.getMentorNum", user_id);
	}

	@Override
	public MentorDTO getMentorInfo(int mentor_num) {
		return sqlSession.selectOne("essay.getMentorInfo", mentor_num);
	}

	@Override
	public int compareMentorAndUser(MentorDTO dto) {
		return sqlSession.selectOne("essay.compareMentorAndUser", dto);
	}

	@Override
	public int getEssayNum() {
		return sqlSession.selectOne("essay.getEssayNum");
	}

	@Override
	public MentorDTO getMentorInfoFromUserIdMethod(String user_id) {
		return sqlSession.selectOne("essay.getMentorInfoFromUserId", user_id);
	}

	@Override
	public List<EssayDTO> mainEssayProcess() {
		return sqlSession.selectList("essay.main_list");
	}

//	for mypage
	@Override
	public List<EssayDTO> myPageEssay(Integer mentor_num) {
		
		return sqlSession.selectList("essay.myPageEssay", mentor_num);
	}
	
	
}
