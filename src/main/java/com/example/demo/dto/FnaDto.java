package com.example.demo.dto;

import lombok.Data;

@Data
public class FnaDto {
	private int fnaid, rnum, state, adminid;
	private String title, writeday, img, content, admin_name;
}
