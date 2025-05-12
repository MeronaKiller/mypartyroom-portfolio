package com.example.demo.dto;

import lombok.Data;

@Data
public class MemberDto {
	private int memberid, status;
	private String userid,pwd,email,phone,created_day,modified_day,name;
}
