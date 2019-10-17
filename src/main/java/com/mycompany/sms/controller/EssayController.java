package com.mycompany.sms.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.mycompany.sms.dto.EssayDTO;
import com.mycompany.sms.dto.MentorDTO;
import com.mycompany.sms.dto.PageDTO;
import com.mycompany.sms.dto.UserDTO;
import com.mycompany.sms.service.EssayService;
import com.mycompany.sms.service.MentorService;
import com.mycompany.sms.service.UserService;
import com.mycompany.sms.service.WannaService;

//http://localhost:8090/sms/essay_list.do
@Controller
public class EssayController {

	@Autowired
	private EssayService service;
	private int currentPage;
	private PageDTO pdto;

	@Autowired
	private UserService uservice;

	@Autowired
	private WannaService wservice;

	@Autowired
	private MentorService mentorservice;

	public EssayController() {
	}

	public void setService(EssayService service) {
		this.service = service;
	}

	@RequestMapping("/essay_list.do")
	public ModelAndView essayListPage(PageDTO pv, ModelAndView mav, HttpSession session) {
		int totalRecord = service.countProcess();
		String user_id = (String) session.getAttribute("user_id");
		int mentor_num = 0;
		// checkMentor = 0 이면 mentor 가 아님 1 이면 멘토
		if (user_id != null) {
			int checkMentor = service.checkMentorMethod(user_id);
			if (checkMentor == 1) {
				mentor_num = service.getMentorNumMethod(user_id);
				mav.addObject("mentor_num", mentor_num);
			}
			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod(user_id);
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
			mav.addObject("userDTO", udto);
			mav.addObject("CheckMentor", checkMentor);
		}
		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0) {
				currentPage = 1;
			} else {
				currentPage = pv.getCurrentPage();
			}
			pdto = new PageDTO(currentPage, totalRecord);
			mav.addObject("pv", pdto);
			for (EssayDTO edto : service.essayListProcess(pdto)) {
				String str = edto.getEssay_date();
				int index = str.indexOf(" ");
				String date = str.substring(0, index);
				date = date.replace("-", ". ");
				mav.addObject("date", date);
			}
			mav.addObject("e_list", service.essayListProcess(pdto));
		}
		mav.setViewName("essay_list");
		return mav;
	}

	@RequestMapping("/essay_view.do")
	public ModelAndView essayViewPage(ModelAndView mav, int essay_num, int currentPage, int mentor_num,
			HttpSession session, HttpServletRequest req) {
		String user_id = (String) session.getAttribute("user_id");
		MentorDTO mdto = new MentorDTO();
		if (user_id != null) {
			mdto.setUser_id(user_id);
			mdto.setMentor_num(mentor_num);

			int compareMentorAndUser = service.compareMentorAndUser(mdto);
			mav.addObject("cmau", compareMentorAndUser);// 유저가 멘토인지 확인
			req.setAttribute("cmau", compareMentorAndUser);
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);

			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod(user_id);
			mav.addObject("userDTO", udto);
		}

		EssayDTO edto = new EssayDTO();
		edto = service.essayViewProcess(essay_num);
		mdto = service.getMentorInfo(mentor_num);
		mav.addObject("mentorDTO", mdto);
		mav.addObject("essayDTO", edto);
		mav.addObject("fieldDTO", mentorservice.fieldviewProcess(mdto.getMentor_num()));
		mav.addObject("currentPage", currentPage);
		mav.setViewName("essay_view");
		// 날짜
		String str = edto.getEssay_date();
		int index = str.indexOf(" ");
		String date = str.substring(0, index);
		date = date.replace("-", ". ");
		edto.setEssay_date(date);
		return mav;
	}

	@RequestMapping(value = "/essay_write.do", method = RequestMethod.GET)
	public ModelAndView essayInsertPage(ModelAndView mav, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");

		if (user_id != null) {
			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod(user_id);
			mav.addObject("userDTO", udto);

			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
		}
		MentorDTO mdto = service.getMentorInfoFromUserIdProcess(user_id);
		mav.addObject("fieldDTO", mentorservice.fieldviewProcess(mdto.getMentor_num()));
		mav.addObject("mentorDTO", mdto);
		mav.setViewName("essay_write");
		return mav;
	}

	@RequestMapping(value = "/essay_insert.do", method = RequestMethod.POST)
	public ModelAndView essayInsertProPage(EssayDTO dto, HttpServletRequest request, ModelAndView mav,
			HttpSession session) {
		// 사용자
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod(user_id);
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
			mav.addObject("userDTO", udto);
		}
		// 사용자 끝
		MultipartFile file = dto.getFilepath();

		if (!file.isEmpty()) {
			UUID random = saveCopyFile(file, request);
			dto.setEssay_img(random + "_" + file.getOriginalFilename());
		}
		int mentor_num = service.getMentorNumMethod(user_id);
		dto.setMentor_num(mentor_num);
		service.essayInsertProcess(dto);
		dto = service.essayViewProcess(service.getEssayNum());
		MentorDTO mdto = service.getMentorInfo(mentor_num);
		mav.addObject("fieldDTO", mentorservice.fieldviewProcess(mdto.getMentor_num()));
		mav.addObject("mentorDTO", mdto);
		mav.addObject("essay_num", service.getEssayNum());
		mav.addObject("mentor_num", dto.getMentor_num());
		mav.addObject("essayDTO", dto);
		int compareMentorAndUser = 1;
		mav.addObject("cmau", compareMentorAndUser);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("essay_view");
		return mav;
	}

	@RequestMapping(value = "/essay_update.do", method = RequestMethod.GET)
	public ModelAndView essayUpViewPage(ModelAndView mav, int essay_num, int currentPage, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod(user_id);
			mav.addObject("userDTO", udto);

			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
		}
		mav.addObject("currentPage", currentPage);
		MentorDTO mdto = service.getMentorInfoFromUserIdProcess(user_id);
		mav.addObject("fieldDTO", mentorservice.fieldviewProcess(mdto.getMentor_num()));
		mav.addObject("mentorDTO", mdto);
		mav.addObject("essayDTO", service.essayUpViewProcess(essay_num));
		mav.setViewName("essay_update");
		return mav;
	}

	@RequestMapping(value = "/essay_update.do", method = RequestMethod.POST)
	public ModelAndView essayUpdatePage(ModelAndView mav, HttpServletRequest request, EssayDTO dto, int currentPage,
			HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			UserDTO udto = new UserDTO();
			udto = uservice.userInfoMethod(user_id);
			mav.addObject("userDTO", udto);
			int mCheck = wservice.getMentorCheckMethod(user_id);
			mav.addObject("mCheck", mCheck);
		}
		String filename = service.essayUpViImgProcess(dto.getEssay_num());
		String root = request.getSession().getServletContext().getRealPath("/");
		String saveDirectory = root + "temp" + File.separator;
		// 수정할 첨부파일
		MultipartFile file = dto.getFilepath();
		String fileOri = file.getOriginalFilename();
		// 수정한 첨부파일이 있으면
		if (!file.isEmpty()) {
			// 기존 첨부파일이 있으면....
			if (filename != null) {
				File fe = new File(saveDirectory, filename);
				fe.delete();
			}
			UUID random = saveCopyFile(file, request);
			dto.setEssay_img(random + "_" + fileOri);
		} else {
			dto.setEssay_img(filename);
		}
		MentorDTO mdto = service.getMentorInfoFromUserIdProcess(user_id);
		mav.addObject("mentorDTO", mdto);
		service.essayUpdateProcess(dto);
		int compareMentorAndUser = 1;
		mav.addObject("cmau", compareMentorAndUser);
		mav.addObject("essayDTO", service.essayUpViewProcess(dto.getEssay_num()));
		mav.addObject("fieldDTO", mentorservice.fieldviewProcess(mdto.getMentor_num()));
		mav.addObject("currentPage", currentPage);
		mav.setViewName("essay_view");
		return mav;
	}

	@RequestMapping("/essay_delete.do")
	public String essayDeletePage(int essay_num) {
		service.essayDeleteProcess(essay_num);
		return "redirect:/essay_list.do";
	}

	public UUID saveCopyFile(MultipartFile file, HttpServletRequest request) {
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
	}// end saveCopyFile()
}
