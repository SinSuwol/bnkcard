<%@ page contentType="text/html; charset=UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카드 상세</title>
  <link rel="stylesheet" href="/css/style.css">
  <style>
    html, body {
      background: #fff;
      margin: 0;
      padding: 0;
      font-family: 'Noto Sans KR', sans-serif;
      color: #333;
      box-sizing: border-box;
    }

    *, *::before, *::after {
      box-sizing: inherit;
    }

    .wrap {
      width: 100%;
      max-width: 1000px;
      margin: 0px auto;
    }

    .top {
      display: flex;
      flex-wrap: wrap;
      gap: 40px;
      padding: 40px 20px 20px;
      align-items: flex-start;
    }

    .card-img {
      width: 260px;
      min-width: 260px;
      max-width: 260px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }

    .info {
      flex: 1 1 0;
      min-width: 0;
    }

    .info h2 {
      font-size: 32px;
      font-weight: 700;
      color: #111;
      margin: 0;
    }

    .info p {
      font-size: 18px;
      color: #555;
      margin: 14px 0;
    }

    .fee-box {
      margin-top: 20px;
      display: flex;
      gap: 20px;
    }

    .fee-line {
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .fee-line img {
      width: 24px;
    }

    .fee-line span {
      font-size: 16px;
      font-weight: 500;
    }

    .summary-benefit {
      display: flex;
      gap: 12px;
      margin-top: 20px;
      flex-wrap: wrap;
    }

    .benefit-card {
      background: #f0f4ff;
      padding: 10px 14px;
      border-radius: 20px;
      font-size: 14px;
      font-weight: 500;
      color: #002e5b;
      border: 1px solid #cdd9ff;
    }

    .accordion-container {
      padding: 20px;
    }

    .accordion {
      background: #f8f9fb;
      border: 1px solid #dcdfe6;
      border-radius: 6px;
      padding: 18px 22px;
      margin-bottom: 14px;
      cursor: pointer;
    }

    .accordion:hover {
      background: #edf0f6;
    }

    .accordion h4 {
      margin: 0;
      font-size: 17px;
      font-weight: 600;
      color: #002e5b;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .accordion p {
      display: none;
      margin-top: 12px;
      font-size: 15px;
      color: #444;
      line-height: 1.6;
    }

    .accordion.active p {
      display: block;
    }

    .section {
      padding: 30px 20px;
    }

    .section h3 {
      margin-bottom: 16px;
      font-size: 18px;
      font-weight: 600;
      color: #002e5b;
      border-left: 4px solid #002e5b;
      padding-left: 10px;
    }

    .section pre {
      white-space: pre-wrap;
      font-family: 'Noto Sans KR', sans-serif;
      font-size: 15px;
      color: #555;
      line-height: 1.7;
    }
  </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/fragments/mainheader.jsp" />

<div class="wrap">
  <div class="top">
    <div>
      <img id="cardImg" src="" alt="카드이미지" class="card-img">
      <div class="fee-box">
        <p><strong>연회비:</strong></p>
        <div class="fee-line"><img src="/image/overseas_pay_domestic.png" alt="국내"><span id="feeDomestic">-</span></div>
        <div class="fee-line"><img src="/image/overseas_pay_visa.png" alt="VISA"><span id="feeVisa">-</span></div>
        <div class="fee-line"><img src="/image/overseas_pay_master.png" alt="MASTER"><span id="feeMaster">-</span></div>
      </div>
    </div>
    <div class="info">
      <h2 id="cardName"></h2>
      <p id="cardSlogan"></p>
      <div class="summary-benefit" id="summaryBenefit"></div>
    </div>
  </div>

  <div class="accordion-container" id="accordionContainer"></div>

  <div class="section">
    <h3>특화 서비스</h3>
    <pre id="sService"></pre>
  </div>

  <div class="section">
    <h3>유의사항</h3>
    <pre id="notice"></pre>
  </div>
</div>

<script>
  const CATEGORY_KEYWORDS = {
    '커피': ['커피', '스타벅스', '이디야', '카페베네'],
    '편의점': ['편의점', 'GS25', 'CU', '세븐일레븐'],
    '베이커리': ['베이커리', '파리바게뜨', '뚜레쥬르', '던킨'],
    '영화': ['영화관', '영화', '롯데시네마', 'CGV'],
    '쇼핑': ['쇼핑몰', '쿠팡', '마켓컬리', 'G마켓', '다이소', '백화점', '홈쇼핑'],
    '외식': ['음식점', '레스토랑', '맥도날드', '롯데리아'],
    '교통': ['버스', '지하철', '택시', '대중교통', '후불교통'],
    '통신': ['통신요금', '휴대폰', 'SKT', 'KT', 'LGU+'],
    '교육': ['학원', '학습지'],
    '레저&스포츠': ['체육', '골프', '스포츠', '레저'],
    '구독': ['넷플릭스', '멜론', '유튜브프리미엄', '정기결제', '디지털 구독'],
    '병원': ['병원', '약국', '동물병원'],
    '공공요금': ['전기요금', '도시가스', '아파트관리비'],
    '주유': ['주유', '주유소', 'SK주유소', 'LPG'],
    '하이패스': ['하이패스'],
    '배달앱' : ['쿠팡', '배달앱'],
    '환경': ['전기차', '수소차', '친환경'],
    '공유모빌리티': ['공유모빌리티', '카카오T바이크', '따릉이', '쏘카', '투루카'],
    '세무지원': ['세무', '전자세금계산서', '부가세'],
    '포인트&캐시백': ['포인트', '캐시백'],
    '놀이공원': ['놀이공원', '자유이용권'],
    '라운지': ['공항라운지'],
    '발렛': ['발렛파킹']
  };

  function extractCategories(text, max = 5) {
    const found = new Set();
    const lowerText = text.toLowerCase();

    for (const [category, keywords] of Object.entries(CATEGORY_KEYWORDS)) {
      if (found.size >= max) break;
      for (const keyword of keywords) {
        if (lowerText.includes(keyword.toLowerCase())) {
          found.add(category);
          break;
        }
      }
    }

    return Array.from(found);
  }

  const urlParams = new URLSearchParams(location.search);
  const cardNo = urlParams.get("no");

  if (!cardNo) {
    alert("카드 번호가 없습니다.");
    throw new Error("카드 번호 누락");
  }

  fetch(`/api/cards/${cardNo}`)
    .then(r => {
      if (!r.ok) throw new Error('존재하지 않는 카드');
      return r.json();
    })
    .then(c => {
      renderCard(c);
      fetch(`/api/cards/${cardNo}/view`, { method: 'PUT' });
    })
    .catch(err => {
      alert('카드 정보를 불러올 수 없습니다.');
      console.error(err);
    });

  function renderCard(c) {
    document.title = `${c.cardName} 상세`;
    document.getElementById('cardImg').src = c.cardUrl;
    document.getElementById('cardImg').alt = c.cardName;
    document.getElementById('cardName').innerText = c.cardName;
    document.getElementById('cardSlogan').innerText = c.cardSlogan ?? '-';
    document.getElementById('sService').innerText = c.sService ?? '';
    document.getElementById('notice').innerText = c.cardNotice ?? '';

    const brand = (c.cardBrand || '').toUpperCase();
    const fee = (c.annualFee ?? 0).toLocaleString() + '원';
    document.getElementById('feeDomestic').innerText = brand.includes('BC') || brand.includes('LOCAL') ? fee : '없음';
    document.getElementById('feeVisa').innerText     = brand.includes('VISA') ? fee : '없음';
    document.getElementById('feeMaster').innerText   = brand.includes('MASTER') ? fee : '없음';

    renderCategories(c.service + '\n' + (c.sService ?? ''));
    renderBenefits(c.service);
  }

  function renderCategories(text) {
	  const categories = extractCategories(text, 5);
	  const html = categories.map(c => `<div class="benefit-card">#${c}</div>`).join('');
	  document.getElementById("summaryBenefit").innerHTML = html;
	}


  function renderBenefits(rawService) {
    const accordionDiv = document.getElementById('accordionContainer');
    const parts = rawService.split('◆').map(s => s.trim()).filter(s => s !== '');
    accordionDiv.innerHTML = `
      <div class="accordion" onclick="toggleAccordion(this)">
        <h4>기본 서비스 <span>▼</span></h4>
        <p>${parts.map(p => p.replace(/\n/g, "<br>")).join("<br><br>")}</p>
      </div>
    `;
  }

  function toggleAccordion(el) {
    el.classList.toggle("active");
  }
</script>

</body>
</html>
