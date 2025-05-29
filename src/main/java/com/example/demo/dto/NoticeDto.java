package com.example.demo.dto;

import lombok.Data;

@Data
public class NoticeDto {
	private int noticeid, state, adminid;
	private String title, writeday, content, admin_name;
}
