# 이벤트 정의서 (Event Taxonomy)

## 이벤트 목록

| # | event_name | 페이지 카테고리 | 설명 | 주요 properties |
|---|-----------|-------------|------|---------------|
| 1 | page_view | 공통 | 페이지 진입 | page_type, referrer |
| 2 | product_view | 상품 | 상품 상세 조회 | product_id, category, price |
| 3 | product_list_view | 상품 목록 | 카테고리/검색 결과 조회 | list_type, keyword |
| 4 | add_cart | 장바구니 | 장바구니 담기 | product_id, quantity, price |
| 5 | remove_cart | 장바구니 | 장바구니 제거 | product_id |
| 6 | begin_checkout | 주문 | 주문서 진입 | cart_total, item_count |
| 7 | purchase | 주문 | 구매 완료 | order_id, total_amount, payment_method |
| 8 | search | 검색 | 검색 실행 | keyword, result_count |
| 9 | login | 인증 | 로그인 | method |
| 10 | signup | 인증 | 회원가입 | method |
| 11 | return_request | 반품 | 반품 신청 | order_id, reason_category |

## 스키마

| 컬럼 | 타입 | 설명 |
|------|------|------|
| event_name | VARCHAR(50) | 이벤트 이름 |
| uniq_id | VARCHAR(100) | 비회원 포함 고유 식별자 (쿠키 기반) |
| member_id | VARCHAR(50) | 회원 ID (로그인 시, nullable) |
| platform | VARCHAR(10) | PC / Mobile |
| properties | TEXT | 이벤트 속성 (JSON 문자열) |

## 수집 규칙
- PC/모바일 별도 경로에서 동일 스키마로 수집
- properties는 JSON 문자열로 저장 (MySQL 5.1.45 JSON 미지원 대응)
- 중복 제거: 매일 정각마다 배치 실행
- 집계: 매일 09:01 배치 실행
