<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>카드 챗봇</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #FFF8F0;
            padding: 20px;
        }

        .chat-container {
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            border-radius: 12px;
            background-color: white;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
        }

        .chat-box {
            height: 430px;
            overflow-y: auto;
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 15px;
            background: #fafafa;
            display: flex;
            flex-direction: column;
            gap: 10px;
            border-radius: 10px;
        }

        .chat-entry {
            padding: 12px 16px;
            border-radius: 18px;
            max-width: 75%;
            word-break: break-word;
            position: relative;
            line-height: 1.5;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .chat-entry.user {
            background-color: #FF7043;
            color: white;
            align-self: flex-end;
            border-bottom-right-radius: 4px;
        }

        .chat-entry.user::after {
            content: '';
            position: absolute;
            right: -10px;
            top: 10px;
            border: 6px solid transparent;
            border-left-color: #FF7043;
        }

        .chat-entry.bot {
            background-color: #e0e0e0;
            color: #333;
            align-self: flex-start;
            border-bottom-left-radius: 4px;
        }

        .chat-entry.bot::after {
            content: '';
            position: absolute;
            left: -10px;
            top: 10px;
            border: 6px solid transparent;
            border-right-color: #e0e0e0;
        }

        #inputArea {
            display: flex;
            gap: 10px;
        }

        input[type="text"] {
            flex: 1;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button {
            padding: 10px 15px;
            background-color: #FF7043;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 6px;
        }
    </style>
</head>
<body>

<div class="chat-container">
    <h2 style="text-align:center;">카드 추천 챗봇</h2>
    <div class="chat-box" id="chatBox">
        <!-- 대화 메시지 -->
    </div>

    <div id="inputArea">
        <input type="text" id="userInput" placeholder="질문을 입력하세요" onkeydown="if(event.key === 'Enter') sendMessage()">
        <button onclick="sendMessage()">보내기</button>
    </div>
</div>

<script>
window.onload = function () {
    appendMessage("안녕하세요! 고객님의 생활에 도움이 되는 카드를 추천해드릴게요 😊", "bot");
};

function sendMessage() {
    const input = document.getElementById("userInput");
    const question = input.value.trim();
    if (!question) return;

    appendMessage(question, "user");
    input.value = "";

    fetch("/user/card/chatbot", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ question: question })
    })
    .then(res => res.text())
    .then(answer => {
        appendMessage(answer, "bot");
    })
    .catch(err => {
        appendMessage("서버 오류가 발생했습니다.", "bot");
    });
}

function appendMessage(message, type) {
    const chatBox = document.getElementById("chatBox");
    const div = document.createElement("div");
    div.className = `chat-entry ${type}`;
    div.innerText = message;
    chatBox.appendChild(div);
    chatBox.scrollTop = chatBox.scrollHeight;
}
</script>

</body>
</html>
