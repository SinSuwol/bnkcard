# BNK Card 프로젝트

![Java](https://img.shields.io/badge/Java-21-red)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3-green)
![Flutter](https://img.shields.io/badge/Flutter-3.24-blue)
![Oracle](https://img.shields.io/badge/Oracle-DB-orange)
![Python](https://img.shields.io/badge/Python-FastAPI-yellow)
![AI](https://img.shields.io/badge/AI-YOLOv8%20%7C%20EasyOCR%20%7C%20FaceNet-lightgrey)

**AI 기반 부산은행 카드 발급 및 관리 플랫폼**

Spring Boot, Flutter, Oracle, Python 기반의 하이브리드 금융 서비스입니다.  
카드 발급, 본인 인증, 커스텀 카드, 챗봇, 피드백 분석 등 다양한 기능을 포함하고 있습니다.

---

## 1. 프로젝트 개요

**BNK Card**는 사용자의 카드 신청부터 발급, 관리까지의 모든 과정을 디지털로 통합한 모바일 금융 서비스입니다.  
AI 기술을 활용해 신분증 인증, 이미지 검열, 피드백 감정 분석을 자동화하였으며  
사용자 경험(UX)과 금융 보안을 모두 충족하는 구조로 설계되었습니다.

**프로젝트 핵심 목표**
- 안전하고 효율적인 카드 발급 절차 구현  
- AI 기술을 활용한 자동화 및 고도화  
- 관리자/사용자 통합 운영 시스템 구축  


**웹 메인페이지** 
<img width="4000" height="2250" alt="image" src="https://github.com/user-attachments/assets/27108bd7-75bb-4f02-9012-e643b9b6cb0f" />

---

## 2. 기술 스택

| 구분 | 사용 기술 |
|------|------------|
| **Frontend** | Flutter |
| **Backend** | Spring Boot (Java 21) |
| **Database** | Oracle |
| **AI Server** | Python (FastAPI, YOLOv8, EasyOCR, FaceNet) |
| **Infra/기타** | Gradle, Lombok, WebSocket/STOMP, SSE, OpenAPI |
| **AI Model** | YOLOv8, InceptionResnetV1, MTCNN, OCR |

---

## 3. 아키텍처 구성

[Flutter App] ↔ [Spring Boot Server] ↔ [Oracle DB]<br>
↘<br>
↘ (HTTP/REST)<br>
[Python AI Server]<br>
├── OCR 및 얼굴 인식 검증<br>
├── 이미지 검열 (YOLO)<br>
└── 피드백 감정 분석

## 4. 주요 기능

| 구분 | 기능 설명 |
|------|------------|
| **회원 및 보안** | 주민등록번호 + 얼굴 인식 기반 본인 인증, 로그인/세션 관리 |
| **카드 발급 절차** | 약관 동의 → 정보 입력 → AI 인증 → 배송지 입력 → PIN 설정 → 전자서명 → 완료 |
| **커스텀 카드** | 텍스트, 배경, 이모티콘 편집 및 AI 이미지 검열 기능 포함 |
| **챗봇** | 카드 상품·혜택·발급 상담 지원, WebSocket 상담사 연결 지원 |
| **피드백 분석** | 사용자 리뷰를 수집하여 AI 감정 분석(긍정/부정 비율, 키워드 통계) |
| **위치 기반 서비스** | GPS 기반 영업점 검색, 거리순 추천 및 지도 표시 |
| **관리자 페이지** | 고객 정보, 약관, 추천상품, 리포트, 이탈률, 리뷰 관리 |

---

## 5. AI 기능 요약

| 기능 | 설명 |
|------|------|
| **YOLOv8 이미지 검열** | 커스텀 카드 이미지 내 부적절(총기, 음란물 등) 콘텐츠 자동 탐지 |
| **OCR + 얼굴 인식** | 신분증의 주민번호 인식(OCR) + 실시간 얼굴 비교로 본인 확인 |
| **감정 분석** | 사용자 피드백을 자연어 처리 기반으로 긍정/부정 분류 및 키워드 통계 생성 |

---

## 6. UX 설계 원칙

- **핀테크 스타일 UX**: 단순하고 명확한 시각 구조  
- **탐색 효율성**: 해시태그 기반 카드 검색 (#카페, #쇼핑 등)  
- **즉시 피드백**: 실시간 입력 검증 및 인라인 에러 메시지  
- **약관 UX**: 전체 스크롤 완료 후 동의 버튼 활성화  
- **자동화 입력**: 로그인 정보 기반 오토필, 민감정보 마스킹  
- **보안 UX**: 랜덤 배열 보안 키패드, 비밀번호 재입력 방지  
- **정책 안내**: 20일 이내 다중 계좌 생성 제한을 UX로 자연스럽게 표현  

---

## 7. 역할 분담

| 이름 | 담당 기능 |
|------|------------|
| **김성훈** | AI 이미지 검열, SSE 푸시 알림, 리뷰 피드백 분석 |
| **수현** | 회원 및 상품 관리, 약관 뷰어, PDF/Excel 보고서 |
| **창훈** | 카드 발급 프로세스, 단계별 통계, UX 설계 |
| **민수** | 위치 기반 영업점 안내, 커스텀 카드 UI |
| **대영** | 추천상품 관리, 공통/개별 약관 등록 및 관리 |

---

## 8. 관리자 기능 요약

| 기능 | 설명 |
|------|------|
| **고객 관리** | 개인정보, 신청 내역, 이탈률 추적 |
| **약관 관리** | PDF 업로드, 사용 여부 전환, 버전별 관리 |
| **추천 상품 관리** | 클릭/신청 통계 기반 추천 카드 운영 |
| **리포트** | Excel/PDF 내보내기, 기간별 발급 통계 |
| **이탈률 분석** | 각 단계별 전환율/이탈율 시각화 그래프 제공 |

---

## 9. 성과 및 개선 사항

**성과**
- AI 기술(OCR, 얼굴 인식, 감정 분석, YOLO)을 실무 서비스에 적용  
- 사용자 UX와 금융 보안을 함께 고려한 설계  
- 관리자/사용자 통합 환경 완성  

**개선 방향**
- AI 데이터셋 확장 및 모델 정밀도 향상  
- SSE 기반 실시간 이벤트 및 알림 시스템 고도화  
- UI 일관성, 클라이언트 유효성 검증 강화  

---

## 10. 프로젝트 결과 및 배운 점

- 카드 발급 절차를 실제 구현하며 금융 서비스 전반의 흐름 이해  
- AI 기술을 서비스 맥락에 통합하며 실무 적용 가능성 체감  
- UX 설계에서 작은 마찰이 사용자 이탈로 이어질 수 있음을 학습  
- 화면 구현보다 흐름과 예외 처리가 더 중요함을 인식  
- 관리자 관점의 데이터 분석 및 운영 프로세스 설계 경험 확보  

---

## 11. 실행 환경 요약

| 항목 | 설정 |
|------|------|
| **Spring Server** | http://localhost:8090 |
| **AI Server (Chatbot)** | http://localhost:8000 |
| **AI Server (YOLO)** | http://localhost:8001 |
| **DB 연결** | Oracle XE (로컬/도커) |
| **Flutter 앱 테스트** | Android Emulator / Web |

---

## 12. 디렉토리 구조
Spring <br>
<img width="223" height="397" alt="image" src="https://github.com/user-attachments/assets/16e5b93e-841c-4bd8-9c93-e2694a9b0d6c" />


---

## 13. 향후 계획

- 실사용 데이터 기반 AI 학습 정밀도 향상  
- 사용자 이벤트 기반 실시간 알림 및 리텐션 기능 강화  
- SSE 채널 표준화 및 운영자 대시보드 구축  
- 피드백 자동 반영 및 A/B 테스트 연동  

---

**Last Updated:** 2025.10  
**Author:** 김성훈 (AI/Backend Developer)
