package com.example.demo.dto;

import lombok.Data;

@Data
public class NoticeDto {
	private int noticeid, rnum, state;
	private String title, writeday, img, content, admin_name;
}
