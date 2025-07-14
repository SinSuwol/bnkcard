function formatTime(sec){
	const min = Math.floor(sec / 60);
	const secStr = sec % 60 < 10 ? "0" + (sec % 60) : (sec % 60);
	return min + ":" + secStr;
}

function updateTimer(){
	const timer = document.getElementById("session-timer");
	if(remainingSeconds <= 0){
		timer.textContent = "00:00";
		clearInterval(timerInterval);
		
		location.href = "/logout";
		return;
	}
	timer.textContent = formatTime(remainingSeconds);
	remainingSeconds--;
}

const timerInterval = setInterval(updateTimer, 1000);
updateTimer();

function extend(){
	fetch("/session/keep-session", {
		method: "POST"
	})
	.then(res => res.json())
	.then(data => {
		if (data.remainingSeconds) {
			remainingSeconds = data.remainingSeconds;
			updateTimer();
		}
	});
}

function logout(){
	if(confirm("로그아웃 하시겠습니까?")){
		document.getElementById("logoutForm").submit();
	}
}