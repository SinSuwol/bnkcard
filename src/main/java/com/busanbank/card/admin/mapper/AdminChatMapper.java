package com.busanbank.card.admin.mapper;

import com.busanbank.card.user.dto.ChatRoomDto;
import com.busanbank.card.user.dto.ChatMessageDto;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface AdminChatMapper {

    List<ChatRoomDto> selectAllRooms();

    void assignAdmin(Long roomId, Long adminNo);

    void closeRoom(Long roomId);

    void insertAdminMessage(ChatMessageDto dto);
    
    List<ChatMessageDto> selectMessages(Long roomId);

}
