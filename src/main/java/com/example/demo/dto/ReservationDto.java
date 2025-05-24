package com.example.demo.dto;
import lombok.Data;

@Data
public class ReservationDto {
	private int reservationid,status,card1,halbu1,bank1,card2,bank2,sudan,review,tel,reservprice,chongprice;
	private String rcode,jumuncode,writeday,userid,startTime,endTime,selectedDate,purposeuse,requesttohost,name,pic,email,phone,mname,modified_at;
}