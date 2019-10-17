package com.mycompany.sms.service;

import com.mycompany.sms.dto.UserDTO;

public interface UserService {
	public UserDTO userInfoMethod(String user_id);
	public void userInsertServiceMethod(UserDTO dto);
	public void userSettingUploadServiceMethod(UserDTO dto);
	public String userSelectFile(UserDTO dto);
	public int userCheckMethod(UserDTO dto);
	public void userQuitSMSProcess(String user_id);
	public void userQuitSMSProcess2(String user_id);
	public int uCheck2(String email);
	
}
