package com.mycompany.sms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.sms.dao.UserDAO;
import com.mycompany.sms.dto.UserDTO;

@Service
public class UserServiceImp implements UserService {
	@Autowired
	private UserDAO userdao;

	public void setDao(UserDAO userdao) {
		this.userdao = userdao;
	}

	@Override
	public void userInsertServiceMethod(UserDTO dto) {
		userdao.userInsertMethod(dto);
	}

	@Override
	public void userSettingUploadServiceMethod(UserDTO dto) {
		userdao.userSettingUploadMethod(dto);
	}

	@Override
	public String userSelectFile(UserDTO dto) {
		return userdao.userSelectfile(dto);
	}

	@Override
	public UserDTO userInfoMethod(String user_id) {
		return userdao.userInfoMethod(user_id);
	}

	@Override
	public int userCheckMethod(UserDTO dto) {
		return userdao.userCheckMethod(dto);
	}

	@Override
	public void userQuitSMSProcess(String user_id) {
		userdao.userQuitSMSProcess(user_id);
	}

	@Override
	public int uCheck2(String email) {
		return userdao.uCheck2(email);
	}

	@Override
	public void userQuitSMSProcess2(String user_id) {
		userdao.userQuitSMSProcess2(user_id);
	}

}
