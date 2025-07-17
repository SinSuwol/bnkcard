<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원/비회원 검색 통계</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
/* ===== 기본 설정 ===== */


/* ===== 제목 스타일 ===== */
h1, h2 {
  margin-top: 50px;
  margin-bottom: 20px;
  font-weight: 600;
  color: #2c3e50;
  text-align: center;
}

/* ===== 테이블 공통 ===== */
table {
  width: 90%;
  max-width: 1000px;
  margin: 0 auto 40px auto;
  border-collapse: collapse;
  background-color: #fff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

thead {
  background-color: #f1f3f5;
}

th, td {
  padding: 14px 18px;
  font-size: 14px;
  border-bottom: 1px solid #e9ecef;
}

tbody tr:hover {
  background-color: #f8f9fa;
}

/* ===== 차트 영역 ===== */
.chart-container {
  width: 90%;
  max-width: 900px;
  margin: 0 auto 60px auto;
  padding: 30px 20px;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

/* ===== 전환율 통계 박스 ===== */
#conversionStats {
  width: 90%;
  max-width: 900px;
  margin: 30px auto 80px auto;
  background-color: #ffffff;
  padding: 24px 28px;
  font-size: 15px;
  text-align: left;
  color: #495057;
  border-radius: 8px;
  box-shadow: 0 1px 6px rgba(0, 0, 0, 0.04);
}

#conversionStats p {
  margin: 8px 0;
  line-height: 1.6;
}



</style>
<link rel="stylesheet" href="/css/adminstyle.css">
</head>
<body>
<jsp:include page="../fragments/header.jsp"></jsp:include>
	<h1>회원/비회원 검색 통계</h1>

	<!-- 비율 차트 -->
	<div class="chart-container">
		<canvas id="userTypeChart" width="400" height="400"></canvas>
	</div>

	<!-- 최근 7일간 검색 추이 -->
	<h2>최근 7일 검색 추이</h2>
	<table id="log-trend">
		<thead>
			<tr>
				<th>날짜</th>
				<th>회원 검색수</th>
				<th>비회원 검색수</th>
				<th>전체 검색수</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<!-- 인기 검색어 TOP5 -->
	<h2>인기 검색어 TOP5 (회원)</h2>
	<table id="top-member">
		<thead>
			<tr>
				<th>키워드</th>
				<th>검색수</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<h2>인기 검색어 TOP5 (비회원)</h2>
	<table id="top-nonmember">
		<thead>
			<tr>
				<th>키워드</th>
				<th>검색수</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>


	<h2>최근 1개월 기간별 검색량 추이</h2>
	<div class="chart-container" style="width: 80%;">
		<canvas id="dateChart"></canvas>
	</div>

	<h2>오늘 시간대별 검색량</h2>
	<div class="chart-container" style="width: 80%;">
		<canvas id="hourChart"></canvas>
	</div>

	<script src="/js/adminHeader.js"></script>
	<h2>최근 7일 누적 시간대별 검색량</h2>
	<div class="chart-container" style="width: 80%;">
		<canvas id="last7daysHourChart"></canvas>
	</div>

	<h2>추천어 검색 전환율</h2>
	<div id="conversionStats"></div>

	<script>
// 추천어 전환율 가져오기
fetch('/admin/Search/stats/recommendedConversionRate')
  .then(res => res.json())
  .then(data => {
    const div = document.getElementById('conversionStats');
    div.innerHTML = `
      <p><strong>총 검색 건수:</strong> \${data.total.toLocaleString()}</p>
      <p><strong>추천어 검색 건수:</strong> \${data.recommended.toLocaleString()}</p>
      <p><strong>추천어 검색 전환율:</strong> \${data.conversionRate}%</p>
    `;
  })
  .catch(err => {
    console.error('추천어 전환율 로드 실패:', err);
  });
