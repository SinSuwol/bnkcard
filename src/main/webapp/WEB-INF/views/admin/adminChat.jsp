<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    // 세션에서 관리자 번호 꺼내 JS에 전달
    Object adminNoObj = session.getAttribute("loginAdminNo");
    Long adminNoLong = null;
    if (adminNoObj instanceof Number) {
        adminNoLong = ((Number)adminNoObj).longValue();
    } else if (adminNoObj instanceof String) {
        try { adminNoLong = Long.valueOf((String)adminNoObj); } catch(Exception ignore){}
    }
    if (adminNoLong == null) adminNoLong = 999L;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Admin Chat</title>
<style>
/* --- 스타일 기존 그대로 --- */
body { margin:0; font-family:'Noto Sans KR', sans-serif; background:#f4f4f4; }
.container { display:flex; height:100vh; }
.sidebar { width:300px; background:#fff; border-right:1px solid #ddd; overflow-y:auto; padding:20px; }
.chat-area { flex-grow:1; display:flex; flex-direction:column; padding:20px; }
.chat-header { font-weight:bold; margin-bottom:10px; }
#chatBox { flex-grow:1; border:1px solid #ddd; background:#fff; overflow-y:auto; padding:10px; margin-bottom:10px;
           display:flex; flex-direction:column; gap:10px; }
.message { display:inline-block; padding:8px 12px; border-radius:10px; max-width:70%; word-break:break-word; }
.user { background:#d1e7dd; align-self:flex-end; margin-left:auto; }
.admin { background:#f8d7da; align-self:flex-start; margin-right:auto; }
.input-area { display:flex; gap:10px; }
.input-area input { flex-grow:1; padding:10px; border:1px solid #ccc; border-radius:5px; }
.input-area button { padding:10px 15px; background:#007bff; color:#fff; border:none; border-radius:5px; cursor:pointer; }
.input-area button:hover { background:#0056b3; }
.room-item { padding:10px; margin-bottom:10px; border:1px solid #ddd; border-radius:5px; cursor:pointer; transition:background 0.2s; }
.room-item:hover { background:#f1f1f1; }
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
/* JSP에서 전달받은 관리자 번호 */
const ADMIN_NO_SERVER = <%= adminNoLong %>;
console.log("🔐 서버세션 adminNo =", ADMIN_NO_SERVER);

let stompClient = null;
let currentRoomId = null;

window.onload = function () {
	console.log("✅ window.onload 시작");
	loadRooms();
	document.getElementById('sendAdminBtn').addEventListener('click', sendAdminMessage);
};

/* 방 목록 로드 */
function loadRooms() {
	fetch('/api/admin/chat/rooms')
		.then(response => response.json())
		.then(data => {
			console.log("📦 방 목록:", data);
			const roomList = document.getElementById("roomList");
			roomList.innerHTML = "";

			if (!Array.isArray(data) || data.length === 0) {
				roomList.innerHTML = "<p>현재 등록된 방이 없습니다.</p>";
				return;
			}

			data.forEach(room => {
				if (!room || room.roomId == null) return;

				const div = document.createElement("div");
				div.className = "room-item";
				div.textContent =
				    "방번호: " + room.roomId +
				    " | 회원번호: " + (room.memberNo ?? "-") +
				    " | 미확인: " + (room.unreadCount ?? "0");

				div.dataset.roomId = room.roomId;

				div.addEventListener("click", function () {
					const rid = Number(this.dataset.roomId);
					console.log("📥 클릭된 roomId:", rid);
					enterRoom(rid);
				});

				roomList.appendChild(div);
			});
		})
		.catch(error => {
			console.error("❌ 방 목록 오류:", error);
		});
}

/* 방 입장 */
function enterRoom(roomId) {
	if (!roomId || isNaN(roomId)) {
		alert("유효하지 않은 방 번호입니다.");
		return;
	}
	if (!ADMIN_NO_SERVER || isNaN(ADMIN_NO_SERVER)) {
		alert("관리자 번호가 유효하지 않습니다. 다시 로그인하세요.");
		return;
	}

	currentRoomId = roomId;
	console.log("➡️ enterRoom 호출:", roomId, "관리자:", ADMIN_NO_SERVER);

	const enterUrl = '/api/admin/chat/room/' + roomId + '/enter?adminNo=' + ADMIN_NO_SERVER;
	console.log("🌐 Enter 요청 URL:", enterUrl);

	fetch(enterUrl, { method: 'POST' })
		.then(res => {
			if (!res.ok) throw new Error("관리자 배정 실패:" + res.status);

			// UI show
			document.querySelector(".chat-area").style.display = "flex";
			document.getElementById("roomTitle").textContent = '채팅방 #' + roomId;

			// 메시지 로드
			const msgUrl = '/api/admin/chat/room/' + roomId + '/messages';
			console.log("🌐 메시지 로드 URL:", msgUrl);
			return fetch(msgUrl);
		})
		.then(res => res.json())
		.then(data => {
			const chatBox = document.getElementById("chatBox");
			chatBox.innerHTML = "";
			if (Array.isArray(data)) {
				data.forEach(showMessage);
			} else {
				console.warn("⚠️ 메시지 데이터가 배열이 아님:", data);
			}
			// WebSocket 연결
			connect(roomId);
		})
		.catch(err => {
			console.error("🚨 방 입장 실패:", err);
			alert("방 입장에 실패했습니다.");
		});
}

/* WebSocket 연결 */
function connect(roomId) {
	// 기존 연결 끊기 (선택)
	if (stompClient && stompClient.connected) {
		stompClient.disconnect(() => console.log("🔌 이전 WS 연결 해제"));
	}

	const socket = new SockJS('/ws/chat');
	stompClient = Stomp.over(socket);

	stompClient.connect({}, function (frame) {
		console.log("✅ WebSocket 연결됨:", frame);
		const topic = '/topic/room/' + roomId;
		console.log("📡 구독:", topic);
		stompClient.subscribe(topic, function (message) {
			console.log("📩 WS 수신:", message.body);
			try {
				const data = JSON.parse(message.body);
				showMessage(data);
			} catch (err) {
				console.error("❌ 메시지 파싱 실패:", err);
			}
		});
	}, function (err) {
		console.error("❌ WebSocket 연결 실패:", err);
	});
}

/* 관리자 메시지 전송 */
function sendAdminMessage() {
	const msgEl = document.getElementById("adminMessageInput");
	const msg = msgEl.value.trim();

	if (!msg) {
		alert("메시지를 입력하세요.");
		return;
	}
	if (!currentRoomId) {
		alert("먼저 채팅방에 입장하세요.");
		return;
	}

	const payload = {
		roomId: currentRoomId,
		senderType: "ADMIN",
		senderId: ADMIN_NO_SERVER,
		message: msg
	};

	console.log("🚀 관리자 메시지 송신:", payload);
	stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(payload));
	msgEl.value = "";
}

/* 메시지 표시 */
function showMessage(message) {
	const sender = message.senderType ?? "알 수 없음";
	const text   = message.message ?? "(빈 메시지)";
	const time   = message.sentAt ? formatTime(message.sentAt) : "";

	const div = document.createElement("div");
	div.classList.add("message", sender === "USER" ? "user" : "admin");
	div.textContent = sender + ": " + text + (time ? " (" + time + ")" : "");

	const chatBox = document.getElementById("chatBox");
	chatBox.appendChild(div);
	chatBox.scrollTop = chatBox.scrollHeight;
}

function formatTime(t) {
	try {
		const d = new Date(t);
		if (isNaN(d.getTime())) return "";
		return d.toLocaleTimeString();
	} catch(e) {
		return "";
	}
}
</script>
</body>
</html>
