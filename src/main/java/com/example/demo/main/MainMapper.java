package com.example.demo.main;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.RoomDto;

@Mapper
public interface MainMapper {

	ArrayList<RoomDto> HeartRanking();

	}
