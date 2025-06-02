package com.example.demo.room;

import org.springframework.context.ApplicationEvent;

public class ReservationStatusUpdateEvent extends ApplicationEvent {
    private final String uuid;
    private final String status;
    private final String message;
    private final String jumuncode;
    
    public ReservationStatusUpdateEvent(Object source, String uuid, String status, String message, String jumuncode) {
        super(source);
        this.uuid = uuid;
        this.status = status;
        this.message = message;
        this.jumuncode = jumuncode;
    }
    
    // Getter 메서드들
    public String getUuid() { 
        return uuid; 
    }
    
    public String getStatus() { 
        return status; 
    }
    
    public String getMessage() { 
        return message; 
    }
    
    public String getJumuncode() { 
        return jumuncode; 
    }
}