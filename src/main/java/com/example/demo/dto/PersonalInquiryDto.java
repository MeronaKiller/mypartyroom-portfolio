package com.example.demo.dto;

import lombok.Data;

@Data
public class PersonalInquiryDto {
	private int personalInquiryid, state, category;
	private String title, content, writeday, answerwriteday, admin_userid, answercontent, userid;
}
