package com.mycompany.sms.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mycompany.sms.dto.UserDTO;

@Repository
public class UserDaoImp implements UserDAO {

	private SqlSessionTemplate sqlSession;

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void userInsertMethod(UserDTO dto) {
		sqlSession.insert("userInput.uInput", dto);
	}

	@Override
	public void userSettingUploadMethod(UserDTO dto) {
		sqlSession.update("userInput.uUpdate", dto);
	}

	@Override
	public String userSelectfile(UserDTO dto) {
		return sqlSession.selectOne("userInput.uSelectFile", dto);

	}

	@Override
	public UserDTO userInfoMethod(String user_id) {
		return sqlSession.selectOne("userInput.uUserInfo", user_id);
	}

	@Override
	public int userCheckMethod(UserDTO dto) {
		return sqlSession.selectOne("userInput.uCheck", dto);
	}

	@Override
	public void userQuitSMSProcess(String user_id) {
		sqlSession.delete("userInput.uQuit", user_id);
	}

	@Override
	public int uCheck2(String email) {
		return sqlSession.selectOne("userInput.uCheck2", email);
	}

	@Override
	public void userQuitSMSProcess2(String user_id) {
		sqlSession.delete("userInput.uQuit2", user_id);
	}

}
