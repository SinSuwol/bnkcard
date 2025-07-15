package com.busanbank.card.user.mapper;

import com.busanbank.card.user.dto.ChatMessageDto;
import com.busanbank.card.user.dto.ChatRoomDto;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatMapper {
    
    void insertChatRoom(ChatRoomDto room);

    Long selectCurrRoomId();

    ChatRoomDto selectChatRoom(Long roomId);

    void insertChatMessage(ChatMessageDto dto);

    void increaseUnreadCount(Long roomId);
    
    List<ChatMessageDto> selectMessages(Long roomId);
    
    Long selectRoomIdByMember(Long memberNo);


}
