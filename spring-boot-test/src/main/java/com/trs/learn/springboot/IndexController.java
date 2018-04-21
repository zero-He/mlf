package com.trs.learn.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class IndexController {
	@Autowired
    private Environment env;
	@Value(value="${morning.time}")
	private int time;
	
	@RequestMapping(value="index",method=RequestMethod.GET)
	public String index(String taskId){
		System.out.println(taskId);
		return env.getProperty("test.msg");
	}

}
