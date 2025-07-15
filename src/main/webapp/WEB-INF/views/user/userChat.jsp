<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>User Chat</title>
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
<h2>User Chat Page</h2>

<div id="chatBox"></div>

<input type="text" id="messageInput" placeholder="메시지를 입력하세요">
<button id="sendBtn">보내기</button>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script>
    let stompClient = null;
    let roomId = null;
    let memberNo = null;

    window.onload = function() {
        // ① 로그인 유저 정보 조회
        fetch('/user/chat/info')
            .then(response => {
                if (!response.ok) throw new Error("로그인 정보 없음");
                return response.json();
            })
            .then(data => {
                console.log("유저 정보:", data);
                memberNo = data.memberNo;

                // ② 방 생성 요청
                return fetch('/user/chat/room', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: `memberNo=${memberNo}`
                });
            })
            .then(response => {
                if (!response.ok) throw new Error("방 생성 실패");
                return response.text();
            })
            .then(id => {
                roomId = Number(id);
                console.log("생성된 roomId:", roomId);

                connect(roomId);
                loadPreviousMessages(roomId);

                document.getElementById('sendBtn').addEventListener('click', sendMessage);
            })
            .catch(err => {
                console.error(err);
                alert("로그인이 필요합니다.");
                window.location.href = "/user/login";
            });
    };

    function connect(roomId) {
        const socket = new SockJS('/ws/chat');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, function(frame) {
            console.log("WebSocket 연결됨:", frame);
            stompClient.subscribe('/topic/room/' + roomId, function(message) {
                let data;
                try {
                    data = JSON.parse(message.body);
                    showMessage(data);
                } catch (e) {
                    console.error("JSON 파싱 오류:", e);
                }
            });
        });
    }

    function loadPreviousMessages(roomId) {
        fetch(`/user/chat/room/${roomId}/messages`)
            .then(res => res.json())
            .then(data => {
                console.log("기존 메시지:", data);
                document.getElementById("chatBox").innerHTML = "";
                if (Array.isArray(data)) {
                    data.forEach(showMessage);
                }
            })
            .catch(err => console.error("이전 메시지 로딩 오류:", err));
    }

    function sendMessage() {
        const msg = document.getElementById('messageInput').value.trim();

        if (!msg) {
            alert("메시지를 입력하세요.");
            return;
        }

        const payload = {
            roomId: roomId,
            senderType: "USER",
            senderId: memberNo,
            message: msg
        };

        console.log("전송 payload:", payload);

        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(payload));
        document.getElementById('messageInput').value = "";
    }

    function showMessage(message) {
        console.log("수신 데이터:", message);

        const sender = message.senderType ?? "알 수 없음";
        const text = message.message ?? "(빈 메시지)";

        const div = document.createElement("div");
        div.classList.add("message");
        div.classList.add(sender === "USER" ? "user" : "admin");
        div.textContent = sender + ": " + text;

        document.getElementById("chatBox").appendChild(div);
        document.getElementById("chatBox").scrollTop = document.getElementById("chatBox").scrollHeight;
    }
</script>
</body>
</html>
