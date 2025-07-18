<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
 <!-- ★ 추가 -->

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="rs" value="${empty remainingSeconds ? 0 : remainingSeconds}" />

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>고객센터 FAQ</title>
<link rel="stylesheet" href="${ctx}/css/style.css">
<!-- 공통 css -->

<style>
/* ===== 기존 스타일 그대로 ===== */
:root {
	--bnk-red: #d6001c;
	--bnk-red-dark: #bb0018;
	--bnk-gray-bg: #f5f6f8;
	--bnk-gray-border: #d5d7db;
	--bnk-gray-text: #555;
	--bnk-gray-text-light: #777;
	--bnk-radius: 6px;
	--bnk-transition: 0.15s;
	--bnk-max-width: 1000px;
	--bnk-cat-bg: #e9ecef;
	--bnk-cat-text: #444;
	--bnk-cat-radius: 10px;
}

body {
	background: var(--bnk-gray-bg);
	margin: 0;
	font-family: 'Noto Sans KR', '맑은 고딕', sans-serif;
	color: #000
}

.main-content {
	padding-top: 70px;
	margin: 0 auto;
	width: 100%;
	max-width: var(--bnk-max-width);
	padding-left: 30px;
	padding-right: 30px;
	box-sizing: border-box
}

.main-content h1 {
	margin-top: 0;
	font-size: 28px;
	font-weight: 700
}

hr {
	border: none;
	border-top: 1px solid var(--bnk-gray-border);
	margin: 16px 0 24px
}

.faq-search-form {
	display: flex;
	align-items: center;
	gap: 8px;
	max-width: 400px
}

.faq-search-form input[type="text"] {
	flex: 1;
	padding: 8px 10px;
	font-size: 15px;
	border: 1px solid var(--bnk-gray-border);
	border-radius: var(--bnk-radius)
}

.faq-search-form button {
	padding: 8px 16px;
	font-size: 15px;
	font-weight: 600;
	color: #fff;
	background: var(--bnk-red);
	border: none;
	border-radius: var(--bnk-radius);
	cursor: pointer;
	transition: background var(--bnk-transition)
}

.faq-search-form button:hover {
	background: var(--bnk-red-dark)
}

.faq-table-wrapper {
	margin-top: 16px;
	overflow-x: auto;
	border: 1px solid var(--bnk-gray-border);
	border-radius: var(--bnk-radius);
	background: #fff
}

table.faq-table {
	width: 100%;
	border-collapse: collapse;
	min-width: 600px;
	font-size: 15px
}

table.faq-table thead th {
	background: var(--bnk-red);
	color: #fff;
	padding: 10px;
	text-align: left;
	font-weight: 700;
	border-bottom: 1px solid var(--bnk-red-dark);
	white-space: nowrap
}

table.faq-table tbody td {
	padding: 10px;
	border-bottom: 1px solid var(--bnk-gray-border);
	vertical-align: top
}

table.faq-table tbody tr:nth-child(odd) {
	background: #fafbfc
}

table.faq-table tbody tr:hover {
	background: #fff3f3;
	cursor: pointer
} /* ★ NEW : cursor 손모양 */
table.faq-table th:first-child, table.faq-table td:first-child {
	width: 60px;
	text-align: center
}

.faq-cat {
	display: inline-block;
	padding: 2px 10px;
	font-size: 13px;
	background: var(--bnk-cat-bg);
	color: var(--bnk-cat-text);
	border-radius: var(--bnk-cat-radius);
	white-space: nowrap
}

.faq-answer {
	white-space: pre-wrap;
	line-height: 1.4;
	color: var(--bnk-gray-text)
}
/* ===== JS로 그릴 페이지네이션용 컨테이너 ===== */
.faq-paging {
	margin-top: 24px;
	font-size: 16px;
	text-align: center
}

.faq-paging a {
	margin: 0 4px;
	text-decoration: none;
	color: var(--bnk-red);
	font-weight: 600
}

.faq-paging a:hover {
	text-decoration: underline
}

.faq-paging strong {
	margin: 0 4px;
	color: #000
}
/* ===== 모달 ===== */
/* ★ NEW : 모달 bg / content */
.modal-bg {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, .45);
	display: none;
	align-items: center;
	justify-content: center;
	z-index: 999
}

.modal-content {
	background: #fff;
	padding: 30px;
	border-radius: var(--bnk-radius);
	max-width: 650px;
	width: 92%;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .25);
	position: relative
}

.modal-title {
	margin-top: 0;
	font-size: 22px;
	font-weight: 700
}

.modal-answer {
	margin-top: 20px;
	white-space: pre-wrap;
	line-height: 1.6;
	color: var(--bnk-gray-text)
}

.modal-category {
	margin-top: 6px;
	font-size: 14px;
	color: var(--bnk-gray-text-light)
}

.modal-close {
	position: absolute;
	top: 12px;
	right: 16px;
	font-size: 28px;
	color: #999;
	cursor: pointer
}

.modal-close:hover {
	color: #444
}

