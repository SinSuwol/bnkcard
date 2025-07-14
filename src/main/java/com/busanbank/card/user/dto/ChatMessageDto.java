package com.busanbank.card.user.dto;

import lombok.Data;

@Data
public class ChatMessageDto {
    private Long roomId;
    private String senderType; // USER / ADMIN
    private Long senderId;
    private String message;
}
