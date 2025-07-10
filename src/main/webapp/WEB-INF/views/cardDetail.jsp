<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카드 상세</title>
  <style>
    .wrap        { max-width:1000px; margin:0 auto; }
    .top         { display:flex; gap:40px; padding:40px 20px; }
    .card-img    { width:300px; }
    .info h2     { margin:0 0 10px; }
    .info p      { margin:4px 0; }
    .section     { border-top:1px solid #ccc; padding:25px 20px; }
    .section h3  { margin:0 0 10px; }
    .section pre { white-space:pre-wrap; font-family:inherit; }
  </style>
</head>
<body>

<div class="wrap">
 
  <div class="top">
    <img id="cardImg" src="" alt="카드이미지" class="card-img">
    <div class="info">
      <h2 id="cardName"></h2>
      <p><strong>브랜드:</strong> <span id="cardBrand"></span></p>
      <p><strong>연회비:</strong> <span id="annualFee"></span></p>
      <p><strong>슬로건:</strong> <span id="cardSlogan"></span></p>
      <p><strong>발급대상:</strong> <span id="issuedTo"></span></p>
      <p><strong>조회수:</strong> <span id="viewCount"></span></p> <!-- ← 조회수 표시 -->
    </div>
  </div>

  <div class="section">
    <h3>기본 혜택</h3>
    <pre id="service"></pre>
  </div>

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

  // ① 카드 상세 정보 호출 + ② 조회수 증가 요청
  fetch(`/api/cards/${cardNo}`)
    .then(r => {
      if (!r.ok) throw new Error('존재하지 않는 카드');
      return r.json();
    })
    .then(data => {
      renderCard(data);
      // ③ 조회수 증가 요청
      fetch(`/api/cards/${cardNo}/view`, { method: 'PUT' });
    })
    .catch(err => {
      alert('카드 정보를 불러올 수 없습니다.');
      console.error(err);
    });

  // 카드 상세 정보 렌더링
  function renderCard(c) {
    document.title = `${c.cardName} 상세`;
    document.getElementById('cardImg').src        = c.cardUrl;
    document.getElementById('cardImg').alt        = c.cardName;
    document.getElementById('cardName').innerText = c.cardName;
    document.getElementById('cardBrand').innerText  = c.cardBrand ?? '-';
    document.getElementById('annualFee').innerText   = (c.annualFee ?? 0).toLocaleString() + '원';
    document.getElementById('cardSlogan').innerText  = c.cardSlogan ?? '-';
    document.getElementById('issuedTo').innerText    = c.issuedTo ?? '-';
    document.getElementById('viewCount').innerText   = c.viewCount ?? '0';
    document.getElementById('service').innerText     = c.service   ?? '';
    document.getElementById('sService').innerText    = c.sService  ?? '';
    document.getElementById('notice').innerText      = c.cardNotice?? '';
  }
</script>

</body>
</html>
