<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Admin Chat</title>
    <style>
        #chatBox {
            width: 400px;
            height: 400px;
            border: 1px solid #ccc;
            overflow-y: scroll;
            padding: 10px;
            margin-bottom: 10px;
            background: #f9f9f9;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .message {
            display: inline-block;
            padding: 8px 12px;
            border-radius: 10px;
            max-width: 70%;
            min-width: 50px;
            word-break: break-all;
            font-size: 14px;
            color: #000;
        }
        .user {
            background: #d1e7dd;
            align-self: flex-end;
        }
        .admin {
            background: #f8d7da;
            align-self: flex-start;
        }
    </style>
</head>
<body>
<h2>Admin Chat Page</h2>

<button onclick="loadRooms()">방 목록 불러오기</button>

<div id="roomList"></div>

<hr>

<div id="chatArea" style="display:none;">
    <h3>채팅방 <span id="roomTitle"></span></h3>
    <div id="chatBox"></div>
    <input type="text" id="adminMessageInput" placeholder="메시지를 입력하세요">
    <button id="sendAdminBtn">보내기</button>
</div>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script>
    let stompClient = null;
    let currentRoomId = null;
    let adminNo = 999; // 테스트용

    function loadRooms() {
        fetch('/admin/chat/rooms')
            .then(response => response.json())
            .then(data => {
                console.log("방 목록 데이터:", data);

                let html = "";

                if (data.length === 0) {
                    html = "<p>현재 등록된 방이 없습니다.</p>";
                } else {
                    data.forEach(room => {
                        html += "<p>" +
                            "방번호: " + (room.roomId ?? '-') + " | " +
                            "회원번호: " + (room.memberNo ?? '-') + " | " +
                            "미확인메시지: " + (room.unreadCount ?? 0) +
                            " <button onclick='enterRoom(" + room.roomId + ")'>입장</button>" +
                            "</p>";
                    });
                }

                document.getElementById("roomList").innerHTML = html;
            })
            .catch(error => {
                console.error("방 목록 가져오기 실패:", error);
                document.getElementById("roomList").innerHTML = "<p>방 목록을 불러오지 못했습니다.</p>";
            });
    }


    function enterRoom(roomId) {
        currentRoomId = roomId;

        fetch(`/admin/chat/room/${roomId}/enter?adminNo=${adminNo}`, {
            method: 'POST'
        }).then(() => {
            document.getElementById("roomTitle").textContent = roomId;
            document.getElementById("chatArea").style.display = "block";

            fetch(`/admin/chat/room/${roomId}/messages`)
                .then(response => response.json())
                .then(data => {
                    document.getElementById("chatBox").innerHTML = "";
                    data.forEach(showMessage);
                });

            connect(roomId);
        });
    }


    function connect(roomId) {
        const socket = new SockJS('/ws/chat');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, function(frame) {
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/room/' + roomId, function(message) {
                showMessage(JSON.parse(message.body));
            });
        });
    }

    function sendAdminMessage() {
        const msg = document.getElementById('adminMessageInput').value;

        if (!msg || msg.trim() === "") {
            alert("메시지를 입력하세요.");
            return;
        }

        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify({
            roomId: currentRoomId,
            senderType: "ADMIN",
            senderId: adminNo,
            message: msg
        }));

        document.getElementById('adminMessageInput').value = "";
    }

    function showMessage(message) {
        console.log("수신 메시지:", message);

        const div = document.createElement("div");
        div.classList.add("message");

        let sender = message.senderType;
        let text = message.message;

        if (!sender) sender = "알 수 없음";
        if (!text) text = "(빈 메시지)";

        if (sender === "USER") {
            div.classList.add("user");
        } else {
            div.classList.add("admin");
        }

        div.textContent = `${sender}: ${text}`;
        document.getElementById("chatBox").appendChild(div);

        document.getElementById("chatBox").scrollTop = document.getElementById("chatBox").scrollHeight;
    }

    window.onload = function() {
        document.getElementById('sendAdminBtn').addEventListener('click', sendAdminMessage);
    };
</script>
</body>
</html>
