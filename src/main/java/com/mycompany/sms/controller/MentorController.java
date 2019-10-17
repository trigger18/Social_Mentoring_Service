package com.mycompany.sms.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.mycompany.sms.dto.AnswerDTO;
import com.mycompany.sms.dto.MentorFieldDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.QuestionDTO;
import com.mycompany.sms.dto.UserDTO;
import com.mycompany.sms.service.MentorService;
import com.mycompany.sms.service.UserService;
import com.mycompany.sms.service.WannaService;

//http://localhost:8090/sms/mentor_list.do

@Controller
public class MentorController {
	@Autowired
	private MentorService mservice;

	@Autowired
	private UserService uservice;

	@Autowired
	private WannaService wservice;

	public MentorController() {

	}

	public void setMservice(MentorService mservice) {
		this.mservice = mservice;
	}

	// 멘토 찾기 페이지
	@RequestMapping("/mentor_list.do")
	public ModelAndView listMethod(ModelAndView mav, HttpSession session, MentorFieldDTO mfdto) {
		if (session.getAttribute("user_id") != null) {
			UserDTO dto = new UserDTO();
			dto = uservice.userInfoMethod((String) session.getAttribute("user_id"));
			String user_id = (String) session.getAttribute("user_id");
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
			mav.addObject("userDTO", dto);
		}

		if (mfdto.getField_num() != 0) {
			if (mservice.mentorMemberCheck(mfdto.getField_num()) != 0) {
				List<MentorFieldDTO> mflist = mservice.fieldcheckProcess(mfdto.getField_num());
				mav.addObject("mentorList", mservice.listProcess(mflist));
			}
		} else {
			mav.addObject("mentorList", mservice.listProcess());
		}

		mav.setViewName("mentor_list");
		return mav;
	}// end listMethod()

	// 멘토 상세페이지
	@RequestMapping("/mentor_view.do")
	public ModelAndView viewMethod(int num, ModelAndView mav, HttpSession session) {
		// System.out.println("mento_num:"+num);
		if (session.getAttribute("user_id") != null) {
			UserDTO dto = new UserDTO();
			dto = uservice.userInfoMethod((String) session.getAttribute("user_id"));
			mav.addObject("userDTO", dto);
			String user_id = (String) session.getAttribute("user_id");
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
			mav.addObject("mentorView", mservice.viewProcess(num));
			mav.addObject("fieldDTO", mservice.fieldviewProcess(num));
			mav.addObject("cnt", (mservice.followerCnt(num) - 1));
			// 멘토 팔로우 여부 검색
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("user_id", session.getAttribute("user_id"));
			map.put("mentor_num", num);

			int check_num = mservice.followcheckProcess(map);
			mav.addObject("check_num", check_num);

			mav.setViewName("mentor_view");
		} else {
			mav.setViewName("redirect:/userLogin.do");
		}
		return mav;
	}// end viewMethod()

	// 멘토 팔로우
	@RequestMapping("/mentor_follow.do")
	public @ResponseBody String followUpdateMethod(ModelAndView mav, String mentor_num, String user_id,
			MentorFollowDTO fdto) {
		/* System.out.println("follow mentor_num:"+mentor_num); */
		fdto.setMentor_num(Integer.parseInt(mentor_num));
		fdto.setUser_id(user_id);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user_id);
		map.put("mentor_num", mentor_num);

		// 멘토 팔로우 여부 검색
		int check_num1 = mservice.followcheckProcess(map);

		// 팔로우 하고있지 않을 시 udpate, 팔로우하고 있을 시 delete
		if (check_num1 == 0) {
			mservice.followupdateProcess(fdto);
		} else
			mservice.followdelProcess(fdto);

		int check_num2 = mservice.followcheckProcess(map);
		int num = Integer.parseInt(mentor_num);
		int cnt2 = mservice.followerCnt(num) - 1;
		/* System.out.println("팔로워수 :" + cnt2); */
		// ajax로 check_num값 넘기기 위해 JsonObject에 값 저장
		JsonObject obj = new JsonObject();
		obj.addProperty("check_num", check_num2);
		obj.addProperty("cnt2", cnt2);

		return new Gson().toJson(obj);
	}// end followUpdateMethod()

	// 질문 등록
	@RequestMapping("/question_pro.do")
	public ModelAndView questionProMethod(ModelAndView mav, QuestionDTO qdto) {
		mservice.qsinsertProcess(qdto);
		mav.setViewName("redirect:/mentor_view.do?num=" + qdto.getMentor_num());

		return mav;
	}// end questionProMethod()

	// 마이페이지-질문 리스트
	@RequestMapping("/question_list.do")
	public ModelAndView questionListMethod(ModelAndView mav, HttpSession session) {

		if (session.getAttribute("user_id") != null) {
			UserDTO dto = new UserDTO();
			dto = uservice.userInfoMethod((String) session.getAttribute("user_id"));
			mav.addObject("userDTO", dto);

			String user_id = (String) session.getAttribute("user_id");
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);

		}
		// 현재 로그인 된 id로 멘토 여부 체크
		String user_id = (String) session.getAttribute("user_id");
		int chk = wservice.getMentorCheckMethod(user_id);

		if (chk != 0) {
			mav.addObject("questionList2", mservice.qslistProcess(user_id));
			mav.addObject("questionList", mservice.qslistProcess2(user_id));
		} else {
			mav.addObject("questionList", mservice.qslistProcess2(user_id));
		}

		mav.setViewName("question_list");
		return mav;
	}// questionListMethod()

	// 마이페이지-질문 상세
	@RequestMapping("/question_view.do")
	public ModelAndView questionViewMethod(ModelAndView mav, HttpSession session, QuestionDTO qdto) {
		/* System.out.println("question_num:" +question_num); */
		if (session.getAttribute("user_id") != null) {
			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod((String) session.getAttribute("user_id"));
			mav.addObject("userDTO", udto);
			String user_id = (String) session.getAttribute("user_id");
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
		}
		qdto = mservice.qsviewProcess(qdto.getQuestion_num());
		mav.addObject("questionView", qdto);
		mav.addObject("answerList", mservice.aslistProcess(qdto.getQuestion_num()));

		mav.addObject("mentorDTO", mservice.viewProcess(qdto.getMentor_num()));
		mav.setViewName("question_view");
		return mav;
	}// questionViewMethod()

	// 답변 등록
	@RequestMapping("/answer_pro.do")
	public ModelAndView answerProMethod(ModelAndView mav, HttpSession session, AnswerDTO adto) {

		mservice.asinsertProcess(adto);
		mav.setViewName("redirect:/question_view.do?question_num=" + adto.getQuestion_num());
		return mav;
	}// answerProMethod()

}// end class
