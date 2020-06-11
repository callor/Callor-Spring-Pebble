package com.callor.product.controller;

import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mitchellbosecke.pebble.PebbleEngine;
import com.mitchellbosecke.pebble.template.PebbleTemplate;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@ResponseBody
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		PebbleEngine engine = new PebbleEngine.Builder().build();
		PebbleTemplate compiledTemplate = engine.getTemplate("/WEB-INF/template/home.html");

		Map<String, Object> context = new HashMap<>();
		context.put("name", "Mitchell");

		Writer writer = new StringWriter();
		try {
			compiledTemplate.evaluate(writer, context);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String output = writer.toString();
		
		
		return output;
//		return "redirect:/plist";
	}

	@ResponseBody
	@RequestMapping(value="nation",
			method=RequestMethod.GET,
			produces = "text/html;charset=UTF-8")
	public String getNation(String str) {
		
		log.debug("Req 변수 str : " + str);
		
		long sum = 0;
		for(long i = 0 ; i < 10000000000L ; i++) {
			sum += i;
		}
		
		String strNation = "Republic of Korea";
		strNation = str + sum;
		return strNation;
		
	}
	
	@RequestMapping(value="/vue",method=RequestMethod.GET)
	public String vue() {
		
		return "vue";
	}
}
