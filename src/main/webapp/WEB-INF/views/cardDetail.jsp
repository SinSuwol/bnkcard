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
    }

    .wrap {
      max-width: 1000px;
      margin: 40px auto;
    }

    .top {
      display: flex;
      gap: 40px;
      padding: 40px 20px 20px;
      align-items: flex-start;
    }

    .card-img {
      width: 260px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }

    .info {
      flex: 1;
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
      flex: 1 1 calc(50% - 12px);
      background: #f9faff;
      padding: 12px 16px;
      border: 1px solid #e0e6ff;
      border-radius: 6px;
      font-size: 15px;
      font-weight: 500;
      color: #222;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
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

    renderBenefits(c.service);
  }

  function renderBenefits(rawService) {
    const summaryDiv = document.getElementById('summaryBenefit');
    const accordionDiv = document.getElementById('accordionContainer');
    const parts = rawService.split('◆').map(s => s.trim()).filter(s => s !== '');

    const summaryItems = parts.slice(0, 3).map(part => {
      const [titleLine, ...contentLines] = part.split('\n');
      const summaryText = `${titleLine.trim()} - ${contentLines[0]?.trim() || ''}`;
      return `<div class="benefit-card">${summaryText}</div>`;
    });
    summaryDiv.innerHTML = summaryItems.join('');

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
