package com.busanbank.card.admin.service.impl;

import com.busanbank.card.admin.mapper.AdminChatMapper;
import com.busanbank.card.admin.service.AdminChatService;
import com.busanbank.card.user.dto.ChatRoomDto;
import com.busanbank.card.user.dto.ChatMessageDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminChatServiceImpl implements AdminChatService {

    private final AdminChatMapper adminChatMapper;

    @Override
    public List<ChatRoomDto> getAllRooms() {
        return adminChatMapper.selectAllRooms();
    }

    @Override
    public void assignAdmin(Long roomId, Long adminNo) {
        adminChatMapper.assignAdmin(roomId, adminNo);
    }

    @Override
    public void closeRoom(Long roomId) {
        adminChatMapper.closeRoom(roomId);
    }

    @Override
    public void sendAdminMessage(ChatMessageDto dto) {
        adminChatMapper.insertAdminMessage(dto);
    }
    
    @Override
    public List<ChatMessageDto> getMessages(Long roomId) {
        return adminChatMapper.selectMessages(roomId);
    }

}
