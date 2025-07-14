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

	<script
		src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
	<script>
    let stompClient = null;
    let roomId = null;
    let memberNo = 1234; // 테스트용

    window.onload = function() {
        // ① 방 먼저 생성
        fetch("/chat/room", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: "memberNo=" + memberNo
        })
        .then(response => response.text())
        .then(id => {
            roomId = id;
            console.log("방 생성됨. roomId = " + roomId);
            connect(roomId);
        });

        // 버튼 이벤트 등록
        document.getElementById('sendBtn').addEventListener('click', sendMessage);
    };

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

    function sendMessage() {
        const msg = document.getElementById('messageInput').value;

        if (!msg || msg.trim() === "") {
            alert("메시지를 입력하세요.");
            return;
        }

        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify({
            roomId: roomId,
            senderType: "USER",
            senderId: memberNo,
            message: msg
        }));

        document.getElementById('messageInput').value = "";
    }

    function showMessage(message) {
        console.log("수신 메시지:", message);
        console.log("message.senderType:", message.senderType);
        console.log("message.message:", message.message);

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

        // ✅ innerHTML 대신 textContent 사용
        div.textContent = `${sender}: ${text}`;
        document.getElementById("chatBox").appendChild(div);

        document.getElementById("chatBox").scrollTop = document.getElementById("chatBox").scrollHeight;
    }

</script>
</body>
</html>
