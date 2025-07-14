package com.busanbank.card.user.service.impl;

import com.busanbank.card.user.dto.ChatMessageDto;
import com.busanbank.card.user.dto.ChatRoomDto;
import com.busanbank.card.user.mapper.ChatMapper;
import com.busanbank.card.user.service.ChatService;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService {

    private final ChatMapper chatMapper;

    @Override
    public Long createRoom(Long memberNo) {
        chatMapper.insertChatRoom(memberNo);
        return chatMapper.selectCurrRoomId();
    }

    @Override
    public ChatRoomDto getRoom(Long roomId) {
        return chatMapper.selectChatRoom(roomId);
    }

    @Override
    public void sendMessage(ChatMessageDto dto) {
        chatMapper.insertChatMessage(dto);

        if ("USER".equals(dto.getSenderType())) {
            chatMapper.increaseUnreadCount(dto.getRoomId());
        }
    }

    @Override
    public void requestAdmin(Long roomId) {
        System.out.println("Room [" + roomId + "] 상담사 연결 요청됨.");
    }
    
    @Override
    public List<ChatMessageDto> getMessages(Long roomId) {
        return chatMapper.selectMessages(roomId);
    }

}
