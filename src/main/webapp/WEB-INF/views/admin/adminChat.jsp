<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Admin Chat</title>
<style>
    body { margin:0; font-family:'Noto Sans KR', sans-serif; background:#f4f4f4; }
    .container { display:flex; height:100vh; }
    .sidebar { width:300px; background:#fff; border-right:1px solid #ddd; overflow-y:auto; padding:20px; }
    .chat-area { flex-grow:1; display:flex; flex-direction:column; padding:20px; }
    .chat-header { font-weight:bold; margin-bottom:10px; }
    #chatBox { flex-grow:1; border:1px solid #ddd; background:#fff; overflow-y:auto; padding:10px; margin-bottom:10px; display:flex; flex-direction:column; gap:10px; }
    .message { display:inline-block; padding:8px 12px; border-radius:10px; max-width:70%; word-break:break-all; }
    .user { background:#d1e7dd; align-self:flex-end; margin-left:auto; }
    .admin { background:#f8d7da; align-self:flex-start; margin-right:auto; }
    .input-area { display:flex; gap:10px; }
    .input-area input { flex-grow:1; padding:10px; border:1px solid #ccc; border-radius:5px; }
    .input-area button { padding:10px 15px; background:#007bff; color:#fff; border:none; border-radius:5px; cursor:pointer; }
    .input-area button:hover { background:#0056b3; }
    .room-item { padding: 10px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 5px; cursor: pointer; transition: background 0.2s; }
    .room-item:hover { background: #f1f1f1; }
</style>
</head>
<body>
<div class="container">
    <div class="sidebar">
        <h3>방 목록</h3>
        <div id="roomList"></div>
    </div>
    <div class="chat-area" style="display:none;">
        <div class="chat-header" id="roomTitle">채팅방</div>
        <div id="chatBox"></div>
        <div class="input-area">
            <input type="text" id="adminMessageInput" placeholder="메시지를 입력하세요">
            <button id="sendAdminBtn">보내기</button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script>
    let stompClient = null;
    let currentRoomId = 1;
    let adminNo = 999;

    window.onload = function () {
        console.log("💡 window.onload 시작");
        loadRooms();
        document.getElementById('sendAdminBtn').addEventListener('click', sendAdminMessage);
    };

    function loadRooms() {
        console.log("loadRooms() 호출됨");

        fetch('/admin/chat/rooms')
            .then(response => {
                console.log("fetch 응답 상태:", response.status, response.statusText);
                return response.json();
            })
            .then(data => {
                console.log("방 목록 JSON 응답:", JSON.stringify(data, null, 2));

                const roomList = document.getElementById("roomList");
                roomList.innerHTML = "";

                if (!data || data.length === 0) {
                    roomList.innerHTML = "<p>현재 등록된 방이 없습니다.</p>";
                    return;
                }

                data.forEach(room => {
                    console.log("개별 방 데이터:", JSON.stringify(room, null, 2));

                    const div = document.createElement("div");
                    div.className = "room-item";

                    div.textContent =
                        "방번호: " + (room.roomId != null ? room.roomId : "-") + " | " +
                        "회원번호: " + (room.memberNo != null ? room.memberNo : "-") + " | " +
                        "미확인: " + (room.unreadCount != null ? room.unreadCount : "0");

                    if (room.roomId != null) {
                        div.onclick = () => enterRoom(room.roomId);
                    }
                    roomList.appendChild(div);
                });
            })
            .catch(error => {
                console.error("❌ 방 목록 가져오기 실패:", error);
                document.getElementById("roomList").innerHTML = "<p>방 목록을 불러오지 못했습니다.</p>";
            });
    }

    function enterRoom(roomId) {
        console.log(`➡️ enterRoom() 호출됨. roomId=${roomId}`);

        currentRoomId = roomId;

        fetch(`/admin/chat/room/${roomId}/enter?adminNo=${adminNo}`, { method: 'POST' })
            .then(() => {
                document.querySelector(".chat-area").style.display = "flex";
                document.getElementById("roomTitle").textContent = `채팅방 #${roomId}`;

                fetch(`/admin/chat/room/${roomId}/messages`)
                    .then(res => res.json())
                    .then(data => {
                        console.log("기존 채팅 내역:", JSON.stringify(data, null, 2));

                        document.getElementById("chatBox").innerHTML = "";
                        if (Array.isArray(data)) {
                            data.forEach(showMessage);
                        } else {
                            console.warn("⚠기존 채팅 데이터가 배열이 아님:", data);
                        }
                    })
                    .catch(err => console.error("기존 메시지 로딩 오류:", err));

                connect(roomId);
            })
            .catch(err => {
                console.error("방 입장 오류:", err);
            });
    }

    function connect(roomId) {
        console.log("WebSocket 연결 시도 중...");

        const socket = new SockJS('/ws/chat');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, function (frame) {
            console.log("✅ WebSocket 연결됨:", frame);

            stompClient.subscribe('/topic/room/' + roomId, function (message) {
                console.log("📥 수신된 WebSocket 메시지(raw):", message);
                try {
                    const data = JSON.parse(message.body);
                    console.log("✅ 파싱된 WebSocket 데이터:", data);
                    showMessage(data);
                } catch (e) {
                    console.error("❌ WebSocket 메시지 JSON 파싱 오류:", e);
                }
            });
        }, function (error) {
            console.error("❌ WebSocket 연결 실패:", error);
        });
    }

    function sendAdminMessage() {
        const msg = document.getElementById('adminMessageInput').value.trim();

        if (!msg) {
            alert("메시지를 입력하세요.");
            return;
        }

        const payload = {
            roomId: currentRoomId,
            senderType: "ADMIN",
            senderId: adminNo,
            message: msg
        };

        console.log("🚀 관리자 메시지 전송 payload:", payload);

        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(payload));
        document.getElementById('adminMessageInput').value = "";
    }

    function showMessage(message) {
        console.log("수신 데이터:", message);

        const sender = (message.senderType !== undefined && message.senderType !== null)
            ? message.senderType
            : "알 수 없음";

        // ✅ content 혹은 message 둘 중 하나라도 있으면 쓰도록 수정
        const text = (message.message !== undefined && message.message !== null)
            ? message.message
            : (
                (message.content !== undefined && message.content !== null)
                ? message.content
                : "(빈 메시지)"
            );

        console.log("sender:", sender);
        console.log("text:", text);

        const div = document.createElement("div");
        div.classList.add("message");

        if (sender === "USER") {
            div.classList.add("user");
        } else {
            div.classList.add("admin");
        }

        div.textContent = sender + ": " + text;

        document.getElementById("chatBox").appendChild(div);
        document.getElementById("chatBox").scrollTop = document.getElementById("chatBox").scrollHeight;
    }

</script>
</body>
</html>
