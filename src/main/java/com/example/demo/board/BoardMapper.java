package com.example.demo.board;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.FnaDto;
import com.example.demo.dto.NoticeDto;

@Mapper
public interface BoardMapper {
	ArrayList<NoticeDto> noticeList(int index);
	int noticeGetChong();
	ArrayList<FnaDto> fna();
}
