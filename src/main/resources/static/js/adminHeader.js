document.querySelector(".header-close-btn").addEventListener("click",function(){
	document.querySelector(".sidebar").classList.add("closed");
})
document.querySelector(".header-open-btn").addEventListener("click",function(){
	document.querySelector(".sidebar").classList.remove("closed");
})