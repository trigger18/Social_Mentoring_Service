package com.mycompany.sms.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.mycompany.sms.api.Kakaoapi;
import com.mycompany.sms.api.NaverLoginBO;
import com.mycompany.sms.dto.GoogleAuthInfo;
import com.mycompany.sms.dto.UserDTO;
import com.mycompany.sms.service.UserService;

@Controller
public class LoginController {

	@Autowired
	private UserService service;

	@Autowired
	private NaverLoginBO naverLoginBO;

	@Autowired
	private Kakaoapi Kakaoapi;

	@Autowired
	private GoogleOAuth2Template googleOAuth2Template;

	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	private String apiResult = null;

	@Inject
	private GoogleAuthInfo authInfo;

	public LoginController() {
	}

	// 페이스북 로그인
	@RequestMapping("/fblogin.do")
	public String fblogin(HttpSession session, String name, String email) {
		int num = service.uCheck2(email);
		UserDTO userdto = new UserDTO();
		if (num == 0) {
			userdto.setUser_id(email);
			userdto.setUser_name(name);
			userdto.setUser_email(email);
			userdto.setUser_pass("");
			service.userInsertServiceMethod(userdto);
			session.setAttribute("user_id", email);
			session.setAttribute("sessionName", name);
		} else {
			session.setAttribute("user_id", email);
			session.setAttribute("sessionName", name);
		}

		return "redirect:/home.do";
	}

	@RequestMapping("/userLogout.do")
	public String logOutProcess(HttpSession session) {
		Kakaoapi.kakaoLogout((String) session.getAttribute("access_Token"));
		session.removeAttribute("access_Token");
		session.removeAttribute("userId");

		session.removeAttribute("user_id");
		return "redirect:/home.do";
	}

	// 아이디 중복확인
	@RequestMapping("/chkid.do")
	public @ResponseBody String chkid(String user_id) {
		if (service.userInfoMethod(user_id) != null) {
			return "true";
		} else
			return "false";
	}

	// 네이버, 구글 로그인
	@RequestMapping(value = "/userLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView logInProcess(Model model, HttpSession session, ModelAndView mav) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		String url = googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("google_url", url);
		mav.addObject("url", naverAuthUrl);
		mav.setViewName("log");
		return mav;
	}

	// Naver call
	// back====================================================================
	@RequestMapping(value = "/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView callback(Model model, @RequestParam String code, @RequestParam String state,
			HttpSession session, ModelAndView mav) throws IOException, ParseException {
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"shinn0608@naver.com","name":"\uc2e0\ubc94\ud638"}}
		 **/
		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		// 3. 데이터 파싱
		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		// response의 nickname값 파싱동
		// nickname 사용안해서 name 이랑 email 파싱 받음
		// name 은 동명이인이 있으니까 email로 세션에 넣음
		String name = (String) response_obj.get("name");
		String email = (String) response_obj.get("email");

		UserDTO userDTO = new UserDTO();
		userDTO.setUser_id(email);
		userDTO.setUser_name(name);
		userDTO.setUser_email(email);
		userDTO.setUser_pass("");
		// service.apiUserInsertServiceMethod(userDTO);
		if (service.userInfoMethod(userDTO.getUser_id()) == null) {
			service.userInsertServiceMethod(userDTO);
		}
		// else {
		// }
		// 4.파싱 닉네임 세션으로 저장
		session.setAttribute("user_id", email); // 세션 생성
		session.setAttribute("sessionName", name);
		model.addAttribute("result", apiResult);
		mav.addObject("userDTO", service.userInfoMethod(userDTO.getUser_id()));
		mav.addObject("loginSuccess",1);
		mav.setViewName("redirect:/home.do");
		return mav;
	}

	// google
	// callback====================================================================
	@RequestMapping(value = "/googleSignInCallback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView doSessionAssignActionPage(HttpServletRequest request, ModelAndView mav, HttpSession session)
			throws Exception {
		String code = request.getParameter("code");

		// RestTemplate을 사용하여 Access Token 및 profile을 요청한다.
		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
		parameters.add("code", code);
		parameters.add("client_id", authInfo.getClientId());
		parameters.add("client_secret", authInfo.getClientSecret());
		parameters.add("redirect_uri", googleOAuth2Parameters.getRedirectUri());
		parameters.add("grant_type", "authorization_code");

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(
				parameters, headers);
		ResponseEntity<Map> responseEntity = restTemplate.exchange("https://www.googleapis.com/oauth2/v4/token",
				HttpMethod.POST, requestEntity, Map.class);
		Map<String, Object> responseMap = responseEntity.getBody();

		String[] tokens = ((String) responseMap.get("id_token")).split("\\.");
		Base64 base64 = new Base64(true);
		String body = new String(base64.decode(tokens[1]));

		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> result = mapper.readValue(body, Map.class);

		UserDTO userDTO = new UserDTO();
		userDTO.setUser_id(result.get("email"));
		userDTO.setUser_name(result.get("name"));
		userDTO.setUser_email(result.get("email"));
		userDTO.setUser_pass("");
		// service.apiUserInsertServiceMethod(userDTO);
		if (service.userInfoMethod(userDTO.getUser_id()) == null) {
			service.userInsertServiceMethod(userDTO);
		}
		session.setAttribute("user_id", result.get("email")); // 세션 생성
		session.setAttribute("sessionName", result.get("name"));
		mav.addObject("userDTO", service.userInfoMethod(userDTO.getUser_id()));
		mav.addObject("loginSuccess",1);
		mav.setViewName("redirect:/home.do");
		return mav;

	}

	// 카카오 로그인
	@RequestMapping(value = "/kakao.do", method = RequestMethod.GET)
	public ModelAndView kakakologin(@RequestParam("code") String code, HttpSession session, ModelAndView mav) {
		String access_Token = Kakaoapi.getAccessToken(code);
		HashMap<String, Object> userInfo = Kakaoapi.getUserInfo(access_Token);

		String email = (String) userInfo.get("email");
		String name = (String) userInfo.get("nickname");

		UserDTO userDTO = new UserDTO();
		userDTO.setUser_id(email);
		userDTO.setUser_name(name);
		userDTO.setUser_email(email);
		userDTO.setUser_pass("");
		if (service.userInfoMethod(userDTO.getUser_id()) == null) {
			service.userInsertServiceMethod(userDTO);
		}

		if (userInfo.get("email") != null) {
			session.setAttribute("userId", userInfo.get("email"));
			session.setAttribute("access_Token", access_Token);
		}

		session.setAttribute("user_id", email);
		session.setAttribute("sessionName", name);

		mav.addObject("userDTO", service.userInfoMethod(userDTO.getUser_id()));
		mav.addObject("loginSuccess",1);
		mav.setViewName("redirect:/home.do");
		return mav;
	}

}// end LoginController
