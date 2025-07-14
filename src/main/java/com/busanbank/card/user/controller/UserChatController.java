package com.busanbank.card.user.controller;

import com.busanbank.card.user.dto.ChatMessageDto;
import com.busanbank.card.user.dto.ChatRoomDto;
import com.busanbank.card.user.service.ChatService;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/chat")
@RequiredArgsConstructor
public class UserChatController {

    private final ChatService chatService;

    /**
     * 방 생성
     */
    @PostMapping("/room")
    public ResponseEntity<Long> createRoom(@RequestParam("memberNo") Long memberNo) {
        Long roomId = chatService.createRoom(memberNo);
        return ResponseEntity.ok(roomId);
    }

    /**
     * 내 방 정보 조회
     */
    @GetMapping("/room/{roomId}")
    public ResponseEntity<ChatRoomDto> getRoom(@PathVariable("roomId") Long roomId) {
        ChatRoomDto dto = chatService.getRoom(roomId);
        return ResponseEntity.ok(dto);
    }

    /**
     * 메시지 전송
     */
    @PostMapping("/message")
    public ResponseEntity<Void> sendMessage(@RequestBody ChatMessageDto dto) {
        chatService.sendMessage(dto);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/room/{roomId}/messages")
    public ResponseEntity<List<ChatMessageDto>> getUserMessages(@PathVariable("roomId") Long roomId) {
        List<ChatMessageDto> list = chatService.getMessages(roomId);
        return ResponseEntity.ok(list);
    }

    /**
     * 상담사 연결 요청
     */
    @PostMapping("/room/{roomId}/request-admin")
    public ResponseEntity<Void> requestAdmin(@PathVariable("roomId") Long roomId) {
        chatService.requestAdmin(roomId);
        return ResponseEntity.ok().build();
    }
}
