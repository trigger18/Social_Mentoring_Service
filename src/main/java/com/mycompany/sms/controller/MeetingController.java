package com.mycompany.sms.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.sms.dto.MeetingDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.PageDTO;
import com.mycompany.sms.dto.UserDTO;
import com.mycompany.sms.service.MeetingService;
import com.mycompany.sms.service.UserService;
import com.mycompany.sms.service.WannaService;

@Controller
public class MeetingController {
	private int currentPage;
	private PageDTO pdto;
	@Autowired
	private MeetingService service;

	@Autowired
	private UserService uservice;

	@Autowired
	private WannaService wservice;

	public MeetingController() {

	}

	public void setService(MeetingService service) {
		this.service = service;
	}

	@RequestMapping(value = "/detail.do", method = RequestMethod.GET)
	public ModelAndView main(ModelAndView mav, HttpSession session, MeetingDTO dto, int meeting_num) {
		String user_id = null;
		HashMap<String, Object> hash = new HashMap<>();
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod(user_id);
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("userDTO", udto);
			mav.addObject("mCheck", mCheck);
			hash.put("meeting_num", meeting_num);
			hash.put("user_Id", user_id);
			// 신청했는지안했는지 확인하는 메소드
			mav.addObject("memberCheck", service.memberCheckMethod(hash));
			// 모임신청인원 카운트
			mav.addObject("count_num", service.meeting_count(meeting_num));
			// 모임글을쓴 맨토의 아이디값
			mav.addObject("mentor_id", service.mentor_id(service.meeting_info(meeting_num).getMentor_num()));
			// 로그인한 유저 아이디값
			mav.addObject("user_Id", user_id);
			// 글을쓴 멘토의 모임데이터값
			mav.addObject("meeting", service.meeting_info(meeting_num));
			// 글을쓴 멘토의 정보값
			mav.addObject("mentor", service.mentor_infor(service.meeting_info(meeting_num)));
			mav.setViewName("meeting_detail");
			return mav;
		} else {
			mav.addObject("count_num", service.meeting_count(meeting_num));
			// 모임글을쓴 맨토의 아이디값
			mav.addObject("mentor_id", service.mentor_id(service.meeting_info(meeting_num).getMentor_num()));
			// 글을쓴 멘토의 모임데이터값
			mav.addObject("meeting", service.meeting_info(meeting_num));
			// 글을쓴 멘토의 정보값
			mav.addObject("mentor", service.mentor_infor(service.meeting_info(meeting_num)));
			mav.setViewName("meeting_detail");
			return mav;
		}

	}

	@RequestMapping("/list.do")
	public ModelAndView mettinglist(ModelAndView mav, HttpSession session, PageDTO pv) {
		String user_id = null;
		List<MeetingDTO> membercheck = new ArrayList<MeetingDTO>();
		int totalRecord = service.countProcess();
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod(user_id);
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("userDTO", udto);
			mav.addObject("mCheck", mCheck);
			if (service.login_user(user_id) > 0) {
				mav.addObject("user", service.login_user(user_id));
			}
		}
		;

		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0) {
				currentPage = 1;
			} else {
				currentPage = pv.getCurrentPage();
			}
			pdto = new PageDTO(currentPage, totalRecord);
			mav.addObject("pv", pdto);
		}
		membercheck = service.mainmeetingList(pdto);

		for (int i = 0; i < membercheck.size(); i++) {
			// 모집 가득참 확인
			int max = (membercheck.get(i).getMeeting_recruitment()
					- service.memberCheckList(membercheck.get(i).getMeeting_num()));
			// max = 0 가득참 양수일땐 모집중
			if (max == 0) {
				membercheck.get(i).setMemberCheck(0);
			} else
				membercheck.get(i).setMemberCheck(1);
		}
		mav.addObject("meetingList", membercheck);
		mav.setViewName("meeting_list");
		return mav;
	}

	@RequestMapping(value = "/write.do", method = RequestMethod.GET) // 리스트에서 글쓰기로 넘어감
	public ModelAndView meetingWriteProcess(ModelAndView mav, HttpSession session) {
		String date = null;
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod(user_id);
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("userDTO", udto);
			mav.addObject("mCheck", mCheck);
		}
		mav.setViewName("meeting_write");
		return mav;
	}

	@RequestMapping(value = "/write.do", method = RequestMethod.POST) // write 글쓰기 컨트롤
	public String meetingInsert(HttpServletRequest request, MeetingDTO dto, HttpSession session) {
		String date = null;
		MultipartFile file = dto.getMeeting_file();
		if (!file.isEmpty()) {
			UUID random = saveCopyfile(file, request);
			dto.setMeeting_img_name(random + "_" + file.getOriginalFilename());
		}
		String user_id = (String) session.getAttribute("user_id");
		int mentor_num = service.getMentorNumMethod(user_id);
		dto.setMentor_num(mentor_num);
		date = dto.getMeeting_date().replace("-", ". ").replace("T", " | ");
		dto.setMeeting_date(date);
		service.meetingInsertProcess(dto);
		return "redirect:/list.do";
	}

	@RequestMapping(value = "/meeting_update.do", method = RequestMethod.GET)
	public ModelAndView meetingUpdate(ModelAndView mav, HttpSession session, int meeting_num) {
		String date = null;
		// 글을쓴 멘토의 모임데이터값
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod(user_id);
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("userDTO", udto);
			mav.addObject("mCheck", mCheck);
		}
		MeetingDTO dto = service.meeting_info(meeting_num);
		date = dto.getMeeting_date().replace(". ", "-").replace(" | ", "T");
		dto.setMeeting_date(date);
		mav.addObject("meeting", dto);
		mav.setViewName("meeting_update");
		return mav;
	}

	@RequestMapping(value = "/meeting_update.do", method = RequestMethod.POST)
	public ModelAndView meetingUpdateLi(ModelAndView mav, MeetingDTO dto, HttpServletRequest request) {
		String filename = service.fileSelectprocess(dto.getMeeting_num());
		String date = null;
		String root = request.getSession().getServletContext().getRealPath("/");
		String saveDirectory = root + "temp" + File.separator;
		// 수정할 첨부파일
		MultipartFile file = dto.getMeeting_file();
		// 수정한 첨부파일이 있으면
		if (!file.isEmpty()) {
			// 기존 첨부파일이 있으면....
			if (filename != null) {
				File fe = new File(saveDirectory, filename);
				fe.delete();
			}
			UUID random = saveCopyfile(file, request);

			dto.setMeeting_img_name(random + "_" + file.getOriginalFilename());

		}
		date = dto.getMeeting_date().replace("-", ". ").replace("T", " | ");
		dto.setMeeting_date(date);
		service.update(dto);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("redirect:/list.do");
		return mav;

	}

	@RequestMapping("/meeting_delete.do")
	public String meetingdelete(int meeting_num, HttpServletRequest request, ModelAndView mav) {
		String upload = service.fileSelectprocess(meeting_num);
		if (upload != null) {
			String root = request.getSession().getServletContext().getRealPath("/");
			String saveDirectory = root + "_" + File.separator;
			File fe = new File(saveDirectory, upload);
			fe.delete();
		}
		service.delete(meeting_num);
		return "redirect:/list.do";
	}

	@RequestMapping("/meeting_cnt.do")
	public ModelAndView meetingCnt(String user_Id, int meeting_num, ModelAndView mav) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_Id", user_Id);
		map.put("meeting_num", meeting_num);
		service.meeting_apply(map);
		mav.addObject("meeting_num", meeting_num);
		mav.setViewName("redirect:/detail.do");
		return mav;
	}

	@RequestMapping("/meeting_cancel.do")
	public ModelAndView meetingCancle(String user_Id, int meeting_num, ModelAndView mav) {
		service.memeberCancel(user_Id);
		mav.addObject("meeting_num", meeting_num);
		mav.setViewName("redirect:/detail.do");
		return mav;
	}

	public UUID saveCopyfile(MultipartFile file, HttpServletRequest request) {
		String fileName = file.getOriginalFilename();
		// 중복파일명을 처리하기 위해 난수 발생
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
	}// end saveCopyFile()////////////////////////////

}// end class
