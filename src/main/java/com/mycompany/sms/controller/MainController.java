package com.mycompany.sms.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.sms.dto.BestFollow;
import com.mycompany.sms.dto.MeetingDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.UserDTO;
import com.mycompany.sms.service.EssayService;
import com.mycompany.sms.service.MeetingService;
import com.mycompany.sms.service.MentorService;
import com.mycompany.sms.service.UserService;
import com.mycompany.sms.service.WannaService;

//http://localhost:8090/sms/home.do

@Controller
public class MainController {

	@Autowired
	private UserService service;

	@Autowired
	private WannaService wservice;

	@Autowired
	private MentorService mentorservice;

	@Autowired
	private MeetingService meetingservice;

	@Autowired
	private EssayService eservice;

	public void setService(UserService service) {
		this.service = service;
	}

	public MainController() {
	}

	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public ModelAndView homeGetProcess(HttpSession session, ModelAndView mav, HttpServletRequest req, String user_id) {
		user_id = (String) session.getAttribute("user_id");

		if (req.getParameter("loginSuccess") != null) {
			int apiLoginSuccess = Integer.parseInt(req.getParameter("loginSuccess"));
			mav.addObject("loginSuccess", apiLoginSuccess);
		}

		if (user_id != null) {
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
			mav.addObject("userDTO", service.userInfoMethod((String) session.getAttribute("user_id")));
			// my 팔로워------------------------------------------------------------------
			List<MentorFollowDTO> mfList = new ArrayList<MentorFollowDTO>();
			mfList = mentorservice.myfollowProcess(user_id);
			List<MentorDTO> mmList = new ArrayList<MentorDTO>();
			for (int i = 0; i < mfList.size(); i++) {
				MentorDTO mdto = new MentorDTO();
				mdto = mentorservice.viewProcess(mfList.get(i).getMentor_num());
				mmList.add(mdto);
			}
			mav.addObject("mymentorInfo", mmList);
			// my 팔로워--------------------------------------------------------
		}
		// best 팔로워-----------------------------------------------------------
		List<BestFollow> bflist = new ArrayList<BestFollow>();
		bflist = mentorservice.getBestFollowProcess();// 저장
		List<MentorDTO> mList = new ArrayList<MentorDTO>();
		for (int i = 0; i < bflist.size(); i++) {
			MentorDTO mdto = new MentorDTO();
			mdto = mentorservice.viewProcess(bflist.get(i).getMentor_num());
			mdto.setFollow_num(bflist.get(i).getFollow_count());
			mList.add(mdto);
		}
		// best 팔로워-----------------------------------------------------------
		// 최근 개설모임----------------------------------------------------------
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
			UserDTO udto = new UserDTO();
			udto = service.userInfoMethod(user_id);
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("userDTO", udto);
			mav.addObject("mCheck", mCheck);
			if (meetingservice.login_user(user_id) > 0) {
				mav.addObject("user", meetingservice.login_user(user_id));
			}
		}
		List<MeetingDTO> membercheck = new ArrayList<MeetingDTO>();
		
		membercheck = meetingservice.meeting_listProcess();

