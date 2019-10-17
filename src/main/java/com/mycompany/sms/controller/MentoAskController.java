package com.mycompany.sms.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.format.DataFormatDetector;
import com.mycompany.sms.dto.FieldDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.MentorFieldDTO;
import com.mycompany.sms.dto.MentorFollowDTO;
import com.mycompany.sms.dto.UserDTO;
import com.mycompany.sms.service.MentorService;
import com.mycompany.sms.service.UserService;
import com.mycompany.sms.service.WannaService;

//http://localhost:8090/sms/wannabe.do

@Controller
public class MentoAskController {
	@Autowired
	private WannaService service;

	@Autowired
	private UserService uservice;

	@Autowired
	private MentorService mservice;

	public void setService(WannaService service) {
		this.service = service;
	}

	@RequestMapping("/signUpMento.do")
	public ModelAndView process(ModelAndView mav, MentorDTO dto, HttpServletRequest req, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		dto.setUser_id(user_id);
		service.insertProcess(dto);
		MentorFollowDTO mfdto = new MentorFollowDTO();

		int mentor_num = service.getMentorNumMethod();
		mfdto.setMentor_num(mentor_num);
		mfdto.setUser_id(user_id);

		service.InsertmentorMethod(mfdto);
		int mCheck = service.getMentorCheckMethod(user_id);

		String[] field = req.getParameterValues("field_num");

		for (String s : field) {
			MentorFieldDTO fdto = new MentorFieldDTO();
			fdto.setMentor_num(mentor_num);
			fdto.setField_num(Integer.parseInt(s));
			service.insertFieldMethod(fdto);
		}
		mav.addObject("mCheck", mCheck);
		mav.setViewName("redirect:/home.do");
		return mav;
	}

	@RequestMapping("/wannabe.do")
	public ModelAndView signUpMentoProcess(ModelAndView mav, HttpSession session) {
		if (session.getAttribute("user_id") != null) {
			UserDTO dto = new UserDTO();
			dto = uservice.userInfoMethod((String) session.getAttribute("user_id"));
			mav.addObject("userDTO", dto);
			String user_id = (String) session.getAttribute("user_id");
			int mCheck = service.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
		}
		mav.setViewName("wannabe");
		return mav;
	}

	@RequestMapping("/update_Mento.do")
	public ModelAndView updateprocess(ModelAndView mav, HttpSession session) {
		if (session.getAttribute("user_id") != null) {
			UserDTO dto = new UserDTO();
			dto = uservice.userInfoMethod((String) session.getAttribute("user_id"));
			mav.addObject("userDTO", dto);
			String user_id = (String) session.getAttribute("user_id");
			int mCheck = service.getMentorCheckMethod(user_id);
			MentorDTO mdto = new MentorDTO();
			mdto = service.getMentorinfoMethod(user_id);
			mav.addObject("MentorDTO", mdto);
			mav.addObject("mCheck", mCheck);
		}
		mav.setViewName("wannabe_update");
		return mav;
	}

	@RequestMapping("/setmentor.do")
	public ModelAndView setMentorInfoProcess(ModelAndView mav, MentorDTO dto, HttpServletRequest req,
			HttpSession session) {

		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			int mCheck = service.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
			service.updateMentorMethod(dto);
			service.deletFieldMethod(dto.getMentor_num());
			String[] field = req.getParameterValues("field_num");

			for (String s : field) {
				MentorFieldDTO fdto = new MentorFieldDTO();
				fdto.setMentor_num(dto.getMentor_num());
				fdto.setField_num(Integer.parseInt(s));
				service.insertFieldMethod(fdto);
			}
			mav.addObject("userDTO", uservice.userInfoMethod(user_id));
			mav.addObject("mentorView", dto);
			mav.addObject("fieldDTO", mservice.fieldviewProcess(dto.getMentor_num()));
		}
		mav.setViewName("mentor_view");
		return mav;

	}

}// end class
