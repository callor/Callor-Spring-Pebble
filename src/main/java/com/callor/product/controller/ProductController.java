package com.callor.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.callor.product.domain.ProFileDTO;
import com.callor.product.domain.ProductDTO;
import com.callor.product.service.FileService;
import com.callor.product.service.ProductSerivce;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProductController {
	
	@Autowired
	ProductSerivce pService;

	@Autowired
	FileService fService;
	
	// @ResponseBody
	@RequestMapping(
			value="plist",
			method=RequestMethod.GET,
			produces = "application/json;charset=UTF-8;")
	
	public String getPlist(Model model) {
		List<ProductDTO> proList = pService.selectAll();
		
		model.addAttribute("PLIST",proList);
		return "home";
	}

	/*
	 * 1개 파일을 업로드를 할때는 MulipartFile로 업로드를 수행하면되고
	 * 2개 이상의 파일을 업로드 할때는 MulipartRequest 객체로
	 * 파일을 받아서 처리를 수행
	 */
	@RequestMapping(value="input",method=RequestMethod.POST)
	public String input(
			@ModelAttribute
			ProductDTO proDTO,
			@RequestParam("u_file") MultipartFile u_file,
			// 다수의 파일 업로드 정보를 수신
			MultipartHttpServletRequest u_files) throws Exception {
		
		// 파일리스트만 추출
		// List<MultipartFile> fs = u_files.getFiles("u_files");
		
		/*
		 * MultipartHttpServletRequest 여려개의
		 * MultipartFile을 포함하고 있는 객체리스트
		 * getFiles("input tag의 name 변수명")
		 */
		for(MultipartFile f : u_files.getFiles("u_files")) {
			log.debug("파일이름 : " + f.getOriginalFilename());
		}

		
		if(proDTO.getP_file() != null) {
			fService.fileDelete(proDTO.getP_file());
		}
		String profileImage = fService.fileUp(u_file);
		if(profileImage != null) {
			proDTO.setP_file(profileImage);
		}
		
		// 파일 업로드 수행후 파일리스트를 받음
		List<ProFileDTO> upFileList = fService.filesUp(u_files);
		
		int ret = 0;
		if(proDTO.getP_code().isEmpty()) {
			
			log.debug("새로운 상품등록");
			
			// 상품정보와 파일 리스트를 insert() method에 전달
			ret = pService.insert(proDTO,upFileList);
			
			// insert 실행
			
		} else {
			log.debug("기존 상품변경");
			// update 실행
			
			// 변경할 상품정봐 파일리스트를 update() method에 전달
			ret = pService.update(proDTO,upFileList);
		}
		
		return "redirect:/plist";
	
	}
	
	@RequestMapping(value="imgDelete",method=RequestMethod.GET)
	public String imgDelete(String p_code) {
		/*
		ProductDTO proDTO = pService.findByPCode(p_code);
		if(proDTO.getP_file() != null && 
				!proDTO.getP_file().isEmpty()) {

			fService.fileDelete(proDTO.getP_file());
			proDTO.setP_file(null);
			// pService.update(proDTO);
		}
		*/
		return "redirect:/plist";
	}
	/*
	 * 결과물을 view(*.jsp)로 변환하지 않고
	 * 문자열그대로 또는
	 * 
	 * 객체(vo,dto)를 json 형태로 변경하여
	 * 클라이언트에게 response를 수행하는 기능
	 */
	/*
	@ResponseBody
	@RequestMapping(value="getProduct",
			method=RequestMethod.GET,
			produces = "application/json;charset=UTF-8")
	public ProductDTO getProduct(String p_code) {
		ProductDTO proDTO = pService.findByPCode(p_code);
		
		return proDTO;
	}
	*/

	/*
	 * 문자열이나 객체에 담긴 데이터를 그대로 client에게 전송
	 */
	@ResponseBody
	@RequestMapping(value="getString",
			method=RequestMethod.GET,
			
			// @ResponseBody를 사용할때는
			// 꼭 produces를 설정하는 것이 좋다.
			// 특히 한글 데이터를 response할때는 반드시 !!!
			// charset=UTF-8은 꼭 있어야 한다.
			produces = "application/json;charset=UTF-8" )
	public String getString(
			
			// query로 보내는 변수명
			@RequestParam(value="str", 
			
				// require=false와 defaultValue가 없으면
				// server는 client에게 400오류를 보내고 처리를 거부한다.
				// 절대 사용자만든 vo,dto에는 적용하면 안된다.
			
				// 혹시 값을 보내지 않아도 오류를 내지 마라
				required = false,  
				// 값을 보내지 않으면 없음 이라는 문자열을 세팅하라
				defaultValue = "없음") 
			
			String myStr ) {
		
		if(myStr.equals("없음")) {
			return "http://localhost:8080/product/getString?str=문자열 형식으로 보내세요";
		} else {
			return "보낸문자열은? : " + myStr;
		}
	}
	
	
	
	
	@ResponseBody
	@RequestMapping(
			value="plist/name",
			method=RequestMethod.GET,
			produces = "application/json;charset=UTF-8;")
	
	public List<ProductDTO> getNames(String p_name) {
		List<ProductDTO> proList = pService.findByPNames(p_name);
		return proList;
	}
	
	/*
	 * produces의 content-Type
	 * 서버에서 문자열, 객체 등등의 실제 데이터를 response할때
	 * 어떤 type으로 보낼것인가를 나타내는 문자열
	 * 
	 */
	@ResponseBody
	@RequestMapping(
			value="pname",
			method=RequestMethod.GET,
			produces = "text/plain;charset=UTF-8;")
	public String getPName(String p_code) {
		
		ProductDTO proDTO = pService.findByPCode(p_code);
		// return proDTO.getP_name();
		return "<h1>" + proDTO.getP_name() + "</h1>";
		
	}

	
	@ResponseBody
	@RequestMapping(
			value="oprice",
			method=RequestMethod.GET,
			produces = "text/html;charset=UTF-8")
	public String getOPrice(String p_code) {
		
		ProductDTO proDTO = pService.findByPCode(p_code);
		return proDTO.getP_oprice()+"";
		
	}

	@ResponseBody
	@RequestMapping(
			value="iprice",
			method=RequestMethod.GET,
			produces = "text/html;charset=UTF-8")
	public String getIPrice(String p_code) {
		
		ProductDTO proDTO = pService.findByPCode(p_code);
		return proDTO.getP_iprice()+"";
	}
	
	
	

}