		for (int i = 0; i < membercheck.size(); i++) {
			// 모집 가득참 확인
			int max = (membercheck.get(i).getMeeting_recruitment()
					- meetingservice.memberCheckList(membercheck.get(i).getMeeting_num()));
			// max = 0 가득참 양수일땐 모집중
			if (max == 0) {
				membercheck.get(i).setMemberCheck(0);
			} else
				membercheck.get(i).setMemberCheck(1);
		}
		mav.addObject("meetingList", membercheck);
		mav.addObject("mm", membercheck);
		mav.addObject("mentorInfo", mList);
		// 최근 개설모임----------------------------------------------
		// 에세이------------------------------------------------------
		mav.addObject("main_list", eservice.mainEssayProcess());
		// 에세이---------------------------------------------------------
		mav.setViewName("home");
		return mav;
	}

	@RequestMapping(value = "/home.do", method = RequestMethod.POST)
	public ModelAndView indexProcess(UserDTO dto, ModelAndView mav, HttpSession session, HttpServletRequest req) {
		if (service.userCheckMethod(dto) != 0) {
			session.setAttribute("user_id", service.userInfoMethod(dto.getUser_id()).getUser_id());
			mav.addObject("userDTO", service.userInfoMethod(dto.getUser_id()));
			mav.addObject("mCheck", wservice.getMentorCheckMethod((String) session.getAttribute("user_id")));
			session.setAttribute("user_id", dto.getUser_id());

			String user_id = dto.getUser_id();
			mav.addObject("loginSuccess", 1);
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
			mav.addObject("userDTO", service.userInfoMethod((String) session.getAttribute("user_id")));
			// -------------------------my follower
			List<MentorFollowDTO> mfList = new ArrayList<MentorFollowDTO>();
			mfList = mentorservice.myfollowProcess(user_id);
			List<MentorDTO> mmList = new ArrayList<MentorDTO>();
			for (int i = 0; i < mfList.size(); i++) {
				MentorDTO mdto = new MentorDTO();
				mdto = mentorservice.viewProcess(mfList.get(i).getMentor_num());
				mmList.add(mdto);
			}
			mav.addObject("mymentorInfo", mmList);

			List<BestFollow> bflist = new ArrayList<BestFollow>();
			bflist = mentorservice.getBestFollowProcess();// 저장
			List<MentorDTO> mList = new ArrayList<MentorDTO>();
			for (int i = 0; i < bflist.size(); i++) {
				MentorDTO mdto = new MentorDTO();
				mdto = mentorservice.viewProcess(bflist.get(i).getMentor_num());
				mdto.setFollow_num(bflist.get(i).getFollow_count());
				mList.add(mdto);
			}
			// best 팔로워----------------------------------------
			// --------- start recent meeting list----------------
			if (session.getAttribute("user_id") != null) {
				user_id = (String) session.getAttribute("user_id");
				UserDTO udto = new UserDTO();
				udto = service.userInfoMethod(user_id);

				mav.addObject("userDTO", udto);
				mav.addObject("mCheck", mCheck);
				if (meetingservice.login_user(user_id) > 0) {
					mav.addObject("user", meetingservice.login_user(user_id));
				}
			}
			mav.addObject("mm", meetingservice.meeting_listProcess());

			mav.addObject("mentorInfo", mList);
			// -------------------end recent meeting list ------------------
			// ------------------start essay -----------------------
			mav.addObject("main_list", eservice.mainEssayProcess());
			// ------------------end essay----------------
			mav.setViewName("home");
		} else {
			int noUser = 1;
			mav.addObject("noUser", noUser);
			session.invalidate();
			mav.setViewName("log");
		}

		return mav;
	}

	@RequestMapping("/about.do")
	public ModelAndView aboutProcess(HttpSession session, ModelAndView mav) {
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			UserDTO udto = new UserDTO();
			int mCheck = wservice.getMentorCheckMethod(user_id);
			udto = service.userInfoMethod(user_id);
			mav.addObject("userDTO", udto);
			mav.addObject("mCheck", mCheck);
		}
		mav.setViewName("about");
		return mav;
	}

	// 탈퇴 했을때-------------------------------------------------------------------
	@RequestMapping("/quitSMS.do")
	public ModelAndView quitSMSProcess(HttpSession session, ModelAndView mav) {
		String user_id = (String) session.getAttribute("user_id");
		service.userQuitSMSProcess(user_id);
		service.userQuitSMSProcess2(user_id);
		session.removeAttribute("user_id");
		session.invalidate();
		mav.setViewName("redirect:/home.do");
		return mav;
	}

	@RequestMapping(value = "/userProfile.do", method = RequestMethod.GET)
	public ModelAndView userProfileGetProcess(ModelAndView mav, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		UserDTO udto = new UserDTO();
		udto = service.userInfoMethod(user_id);
		int mCheck = wservice.getMentorCheckMethod(user_id);
		mav.addObject("mCheck", mCheck);
		mav.addObject("userDTO", udto);
		mav.setViewName("user_profile");
		return mav;
	}

	@RequestMapping(value = "/userSetting.do", method = RequestMethod.GET)
	public ModelAndView userSettingGetProcess(ModelAndView mav, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		UserDTO udto = new UserDTO();
		udto = service.userInfoMethod(user_id);
		int mCheck = wservice.getMentorCheckMethod(user_id);
		mav.addObject("mCheck", mCheck);
		mav.addObject("userDTO", udto);
		mav.setViewName("user_setting");
		return mav;
	}

	@RequestMapping(value = "/userSetting.do", method = RequestMethod.POST)
	public ModelAndView userSettingPostProcess(UserDTO dto, ModelAndView mav, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		UserDTO udto = new UserDTO();
		udto = service.userInfoMethod(user_id);
		int mCheck = wservice.getMentorCheckMethod(user_id);
		mav.addObject("mCheck", mCheck);
		mav.addObject("userDTO", udto);
		mav.setViewName("user_setting");
		return mav;
	}

	@RequestMapping(value = "/userInsert.do", method = RequestMethod.POST)
	public String userInsertMethod(UserDTO dto, HttpServletRequest request, HttpSession session) {
		session.setAttribute("user_id", dto.getUser_id());
		service.userInsertServiceMethod(dto);
		return "redirect:/home.do";
	}

	@RequestMapping(value = "/userUpdate.do", method = RequestMethod.POST)
	public ModelAndView userUpdateMethod(UserDTO dto, ModelAndView mav, HttpServletRequest request,
			HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");

		UserDTO udto = new UserDTO();
		MultipartFile file = dto.getUser_image_filename();
		// 기존 첨부파일
		String filename = service.userSelectFile(dto);
		String root = request.getSession().getServletContext().getRealPath("/");
		String saveDirectory = root + "temp" + File.separator;
		// 수정할 첨부파일

		if (!file.isEmpty()) {
			if (filename != null) {
				File fe = new File(saveDirectory, filename);
				fe.delete();
			}
			UUID random = saveCopyFile(file, request);
			dto.setUser_image(random + "_" + file.getOriginalFilename());
		}
		service.userSettingUploadServiceMethod(dto);
		udto = service.userInfoMethod(dto.getUser_id());

		MentorDTO mdto = new MentorDTO();
		mdto.setMentor_image(dto.getUser_image());
		mdto.setUser_id(user_id);
		wservice.updateMentorPicMethod(mdto);
		int mCheck = wservice.getMentorCheckMethod(user_id);
		mav.addObject("mCheck", mCheck);
		mav.addObject("userDTO", udto);
		mav.setViewName("user_profile");
		return mav;
	}

	public UUID saveCopyFile(MultipartFile file, HttpServletRequest request) {
		String fileName = file.getOriginalFilename();
		UUID random = UUID.randomUUID();
		String root = request.getSession().getServletContext().getRealPath("/");
		String saveDirectory = root + "temp" + File.separator;
		File fe = new File(saveDirectory);
		if (!fe.exists())
			fe.mkdir();
		File ff = new File(saveDirectory, random + "_" + fileName);
		try {
			FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return random;
	}// end saveCopyFile()/////////////////////////////

	@RequestMapping(value = "/signUp.do")
	public ModelAndView signUpProcess(ModelAndView mav) {
		mav.setViewName("sign");
		return mav;
	}

	// 마이
	// 페이지========================================================================
	@RequestMapping("/myPage.do")
	public ModelAndView myPage(HttpSession session, ModelAndView mav) {
		String user_id = (String) session.getAttribute("user_id");
		MentorDTO mentorDTO = mentorservice.checkMentor(user_id);
		// 여기부터
		// -------------------------my follower
		List<MentorFollowDTO> mfList = new ArrayList<MentorFollowDTO>();
		mfList = mentorservice.myfollowProcess(user_id);
		List<MentorDTO> mmList = new ArrayList<MentorDTO>();
		for (int i = 0; i < mfList.size(); i++) {
			MentorDTO mdto = new MentorDTO();
			mdto = mentorservice.viewProcess(mfList.get(i).getMentor_num());
			mmList.add(mdto);
		}
		mav.addObject("mymentorInfo", mmList);

		List<BestFollow> bflist = new ArrayList<BestFollow>();
		bflist = mentorservice.getBestFollowProcess();// 저장
		List<MentorDTO> mList = new ArrayList<MentorDTO>();
		int mCheck = wservice.getMentorCheckMethod(user_id);
		for (int i = 0; i < bflist.size(); i++) {
			MentorDTO mdto = new MentorDTO();
			mdto = mentorservice.viewProcess(bflist.get(i).getMentor_num());
			mdto.setFollow_num(bflist.get(i).getFollow_count());
			mList.add(mdto);
		}
		// 멘티
		if (mentorDTO == null) {
			mav.addObject("meetingInfoList", meetingservice.forMyPage(user_id));
			mav.addObject("mymentorInfo", mmList);
			mav.addObject("userDTO", service.userInfoMethod(user_id));
			mav.addObject("mCheck", mCheck);
			mav.setViewName("myPageMentor");

		} else {
			// 멘토
			int mentor_num = mentorDTO.getMentor_num();
			mav.addObject("meetingInfoList", meetingservice.forMyPage2(mentor_num));
			mav.addObject("eassayInfoList", eservice.myPageEssay(mentor_num));
			mav.addObject("mymentorInfo", mmList);
			mav.addObject("userDTO", service.userInfoMethod(user_id));
			mav.addObject("mCheck", mCheck);
			mav.setViewName("myPageMentor");
		}
		return mav;
	}
}// end MainController class
