package com.mycompany.sms.dao;

import com.mycompany.sms.dto.UserDTO;

public interface UserDAO {
	public UserDTO userInfoMethod(String user_id);
	public void userInsertMethod(UserDTO dto);
	public void userSettingUploadMethod(UserDTO dto);
	public String userSelectfile(UserDTO dto);
	public int userCheckMethod(UserDTO dto);
	public void userQuitSMSProcess(String user_id);
	public void userQuitSMSProcess2(String user_id);
	public int uCheck2(String email);
	
}
