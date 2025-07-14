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
        let roomId = 1;
        let memberNo = 1234;

        window.onload = function() {
            connect(roomId);
            document.getElementById('sendBtn').addEventListener('click', sendMessage);
        };

        function connect(roomId) {
            const socket = new SockJS('/ws/chat');
            stompClient = Stomp.over(socket);

            stompClient.connect({}, function(frame) {
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

            stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(payload));
            document.getElementById('messageInput').value = "";
        }
        function showMessage(message) {
            console.log("수신 데이터:", message);

            const sender = (message.senderType !== undefined && message.senderType !== null)
                ? message.senderType
                : "알 수 없음";

            const text = (message.message !== undefined && message.message !== null)
                ? message.message
                : "(빈 메시지)";

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
