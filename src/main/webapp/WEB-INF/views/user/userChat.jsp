<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>User Chat</title>
<link rel="stylesheet" href="/css/style.css">
<style>
#chatBox {
    width: 400px; height: 400px;
    border: 1px solid #ccc;
    overflow-y: scroll;
    padding: 10px; margin-bottom: 10px;
    background: #f9f9f9;
    display: flex; flex-direction: column; gap: 10px;
}
.message {
    display: inline-block;
    padding: 8px 12px;
    border-radius: 10px;
    max-width: 70%; min-width: 50px;
    word-break: break-all;
    font-size: 14px; color: #000;
}
.user  { background: #d1e7dd; align-self: flex-end; }
.admin { background: #f8d7da; align-self: flex-start; }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/fragments/mainheader2.jsp" />

<h2>User Chat Page</h2>

<div id="chatBox"></div>
<input type="text" id="messageInput" placeholder="메시지를 입력하세요">
<button id="sendBtn">보내기</button>

<script src="/js/header2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script>
let stompClient = null;
let roomId = null;
let memberNo = null;

window.onload = function() {
    initChatFlow();
};

function initChatFlow() {
    console.log("▶ initChatFlow()");

    // --- 1. 로그인 사용자 정보 ---
    fetch('/user/chat/info', { credentials: 'same-origin' })
        .then(r => {
            console.log("INFO status:", r.status);
            if (!r.ok) throw new Error("로그인 정보 없음");
            return r.json();
        })
        .then(data => {
            console.log("INFO data:", data);
            memberNo = data.memberNo;
            if (!memberNo) throw new Error("세션 memberNo 없음");

            // --- 2. 기존 방 조회 ---
            return fetch('/user/chat/my-room', { credentials: 'same-origin' });
        })
        .then(r => {
            console.log("MY-ROOM status:", r.status);
            if (r.status === 404) {
                console.log("기존 방 없음 → 새 방 생성 진행.");
                return createRoomForMember(memberNo);
            }
            if (!r.ok) throw new Error("my-room 조회 실패");
            return r.text();   // body = roomId (text)
        })
        .then(idText => {
            if (!idText) {
                throw new Error("my-room 응답이 비어 있음 → 새 방 생성 시도");
            }
            // my-room이 숫자 roomId를 텍스트로 보내니까 Number 처리
            let parsed = Number(idText);
            if (isNaN(parsed) || parsed <= 0) {
                console.warn("my-room 응답이 숫자가 아님. 새 방 생성 시도:", idText);
                return createRoomForMember(memberNo);
            }
            return parsed;
        })
        .then(id => {
        	 if (!id || isNaN(id)) {
        	        console.error("roomId가 유효하지 않습니다. 받은 값:", id);
        	        throw new Error("roomId 불러오기 실패");
        	    }
        	 
            roomId = id;
            console.log("최종 roomId 확정:", roomId);

            connect(roomId);
            loadPreviousMessages(roomId);

            document.getElementById('sendBtn').addEventListener('click', sendMessage);
        })
        .catch(err => {
            console.error("initChatFlow 실패:", err);
            alert("로그인이 필요하거나 채팅 초기화에 실패했습니다.");
            window.location.href = "/user/login";
        });
}

/* 새 방 생성 */
function createRoomForMember(memberNo) {
    console.log("▶ createRoomForMember(", memberNo, ")");
    return fetch('/user/chat/room', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'memberNo=' + encodeURIComponent(memberNo),
        credentials: 'same-origin'
    })
    .then(r => {
        console.log("CREATE-ROOM status:", r.status);
        if (!r.ok) throw new Error("방 생성 실패");
        return r.text();
    })
    .then(idText => {
        console.log("CREATE-ROOM raw id:", idText);
        const id = Number(idText);
        if (!id || isNaN(id)) throw new Error("방 생성 응답이 숫자가 아님: " + idText);
        return id;
    });
}

function connect(roomId) {
    if (!roomId) {
        console.error("connect() 호출 실패 - roomId 없음");
        return;
    }
    const socket = new SockJS('/ws/chat');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function(frame) {
        console.log("WebSocket 연결됨:", frame);
        stompClient.subscribe('/topic/room/' + roomId, function(message) {
            try {
                const data = JSON.parse(message.body);
                showMessage(data);
            } catch (e) {
                console.error("WebSocket 메시지 JSON 파싱 오류:", e, message.body);
            }
        });
    }, function(error) {
        console.error("WebSocket 연결 실패:", error);
    });
}

function loadPreviousMessages(id) {
    if (!id || isNaN(id)) {
        console.error("loadPreviousMessages() 실패 - roomId가 유효하지 않음:", id);
        return;
    }

    const url = "/user/chat/room/" + encodeURIComponent(id) + "/messages";
    console.log("▶ loadPreviousMessages() 요청 URL:", url);

    fetch(url, { credentials: 'same-origin' })
        .then(res => {
            console.log("LOAD-MSG status:", res.status);
            if (!res.ok) throw new Error("메시지 조회 실패");
            return res.json();
        })
        .then(data => {
            console.log("LOAD-MSG data:", data);
            const box = document.getElementById("chatBox");
            box.innerHTML = "";
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
    if (!roomId || !memberNo) {
        alert("채팅이 초기화되지 않았습니다. 다시 시도해주세요.");
        return;
    }
    const payload = {
        roomId: roomId,
        senderType: "USER",
        senderId: memberNo,
        message: msg
    };
    console.log("SEND payload:", payload);
    stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(payload));
    document.getElementById('messageInput').value = "";
}

function showMessage(message) {
    console.log("MSG:", message);
    const sender = message.senderType ?? "알 수 없음";
    const text   = message.message ?? "(빈 메시지)";
    const div = document.createElement("div");
    div.classList.add("message", sender === "USER" ? "user" : "admin");
    div.textContent = sender + ": " + text;
    const box = document.getElementById("chatBox");
    box.appendChild(div);
    box.scrollTop = box.scrollHeight;
}
</script>
</body>
</html>
