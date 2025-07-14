<%@ page contentType="text/html; charset=UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카드 상세</title>
 <style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f7f7f7;
    margin: 0;
    padding: 0;
  }

  .wrap {
    max-width: 1000px;
    margin: 40px auto;
    background: #fff;
    box-shadow: 0 0 8px rgba(0,0,0,0.1);
    border-radius: 8px;
    overflow: hidden;
  }

  .top {
    display: flex;
    gap: 40px;
    padding: 40px;
    border-bottom: 1px solid #e0e0e0;
  }

  .card-img {
    width: 300px;
    border: 1px solid #ddd;
    border-radius: 6px;
  }

  .info h2 {
    font-size: 28px;
    color: #333;
    margin-bottom: 10px;
  }

  .info p {
    font-size: 18px;
    font-weight: bold;
    color: #555;
    margin: 6px 0;
  }

  .fee-box {
    margin-top: 20px;
  }

  .fee-line {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 6px;
  }

  .fee-line img {
    width: 40px;
    height: auto;
  }

  .summary-benefit {
    font-size: 15px;
    line-height: 1.6;
    margin-top: 15px;
    font-weight: 500;
    color: #444;
  }

  .accordion-container {
    padding: 30px 40px;
  }

  .accordion {
    background: #f2f4f6;
    border: 1px solid #cfd6e1;
    border-radius: 4px;
    padding: 15px 20px;
    margin-bottom: 12px;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
  }

  .accordion:hover {
    background: #e6ebf2;
  }

  .accordion h4 {
    margin: 0;
    font-size: 17px;
    color: #003478;
  }

  .accordion p {
    display: none;
    margin-top: 12px;
    font-size: 14px;
    color: #333;
  }

  .accordion.active p {
    display: block;
  }

  .section {
    padding: 30px 40px;
    border-top: 1px solid #e0e0e0;
    background: #fff;
  }

  .section h3 {
    margin-bottom: 15px;
    font-size: 18px;
    color: #003478;
    border-left: 4px solid #003478;
    padding-left: 10px;
  }

  .section pre {
    white-space: pre-wrap;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 14px;
    color: #444;
    line-height: 1.6;
  }
</style>

</head>
<body>

<div class="wrap">
  <div class="top">
    <!-- 카드 이미지 및 연회비 -->
    <div>
      <img id="cardImg" src="" alt="카드이미지" class="card-img">
      <div class="fee-box">
        <p><strong>연회비:</strong></p>
        <div class="fee-line">
          <img src="/image/overseas_pay_domestic.png" alt="국내">
          <span id="feeDomestic">-</span>
        </div>
        <div class="fee-line">
          <img src="/image/overseas_pay_visa.png" alt="VISA">
          <span id="feeVisa">-</span>
        </div>
        <div class="fee-line">
          <img src="/image/overseas_pay_master.png" alt="MASTER">
          <span id="feeMaster">-</span>
        </div>
      </div>
    </div>

    <!-- 카드 정보 및 요약 혜택 -->
    <div class="info">
      <h2 id="cardName"></h2>
      <p id="cardSlogan"></p>

      <div class="summary-benefit" id="summaryBenefit"></div>
    </div>
  </div>

  <!-- 아코디언 혜택 박스 -->
  <div class="accordion-container" id="accordionContainer"></div>

  <!-- 특화 서비스, 유의사항 -->
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

    const summaryItems = parts.slice(0, 4).map(part => {
      const [titleLine, ...contentLines] = part.split('\n');
      return `◆ ${titleLine.trim()} - ${contentLines[0]?.trim() || ''}`;
    });
    summaryDiv.innerHTML = summaryItems.join('<br>');

    accordionDiv.innerHTML = parts.map(part => {
      const [titleLine, ...contentLines] = part.split('\n');
      const content = contentLines.map(line => line.trim()).join('<br>');
      return `
        <div class="accordion" onclick="toggleAccordion(this)">
          <h4>${titleLine.trim()}</h4>
          <p>${content}</p>
        </div>
      `;
    }).join('');
  }

  function toggleAccordion(el) {
    el.classList.toggle("active");
  }
</script>

</body>
</html>
