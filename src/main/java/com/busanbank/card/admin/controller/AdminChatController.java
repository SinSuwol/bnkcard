package com.busanbank.card.admin.controller;

import com.busanbank.card.admin.service.AdminChatService;
import com.busanbank.card.user.dto.ChatRoomDto;
import com.busanbank.card.user.dto.ChatMessageDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/chat")
@RequiredArgsConstructor
public class AdminChatController {

    private final AdminChatService adminChatService;

    /**
     * 전체 방 목록 조회
     */
    @GetMapping("/rooms")
    public ResponseEntity<List<ChatRoomDto>> getAllRooms() {
        List<ChatRoomDto> rooms = adminChatService.getAllRooms();
        return ResponseEntity.ok(rooms);
    }

    /**
     * 방 입장 (배정)
     */
    @PostMapping("/room/{roomId}/enter")
    public ResponseEntity<Void> enterRoom(
            @PathVariable("roomId") Long roomId,
            @RequestParam("adminNo") Long adminNo) {
        adminChatService.assignAdmin(roomId, adminNo);
        return ResponseEntity.ok().build();
    }

    /**
     * 메시지 전송
     */
    @PostMapping("/message")
    public ResponseEntity<Void> sendAdminMessage(@RequestBody ChatMessageDto dto) {
        adminChatService.sendAdminMessage(dto);
        return ResponseEntity.ok().build();
    }
    
    @GetMapping("/room/{roomId}/messages")
    public ResponseEntity<List<ChatMessageDto>> getMessages(@PathVariable Long roomId) {
        List<ChatMessageDto> messages = adminChatService.getMessages(roomId);
        return ResponseEntity.ok(messages);
    }


    /**
     * 방 종료
     */
    @PostMapping("/room/{roomId}/close")
    public ResponseEntity<Void> closeRoom(@PathVariable("roomId") Long roomId) {
        adminChatService.closeRoom(roomId);
        return ResponseEntity.ok().build();
    }
}
