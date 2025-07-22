<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>부뱅이 챗봇</title>

<!-- ───── BNK 스타일 ───── -->
<style>
:root { /* 브랜드 컬러 팔레트 */
	--bnk-red: #D6001C;
	--bnk-gray: #F5F6F8;
	--text-dark: #333;
}

/* 배경 */
body {
	font-family: 'Noto Sans KR', sans-serif;
	background: var(--bnk-gray);
	display: flex;
	justify-content: center;
	padding: 24px;
}

/* 팝업(520×750) */
.chat-container {
	width: 100%;
	max-width: 520px;
	height: 660px;
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 4px 18px rgba(0, 0, 0, .12);
	display: flex;
	flex-direction: column;
	padding: 24px;
}

.chat-container h2 {
	margin: 0 0 16px;
	font-size: 22px;
	font-weight: 500;
	text-align: center;
	color: var(--bnk-red);
}

/* 대화 영역 */
.chat-box {
	flex: 1;
	overflow-y: auto;
	background: #FAFAFA;
	border: 1px solid #E0E0E0;
	border-radius: 12px;
	padding: 16px;
	display: flex;
	flex-direction: column;
	gap: 12px;
}

/* 말풍선 공통 */
.chat-entry {

	max-width: 78%;
	padding: 12px 16px;
	border-radius: 20px;
	line-height: 1.55;
	word-break: break-word;
	position: relative;
	box-shadow: 0 2px 5px rgba(0, 0, 0, .08);
}
/* 사용자(오른쪽) */
.chat-entry.user {
	align-self: flex-end;
	background: var(--bnk-red);
	color: #fff;
	border-bottom-right-radius: 6px;
}

.chat-entry.user::after {
	content: '';
	position: absolute;
	top: 12px;
	right: -10px;
	border: 6px solid transparent;
	border-left-color: var(--bnk-red);
}
/* 챗봇/로딩(왼쪽) */
.chat-entry.bot {
	align-self: flex-start;
	background: #E9E9E9;
	color: var(--text-dark);
	border-bottom-left-radius: 6px;
}

.chat-entry.bot::after {
	content: '';
	position: absolute;
	top: 12px;
	left: -10px;
	border: 6px solid transparent;
	border-right-color: #E9E9E9;
}

/* 입력 영역 */
#inputArea {
	margin-top: 18px;
	display: flex;
	gap: 10px;
}

#userInput {
	flex: 1;
	padding: 12px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 8px;
}

button {
	padding: 0 20px;
	background: var(--bnk-red);
	color: #fff;
	border: none;
	border-radius: 8px;
	cursor: pointer;
}

/* 링크 색상 */
a.card-link {
	color: var(--bnk-red);
	text-decoration: underline;
}
</style>
</head>
<body>

	<div class="chat-container">
		<h2>카드 추천 챗봇</h2>

		<div class="chat-box" id="chatBox"></div>

		<div id="inputArea">
			<input type="text" id="userInput" placeholder="질문을 입력하세요"
				onkeydown="if(event.key==='Enter') sendMessage()">
			<button onclick="sendMessage()">보내기</button>
		</div>
	</div>

	<script>
/* 첫 인삿말 */
window.onload = () =>
    appendMessage("안녕하세요! 고객님의 생활에 도움이 되는 카드를 추천해드릴게요 😊","bot");

/* URL → 링크 + 줄바꿈 */
function makeLinksClickable(txt){
    return txt.replace(/<a[^>]*>(.*?)<\/a>/gi,"$1")
              .replace(/(https?:\/\/[^\s<]+)/g,
                       '<a href="$1" target="_blank" rel="noopener noreferrer" class="card-link">카드 상세보기</a>')
              .replace(/\n/g,"<br>");
}

/* 말풍선 생성 (isTemp: 로딩용 여부) */
function appendMessage(msg,type,isTemp=false){
    const box=document.getElementById("chatBox");
    const div=document.createElement("div");
    div.className = 'chat-entry ' + type; 
    div.innerHTML=makeLinksClickable(msg);
    box.appendChild(div); box.scrollTop=box.scrollHeight;
    return isTemp?div:null;
}

/* 로딩 말풍선 애니메이션 */
function createTypingBubble(){
    let dots=1;
    const bubble=appendMessage("작성중.","bot",true);
    const timer=setInterval(()=>{
        dots=dots%3+1;
        bubble.textContent="작성중"+'.'.repeat(dots);
    },400);
    return {bubble,timer};
}

/* 메시지 전송 */
function sendMessage(){
    const input=document.getElementById("userInput");
    const q=input.value.trim(); if(!q) return;
    appendMessage(q,"user"); input.value="";

    /* 로딩 말풍선 */
    const {bubble,timer}=createTypingBubble();

    fetch("/user/card/chatbot",{
        method:"POST",
        headers:{ "Content-Type":"application/json" },
        body:JSON.stringify({question:q})
    })
    .then(res=>res.text())
    .then(ans=>{
        clearInterval(timer); bubble.remove();
        appendMessage(ans,"bot");
    })
    .catch(()=>{
        clearInterval(timer); bubble.remove();
        appendMessage("서버 오류가 발생했습니다.","bot");
    });
}
</script>

</body>
</html>
