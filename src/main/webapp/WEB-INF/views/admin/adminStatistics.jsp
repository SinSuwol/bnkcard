<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 검색 통계</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      padding: 20px;
    }
    h1 {
      text-align: center;
    }
    h2 {
      margin-top: 40px;
      text-align: center;
      color: #2c3e50;
      cursor: pointer;
      background-color: #f1f3f5;
      padding: 10px;
      border-radius: 6px;
    }
    .chart-container, .table-container, .list-container, .button-group {
      display: none;
      margin: 20px auto;
      max-width: 800px;
    }
    canvas {
      width: 100% !important;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      border: 1px solid #ccc;
      padding: 10px;
      text-align: center;
    }
    th {
      background-color: #f8f9fa;
    }
    ul {
      list-style: none;
      padding-left: 0;
    }
    .btn {
      padding: 5px 10px;
      margin: 5px;
      cursor: pointer;
      background: #3498db;
      color: white;
      border: none;
      border-radius: 4px;
    }
  </style>
</head>
<body>
<h1>관리자 검색 통계</h1>

<h2 onclick="toggleSection('userTypeSection')">1. 회원/비회원 검색 비율</h2>
<div id="userTypeSection" class="chart-container">
  <canvas id="userTypeChart"></canvas>
</div>

<h2 onclick="toggleSection('ageGroupSection')">2. 나이대별 카드 조회</h2>
<div id="ageGroupSection" class="chart-container">
  <canvas id="ageGroupChart"></canvas>
</div>

<h2 onclick="toggleSection('genderChartSection')">3. 성별별 카드 조회</h2>
<div id="genderChartSection" class="chart-container">
  <canvas id="genderChart"></canvas>
</div>

<h2 onclick="toggleSection('topCardsSection')">4. 가장 많이 보기된 카드</h2>
<div id="topCardsSection" class="list-container">
  <ul id="topCardsList"></ul>
</div>

<h2 onclick="toggleSection('topKeywordsSection')">5. 인기 검색어 TOP10</h2>
<div id="topKeywordsSection" class="list-container">
  <button class="btn" onclick="loadTopKeywords('member')">회원</button>
  <button class="btn" onclick="loadTopKeywords('nonmember')">비회원</button>
  <ul id="topKeywordsList"></ul>
</div>

<h2 onclick="toggleSection('searchPeriodSection')">6. 검색 건수(기간 별)</h2>
<div id="searchPeriodSection" class="chart-container">
  <div class="button-group" style="text-align:center">
    <button class="btn" onclick="loadSearchStats('day')">하루</button>
    <button class="btn" onclick="loadSearchStats('week')">일주일</button>
    <button class="btn" onclick="loadSearchStats('month')">한달</button>
    <button class="btn" onclick="loadSearchStats('6months')">6개월</button>
    <button class="btn" onclick="loadSearchStats('year')">일년</button>
    <button class="btn" onclick="loadSearchStats('5years')">5>5\uub144</button>
    <button class="btn" onclick="loadSearchStats('all')">전체</button>
  </div>
  <canvas id="searchPeriodChart"></canvas>
</div>

<h2 onclick="toggleSection('recommendedRateSection')">7. 추천어 전환율</h2>
<div id="recommendedRateSection" class="table-container">
  <table>
    <thead>
      <tr><th>전체 검색</th><th>추천 검색</th><th>전환율 (%)</th></tr>
    </thead>
    <tbody id="recommendTableBody"></tbody>
  </table>
</div>

<script>
function toggleSection(id) {
  const el = document.getElementById(id);
  const visible = el.style.display === 'block';
  el.style.display = visible ? 'none' : 'block';
  if (!visible && !el.dataset.loaded) {
    loadDataFor(id);
    el.dataset.loaded = 'true';
  }
}

function loadDataFor(id) {
  const map = {
    userTypeSection: loadUserTypeChart,
    ageGroupSection: loadAgeGroupChart,
    genderChartSection: loadGenderChart,
    topCardsSection: loadTopCards,
    recommendedRateSection: loadRecommendConversion
  };
  if (map[id]) map[id]();
}

function loadUserTypeChart() {
  fetch('/admin/Search/stats/userType')
    .then(res => res.json())
    .then(data => {
      new Chart(document.getElementById('userTypeChart'), {
        type: 'pie',
        data: {
          labels: ['회원', '비회원'],
          datasets: [{
            data: [data.member, data.nonmember],
            backgroundColor: ['#36A2EB', '#FF6384']
          }]
        }
      });
    });
}

function loadAgeGroupChart() {
  fetch('/admin/Search/stats/cardViewsByAgeGroup')
    .then(res => res.json())
    .then(data => {
      const labels = Object.keys(data);
      const values = Object.values(data);
      new Chart(document.getElementById('ageGroupChart'), {
        type: 'bar',
        data: {
          labels,
          datasets: [{
            label: '조회수',
            data: values,
            backgroundColor: 'rgba(75,192,192,0.5)'
          }]
        }
      });
    });
}

function loadGenderChart() {
  fetch('/admin/Search/stats/cardViewsByGender')
    .then(res => res.json())
    .then(data => {
      const labels = Object.keys(data);
      const values = Object.values(data);
      new Chart(document.getElementById('genderChart'), {
        type: 'doughnut',
        data: {
          labels,
          datasets: [{
            label: '성별 조회',
            data: values,
            backgroundColor: ['#3498db', '#f39c12']
          }]
        }
      });
    });
}

function loadTopCards() {
  fetch('/admin/Search/stats/topCards')
    .then(res => res.json())
    .then(data => {
      const ul = document.getElementById('topCardsList');
      data.forEach(item => {
        const li = document.createElement('li');
        li.textContent = `
        \${item.cardName} (\${item.viewCount} view)`;
        ul.appendChild(li);
      });
    });
}

function loadTopKeywords(type) {
  fetch(`/admin/Search/stats/topKeywords?type=${type}`)
    .then(res => res.json())
    .then(data => {
      const ul = document.getElementById('topKeywordsList');
      ul.innerHTML = '';
      data.forEach(k => {
        const li = document.createElement('li');
        li.textContent = `\${k.keyword} (\${k.count})`;
        ul.appendChild(li);
      });
    });
}

function loadSearchStats(period) {
  fetch(`/admin/Search/stats/searchCountByPeriod?period=${period}`)
    .then(res => res.json())
    .then(data => {
      new Chart(document.getElementById('searchPeriodChart'), {
        type: 'bar',
        data: {
          labels: ['회원', '비회원'],
          datasets: [{
            label: period + ' 검색 건수',
            data: [data.member, data.nonmember],
            backgroundColor: ['#2ecc71', '#e74c3c']
          }]
        }
      });
    });
}

function loadRecommendConversion() {
  fetch('/admin/Search/stats/recommendedConversionRate')
    .then(res => res.json())
    .then(data => {
      const tbody = document.getElementById('recommendTableBody');
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>\${data.total}</td>
      <td>\${data.recommended}</td>
      <td>\${data.conversionRate}%</td>`;
      tbody.appendChild(tr);
    });
}
</script>
</body>
</html>