#chatbotFab {
	background: var(--bnk-red) !important
}

#chatbotFab:hover {
	background: var(--bnk-red-dark) !important
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/fragments/mainheader2.jsp" />

	<div class="main-content">
		<h1>고객센터 (FAQ)</h1>
		<hr>

		<!-- 검색 -->
		<form class="faq-search-form" method="get" action="${ctx}/faq/list">
			<input type="text" name="keyword" placeholder="검색어를 입력하세요"
				value="${keyword}">
			<button type="submit">검색</button>
		</form>

		<!-- FAQ 테이블 -->
		<div class="faq-table-wrapper">
			<table class="faq-table">
				<thead>
					<tr>
						<th>번호</th>
						<th>질문</th>
						<th>답변</th>
						<th>카테고리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="faq" items="${faqList}">
						<!-- ★ NEW : data-* 넣어두고 tr 클릭 시 모달 -->
						<tr class="faq-row"
							data-question="${fn:escapeXml(faq.faqQuestion)}"
							data-answer="${fn:escapeXml(faq.faqAnswer)}"
							data-category="${fn:escapeXml(faq.cattegory)}">
							<td>${faq.faqNo}</td>
							<td>${faq.faqQuestion}</td>
							<td class="faq-answer">${faq.faqAnswer}</td>
							<td><span class="faq-cat">${faq.cattegory}</span></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- 페이지네이션 컨테이너 (JS로 채움) -->
		<div id="pagination" class="faq-paging"></div>
	</div>
	<!-- /.main-content -->

	<!-- ===== 모달 구조 ===== -->
	<!-- ★ NEW -->
	<div id="faqModal" class="modal-bg">
		<div class="modal-content">
			<span class="modal-close" id="modalClose">&times;</span>
			<h2 class="modal-title" id="modalQuestion"></h2>
			<div class="modal-category" id="modalCategory"></div>
			<div class="modal-answer" id="modalAnswer"></div>
		</div>
	</div>

	<script src="${ctx}/js/header2.js"></script>
	<script>
    /* 남은 세션시간 (초) */
    let remainingSeconds = ${rs};

    /* ===== 모달 로직 ===== */
    const modalBg        = document.getElementById('faqModal');
    const modalCloseBtn  = document.getElementById('modalClose');
    const modalQ         = document.getElementById('modalQuestion');
    const modalCat       = document.getElementById('modalCategory');
    const modalA         = document.getElementById('modalAnswer');

    document.querySelectorAll('.faq-row').forEach(tr=>{
        tr.addEventListener('click',()=>{
            modalQ.textContent  = tr.dataset.question;
            modalCat.textContent= '카테고리 : ' + tr.dataset.category;
            modalA.textContent  = tr.dataset.answer;
            modalBg.style.display='flex';
        });
    });
    modalCloseBtn.addEventListener('click',()=>modalBg.style.display='none');
    modalBg.addEventListener('click',e=>{
        if(e.target===modalBg) modalBg.style.display='none';
    });

    /* ===== 페이지네이션 (3개씩 보여주고 슬라이딩) ===== */
    (function(){
    const totalPage   = ${totalPage};
    const currentPage = ${currentPage};
    const ctx         = '${ctx}';
    const keyword     = encodeURIComponent('${keyword}');
    const groupSize   = 3;

    function buildPageLink(p){
        return ctx + '/faq/list?keyword=' + keyword + '&page=' + p;
    }

    const pagin = document.getElementById('pagination');
    if(!pagin) return;

    let start = Math.max(1, currentPage - 1);
    let end   = Math.min(totalPage, start + groupSize - 1);
    if(end - start < groupSize - 1) start = Math.max(1, end - groupSize + 1);

    /* « 처음 */
    pagin.insertAdjacentHTML('beforeend',
        '<a href="' + buildPageLink(1) + '">« 처음</a>');

    /* 가변 숫자 버튼 */
    for(let i=start;i<=end;i++){
        if(i === currentPage){
            pagin.insertAdjacentHTML('beforeend',
                '<strong>[' + i + ']</strong>');
        }else{
            pagin.insertAdjacentHTML('beforeend',
                '<a href="' + buildPageLink(i) + '">[' + i + ']</a>');
        }
    }

    /* 마지막 » */
    pagin.insertAdjacentHTML('beforeend',
        '<a href="' + buildPageLink(totalPage) + '">마지막 »</a>');
})();
    </script>

	<script src="${ctx}/js/sessionTime.js"></script>
	<!-- 공통 챗봇 모달 -->
	<jsp:include page="/WEB-INF/views/fragments/chatbotModal.jsp" />
	<script src="/js/header2.js"></script>
<script>
	let remainingSeconds = ${remainingSeconds};
</script>
<script src="/js/sessionTime.js"></script>
</body>
</html>



<!--
추가하고 싶으면
 <jsp:include page="/WEB-INF/views/fragments/chatbotModal.jsp">
    <jsp:param name="contextPath" value="${ctx}" />
</jsp:include>
 -->

