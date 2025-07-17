<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Admin Chat</title>
<style>
body {
	margin: 0;
	font-family: 'Noto Sans KR', sans-serif;
	background: #f4f4f4;
}
.container {
	display: flex;
	height: 100vh;
}
.sidebar {
	width: 300px;
	background: #fff;
	border-right: 1px solid #ddd;
	overflow-y: auto;
	padding: 20px;
}
.chat-area {
	flex-grow: 1;
	display: flex;
	flex-direction: column;
	padding: 20px;
}
.chat-header {
	font-weight: bold;
	margin-bottom: 10px;
}
#chatBox {
	flex-grow: 1;
	border: 1px solid #ddd;
	background: #fff;
	overflow-y: auto;
	padding: 10px;
	margin-bottom: 10px;
	display: flex;
	flex-direction: column;
	gap: 10px;
}
.message {
	display: inline-block;
	padding: 8px 12px;
	border-radius: 10px;
	max-width: 70%;
	word-break: break-word;
}
.user {
	background: #d1e7dd;
	align-self: flex-end;
	margin-left: auto;
}
.admin {
	background: #f8d7da;
	align-self: flex-start;
	margin-right: auto;
}
.input-area {
	display: flex;
	gap: 10px;
}
.input-area input {
	flex-grow: 1;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}
.input-area button {
	padding: 10px 15px;
	background: #007bff;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}
.input-area button:hover {
	background: #0056b3;
}
.room-item {
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	cursor: pointer;
	transition: background 0.2s;
}
.room-item:hover {
	background: #f1f1f1;
}
</style>
</head>
<body>

<div class="container">
	<div class="sidebar">
		<h3>방 목록</h3>
		<div id="roomList"></div>
	</div>
	<div class="chat-area" style="display: none;">
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
let currentRoomId = null;
const adminNo = ${sessionScope.loginAdminNo != null ? sessionScope.loginAdminNo : 999}; 

window.onload = function () {
	console.log("✅ window.onload 시작");
	loadRooms();
	document.getElementById('sendAdminBtn').addEventListener('click', sendAdminMessage);
};

function loadRooms() {
	fetch('/api/admin/chat/rooms') // ✅ 경로 수정
		.then(response => response.json())
		.then(data => {
			const roomList = document.getElementById("roomList");
			roomList.innerHTML = "";

			if (!data || data.length === 0) {
				roomList.innerHTML = "<p>현재 등록된 방이 없습니다.</p>";
				return;
			}

			data.forEach(room => {
				const div = document.createElement("div");
				div.className = "room-item";
				div.textContent = "방번호: " + room.roomId + " | 회원번호: " + (room.memberNo ?? "-") + " | 미확인: " + (room.unreadCount ?? "0");
				div.setAttribute("data-room-id", room.roomId ?? "");


				div.addEventListener("click", function () {
					const rid = this.getAttribute("data-room-id");
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

function enterRoom(roomId) {
	if (!roomId) {
		alert("유효하지 않은 방 번호입니다.");
		return;
	}

	currentRoomId = roomId;
	console.log("➡️ enterRoom 호출:", roomId);

	fetch(`/api/admin/chat/room/${roomId}/enter?adminNo=${adminNo}`, { method: 'POST' }) // ✅ 경로 수정
		.then(() => {
			document.querySelector(".chat-area").style.display = "flex";
			document.getElementById("roomTitle").textContent = `채팅방 #${roomId}`;

			fetch(`/api/admin/chat/room/${roomId}/messages`) // ✅ 경로 수정
				.then(res => res.json())
				.then(data => {
					const chatBox = document.getElementById("chatBox");
					chatBox.innerHTML = "";

					if (Array.isArray(data)) {
						data.forEach(showMessage);
					} else {
						console.warn("⚠️ 메시지 데이터가 배열이 아님:", data);
					}
				});

			connect(roomId);
		})
		.catch(err => {
			console.error("🚨 방 입장 실패:", err);
			alert("방 입장에 실패했습니다.");
		});
}

function connect(roomId) {
	const socket = new SockJS('/ws/chat'); // WebSocket endpoint
	stompClient = Stomp.over(socket);

	stompClient.connect({}, function (frame) {
		console.log("✅ WebSocket 연결됨:", frame);
		stompClient.subscribe(`/topic/room/${roomId}`, function (message) {
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

function sendAdminMessage() {
	const msg = document.getElementById("adminMessageInput").value.trim();

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
		senderId: adminNo,
		message: msg
	};

	stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(payload));
	document.getElementById("adminMessageInput").value = "";
}

function showMessage(message) {
	const sender = message.senderType ?? "알 수 없음";
	const text = message.message ?? "(빈 메시지)";
	const div = document.createElement("div");

	div.classList.add("message", sender === "USER" ? "user" : "admin");
	div.textContent = `${sender}: ${text}`;

	const chatBox = document.getElementById("chatBox");
	chatBox.appendChild(div);
	chatBox.scrollTop = chatBox.scrollHeight;
}
</script>

</body>
</html>
