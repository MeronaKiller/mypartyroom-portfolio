package com.example.demo.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
@Qualifier("ms")
public class MainServiceImpl implements MainService {
	
	@Autowired
	private MainMapper mapper;
	
	@Override
	public String main()
	{
		return "/main/main";
	}
	@Override
	public String room()
	{
		return "/room/room";
	}
}
