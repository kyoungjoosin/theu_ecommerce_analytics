# theu-ecommerce-analytics

제약 이커머스 자사몰(카페24 기반)의 실운영 데이터를 기반으로  
문제를 직접 정의하고 분석 → 액션 → 검증까지 수행한 프로젝트 모음입니다.

---

## 프로젝트 목록

| # | 프로젝트 | 핵심 결과 | 기술 스택 |
|---|---------|----------|----------|
| 1 | [반품률 축소 테스트 액션](./01_return_rate_reduction/) | 전체 반품률 2.5%p 감소 (주문 +67% 상황) | Python, Pandas, MySQL |
| 2 | [개인화 품목 조회를 활용한 주문 경험 개선](./02_personalized_order_experience/) | 기존 고객 주문 소요시간 6.8% 단축 | Python, Pandas, MySQL |
| 3 | [도매 주문 UI 개선 가설 검증](./03_wholesale_ui_improvement/) | 주문당 평균 16.9개 품목 대량 구매 패턴 확인 | Python, Pandas, MySQL |
| 4 | [자사몰 쿼리 최적화](./04_query_optimization/) | 페이지 로딩 속도 90% 단축 (3~4초 → 0.3초) | MySQL |

---

## 도메인 컨텍스트

- **운영 환경**: 카페24 기반 폐쇄형 자사몰 (소매 + 도매)
- **데이터**: MySQL DB 직접 접근 — 주문 / 반품 / 회원 / 로그인 이력
- **분석 대상**: 구매자(외부) + 운영자(내부) 양방향

---

## 환경 설정

```bash
pip install pandas sqlalchemy pymysql python-dotenv matplotlib seaborn
```

DB 접속 정보는 `.env` 파일로 관리합니다.

```
DB_HOST=your_host
DB_PORT=3306
DB_USER=your_user
DB_PASSWORD=your_password
DB_NAME=your_dbname
```

> 원본 데이터는 개인정보 보호를 위해 포함되어 있지 않습니다.  
> 실제 테이블명은 익명화되어 있습니다.