</script>


	<script>
  // 1) 비율 데이터 로드
  fetch('/admin/Search/stats/userType')
    .then(res => res.json())
    .then(data => {
      const ctx = document.getElementById('userTypeChart');
      new Chart(ctx, {
        type: 'pie',
        data: {
          labels: ['회원', '비회원'],
          datasets: [{
            data: [data.member, data.nonmember],
            backgroundColor: ['#4CAF50', '#FF9800']
          }]
        },
        options: {
          responsive: true,
          plugins: {
            legend: { position: 'bottom' },
            title: { display: true, text: '회원/비회원 검색 비율' }
          }
        }
      });
    });

  // 2) 최근 7일 추이
  fetch('/admin/Search/stats/trend')
    .then(res => res.json())
    .then(data => {
      const tbody = document.querySelector('#log-trend tbody');
      tbody.innerHTML = '';
      data.forEach(row => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td>\${row.date}</td>
          <td>\${row.member}</td>
          <td>\${row.nonmember}</td>
          <td>\${row.total}</td>
        `;
        tbody.appendChild(tr);
      });
    });

  // 3) 회원 인기 검색어
  fetch('/admin/Search/stats/top?type=member')
    .then(res => res.json())
    .then(data => {
      const tbody = document.querySelector('#top-member tbody');
      tbody.innerHTML = '';
      data.forEach(row => {
        const tr = document.createElement('tr');
        tr.innerHTML = `<td>\${row.keyword}</td><td>\${row.count}</td>`;
        tbody.appendChild(tr);
      });
    });

  // 4) 비회원 인기 검색어
  fetch('/admin/Search/stats/top?type=nonmember')
    .then(res => res.json())
    .then(data => {
      const tbody = document.querySelector('#top-nonmember tbody');
      tbody.innerHTML = '';
      data.forEach(row => {
        const tr = document.createElement('tr');
        tr.innerHTML = `<td>\${row.keyword}</td><td>\${row.count}</td>`;
        tbody.appendChild(tr);
      });
    });
  
//5) 기간별 검색량 추이
  fetch('/admin/Search/stats/byDate')
    .then(res => res.json())
    .then(data => {
      const labels = data.map(d => d.date);
      const counts = data.map(d => d.count);

      new Chart(document.getElementById('dateChart'), {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [{
            label: '검색 수',
            data: counts,
            backgroundColor: '#03A9F4'
          }]
        },
        options: {
          responsive: true,
          plugins: {
            title: {
              display: true,
              text: '기간별 검색량 추이'
            },
            legend: { display: false }
          },
          scales: {
            x: { title: { display: true, text: '날짜' }},
            y: { title: { display: true, text: '검색 수' }}
          }
        }
      });
    });

  // 6) 시간대별 검색량
  fetch('/admin/Search/stats/byHour')
    .then(res => res.json())
    .then(data => {
      const labels = data.map(d => d.hour + '시');
      const counts = data.map(d => d.count);

      new Chart(document.getElementById('hourChart'), {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [{
            label: '검색 수',
            data: counts,
            backgroundColor: '#9C27B0'
          }]
        },
        options: {
          responsive: true,
          plugins: {
            title: {
              display: true,
              text: '시간대별 검색량'
            },
            legend: { display: false }
          },
          scales: {
            x: { title: { display: true, text: '시간대' }},
            y: { title: { display: true, text: '검색 수' }}
          }
        }
      });
    });

//7) 최근 7일 시간대별 검색량
  fetch('/admin/Search/stats/byHour7Days')
    .then(res => res.json())
    .then(data => {
      // 시간 순서대로 정렬 (혹시 빠진 시간대 채워주려면 로직 추가 가능)
      const labels = data.map(d => d.hour + '시');
      const counts = data.map(d => d.count);

      const ctx = document.getElementById('last7daysHourChart');
      new Chart(ctx, {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [
            {
              type: 'line',
              label: '검색 수 (꺾은선)',
              data: counts,
              borderColor: '#2196F3',
              backgroundColor: 'transparent',
              tension: 0.2,
              pointRadius: 4,
              pointBackgroundColor: '#2196F3',
              order: 0
            },
            {
              type: 'bar',
              label: '검색 수 (막대)',
              data: counts,
              backgroundColor: '#673AB7',
              order: 1
            }
          ]
        },
        options: {
          responsive: true,
          plugins: {
            title: {
              display: true,
              text: '최근 7일 시간대별 검색량'
            },
            legend: { position: 'top' }
          },
          scales: {
            x: {
              title: { display: true, text: '시간대' }
            },
            y: {
              beginAtZero: true,
              title: { display: true, text: '검색 수' }
            }
          }
        }
      });
    })
    .catch(error => {
      console.error('시간대별 데이터 로딩 오류:', error);
    });

  </script>
</body>
</html>
